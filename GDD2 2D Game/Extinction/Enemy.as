package  Extinction
{
	import flash.display.MovieClip;
	import flash.geom.Point;
		
	public class Enemy extends MovieClip
	
	{
		private var health:int;
		private var vx:int;
		private var vy:int;
		private var spawnPoint:Point;
		private var _player:Player;
		private var game:Game;

		//Takes in the player, a point to spawn the enemy, how fast they move, and a game reference
		public function Enemy(plyr:Player, pnt:Point, velX:int, g:Game) 
		{
			spawnPoint = pnt;
			_player = plyr;
			this.x = spawnPoint.x;
			this.y = spawnPoint.y;
			vx = velX;
			game = g;
		}
		
		//Moves based on player position. If their X is less than the player's X, they must be to the left of him. So move right.
		//Also implements gravity
		public function Move()
		{
			
			if(this.x < _player.x)
			{
				this.x += vx;
			}
			else if(this.x > _player.x)
			{
				this.x -= vx;
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
		}
		
		//Gravity and move
		public function update(velX:int)
		{
			Move();
			vy += 3;
			
		}

	}
	
}
