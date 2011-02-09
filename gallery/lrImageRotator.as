package org.nngtools.gallery {
	
	import flash.display.MovieClip;
	import com.draftParty.Components.ImageRotator;
	import flash.events.MouseEvent;
	
	public class lrImageRotator extends ImageRotator {
		
		public function lrImageRotator():void {
			
		}
		
		override public function init(imageURLS:Array, wid:Number, high:Number, randomTimer:Boolean=false, inOrder:Boolean=true, scale:Number = 1, preloadImages:Boolean=false):void {
			super.init(imageURLS, wid, high, randomTimer, inOrder, scale, preloadImages);
			
			btnPrev.addEventListener(MouseEvent.CLICK, mpreviousImage);
			btnNext.addEventListener(MouseEvent.CLICK, mnextImage);
		}
		
		public function mnextImage(e:MouseEvent):void {
			nextImage();
		}
		
		public function mpreviousImage(e:MouseEvent):void {
			prevImage();
		}
		
	}
	
}