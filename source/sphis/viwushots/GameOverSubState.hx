package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class GameOverSubState extends FlxSubState
{
	public var gameover:FlxSprite;
	public var retry:FlxSprite;

	override function create()
	{
		super.create();

		gameover = new FlxSprite();
		gameover.loadGraphic('assets/images/gameover.png');
		gameover.alpha = 0;

		retry = new FlxSprite();
		retry.loadGraphic('assets/images/retry.png');
		retry.alpha = 0;

		gameover.scale.set(.95, .95);
		gameover.updateHitbox();

		retry.scale.set(.5, .5);
		retry.updateHitbox();

		add(gameover);
		add(retry);

		FlxTween.tween(gameover, {alpha: 1}, 1);
		FlxTween.tween(retry, {alpha: 1}, 1);

		gameover.screenCenter();
		retry.screenCenter();

		gameover.x += gameover.width * .75;
		gameover.y -= gameover.height * .45;
		retry.x += retry.width * 1.25;
		retry.y += retry.height * 1.25;

		gameover.scrollFactor.set();
		retry.scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(retry))
			retry.scale.set(.6, .6);
		else
			retry.scale.set(.5, .5);
		if (FlxG.mouse.justReleased && FlxG.mouse.overlaps(retry))
		{
			FlxG.camera.fade(FlxColor.BLACK, 1, false, () ->
			{
				FlxG.switchState(() -> new PlayState(true));
			});
		}
	}
}
