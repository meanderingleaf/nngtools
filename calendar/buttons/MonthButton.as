package org.nngtools.calendar.buttons 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.nngtools.dateUtils.DateWords;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author tfaas
	 */
	public class MonthButton extends Sprite
	{
		
		public var monthNumber:Number;
		
		protected var active:Boolean;
		protected var atf:TextFormat;
		
		public function MonthButton(n:Number ) 
		{
			monthNumber = n;
			active = false;
			
			this.mouseChildren = false;
			this.buttonMode = true;
			
			txtMonth.text = DateWords.numToMinMonth(n).toUpperCase();
			
			//event listeners
			this.addEventListener(MouseEvent.CLICK, onC);
		}
		
		protected function onC(e:MouseEvent):void {
			dispatchEvent(new Event("clicked"));
		}
		
		public function setActive():void {
			active = true;
		}
		
		public function setInactive():void {
			active = false;
		}
		
	}

}