package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import openfl.display.Sprite;
import sphis.viwushots.Balloon;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxSprite.defaultAntialiasing = true;
		Balloon.initTypes();

		FlxG.save.bind('Viwu Shots', 'Sphis');

		if (FlxG.save.data.highscore == null)
			FlxG.save.data.highscore = 0;

		#if ViwuShootAnimationOffsetsState
		addChild(new FlxGame(0, 0, sphis.viwushots.ViwuShootAnimationOffsetsState));
		#else
		addChild(new FlxGame(0, 0, sphis.viwushots.PlayState));
		#end
	}
}
