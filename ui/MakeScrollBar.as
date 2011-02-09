package org.nngtools.ui {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	public class MakeScrollBar  extends EventDispatcher  {
		private var host_mc:MovieClip;
		private var call_back:Function;
		
		private var drag_mc:MovieClip;
		private var track_mc:MovieClip;
		private var up_mc:MovieClip;
		private var down_mc:MovieClip;
		
		private var scroll_rect:Rectangle;
		private var upper_limit:Number;
		private var range:Number;
		
		public static const UPCLICK:String = "upClick";
		public static const DOWNCLICK:String = "downClick";
		
		public function MakeScrollBar( _mc:MovieClip, cb:Function ){
			host_mc = _mc;
			call_back = cb;
			
			drag_mc = host_mc.drag_mc; // 
			drag_mc.buttonMode = true;
			drag_mc.mouseChildren = false
			drag_mc.addEventListener( MouseEvent.MOUSE_DOWN, press_drag );
			track_mc = host_mc.track_mc;
			track_mc.buttonMode = true;
			track_mc.mouseChildren = false
			track_mc.addEventListener( MouseEvent.CLICK, click_track );
			
			up_mc = host_mc.up_mc;
			up_mc.buttonMode = true;
			up_mc.addEventListener(MouseEvent.CLICK, upclick);
								   
			down_mc = host_mc.down_mc;
			down_mc.buttonMode = true;
			down_mc.addEventListener(MouseEvent.CLICK, downclick);
			
			set_limits();
			
		}
		
		public function setValue(n:Number):void {
			drag_mc.y = n * track_mc.height;
			
			if(drag_mc.y+drag_mc.height > track_mc.height) {
				drag_mc.y = track_mc.height;
			}
		}
		
		private function press_drag( event:MouseEvent ):void {
			/***************************************************/
			drag_mc.stage.addEventListener( MouseEvent.MOUSE_UP, release_drag, false, 0, true );
			/***************************************************/ 
			drag_mc.startDrag( false, scroll_rect );
			drag_mc.addEventListener( Event.ENTER_FRAME, drag );
		}
		
		private function release_drag( event:MouseEvent ):void {
			drag_mc.removeEventListener( Event.ENTER_FRAME, drag );
			drag_mc.stage.removeEventListener( MouseEvent.MOUSE_UP, release_drag );
			drag_mc.stopDrag();
		}
		
		private function click_track( event:MouseEvent ):void {
			trace( "Click track" );
		}
		
		private function upclick(e:MouseEvent):void {
			var upPercent:Number = -.1 * range;
			drag_mc.y += upPercent;
			if(drag_mc.y < track_mc.y) drag_mc.y = track_mc.y;
			
			var p = ( drag_mc.y - track_mc.y ) / range;
			call_back( p );
			//dispatchEvent(new Event(UPCLICK));
		}
		
		public function downclick(e:MouseEvent):void {
			var downPercent:Number = .1 * range;
			drag_mc.y += downPercent;
			if(drag_mc.y > (track_mc.height)) drag_mc.y = track_mc.height;
			var p = ( drag_mc.y - track_mc.y ) / range;
			call_back( p );
			//dispatchEvent(new Event(DOWNCLICK));
		}
		
		private function set_limits():void {
			scroll_rect = new Rectangle( track_mc.x, track_mc.y, 0, track_mc.height - (drag_mc.height/2) );
			upper_limit = track_mc.y;
			range = track_mc.height - (drag_mc.height/2);
		}
		
		private function drag( event:Event ):void {
			var p = ( drag_mc.y - track_mc.y ) / range;
			call_back( p );
		}
	}
}

