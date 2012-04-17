package Extinction
{
	import com.as3toolkit.events.KeyboarderEvent;
	import com.as3toolkit.ui.Keyboarder;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	public class Player extends MovieClip
	{
		//variables
		private var doc:Document;
		private var game:Game;
		private var speed:Number;
		public var curWeapon:Weapon;
		private var weapons:Array = new Array();
		
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
			
			weapons.push(new Gun(game.gLayer, this, 0));
			weapons.push(new Gun(game.gLayer, this, 1));
			curWeapon = weapons[0];
			game.gLayer.addChild(curWeapon);
			
			doc.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			doc.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function mouseDown(e:MouseEvent):void
		{
			if(curWeapon.isGun)
				game.bManager.firing = true;
		}
		
		public function mouseUp(e:MouseEvent):void
		{
			game.bManager.firing = false;
		}
		
		//looks at the keyboard then moves
		public function update():void
		{
			if (this.y < 400)
			{
				vel.y += 3;
			}
			
			doKeys();
			move();
			
			if (Math.abs(mouseX - head_mc.x) > 15 || Math.abs(mouseY - arm_mc.y) > 60)
			{
			//Aiming and rotation logic
				if (mouseX < head_mc.x)
				{
					if (head_mc.scaleX > 0)
					{
						scaleX *= -1;
					}
					
					head_mc.rotation = (Math.atan2(mouseY - head_mc.y, -(mouseX - head_mc.x)) * -(180 / Math.PI)) * .5;
					arm_mc.rotation = (Math.atan2(mouseY - arm_mc.y, -(mouseX - arm_mc.x)) * -(180 / Math.PI));
					torso_mc.rotation = (Math.atan2(mouseY - torso_mc.y, -(mouseX - torso_mc.x)) * -(180 / Math.PI)) * .1;
					
				}
				else
				{
					if (head_mc.scaleX < 0)
					{
						scaleX *= -1;
					}

					head_mc.rotation = Math.atan2(mouseY - head_mc.y, mouseX - head_mc.x) * (180 / Math.PI) * .5;
					arm_mc.rotation = Math.atan2(mouseY - arm_mc.y, mouseX - arm_mc.x) * (180 / Math.PI);
					torso_mc.rotation = Math.atan2(mouseY - torso_mc.y, mouseX - torso_mc.x) * (180 / Math.PI) * .1;

				}
			}
			
			curWeapon.update();
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
			if (Keyboarder.keyIsDown(Keyboard.W) && this.y == 400)
			{
				vel.y = -30;
			}
			
			if (Keyboarder.keyIsDown(Keyboard.NUMBER_1))
			{
				game.gLayer.removeChild(curWeapon);
				curWeapon = weapons[0];
				game.gLayer.addChild(curWeapon);
			}
			
			if (Keyboarder.keyIsDown(Keyboard.NUMBER_2))
			{
				game.gLayer.removeChild(curWeapon);
				curWeapon = weapons[1];
				game.gLayer.addChild(curWeapon);
			}
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
			this.x += speed*vel.x;
		}
		
		public function shootGun():void
		{
			arm_mc.gotoAndPlay("Shoot");
			torso_mc.gotoAndPlay("Shoot");
			head_mc.gotoAndPlay("Shoot");
			if(curWeapon.isGun)
				(curWeapon as Gun).shoot();
		}
	}
}