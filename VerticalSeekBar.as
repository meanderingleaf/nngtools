package org.nngtools {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class VerticalSeekBar extends MovieClip {
		
		public var _tab:Sprite;
		public var _bg:Sprite;
		public var _behind:Sprite;
		public var vidp;
		public var rect:Rectangle;
		public var tmr:Timer;
		public var seeking:Boolean;
		public var renabled:Boolean;
		
		public function VerticalSeekBar():void {
			
			_tab.addEventListener(MouseEvent.MOUSE_DOWN, onMDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMUp);
			_tab.buttonMode = true;
			rect = new Rectangle(0,0, 0, _bg.height);
			seeking = false;
			renabled = false;
		}
		
		public function setVid(vplyr):void {
			vidp = vplyr;
			tmr = new Timer(30);
			tmr.addEventListener(TimerEvent.TIMER, onT);
			tmr.start();
			renabled = true;
		}
		
		public function onT(e:TimerEvent):void {
			if(!seeking) {
				_tab.y = (vidp.playheadPercentage/100) * _bg.height;
				_behind.scaleY = vidp.playheadPercentage / (_bg.height - 20);
			} else {
				_tab.y = mouseY;
				if(_tab.y < 0){ 
					_tab.y = 0;
				} 
				if(_tab.y > _bg.height) {
					_tab.y = _bg.height;
				}
			}
		}
		
		public function onMDown(e:MouseEvent):void {
			if(renabled) {
				//_tab.startDrag(false, rect);
				seeking = true;
			}
		}
		
		public function onMUp(e:MouseEvent):void {
			if(renabled && seeking) {
				vidp.seekPercent(_tab.y / _bg.height * 100);
				//_tab.stopDrag();
				seeking = false;
			}
		}
		
	}
}