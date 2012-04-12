package Extinction
{
	import flash.geom.Point;
	
	public class DodoBird extends Enemy
	{
		
		private var game:Game;
		
		public function DodoBird(p:Player, pnt:Point, v:int, g:Game) 
		{
			game = g;
			super(p, pnt, v, game);
		}

	}
	
}
