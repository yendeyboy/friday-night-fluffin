package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Guilty extends MusicBeatState
{
	var img:FlxSprite;

	var replaySelect:Bool = false;

	public function new():Void
	{
		super();
	}

	override function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		var img:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Shhhh/GUILTY', 'shared'));
        img.screenCenter();
        img.setGraphicSize(Std.int(img.width * 0.85));
		if(FlxG.save.data.antialiasing)
			{
				img.antialiasing = true;
			}
		add(img);

		super.create();
	}

    override function update(elapsed:Float)
    {   {
            if (controls.ACCEPT)
            {
                if (replaySelect)
                {
                    FlxG.switchState(new PlayState());
                }
                else
                {
                    FlxG.switchState(new MainMenuState());
                }
            }
    
            super.update(elapsed);
        }
    }
}    