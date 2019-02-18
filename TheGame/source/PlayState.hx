package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxObject;
import flixel.addons.*;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.input.keyboard.FlxKeyList;
import flixel.text.FlxText;
import flixel.util.FlxTimer;


class PlayState extends FlxState
{
var player: flixel.FlxSprite;
var player2: flixel.FlxSprite;
var healthPlayer: Int;
var healthPlayer2: Int;
var bulletPlayer:FlxSprite;
var bulletPlayer2: FlxSprite;
var map: FlxOgmoLoader;
var mWalls: FlxTilemap;
var leftWall:FlxSprite;
var rightWall:FlxSprite;
var topWall:FlxSprite;
var bottomWall:FlxSprite;
var canShoot2: Bool;
var canShoot:Bool;
var healthText:FlxText;
var healthText2:FlxText;
var gameOver:FlxText;
var blackscreen:FlxSprite;
var player1Won:FlxText;
var player2Won:FlxText;



	override public function create():Void
	{
		
		FlxG.sound.play("assets/sounds/heartbeat.wav",0.15,true);
		healthPlayer=100;
		healthPlayer2=100;

		healthText=new FlxText(0,0, FlxG.width, "Dinosaur: "+ healthPlayer);
		healthText.setFormat(null,15, FlxColor.LIME,"left");
		
		
		healthText2=new FlxText(0,0, FlxG.width, "Zombie: "+ healthPlayer2);
		healthText2.setFormat(null,15, FlxColor.LIME,"right");

		gameOver=new FlxText(0,FlxG.height/2-50, FlxG.width, "Thank you for playing!");
		gameOver.setFormat(null,50, FlxColor.GREEN,"center");
		gameOver.visible = false;
		

		player1Won=new FlxText(0,FlxG.height/50, FlxG.width, "Dinosaur has conquered the world");
		player1Won.setFormat(null,50, FlxColor.WHITE,"center");
		player1Won.visible = false;
		

		player2Won=new FlxText(0,FlxG.height/50, FlxG.width, "Zombie has conquered the world");
		player2Won.setFormat(null,50, FlxColor.WHITE,"center");
		player2Won.visible = false;
		


		blackscreen = new FlxSprite(0,0);
		blackscreen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackscreen.visible = false;
		

		canShoot=true;
		canShoot2=true;

		map = new FlxOgmoLoader("assets/ogmo/Level1.oel");
 		mWalls = map.loadTilemap("assets/images/walls.png", 32, 32, "wall");
 		mWalls.follow();
 		mWalls.setTileProperties(1, FlxObject.NONE);
 		mWalls.setTileProperties(2, FlxObject.ANY);
 		add(mWalls);

 		player = new FlxSprite(20,20);
 		player.loadGraphic("assets/images/dino1.png");
 		add(player);

 		player2= new FlxSprite(580,50);
 		player2.loadGraphic("assets/images/zombie.png");
 		add(player2);
 		FlxG.camera.follow(player, TOPDOWN, 1);
 		map.loadEntities(placeEntities, "entities");

 		bulletPlayer = new FlxSprite(FlxG.width/2-5, FlxG.height-30);
		bulletPlayer.makeGraphic(9, 2, FlxColor.WHITE);
		bulletPlayer.visible = false;
		add(bulletPlayer);

		bulletPlayer2 = new FlxSprite(FlxG.width/2-5, FlxG.height-30);
		bulletPlayer2.makeGraphic(9, 2, FlxColor.WHITE);
		bulletPlayer2.visible = false;
		add(bulletPlayer2);


		leftWall=new Wall(0,0,32,480);
		topWall=new Wall(0,0,640,32);
		add(leftWall);
		add(topWall);
		rightWall=new Wall(608,0,32,480);
		bottomWall=new Wall(0,448,640,32);
		add(rightWall);
		add(bottomWall); 
		add(healthText2);
		add(healthText);
		add(blackscreen);
		add(gameOver);
		add(player1Won);
		add(player2Won);
 	
		super.create();
	}

	function placeEntities(entityName:String, entityData:Xml):Void
 {
     var x:Int = Std.parseInt(entityData.get("x"));
     var y:Int = Std.parseInt(entityData.get("y"));
     if (entityName == "player")
     {
         player.x = x;
         player.y = y;
     }
 }

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player,mWalls);
		FlxG.collide(player,leftWall);
		FlxG.collide(player,rightWall);
		FlxG.collide(player,topWall);
		FlxG.collide(player,bottomWall);

		FlxG.collide(bulletPlayer,mWalls, BWall);
		FlxG.collide(bulletPlayer,leftWall, BWall);
		FlxG.collide(bulletPlayer,rightWall, BWall);
		FlxG.collide(bulletPlayer,topWall, BWall);
		FlxG.collide(bulletPlayer,bottomWall, BWall);

		FlxG.collide(player2,mWalls);
		FlxG.collide(player2,leftWall);
		FlxG.collide(player2,rightWall);
		FlxG.collide(player2,topWall);
		FlxG.collide(player2,bottomWall);

		FlxG.collide(bulletPlayer2,mWalls, BWall2);
		FlxG.collide(bulletPlayer2,leftWall, BWall2);
		FlxG.collide(bulletPlayer2,rightWall, BWall2);
		FlxG.collide(bulletPlayer2,topWall, BWall2);
		FlxG.collide(bulletPlayer2,bottomWall, BWall2);

		FlxG.collide(bulletPlayer, player2, Hit);
		FlxG.collide(bulletPlayer2, player, Hit2);

		player.velocity.x=0;
		player.velocity.y=0;
		player2.velocity.x=0;
		player2.velocity.y=0;

		if (healthPlayer2<=0 )
		{
			blackscreen.visible = true;
			gameOver.visible = true;
			player1Won.visible= true;
			
				new FlxTimer().start(2, function (timer)
				{
					FlxG.switchState(new MenuState());
				});
			
			
		}


		if (healthPlayer<=0 )
		{
			blackscreen.visible = true;
			gameOver.visible = true;
			player2Won.visible= true;
			
				new FlxTimer().start(2, function (timer)
				{
					FlxG.switchState(new MenuState());
				});
			
			
		}

		if(FlxG.keys.justReleased.ENTER && canShoot2 == true){
			canShoot2=false;
			bulletPlayer2.exists=true;
			bulletPlayer2.visible=true;
			bulletPlayer2.x = player2.x+player2.width/2;
			bulletPlayer2.y = player2.y+player2.height/2;
			var x = player2.x-player.x;
			if(x<0){

			bulletPlayer2.velocity.x= 1000;	
			FlxG.sound.play("assets/sounds/Gun+Silencer.wav",0.15,false);
			x=1;
			}
			else{
			bulletPlayer2.velocity.x= -1000;
			FlxG.sound.play("assets/sounds/Gun+Silencer.wav",0.15,false);
			x=-1;
			}
		}

		if(FlxG.keys.justReleased.SPACE && canShoot == true){
			canShoot=false;
			
			bulletPlayer.exists=true;
			bulletPlayer.visible=true;
			bulletPlayer.x = player.x+player.width/2;
			bulletPlayer.y = player.y+player.height/2;
			var x = player2.x-player.x;
			if(x>0){

			bulletPlayer.velocity.x= 1000;	
			FlxG.sound.play("assets/sounds/Gun+Silencer.wav",0.15,false);
			x=-1;
			}
			else{
			bulletPlayer.velocity.x= -1000;
			FlxG.sound.play("assets/sounds/Gun+Silencer.wav",0.15,false);
			x=1;
			}
		}

		//if(healthPlayer2<=0 || healthPlayer<=0){
		//	FlxG.switchState( new MenuState());
		//}

		if(FlxG.keys.anyPressed(["D"])){
			player.velocity.x=100;
		}
		if(FlxG.keys.anyPressed(["A"])){
			player.velocity.x=-100;
		}
		if(FlxG.keys.anyPressed(["W"])){
			player.velocity.y= -100;

		}
		if(FlxG.keys.anyPressed(["S"])){
			player.velocity.y= 100;
		}
		if(FlxG.keys.anyPressed(["RIGHT"])){
			player2.velocity.x=100;
		}
		if(FlxG.keys.anyPressed(["LEFT"])){
			player2.velocity.x=-100;
		}
		if(FlxG.keys.anyPressed(["UP"])){
			player2.velocity.y= -100;

		}
		if(FlxG.keys.anyPressed(["DOWN"])){
			player2.velocity.y= 100;
		}
		
	}

	function BWall(Bullet:FlxObject, Wall:FlxObject):Void{
		Bullet.exists=false;
		canShoot=true;
	}

	function BWall2(Bullet:FlxObject, Wall:FlxObject):Void{
		Bullet.exists=false;
		canShoot2=true;
		
	}

	function Hit(Bullet:FlxObject, Player:FlxObject):Void{
		Bullet.exists=false;
		canShoot=true;
		healthPlayer2-=20;
		healthText2.text="Zombie: " + healthPlayer2;

	}
	function Hit2(Bullet:FlxObject, Player:FlxObject):Void{
		Bullet.exists=false;
		canShoot2=true;
		healthPlayer-=20;
		healthText.text="Dinosaur: " + healthPlayer;


	}
}
