package viwu.viwushots;

import flixel.FlxState;

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
