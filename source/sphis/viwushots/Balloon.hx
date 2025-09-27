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
	public static var types = [];
	public static var targetType:String;

	public var type:String;

	public var storage:Dynamic = {};

	override public function new()
	{
		super(0, 0);

		loadAsset();
	}

	public static function initTypes()
	{
		types = [];

		var xml:Access = new Access(Xml.parse(Assets.getText('assets/images/balloons.xml')).firstElement());

		if (xml == null)
		{
			trace('Null XML');
			types = null;
			return;
		}

		for (subtexture in xml.elements)
		{
			if (subtexture.name == 'SubTexture' && subtexture.has.name)
			{
				var typeName = subtexture.att.name.replace('balloon ', '');
				typeName = typeName.replace('0', '');
				typeName = typeName.replace('1', '');
				typeName = typeName.replace('2', '');
				typeName = typeName.replace('3', '');
				typeName = typeName.replace('4', '');
				typeName = typeName.replace('5', '');
				typeName = typeName.replace('6', '');
				typeName = typeName.replace('7', '');
				typeName = typeName.replace('8', '');
				typeName = typeName.replace('9', '');

				if (!types.contains(typeName))
				{
					trace('Found balloon type: $typeName');
					types.push(typeName);
				}
			}
		}

		targetType = types[FlxG.random.int(0, types.length - 1)];
		trace('Target Balloon Type: $targetType');
	}

	public function loadAsset()
	{
		if (types == null)
		{
			this.makeGraphic(256, 256, FlxColor.RED);

			return;
		}

		frames = FlxAtlasFrames.fromSparrow('assets/images/balloons.png', 'assets/images/balloons.xml');

		for (type in types)
			animation.addByPrefix(type, 'balloon $type');

		useRandomType();
	}

	public function useRandomType()
	{
		animation.play(animation.getNameList()[FlxG.random.int(0, animation.getNameList().length - 1)]);

		type = animation.name;

		if (type == targetType && FlxG.random.bool(1))
			useRandomType();
	}
}
