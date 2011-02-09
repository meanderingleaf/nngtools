package org.nngtools.gallery {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import org.nngtools.OnLoadStuff;
	
	
	/*
	 * Image Rotator
	 * author tfaas
	 * 
	 */
	public class ImageRotator extends MovieClip {
		
		//event consts
		public static const IMAGE_CHANGE:String = "imageChange";
		
		protected var _wid:Number;
		protected var _hig:Number;
		
		public var changeTimer:Timer;
		public var imageArr:Array;
		public var imageClip:MovieClip;
		public var currentIndex:Number;
		public var lastIndex:Number;
		public var randomT:Boolean;
		public var order:Boolean;
		public var loadImages:Boolean;
		public var imageScale:Number;
		public var iLoader:Loader;
		public var oLoader:Loader;
		public var imgURLS:Array;
		public var transitionIn:Object;
		public var transitionOut:Object;
		public var normalForm:Object;
		
		public var totalLoaded:Number;
		
		public function ImageRotator():void {
			TweenPlugin.activate([BlurFilterPlugin]);
		}
		
		public function init(imageURLS:Array, wid:Number, high:Number, initObject:Object):void {
			
			_wid = wid;
			_hig = high;
			
			//presets that may be overriden by the initObject vars
			randomT = (initObject.randomTimer == null) ? false : initObject.randomTimer;
			order = (initObject.inOrder == null) ? true : initObject.inOrder;
			imageScale = (initObject.scale == null) ? 1 : initObject.scale;
			loadImages = (initObject.preloadImages == null) ? true : initObject.preloadImages;
			transitionIn = (initObject.transitionIn == null) ? {time: 2, lite: {}} : initObject.transitionIn;
			transitionOut = (initObject.transitionOut == null) ? {tune: 2, lite: {}} : initObject.transitionOut;
			normalForm = (initObject.normalForm == null) ? {} : initObject.normalForm;
			var changeTime:Number = (initObject.changeTime == null) ? 1 : initObject.changeTime;
			
			//setup two more things
			transitionIn.lite.alpha = 1;
			transitionOut.lite.alpha = 0;
			transitionOut.lite.onComplete = setNormal;
			
			//store a refernece to the image URLS
			imgURLS = imageURLS;
			
			//clean up the image holder if we're re-using this component
			if(imageClip != null) {
				this.removeChild(imageClip);
			}
			imageClip = new MovieClip();
			this.addChild(imageClip);
			
			//ready the timer that will change the images to be displayed
			//converst the change time from seconds to milliseconds
			changeTimer = new Timer(changeTime * 1000);
			changeTimer.addEventListener(TimerEvent.TIMER, onT);
			
			//create an array that stores all the images
			imageArr = new Array();
			totalLoaded = 0;
			
			if(loadImages) {
				for(var i in imageURLS) {
					iLoader = new Loader();
					iLoader.load(new URLRequest(imageURLS[i]));
					imageClip.addChild(iLoader);
					imageArr.push(iLoader);
					
					iLoader.alpha = 0;
					iLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadStuff.centerSmoothMe);
					iLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, scaleImage);
				}
				imageArr[0].alpha = 1;
			} else {
				imageArr = new Array(imageURLS.length);
				goToImage(0);
			}
			
			var imageClipMask:MovieClip = new MovieClip();
			imageClipMask.graphics.beginFill(0x000000);
			imageClipMask.graphics.drawRect(0,0,wid, high);
			imageClipMask.graphics.endFill();
			this.addChild(imageClipMask);
			imageClip.mask = imageClipMask;
			
		}
		
		public function checkLoad():void {
			
			totalLoaded ++;
			
			if(totalLoaded >= imgURLS.length) {
				TweenLite.to(imageArr[0], .2, transitionIn.lite);
				
				currentIndex = 0;
				lastIndex = 0;
				if(loadImages) {
					changeTimer.start();
				}
			}
		}
		
		public function scaleImage(e:Event):void {
			var l:Loader = e.target.loader;
			l.scaleX = l.scaleY = imageScale;
			
			if(oLoader != null) {
				TweenLite.to(oLoader, 1, { alpha: 0, onComplete: removeThisBeing});
				imageClip.addChild(iLoader);
				TweenLite.from(iLoader, 1, {alpha: 0});
			}
			
			//center in gallery
			l.x = _wid / 2;
			l.y = _hig / 2;
			
			//set initial properties
			TweenLite.to(e.target.loader, 0, normalForm);
			
			//check load
			checkLoad();
		}
		
		public function removeThisBeing():void {
			imageClip.removeChild(oLoader);
		}
		
		protected function setNormal():void {
			TweenLite.to(imageArr[lastIndex], 0, normalForm);
		}
		
		public function goToImage(imageNum:Number):void {
			
			if(loadImages) {
				TweenLite.killTweensOf(imageArr[currentIndex]);
				TweenLite.killTweensOf(imageArr[imageNum]);
				
				TweenLite.to(imageArr[currentIndex], 2, { alpha: 0});
				TweenLite.to(imageArr[imageNum], 2, { alpha: 1});
				changeTimer.reset();
				//changeTimer.delay = 5000;
				changeTimer.start();
			} else {
				TweenLite.killTweensOf(oLoader, true);
				if(iLoader != null) {
					oLoader = iLoader;
				}
				iLoader = new Loader();
				imageClip.addChild(iLoader);
				iLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, scaleImage);
				iLoader.load(new URLRequest(imgURLS[imageNum]));
			}
			
			currentIndex = imageNum;
			
			dispatchEvent(new Event(IMAGE_CHANGE));
		}
		
		public function nextImage():void {
			var ni:Number = currentIndex + 1;
			if(ni >= imageArr.length) {
				ni = 0;
			}
			goToImage(ni);
		}
		
		public function prevImage():void {
			var ni:Number = currentIndex - 1;
			if(ni < 0) {
				ni = imageArr.length-1;
			}
			goToImage(ni);
		}
		
		public function onT(e:TimerEvent):void {
			if(imageArr.length > 1) {
				var newIndex:Number;
				if(order) {
					newIndex = currentIndex + 1;
					if(newIndex >= imageArr.length) 
						newIndex = 0;
				}
				else 
					newIndex = Math.floor(Math.random() * imageArr.length);
	
				TweenLite.to(imageArr[currentIndex], transitionOut.time, transitionOut.lite);
				TweenLite.to(imageArr[newIndex], transitionIn.time, transitionIn.lite);
				lastIndex = currentIndex;
				currentIndex = newIndex;
				
				if(randomT) {
					changeTimer.delay = Math.random() * 20000;
				}
				
				dispatchEvent(new Event(IMAGE_CHANGE));
			}
		}
		
	}
	
}