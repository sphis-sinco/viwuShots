package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
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

		add(gameover);
		add(retry);

		FlxTween.tween(gameover, {alpha: 1}, 1);
		FlxTween.tween(retry, {alpha: 1}, 1);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justReleased && FlxG.mouse.overlaps(retry))
		{
			FlxG.camera.fade(FlxColor.BLACK, 1, false, () ->
			{
				FlxG.switchState(() -> new PlayState());
				FlxG.camera.flash(FlxColor.BLACK, 1);
			});
		}
	}
}
