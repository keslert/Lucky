package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip{
		private var dir:int;
		private var speed:int;
		public function Bullet(mc:Sprite, x:int,dir:int) {
			this.x = x;
			this.y = 140;
			this.dir = dir;
			speed = 9;
			mc.addChild(this);
			addEventListener(Event.ENTER_FRAME,updateBullet);
		}
		public function recycle(x:int,dir:int) {
			this.x = x;
			this.y = 140;
			this.dir = dir;
			addEventListener(Event.ENTER_FRAME,updateBullet);
		}
		private function updateBullet(e:Event):void {
			var dist = (this.x-GLOBAL.monster.x)*(this.x-GLOBAL.monster.x);
			if(dist < GLOBAL.monster.getRadius()) {
				GLOBAL.monster.initDeath();
				cleanup();
			} else if(x > GLOBAL.stageX || x < 0) {
				cleanup();
			}
			if(dir > 0) {
				x+=speed;
			} else {
				x-=speed;
			}
			
			
		}
		private function cleanup():void {
			removeEventListener(Event.ENTER_FRAME,updateBullet);
			this.y = -100;
			GLOBAL.hero.recycleBullet(this);
		}

	}
	
}
