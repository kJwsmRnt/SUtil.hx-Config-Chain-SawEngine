package parse;

import openfl.utils.Assets;
import haxe.Json;

typedef SwagWeek =
{
	var songs:Array<SwagSongs>;
	var characters:Array<String>;
	var name:String;
	var locked:Bool;
	var unlockAfter:String;
	var hideStoryMode:Bool;
	var hideFreeplay:Bool;
	var hiddenUntilUnlocked:Bool;
}

typedef SwagSongs =
{
	var name:String;
	var character:String;
	var colors:Array<Int>;
}

class Week
{
	public static var currentLoadedWeeks:Map<String, SwagWeek> = [];
	public static var weeksList:Array<String> = [];

	public static function loadJsons(isStoryMode:Bool = false)
	{
		currentLoadedWeeks.clear();
		weeksList = [];

		final list:Array<String> = CoolUtil.coolTextFile(Paths.txt('weeks/weekList'));
		for (i in 0...list.length)
		{
			if (!currentLoadedWeeks.exists(list[i]))
			{
				var week:SwagWeek = parseJson(Paths.json('weeks/' + list[i]));
				if (week != null)
				{
					if (week != null && (isStoryMode && !week.hideStoryMode) || (!isStoryMode && !week.hideFreeplay))
					{
						currentLoadedWeeks.set(list[i], week);
						weeksList.push(list[i]);
					}
				}
			}
		}
	}

	public static function parseJson(path:String):SwagWeek
	{
		var rawJson:String = null;

		if (Assets.exists(path))
			rawJson = Assets.getText(path);

		return Json.parse(rawJson);
	}
}
