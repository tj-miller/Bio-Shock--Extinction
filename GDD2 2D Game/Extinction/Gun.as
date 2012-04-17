package Extinction
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.Sprite;
	
	public class Gun extends Weapon
	{
		private var gunType:int
		private var layer:Sprite;
		private var player:Player;
		private var shootCount:int;
		
		public var cooldownTime:int;
		public var xOffset:Number;
		public var yOffset:Number;
		public var reloadTime:int;
		public var clipSize:int;
		public var bulletDamage:Number;
		
		public var shotsFired:int;
		
		public function Gun(gLayer:Sprite, p:Player, type:int)
		{
			player = p;
			layer = gLayer;
			gunType = type;
			shotsFired = 0;
			shootCount = 10;
			
			super();
			isGun = true;
			
			if(gunType == 0)
			{
				cooldownTime = 3;
				xOffset = 110;
				yOffset = 11;
				reloadTime = 20;
				clipSize = 30;
				bulletDamage = 1;
				gotoAndStop("M16");
			}
			if(gunType == 1)
			{
				cooldownTime = 7;
				xOffset = 40;
				yOffset = 8;
				reloadTime = 10;
				clipSize = 12;
				bulletDamage = 3;
				gotoAndStop("Pistol");
			}
		}
		
		public override function update():void
		{
			this.y = player.y+player.arm_mc.y;
			if(player.scaleX > 0)
			{
				this.x = player.x+player.arm_mc.x;
				this.rotation = player.arm_mc.rotation;
				this.x += Math.cos(this.rotation*Math.PI/180)*75;
				this.y += Math.sin(this.rotation*Math.PI/180)*75;
				this.scaleX = 1;
				
				if(shootCount < 2)
					this.x -= (shootCount+1)*2;
				else if (shootCount < 4)
					this.x += (3-shootCount)*2-4;
			}
			else
			{
				this.x = player.x-player.arm_mc.x;
				this.rotation = -player.arm_mc.rotation;
				this.x -= Math.cos(this.rotation*Math.PI/180)*75;
				this.y -= Math.sin(this.rotation*Math.PI/180)*75;
				this.scaleX = -1;
				
				if(shootCount < 2)
					this.x += shootCount*2;
				else if (shootCount < 4)
					this.x -= (3-shootCount)*2-4;
			}
			
			
			
			shootCount++;
				
		}
		
		public function shoot():void
		{
			shootCount = 0;
		}
	}
}