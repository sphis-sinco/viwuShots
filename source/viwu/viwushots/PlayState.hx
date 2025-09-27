package viwu.viwushots;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var viwu:Viwu;

	override public function create()
	{
		super.create();

		viwu = new Viwu();
		add(viwu);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
