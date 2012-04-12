package Extinction
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Bullet extends MovieClip
	{
		//velocities and speed
		private var vx:Number;
		private var vy:Number;
		private var speed:Number;
		
		//consructor
		public function Bullet()
		{
			super();
			
			speed = 25;
		}
		
		//sets appropriate position info, rotation, and velocities
		public function fire(pos:Point, vel:Vector2):void
		{
			this.x = pos.x;
			this.y = pos.y;
			this.rotation = vel.angle;
			
			vx=vel.x*speed;
			vy=vel.y*speed;
		}
		
		//moves the bullet based on its velocity
		public function move():void
		{
			this.y += vy;
			this.x += vx;
		}
	}
}