package Extinction
{
	import com.as3toolkit.events.KeyboarderEvent;
	import com.as3toolkit.ui.Keyboarder;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Document extends MovieClip
	{
		private var kb:Keyboarder;
		
		public function Document()
		{
			kb = new Keyboarder(this);
			super();
			var g:Game = new Game(this);
			addChild(g);
		}
	}
}