package  Extinction
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class EnemyManager extends MovieClip
	{
		private var enemies:Array;
		private var bulletManager:BulletManager;
		private var p:Player;
		private var g:Game;
		private var enemiesAlive:int;

		public function EnemyManager(bm:BulletManager, pl:Player, ga:Game) 
		{
			enemies = new Array();
			p = pl;
			g = ga;
			bulletManager = bm;
			enemiesAlive = 6;
		}
		
		public function spawnEnemies()
		{
			if(enemies.length < enemiesAlive)
			{
				var ran:int = -100;
				if(Math.random()*2 > 1.0){
					ran = 900;
				}
				var dodoBird:DodoBird = new DodoBird(p, new Point(ran, 400), 3, g);
				enemies.push(dodoBird);
				g.addChild(dodoBird);
				
			}
		}
		
		public function scrollEnemy(num:Number)
		{

			for(var i:int = 0; i < enemies.length; i++)
			{
				enemies[i].x += num;

			}
			
		}
		
		public function update()
		{
			for(var i:int = 0; i < enemies.length; i++)
			{
				enemies[i].update(3);

			}
			updateCollisions();
			spawnEnemies();
		}
		
		public function updateCollisions()
		{
			for(var j:int = 0; j < enemies.length; j++)
			{
				for(var i:int = 0; i < bulletManager.bullets.length; i++)
				{
					if((enemies[j] as Enemy).hitTestObject((bulletManager.bullets[i] as Bullet)))
					{
						g.removeChild(enemies[j]);
						enemies.splice(j, 1);
						j--;
						bulletManager.killBullet(i);
						i = bulletManager.bullets.length;
					}
				}
			}
		}

	}
	
}
