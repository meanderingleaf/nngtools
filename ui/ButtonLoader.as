package org.nngtools.ui {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class ButtonLoader extends MovieClip {
		
		public var bLoader:Loader;
		public var loadFunction:Function;
		
		public function ButtonLoader(url:String):void {
			bLoader = new Loader();
			bLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCom);
			bLoader.load(new URLRequest(url));
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		
		public function onCom(e:Event):void {
			
			this.addChild(bLoader);
			this.mouseChildren = false;
			if(loadFunction != null) {
				loadFunction(e);
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}