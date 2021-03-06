package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color 
		['The Fluffin Team'],
		['Sourcy',		'sourcy',		'Mod Lead of \nFriday Night Fluffin',					'https://twitter.com/SourceRabbit1',	0xFFFF0000],
		['Grape',		'grape',		'Coding Lead of \nFriday Night Fluffin',					'https://twitter.com/HelloGrape_',	0xFFb19cd9],
		['Person.exe',		'person',		'2nd Programmer of \nFriday Night Fluffin',					'https://www.youtube.com/channel/UCmAI7f48iRxkG2RuFRwL9TQ',	0xFF808080],
		['JULSCA',		'julsca',		'2nd Muscian of \nFriday Night Fluffin',					'https://www.youtube.com/channel/UCx2Q-B1fvlyGukqACV6pUuA',	0xFF800000],
		['Sugar',		'sugar',		'Speed Demon Charter of \nFriday Night Fluffin',					'https://twitter.com/EnhancedSugar',	0xFFdc143c],
		['Ditchu',		'ditchu',		'1st Sprite Artist of \nFriday Night Fluffin',					'https://twitter.com/DitchuArt',	0xFFd771ad],
		['Sodatax',		'sodatax',		'2nd Muscian of \nFriday Night Fluffin',					'https://twitter.com/sodatax1',	0xFF9400D3],
        ['Sylrica',		'sylrica',		'3rd Muscian of \nFriday Night Fluffin',					'',	0xFFff006f],
		['Murasaki',			'murasaki',		'2nd Programmer of \nFriday Night Fluffin',				'https://twitter.com/Murasaki_1514',		0xFFFF69B4],
		['FoodieMellow',		'foodiemellow',		'BG Artist of \nFriday Night Fluffin',					'https://twitter.com/AishkoHere',	0xFF7fffd4],
		['VoltBox',		'voltbox',		'2nd Sprite Artist of \nFriday Night Fluffin',					'https://twitter.com/ArtVoltBox',	0xFF00FF00],
		['YendeyBoy',		'yendey',		'3rd Programmer of \nFriday Night Fluffin',					'https://twitter.com/Yendeyboi',		0xFFFF6010],
		['Irondog888',		'irondog',		'2nd Charter of \nFriday Night Fluffin',					'https://twitter.com/irondoggo888',	0xFFd6d6d6],
		['Brow5',		'brow5',		'Multiple .mp4 Support Guy of \nFriday Night Fluffin',					'https://gamebanana.com/members/1960378',	0xFF964B00],
		['Floof Puppy',		'floof',		'3rd Sprite Artist of \nFriday Night Fluffin',					'https://twitter.com/floof_puppy',	0xFFFFFdd0],  
		[''],
		['Honarable Mentions'],
		['Magma Blood',		'magma',		'1st Muscian of \nFriday Night Fluffin',					'https://www.youtube.com/channel/UCAn8fpAtoU1iRPrJDiswhog',	0xFFFFFFFF],
		['HoldenHanna',		'hanna',		'Composer of Catnip and Catastrophe',					'https://www.fiverr.com/holdenhanna',	0xFFafd6db],
		['Mendes',		'mendes',		'Help with Color Pallets',					'',	0xFFf05886],
		['And You',		'msn',		':3',					'https://www.youtube.com/watch?v=dQw4w9WgXcQ',	0xFF5865F2],
		[''],
        ['Psych Engine Team'],
		['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',					'https://twitter.com/Shadow_Mario_',	0xFFFFDD33],
		['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',				'https://twitter.com/river_oaken',		0xFFC30085],
		[''],
		['Engine Contributors'],
		['shubs',				'shubs',			'New Input System Programmer',						'https://twitter.com/yoshubs',			0xFF4494E6],
		['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',						'https://twitter.com/polybiusproxy',	0xFFE01F32],
		['gedehari',			'gedehari',			'Chart Editor\'s Sound Waveform base',				'https://twitter.com/gedehari',			0xFFFF9300],
		['Keoiki',				'keoiki',			'Note Splash Animations',							'https://twitter.com/Keoiki_',			0xFFFFFFFF],
		['SandPlanet',			'sandplanet',		'Psych Engine Preacher\nAlso cool guy lol',			'https://twitter.com/SandPlanetNG',		0xFFD10616],
		['bubba',				'bubba',		'Guest Composer for "Hot Dilf"',	'https://www.youtube.com/channel/UCxQTnLmv0OAS63yzk9pVfaw',	0xFF61536A],
		[''],
		["Funkin' Crew"],
		['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",				'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",					'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",					'https://twitter.com/evilsk8r',			0xFF53E52C],
		['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",					'https://twitter.com/kawaisprite',		0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 0.5, bg.color, intendedColor, { 
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
