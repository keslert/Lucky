package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Engine {
		private var ROOT:Sprite;
		private var r:Sprite;
		private var numDoors:int;
		private static var ammoDelayReset:int;
		private static var ammoDelay:int;
		
		public function Engine(rootMC:Sprite) {
			ROOT = rootMC;
			r = new Sprite();
			ROOT.addChild(r);
			ROOT.addEventListener(Event.ENTER_FRAME,updateGame);
			numDoors = 2;
			GLOBAL.doors = new Array();
			GLOBAL.level = 1;
			GLOBAL.stageX = 500;
			ammoDelayReset = 2;
			ammoDelay = 0;
			createGUI();
			createDoors();
			createAmmo();
			createMonster();
			createHero();
			Engine.setupLevel();
		}
		private function createGUI():void {
			GLOBAL.gui = new GUI();
			GLOBAL.gui.y=175;
			ROOT.addChild(GLOBAL.gui);
			
		}
		private function createDoors():void {
			for(var i=0;i<numDoors;i++) {
				var door:Door = new Door();
				door.x = 150+i*200;
				door.y = 145;
				r.addChild(door);
				GLOBAL.doors.push(door);
			}
		}
		private function createAmmo():void {
			GLOBAL.ammo = new Ammo(r);
		}
		public static function setupLevel():void {
			var outcomes = ["monster","advance"];
			for(var i=0;i<GLOBAL.doors.length;i++) {
				var door:Door = GLOBAL.doors[i];
				var n:int = int(Math.random()*outcomes.length);
				door.type = outcomes.splice(n,1);
				door.doorMC.gotoAndStop(1);
				trace(door.type);
			}
			ammoDelay--;
			if(ammoDelay < 1) {
				ammoDelay = ammoDelayReset+int(Math.random()*2);
				trace(ammoDelay);
				GLOBAL.ammo.resetAmmo();
			}
			GLOBAL.hero.setX(250);
			GLOBAL.gui.progressText.text = ""+((GLOBAL.level-1)*2)+"%";
		}
		private function createHero():void {
			GLOBAL.hero = new Hero(r);
		}
		private function createMonster():void {
			GLOBAL.monster = new Monster(r);
		}
		private function updateGame(e:Event):void {
			GLOBAL.hero.updateHero();
		}
		public function keysDown(event: KeyboardEvent): void{
				GLOBAL.hero.keysDown(event.keyCode);
		}
		public function keysUp(event: KeyboardEvent): void{
				GLOBAL.hero.keysUp(event.keyCode);
		}
	}
}