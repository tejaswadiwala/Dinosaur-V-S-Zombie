package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.*;
import flixel.ui.*;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var gameTitle:flixel.text.FlxText;
	var btnPlay:flixel.ui.FlxButton;
	var developer:FlxText;

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	override public function create():Void
	{
		FlxG.cameras.flash(FlxColor.BLACK, 3);
		gameTitle = new FlxText(0,FlxG.height/4, FlxG.width, "Dinosaur V/S Zombie \n Who will conquer the World?");
		gameTitle.setFormat(null,30,FlxColor.WHITE, "center");
		add(gameTitle);
		FlxG.sound.play("assets/sounds/heartbeat.wav",0.15,true);
		btnPlay= new FlxButton (280, 220, "Play", clickPlay);
		add(btnPlay);

		developer = new FlxText(280,300, 100, "Developed by Tejas Wadiwala \n @tejaswadiwala");
		add(developer);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
