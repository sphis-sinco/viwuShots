package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import lime.app.Application;
import openfl.display.Sprite;
import sphis.viwushots.Balloon;
import sphis.viwushots.Target;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxSprite.defaultAntialiasing = true;
		Balloon.initTypes();
		Target.getPositions();

		FlxG.save.bind('Viwu Shots', 'Sphis');

		Application.current.onExit.add(l ->
		{
			FlxG.save.flush();
		});

		if (FlxG.save.data.highscore == null)
			FlxG.save.data.highscore = #if randomSave FlxG.random.int(0, Std.int(300 * FlxG.random.float(0, 10))) #else 0 #end;

		#if ViwuShootAnimationOffsetsState
		addChild(new FlxGame(0, 0, sphis.viwushots.ViwuShootAnimationOffsetsState));
		#elseif ViwuGameoverAnimationOffsetsState
		addChild(new FlxGame(0, 0, sphis.viwushots.ViwuGameoverAnimationOffsetsState));
		#else
		addChild(new FlxGame(0, 0, sphis.viwushots.PlayState));
		#end
	}
}
