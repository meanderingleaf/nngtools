package org.nngtools.ui 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author tfaas
	 */
	public class LightboxBG extends Sprite
	{
		
		protected var bgcolor:uint;
		protected var bgalpha:Number;
		protected var bg:Shape;
		
		public function LightboxBG(color:uint, alpha:Number) 
		{
			bgcolor = color;
			bgalpha = alpha;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function drawBg():void {
			
			this.x = 0;
			this.y = 0;
			
			bg = new Shape();
			bg.graphics.beginFill(bgcolor, bgalpha);
			bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			this.addChild(bg);
			
			var gPoint:Point = this.localToGlobal(new Point(0, 0));
			this.x = -gPoint.x;
			this.y = -gPoint.y;
		}
		
		protected function init(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			drawBg();
			
			//add resize
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		protected function onResize(e:Event):void {
			this.removeChild(bg);
			drawBg();
		}
		
	}

}