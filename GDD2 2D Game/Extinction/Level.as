package Extinction
{
	import fl.motion.easing.Back;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Level extends MovieClip
	{
		
		public var background = new Sprite();
		public var midground = new Sprite();
		public var foreground = new Sprite();
		
		//consructor
		public function Level()
		{
			super();
			
			addChild(background);
			addChild(midground);
			addChild(foreground);
			
			this.x = 350;
			this.y = 250;
			
			background.addChild(new Background());
			midground.addChild(new Midground());
			foreground.addChild(new Foreground());
		}
		
		public function scrollLevel(amount:Number)
		{
			foreground.x += amount;
			midground.x += amount/2;
			background.x += amount/4;
		}
	}
}