package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Hero extends MovieClip {
		
		private var speed:int;
		private var curState:String;
		private var mc:Sprite;
		private var left:Boolean;
		private var right:Boolean;
		private var foundExit:Boolean;
		private var shooting:Boolean;
		private var ammo:int;
		private var recycleBullets:Array;
		private var shootingDelay:int;
		
		public function Hero(mc:Sprite) {
			this.mc=mc;
			curState = "stand";
			foundExit = false;
			this.y=152;
			speed = 4;
			ammo = 4;
			shooting = false;
			shootingDelay = 5;
			recycleBullets = new Array();
			this.mc.addChild(this);
		}
		public function updateHero() {
			if(shooting) {
				shootingDelay--;
				if(shootingDelay==0) {
					stopShooting();
				}
			} else {
				if(right && this.x < 490) {
					this.x+=speed;
				} else if(left && this.x > 10) {
					this.x-=speed;
				} else {
					this.gotoAndStop("standing");
				}
			}
		}
		private function checkDoor():void {
			var door:Door;
			for(var i=0;i<GLOBAL.doors.length;i++) {
				door = GLOBAL.doors[i];
				var xDif = (door.x-this.x)*(door.x-this.x);
				if(xDif < 900) {
					if(door.doorMC.currentFrame==1) {
						door.doorMC.gotoAndPlay(door.type);
						if(door.type == "advance")
							foundExit=true;
						if(door.type == "monster")
							GLOBAL.monster.resetMonster(door);
					} else if(foundExit && door.type=="advance") {
						GLOBAL.level++;
						Engine.setupLevel();
					}
				}
			}
		}
		private function heroShoot() {
			if(ammo > 0 && !shooting) {
				shooting = true;
				this.gotoAndPlay("shoot");
				ammo--;
				GLOBAL.gui.ammoText.text = ""+ammo;
				attachBullet();
			}
		}
		private function stopShooting():void {
			shooting = false;
			shootingDelay = 5;
			if(right) {
				gotoAndStop("walk"); 
				scaleX = 1;
			} else if (left) {
				gotoAndStop("walk"); 
				scaleX = -1;
			} else gotoAndStop("standing");;
		}
		private function attachBullet():void {
			var bullet:Bullet;
			if(recycleBullets.length > 0) {
				bullet = recycleBullets.pop();
				bullet.recycle(x,scaleX);
				
			} else {
				bullet = new Bullet(mc,x,scaleX);
				
			}
		}
		public function recycleBullet(bullet:Bullet) {
			recycleBullets.push(bullet);
		}
		public function addAmmo(i:int):void  {
			ammo+=i;
			GLOBAL.gui.ammoText.text = ""+ammo;
		}
		public function keysDown(key:int) {
			if(key==37) { //LEFT
				left = true;
				right = false;
				this.scaleX=-1;
				this.gotoAndStop("walk");
			} else if(key==39) { //RIGHT
				right = true;
				left = false;
				this.scaleX=1;
				this.gotoAndStop("walk");
			}
			if(key==32) { //SPACE
				if(GLOBAL.monster.isAlive()) {
					heroShoot();
				} else {
					checkDoor();
				}
			}
		}
		public function keysUp(key:int):void {
			if(key==37) {
				left = false;
			} else if(key==39) {
				right = false;
			}
		}
		public function setX(x:int):void {
			this.x=x;
		}
	}
	
}
