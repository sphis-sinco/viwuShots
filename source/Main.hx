package;

import flixel.FlxGame;
import flixel.FlxSprite;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxSprite.defaultAntialiasing = true;

		#if ViwuShootAnimationOffsetsState
		addChild(new FlxGame(0, 0, sphis.viwushots.ViwuShootAnimationOffsetsState));
		#else
		addChild(new FlxGame(0, 0, sphis.viwushots.PlayState));
		#end
	}
}
