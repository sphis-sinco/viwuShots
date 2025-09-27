package viwu.viwushots;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

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
		viwu_ghost.color = FlxColor.RED; // red for visability

		viwu = new Viwu();
		add(viwu);

		viwu.animation.play('focus');
		viwu_ghost.animation.play('focus');
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.S)
		{
			viwu.animation.play('shoot');
			viwu.animation.pause();
		}
		if (FlxG.keys.justReleased.F)
		{
			viwu.animation.play('focus', false, false, 8);
			viwu.animation.pause();
		}
	}
}
