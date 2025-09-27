package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxColor;

class GameOverSubState extends FlxSubState
{
	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ENTER)
		{
			FlxG.camera.fade(FlxColor.BLACK, 1, false, () ->
			{
				FlxG.switchState(() -> new PlayState());
				FlxG.camera.flash(FlxColor.BLACK, 1);
			});
		}
	}
}
