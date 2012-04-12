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
		
		//bullet manager constructor, sets pointers and adds an event listener for click
		//(the click event should be change to a mouse down once cooldown is put in)
		public function BulletManager(d:Document, aLayer:Sprite, p:Player)
		{
			doc = d;
			layer = aLayer;
			player = p;
			
			super();
			
			doc.stage.addEventListener(MouseEvent.CLICK, fireBullet);
		}
		
		// get bullet array
		public function getBullets() : Array 
		{
			return bullets;
		}
		
		//update function, calls move for all bullets and cleans up any more than a screen and a half away
		public function update():void
		{
			var b:Bullet;
			
			for(var i:int = 0; i < bullets.length; i++)
			{
				b = bullets[i] as Bullet;
				b.move();
			}
			
			cleanUp();
		}
		
		//fires a bullet on mouse click, right now its from the origin to the cursor
		public function fireBullet(e:MouseEvent):void
		{
			var b:Bullet = new Bullet();
			var v:Vector2 = new Vector2(e.stageX-player.x, e.stageY-(player.y-30));
			v.normalize();
			var p:Point = new Point(player.x+player.arm_mc.x, player.y+player.arm_mc.y);
			if(mouseX < player.x)
			{
				p.x -= Math.cos(player.arm_mc.rotation*Math.PI/180)*90;
				p.y -= Math.sin(player.arm_mc.rotation*Math.PI/180)*90;
			}
			else
			{
				p.x += Math.cos(player.arm_mc.rotation*Math.PI/180)*90;
				p.y += Math.sin(player.arm_mc.rotation*Math.PI/180)*90;
			}
			b.fire(p,v);
			layer.addChild(b);
			bullets.push(b);
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