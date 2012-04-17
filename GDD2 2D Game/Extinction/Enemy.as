package  Extinction
{
	import flash.display.MovieClip;
	import flash.geom.Point;
		
	public class Enemy extends MovieClip
	
	{
		private var health:Number = 25;
		private var vx:int;
		private var vy:int;
		private var spawnPoint:Point;
		private var player:Player;
		private var game:Game;
		private var speed:Number;

		//Takes in the player, a point to spawn the enemy, how fast they move, and a game reference
		public function Enemy(plyr:Player, pnt:Point, enemySpeed:Number, g:Game) 
		{
			spawnPoint = pnt;
			player = plyr;
			speed = enemySpeed;
			this.x = spawnPoint.x;
			this.y = spawnPoint.y;
			game = g;
		}
		
		//Moves based on player position. If their X is less than the player's X, they must be to the left of him. So move right.
		//Also implements gravity
		private function move():void
		{
			
			if(this.x < player.x)
			{
				if(vx < speed)
					vx += speed/2;
			}
			else if(this.x > player.x)
			{
				if(vx > -speed)
					vx -= speed/2;
			}
			
			if(this.y > 400)
			{
				this.y = 400;
				vy = 0;
			}
			else if(this.y < 400)
			{
				this.y += vy;
			}
			
			this.x += vx;
		}
		
		//Gravity and move
		public function update(velX:int)
		{
			move();
			vy += 3;
			
		}
		
		public function takeDamage(dmgAmount:Number):void
		{
			health -= dmgAmount;
			
			if(health <= 0)
				die();
			else
				knockback();
				
		}
		
		private function die():void
		{
			
		}
		
		private function knockback():void
		{
			
		}
		
		private function removeSelf():void
		{
			
		}

	}
	
}
