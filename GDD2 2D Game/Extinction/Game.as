﻿package Extinction
{
	import com.as3toolkit.events.KeyboarderEvent;
	import com.as3toolkit.ui.Keyboarder;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class Game extends Sprite
	{
		private var layer:Sprite = new Sprite();
		private var c:Cursor = new Cursor();
		private var doc:Document;
		private var curLevel:Level = new Level();
		private var scrollSpeed:Number = 20;
		
		//total time passed
		private var time:Number = 0;
		//Declare Player here		
		//Declare Ground here
		//Declare EnemyManager here
		//Declare BulletManager here
		public var player:Player;
		private var bManager:BulletManager;
		private var enMan:EnemyManager;
		
		public function Game(d:Document)
		{
			doc = d;
			
			super();
			
			//add event listeners
			doc.addEventListener(Event.ENTER_FRAME, update);
			
			player = new Player(doc, this);
			bManager = new BulletManager(doc, layer, player);
			enMan = new EnemyManager(bManager, player, this);

			
			addChild(curLevel);
			addChild(layer);
			addChild(player);
			addChild(c);
			enMan.spawnEnemies();
		}
		
		public function update(e:Event):void
		{
			//cursor location
			c.x = mouseX;
			c.y = mouseY;
			
			//update time passed
			time += getTimer();
			//update player here
			//update enemyManager here
			bManager.update();
			player.update();
			enMan.update();
			
			if(Math.abs(player.x-stage.stageWidth/2) > 50)
			{
				centerCamera();
			}
		}
		
		public function centerCamera():void
		{
			var moveAmnt:Number = -(player.x - (stage.stageWidth/2)) / scrollSpeed;
			
			player.x += moveAmnt;
			enMan.scrollEnemy(moveAmnt);
			curLevel.scrollLevel(moveAmnt);
			
		}
	}
}
