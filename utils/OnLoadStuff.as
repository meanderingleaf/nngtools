package org.nngtools.utils {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	public class OnLoadStuff {
		
		static public function centerMe(e:Event):void {
			e.target.loader.x = -e.target.loader.width / 2;
			e.target.loader.y = -e.target.loader.height / 2;
			trace(e.target.loader.width);
		}
		
		static public function smoothMe(e:Event):void {
			var imgToSmooth:Bitmap = e.target.content;
			imgToSmooth.smoothing = true;;
		}
		
		static public function centerSmoothMe(e:Event):void {
			var imgToSmooth:Bitmap = e.target.content;

			imgToSmooth.x = -( imgToSmooth.width/2 );
			imgToSmooth.y = -( imgToSmooth.height/2 );
			imgToSmooth.smoothing = true;
		}
		
	}
	
}