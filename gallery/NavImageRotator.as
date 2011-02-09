package org.nngtools.gallery {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class NavImageRotator extends ImageRotator {
		
		public var navigationMC:MovieClip;
		public var navBTNS:Array;
		public static const ALIGN_BOTTOM_RIGHT:String = "bottomRight";
		public var currentImage:Number;
		
		public function NavImageRotator():void {
			super();
		}
		
		public function ini(imageURLS:Array, navigationButton:Class, wid:Number, high:Number, uiAlign:String, randomTimer:Boolean=false, inOrder:Boolean=true, scale:Number = 1, preloadImages:Boolean=true):void {
			super.init(imageURLS, wid, high, randomTimer, inOrder, scale, preloadImages);
			
			if(navigationMC != null) {
				this.removeChild(navigationMC);
			}
			
			navigationMC = new MovieClip();
			navBTNS = new Array();
			
			for(var i in imageURLS) {
				var nnavBtn:MovieClip =  new navigationButton();
				nnavBtn.name = i;
				nnavBtn.x = Number(i) * (nnavBtn.width + 5);
				nnavBtn.addEventListener(MouseEvent.CLICK, onNavClick);
				nnavBtn.buttonMode = true;
				nnavBtn.mouseChildren = false;
				throw new Error("ERROL");
				navBTNS.push(nnavBtn);
				navigationMC.addChild(nnavBtn);
			}
			
			switch(uiAlign) {
				case ALIGN_BOTTOM_RIGHT:
					navigationMC.y = high - navigationMC.height - 10;
					navigationMC.x = wid - navigationMC.width - 10;
					break;
			}
			
			this.addChild(navigationMC);
		
			currentImage = 0;
			if(navBTNS[currentImage]!=null) {
				navBTNS[currentImage].gotoAndStop(2);
			}
			this.addEventListener(IMAGE_CHANGE, onChange);
		}
		
		public function onChange(e:Event):void {
			navBTNS[currentImage].gotoAndStop(1);
			navBTNS[currentIndex].gotoAndStop(2);
			currentImage = currentIndex;
		}
		
		public function onNavClick(e:MouseEvent):void {
			navBTNS[currentIndex].gotoAndStop(1);
			trace("c:"+e.target.name);
			goToImage(Number(e.target.name));
			trace("b:"+currentImage);
			navBTNS[currentIndex].gotoAndStop(2);
		}
		
	}
}