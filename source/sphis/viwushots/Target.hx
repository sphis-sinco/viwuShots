package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import haxe.xml.Access;
import lime.utils.Assets;

using StringTools;

class Target extends FlxSprite
{
	public static var positions:Map<String, FlxPoint> = [];

	override public function new()
	{
		super(positions.get(Balloon.targetType).x, positions.get(Balloon.targetType).y);

		loadAsset();
	}

	public static function getPositions()
	{
		positions = [];
		var txt = Assets.getText('assets/images/targets-positions.txt').split('\n');
		for (entry in txt)
		{
			var splitEntry = entry.split(' ');
			positions.set(splitEntry[0], new FlxPoint(Std.parseFloat(splitEntry[1]), Std.parseFloat(splitEntry[2])));

			trace('Got offsets for balloon target: ${splitEntry[0]} ${positions.get(splitEntry[0])}');
		}
	}

	public function loadAsset()
	{
		if (Balloon.types == null)
		{
			this.makeGraphic(256, 256, FlxColor.RED);

			return;
		}

		frames = FlxAtlasFrames.fromSparrow('assets/images/targets.png', 'assets/images/targets.xml');

		for (type in Balloon.types)
			animation.addByPrefix(type, 'target $type');

		animation.play(Balloon.targetType);
	}
}
