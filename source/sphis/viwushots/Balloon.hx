package sphis.viwushots;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import haxe.xml.Access;
import lime.utils.Assets;

using StringTools;

class Balloon extends FlxSprite
{
	override public function new()
	{
		super(0, 0);

		loadAsset();
	}

	public function loadAsset()
	{
		var xml:Access = new Access(Xml.parse(Assets.getText('assets/images/balloons.xml')).firstElement());

		if (xml == null)
		{
			trace('Null XML');
			makeGraphic(256, 256, FlxColor.RED);
			return;
		}

		var types = [];

		for (subtexture in xml.elements)
		{
			if (subtexture.name == 'SubTexture' && subtexture.has.name)
			{
				trace('Found balloon type: ${subtexture.att.name.replace('balloon ', '').replace('0000', '')}');
				types.push(subtexture.att.name.replace('balloon ', '').replace('0000', ''));
			}
		}

		frames = FlxAtlasFrames.fromSparrow('assets/images/balloons.png', 'assets/images/balloons.xml');

		for (type in types)
			animation.addByPrefix(type, 'balloon $type');

		useRandomType();
	}

	public function useRandomType()
		animation.play(animation.getNameList()[FlxG.random.int(0, animation.getNameList().length - 1)]);
}
