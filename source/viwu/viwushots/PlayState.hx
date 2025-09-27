package viwu.viwushots;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var viwu:Viwu;
	public var floor:FlxSprite;

	public var focusMode:Bool = false;

	override public function create()
	{
		super.create();

		viwu = new Viwu();
		add(viwu);

		floor = new FlxSprite().loadGraphic('assets/images/floor.png');
		add(floor);

		floor.setPosition(-275.95, 437.25);
		viwu.setPosition(-59.7, 65.2);

		FlxG.camera.zoom = 1;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.F && !focusMode)
		{
			focusMode = true;
			viwu.animation.play('focus');

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, 1, {
				ease: FlxEase.sineInOut
			});
		}

		if (FlxG.keys.justReleased.F && focusMode)
		{
			focusMode = false;
			viwu.animation.play('unfocus');

			FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {
				ease: FlxEase.sineInOut
			});
		}
	}
}
