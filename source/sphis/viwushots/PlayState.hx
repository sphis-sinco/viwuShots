package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import funkin.util.SortUtil;

class PlayState extends FlxState
{
	public var viwu:Viwu;
	public var floor:FlxSprite;

	public var focusMode:Bool = false;
	public var shot:Bool = false;

	public var camFollow:FlxObject;

	public var balloonGroup:FlxTypedGroup<Balloon>;
	public var maxBalloons:Int = 50;

	override public function create()
	{
		super.create();

		add(new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromString('0x996633')).screenCenter());

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

		if (FlxG.keys.justReleased.F && !focusMode)
		{
			focusMode = true;
			viwu.animation.play('focus');

			FlxTween.cancelTweensOf(FlxG.camera);
			FlxTween.tween(FlxG.camera, {zoom: 1.25}, .25, {ease: FlxEase.sineIn});
		}
		else if (FlxG.keys.justReleased.F && focusMode)
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
			balloon.storage.speedX = FlxG.random.float(.5, 4) * FlxG.random.float(1, 10);
			balloon.storage.speedY = FlxG.random.float(.01, .5);
			balloon.storage.maxHeight = FlxG.random.float(25, 100);

			balloon.zIndex = FlxG.random.int(0, 1000);

			balloonGroup.add(balloon);
			balloonGroup.sort(SortUtil.byZIndexBalloon, FlxSort.ASCENDING);
		}

		for (balloon in balloonGroup.members)
		{
			balloon.storage.time += elapsed;
			balloon.x += balloon.storage.speedX;

			balloon.y = balloon.storage.savedY + Math.sin(balloon.storage.time + balloon.storage.speedY) * balloon.storage.maxHeight;

			if (balloon.x > FlxG.width + balloon.width * 2)
			{
				balloonGroup.members.remove(balloon);
				balloon.destroy();
			}

			if (focusMode && !shot && FlxG.mouse.justReleased && FlxG.mouse.overlaps(balloon))
			{
				shot = true;

				balloonGroup.members.remove(balloon);
				balloon.destroy();

				viwu.animation.play('shoot');

				viwu.animation.onFinish.add(animName ->
				{
					shot = false;
					viwu.animation.onFinish.removeAll();
				});
			}
		}
	}
}
