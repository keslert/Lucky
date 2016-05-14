package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Monster extends MovieClip{
		private var stageDelay:int;
		private var door:Door;
		private var mc:Sprite;
		private var speed:int;
		private var radius:int;
		private var alive:Boolean;
		public function Monster(mc:Sprite) {
			this.mc=mc;
			this.mc.addChild(this);
			speed=5;
			radius = 35*35;
			this.y=-100;
			alive=false;
		}
		public function resetMonster(door:Door) {
			stageDelay=-10;
			this.door=door;
			this.addEventListener(Event.ENTER_FRAME,updateMonster);
		}
		private function updateMonster(e:Event):void {
			stageDelay++;
			var xDif = GLOBAL.hero.x-this.x;
			var dist = xDif*xDif;
			if(stageDelay == 0) {
				alive = true;
				this.x = door.x+25;
				this.y = 150;
			} 
			if(stageDelay > 15) {
				if(dist < getRadius()) this.removeEventListener(Event.ENTER_FRAME,updateMonster);
				if(xDif < 0) {
					this.x-=speed;
					this.scaleX = -1;
				} else if(xDif > 0) {
					this.x+=speed;
					this.scaleX = 1;
				}
			} else if(stageDelay > 0) {
				if(xDif > 0) {
					this.x-=speed;
					this.scaleX = -1;
				} else if(xDif < 0) {
					this.x+=speed;
					this.scaleX = 1;
				}
			}
		}
		public function initDeath():void {
			removeMonster();
		}
		private function removeMonster():void {
			alive=false;
			this.removeEventListener(Event.ENTER_FRAME,updateMonster);
			this.y = -100;
		}
		public function isAlive():Boolean {
			return alive;
		}
		public function getRadius():int {
			return radius;
		}
	}
}
