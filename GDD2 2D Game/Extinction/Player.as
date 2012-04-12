package Extinction
{
	import com.as3toolkit.events.KeyboarderEvent;
	import com.as3toolkit.ui.Keyboarder;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class Player extends MovieClip
	{
		//variables
		private var doc:Document;
		private var game:Game;
		private var speed:Number;
		public var vel:Vector2 = new Vector2(0, 0);
				
		//constructor
		public function Player(d:Document, aGame:Game)
		{
			game = aGame;
			doc = d;
			speed = 10;
			this.y = 400;
			this.x = 300;
			super();
		}
		
		//looks at the keyboard then moves
		public function update():void
		{
			if(this.y < 400)
				vel.y += 3;
			
			doKeys();
			move();
			
			if (mouseX < torso_mc.x)
			{
				if (torso_mc.scaleX > 0)
				{
					torso_mc.scaleX *= -1;
					feet_mc.scaleX *= -1;
					arm_mc.scaleX *= -1;
					head_mc.scaleX *= -1;
				}
				
				head_mc.rotation = (Math.atan2(mouseY - head_mc.y, -(mouseX - head_mc.x)) * -(180 / Math.PI));
				arm_mc.rotation = (Math.atan2(mouseY - arm_mc.y, -(mouseX - arm_mc.x)) * -(180 / Math.PI));
				
				feet_mc.x = -7;
				head_mc.x = 3;
			}
			else
			{
				if (torso_mc.scaleX < 0)
				{
					torso_mc.scaleX *= -1;
					feet_mc.scaleX *= -1;
					arm_mc.scaleX *= -1;
					head_mc.scaleX *= -1;
				}

				head_mc.rotation = Math.atan2(mouseY - head_mc.y, mouseX - head_mc.x) * (180 / Math.PI);
				arm_mc.rotation = Math.atan2(mouseY - arm_mc.y, mouseX - arm_mc.x) * (180 / Math.PI);
				
				feet_mc.x = 7;
				head_mc.x = -3;
			}
			
		}
		
		//should we move left or right
		private function doKeys():void
		{
			vel.x = 0;
			
			if(Keyboarder.keyIsDown(Keyboard.A))
			{
				vel.x -= 1;
				if(feet_mc.currentLabel != "Walk")
				{
					feet_mc.gotoAndPlay("Walk");
				}
			}
			if(Keyboarder.keyIsDown(Keyboard.D))
			{
				vel.x += 1;
				if(feet_mc.currentLabel != "Walk")
				{
					feet_mc.gotoAndPlay("Walk");
				}
				
			}
			if(Keyboarder.keyIsDown(Keyboard.W) && this.y == 400)
				vel.y = -30;
		}
		
		//lets move left or right
		private function move():void
		{
			this.y += vel.y;
			if(this.y > 400)
			{
				this.y = 400;
				vel.y = 0;
			}
			/*
			if(this.x < 150 && vel.x < 0)
			{
				game.scrollLevel(-vel.x*speed);
			}
			else if(this.x > 550 && vel.x > 0)
			{
				game.scrollLevel(-vel.x*speed);
			}
			else*/
			//trace(x);
			this.x += speed*vel.x;
		}
	}
}