package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		#if ViwuShootAnimationOffsetsState
		addChild(new FlxGame(0, 0, viwu.viwushots.ViwuShootAnimationOffsetsState));
		#else
		addChild(new FlxGame(0, 0, viwu.viwushots.PlayState));
		#end
	}
}
