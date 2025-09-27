package viwu.viwushots;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;

class Viwu extends FlxSprite
{
	public var offsets:Map<String, FlxPoint> = [];

	override public function new()
	{
		super();

		offsets.clear();
		loadAsset();
	}

	public function loadAsset()
	{
		frames = FlxAtlasFrames.fromSparrow('assets/images/viwu.png', 'assets/images/viwu.xml');

		animation.addByPrefix('idle', 'viwu animation idle', 24, true);
		animation.addByPrefix('focus', 'viwu animation focus', 24, false);
		animation.addByPrefix('unfocus', 'viwu animation unfocus', 24, false);
		animation.addByPrefix('shoot', 'viwu animation shoot', 24, false);

		offsets.set('idle', new FlxPoint(0, 0));
		offsets.set('focus', new FlxPoint(0, 0));
		offsets.set('unfocus', new FlxPoint(0, 0));
		offsets.set('shoot', new FlxPoint(31, 46));

		animation.playCallback = animName ->
		{
			if (offsets.exists(animName))
				offset.set(offsets.get(animName).x, offsets.get(animName).y);
			else
				offset.set();
		}
	}
}
