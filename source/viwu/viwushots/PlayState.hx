package viwu.viwushots;

import flixel.FlxState;

class PlayState extends FlxState
{
	public var viwu:Viwu;
	public var viwu_ghost:Viwu;

	override public function create()
	{
		super.create();

		viwu_ghost = new Viwu();
		add(viwu_ghost);
		viwu_ghost.alpha = .5;

		viwu = new Viwu();
		add(viwu);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
