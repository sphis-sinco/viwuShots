package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public var viwu:Viwu;
	public var floor:FlxSprite;

	public var focusMode:Bool = false;
	public var shot:Bool = false;

	public var camFollow:FlxObject;

	public var balloonGroup:FlxTypedGroup<Balloon>;
	public var maxBalloons:Int = 5;

	public var score:Int = 0;
	public var scoreText:FlxText;

	public var vinylStop:FlxSound;
	public var balloonPop:FlxSound;
	public var balloonPopFaded:FlxSound;
	public var pistol:FlxSound;

	public var background:FlxSprite;

	override public function create()
	{
		super.create();

		balloonPop = new FlxSound().loadStream('assets/sounds/balloon-pop.wav');

		balloonPopFaded = new FlxSound().loadStream('assets/sounds/balloon-pop.wav');
		balloonPopFaded.volume = .1;

		pistol = new FlxSound().loadStream('assets/sounds/pistol.wav');
		vinylStop = new FlxSound().loadStream('assets/sounds/vinyl-stop.wav');

		background = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromString('0x996633'));
		background.screenCenter();
		add(background);

		scoreText = new FlxText(0, 0, 0, "Score: gay", 64);
		scoreText.alignment = "center";
		scoreText.alpha = .5;
		add(scoreText);

		balloonGroup = new FlxTypedGroup<Balloon>();
		add(balloonGroup);

		viwu = new Viwu();
		add(viwu);

		floor = new FlxSprite().loadGraphic('assets/images/floor.png');
		add(floor);

		floor.setPosition(-275.95, 437.25);
		viwu.setPosition(-59.7, 65.2);

		FlxG.camera.zoom = 1;

		camFollow = new FlxObject();
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, .2);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (score > (FlxG.save.data.highscore ?? 0))
		{
			try
			{
				FlxG.save.data.highscore = score;
			}
			catch (_) {}
		}

		scoreText.text = 'Score:\n$score\nHighscore:\n${FlxG.save.data.highscore ?? 0}';
		scoreText.screenCenter();

		if (score < -1000 && maxBalloons > 0)
		{
			maxBalloons = 0;
			vinylStop.play();
			focusMode = false;

			if (viwu.animation.name != 'shoot')
				viwu.animation.play(viwu.animation.name, false, true, viwu.animation.frameIndex);

			viwu.animation.onFinish.add(animName ->
			{
				viwu.animation.play('idle');
				viwu.animation.onFinish.removeAll();
			});

			FlxTween.tween(background, {alpha: .25}, 1, {
				startDelay: .204
			});

			FlxTween.tween(scoreText, {alpha: 0}, 1, {
				startDelay: .204
			});
			for (balloon in balloonGroup.members)
			{
				FlxTween.tween(balloon, {alpha: .25}, 1, {
					startDelay: .204
				});
				FlxTween.tween(balloon.storage, {speedX: 0, speedY: 0}, 1, {
					startDelay: .204
				});
			}

			FlxTween.tween(camFollow, {x: FlxG.width / 2 - 320}, 4, {
				startDelay: .204
			});
			FlxTween.tween(FlxG.camera, {zoom: 1.3}, 4, {
				startDelay: .204
			});

			FlxTimer.wait(2, () ->
			{
				viwu.animation.play('results-bad');
			});
		}

		if (maxBalloons > 0 && FlxG.keys.justReleased.F && !focusMode)
		{
			focusMode = true;
			viwu.animation.play('focus');

			FlxTween.cancelTweensOf(FlxG.camera);
			FlxTween.tween(FlxG.camera, {zoom: 1.25}, .25, {ease: FlxEase.sineIn});
		}
		else if (maxBalloons > 0 && FlxG.keys.justReleased.F && focusMode)
		{
			focusMode = false;
			viwu.animation.play('unfocus');

			FlxTween.cancelTweensOf(FlxG.camera);
			FlxTween.tween(FlxG.camera, {zoom: 1}, .25, {ease: FlxEase.sineOut});
		}

		if (focusMode && #if camFollowShit true #else false #end)
		{
			camFollow.setPosition(FlxG.width - FlxG.mouse.getViewPosition().x * 2, FlxG.height - FlxG.mouse.getViewPosition().y * 2);

			if (camFollow.x < 800)
				camFollow.x = 800;
		}
		else
		{
			if (maxBalloons > 0)
				camFollow.setPosition(FlxG.width / 2, FlxG.height / 2);
		}

		FlxG.watch.addQuick('camFollow pos', camFollow.getPosition());

		if (balloonGroup.members.length < maxBalloons)
		{
			var balloon = new Balloon();
			balloon.screenCenter();
			balloon.x = -FlxG.width - balloon.width;

			balloon.x += FlxG.random.float(-10, 10);
			balloon.y += FlxG.random.float(-10, 10);

			balloon.storage.savedY = balloon.y;
			balloon.storage.time = elapsed * FlxG.random.int(0, 10);
			balloon.storage.speedX = FlxG.random.float(.5, 4) * FlxG.random.float(5, 10);
			balloon.storage.speedY = FlxG.random.float(.01, .5);
			balloon.storage.maxHeight = FlxG.random.float(25, 100);

			balloonGroup.add(balloon);
		}

		for (balloon in balloonGroup.members)
		{
			try
			{
				balloon.storage.time += elapsed;
				balloon.x += balloon.storage.speedX;

				balloon.y = balloon.storage.savedY + Math.sin(balloon.storage.time + balloon.storage.speedY) * balloon.storage.maxHeight;
				balloonGroup.sort(FlxSort.byY);

				if (balloon.x > FlxG.width + balloon.width * 2)
				{
					if (balloon.type == Balloon.targetType && maxBalloons > 0)
						score -= 50;

					balloonGroup.members.remove(balloon);
					balloon.destroy();

					// balloonPopFaded.play();
				}

				balloon.color = FlxColor.WHITE;

				if (focusMode && !shot && FlxG.mouse.overlaps(balloon))
					balloon.color = FlxColor.RED;

				if (focusMode && !shot && FlxG.mouse.justReleased && FlxG.mouse.overlaps(balloon))
				{
					shot = true;

					balloonPop.play();
					// pistol.play();

					if (balloon.type == Balloon.targetType)
						score += 300;
					else
						score -= 150;

					balloonGroup.members.remove(balloon);
					balloon.destroy();

					if (FlxG.camera.zoom != 1.25)
					{
						FlxTween.cancelTweensOf(FlxG.camera);
						FlxG.camera.zoom = 1.25;
					}

					viwu.animation.play('shoot', true);
					FlxTween.tween(FlxG.camera, {zoom: 1.15}, .1, {
						ease: FlxEase.bounceInOut,
						onComplete: t ->
						{
							FlxTween.tween(FlxG.camera, {zoom: 1.25}, .1, {ease: FlxEase.sineIn});
						}
					});

					viwu.animation.onFrameChange.add((animName, frameNumber, frameIndex) ->
					{
						if (animName == 'shoot' && frameNumber > 8)
						{
							shot = false;
							viwu.animation.onFrameChange.removeAll();
						}
					});
				}
			}
			catch (e)
			{
				balloonGroup.members.remove(balloon);
				balloon.destroy();

				// trace('obj died becuz of crash');
			}
		}
	}
}
