package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class ViwuGameoverAnimationOffsetsState extends FlxState
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

		viwu.animation.play('idle');
		viwu_ghost.animation.play('idle');

		viwu_ghost.screenCenter();
		viwu.screenCenter();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.S)
		{
			viwu.animation.play('results-bad');
			viwu.animation.pause();
		}
		if (FlxG.keys.justReleased.F)
		{
			viwu.animation.play('idle');
			viwu.animation.pause();
		}

		if (viwu.animation.name == 'results-bad')
		{
			var offsets = viwu.offsets.get('results-bad');

			if (FlxG.keys.justReleased.LEFT)
				offsets.x += 1;
			if (FlxG.keys.justReleased.RIGHT)
				offsets.x -= 1;
			if (FlxG.keys.justReleased.UP)
				offsets.y += 1;
			if (FlxG.keys.justReleased.DOWN)
				offsets.y -= 1;

			if (FlxG.keys.anyJustReleased([LEFT, DOWN, UP, RIGHT]))
			{
				viwu.offsets.set('results-bad', offsets);
				viwu.animation.play('results-bad');
				viwu.animation.pause();
			}
		}
		FlxG.watch.addQuick('Viwu results-bad offsets', viwu.offsets.get('results-bad'));
	}
}
