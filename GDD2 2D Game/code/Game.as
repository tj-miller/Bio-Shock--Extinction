package code {
	
	import flash.events.*;
	import flash.utils.getTimer;
	
	public class Game {
		
		//total time passed
		var time:Number = 0;
		//Declare Player here		
		//Declare Ground here
		//Declare EnemyManager here
		//Declare BulletManager here

		public function Game() {
			//add children here
			
			//listeners
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(e:Event) {
			//update time passed
			time += getTimer();
			
			//update player here
			//update enemyManager here
			//update bulletManager here
		}

	}
	
}
