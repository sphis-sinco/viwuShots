package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.system.debug.console.ConsoleUtil;
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

		#if randomSave
		FlxG.save.bind('Viwu Shots (Random Save)', 'Sphis');
		#else
		FlxG.save.bind('Viwu Shots', 'Sphis');
		#end

		Application.current.onExit.add(l ->
		{
			FlxG.save.flush();
		});

		if (FlxG.save.data.highscore == null)
			FlxG.save.data.highscore = 0;

		#if randomSave
		FlxG.save.data.highscore = FlxG.random.int(0, Std.int(300 * FlxG.random.float(0, 10)));
		#end

		ConsoleUtil.registerFunction('New Target', () ->
		{
			Balloon.initTypes();
			FlxG.resetGame();
		});

		ConsoleUtil.registerFunction('ResetGame', () ->
		{
			Balloon.initTypes();
			Target.getPositions();

			FlxG.resetGame();
		});

		#if ViwuShootAnimationOffsetsState
		addChild(new FlxGame(0, 0, sphis.viwushots.ViwuShootAnimationOffsetsState));
		#elseif ViwuGameoverAnimationOffsetsState
		addChild(new FlxGame(0, 0, sphis.viwushots.ViwuGameoverAnimationOffsetsState));
		#else
		addChild(new FlxGame(0, 0, sphis.viwushots.PlayState));
		#end
	}
}
