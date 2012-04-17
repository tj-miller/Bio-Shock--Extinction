package Extinction
{
	//imports
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	public class BulletManager extends MovieClip
	{
		//bullets array, a doc pointer, and a layer
		public var bullets:Array = new Array();
		private var doc:Document;
		private var layer:Sprite;
		private var player:Player;
		public var firing:Boolean;
		private var reloading:Boolean;
		private var count:int;
		
		private var cooldownTime:int;
		private var xOffset:Number;
		private var yOffset:Number;
		private var reloadTime:int;
		private var clipSize:int;
		private var bulletDamage:Number;
		
		//bullet manager constructor, sets pointers and adds an event listener for click
		//(the click event should be change to a mouse down once cooldown is put in)
		public function BulletManager(d:Document, aLayer:Sprite, p:Player)
		{
			doc = d;
			layer = aLayer;
			player = p;
			firing = false;
			reloading = false;
			updateStats();
			
			super();
		}
		
		// get bullet array
		public function getBullets() : Array 
		{
			return bullets;
		}
		
		private function updateStats():void
		{
			if(player.curWeapon.isGun)
			{
				cooldownTime = (player.curWeapon as Gun).cooldownTime;
				xOffset = (player.curWeapon as Gun).xOffset;
				yOffset = (player.curWeapon as Gun).yOffset;
				reloadTime = (player.curWeapon as Gun).reloadTime;
				clipSize = (player.curWeapon as Gun).clipSize;
				bulletDamage = (player.curWeapon as Gun).bulletDamage;
			}
		}
		
		//update function, calls move for all bullets and cleans up any more than a screen and a half away
		public function update():void
		{
			updateStats();
			
			count++;
			var b:Bullet;
			
			for(var i:int = 0; i < bullets.length; i++)
			{
				b = bullets[i] as Bullet;
				b.move();
			}
			
			cleanUp();
			
			if (firing && count > cooldownTime && !reloading)
			{
				if(clipSize > (player.curWeapon as Gun).shotsFired)
				{
					fireBullet();
					count = 0;
					(player.curWeapon as Gun).shotsFired++;
					trace(clipSize - (player.curWeapon as Gun).shotsFired);
				}
				else
				{
					reloading = true;
					count = 0;
				}
			}
			
			if(reloading && count > reloadTime)
			{
				reloading = false;
				(player.curWeapon as Gun).shotsFired = 0;
				count = 0;
			}
		}
		
		private function stopFiring(e:MouseEvent):void
		{
			firing = false;
		}
		
		private function fireGun(e:MouseEvent):void
		{
			firing = true;
		}
		
		//fires a bullet on mouse click, right now its from the origin to the cursor
		public function fireBullet():void
		{
			var b:Bullet = new Bullet((player.curWeapon as Gun).bulletDamage);
			var v:Vector2 = new Vector2(mouseX-player.x, mouseY-(player.y+player.arm_mc.y));
			v.normalize();
			var p:Point = new Point(player.curWeapon.x, player.curWeapon.y);
			if (Math.abs(mouseX - player.x) > 20 || Math.abs(mouseY - (player.y+player.arm_mc.y)) > 80)
			{
				if(mouseX < player.x)
				{
					p.x -= Math.cos(-player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).xOffset;
					p.y -= Math.sin(-player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).xOffset;
					
					p.x += Math.sin(-player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).yOffset;
					p.y -= Math.cos(-player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).yOffset;
				}
				else
				{
					p.x += Math.cos(player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).xOffset;
					p.y += Math.sin(player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).xOffset;
					
					p.x += Math.sin(player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).yOffset;
					p.y -= Math.cos(player.arm_mc.rotation*Math.PI/180)*(player.curWeapon as Gun).yOffset;
				}
				
				b.fire(p,v);
				layer.addChild(b);
				bullets.push(b);
				
				player.shootGun();
			}
		}
		
		//cleans up any bullet far off screen
		public function cleanUp():void
		{
			var b:Bullet;
			
			for(var i:int = 0; i < bullets.length; i++)
			{
				b = bullets[i] as Bullet;
				if(Math.abs(b.x-(doc.stage.stageWidth/2)) > (doc.stage.stageWidth*.75) || Math.abs(b.y-(doc.stage.stageHeight/2)) > (doc.stage.stageHeight*.75))
				{
					layer.removeChild(b);
					bullets.splice(i, 1);
					i--;
				}
			}
		}
		
		public function killBullet(index:int):void
		{
			layer.removeChild(bullets[index]);
			bullets.splice(index,1);
		}
	}
}