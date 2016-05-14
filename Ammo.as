package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Ammo extends MovieClip {
		private var radius:int;
		private var mc:Sprite;
		private var found:Boolean;
		public function Ammo(mc:Sprite) {
			this.mc = mc;
			this.mc.addChild(this);
			this.y = -100;
			radius = 20*20;
		}
		public function resetAmmo():void {
			this.x=460;
			this.y=167;
			found = false;
			addEventListener(Event.ENTER_FRAME,updateAmmo);
		}
		private function updateAmmo(e:Event) {
			var xDif = (x-GLOBAL.hero.x)*(x-GLOBAL.hero.x);
			if(xDif < radius) {
				found = true;
				GLOBAL.hero.addAmmo(1);
				cleanup();
			}
		}
		public function cleanup():void {
			y=-100;
			removeEventListener(Event.ENTER_FRAME,updateAmmo);
		}
	}
}
