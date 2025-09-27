package viwu.viwushots;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var viwu:Viwu;
	public var floor:FlxSprite;

	override public function create()
	{
		super.create();

		viwu = new Viwu();
		add(viwu);

		floor = new FlxSprite().loadGraphic('assets/images/floor.png');
		add(floor);

		floor.setPosition(-275.95, 437.25);
		viwu.setPosition(-59.7, 65.2);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
