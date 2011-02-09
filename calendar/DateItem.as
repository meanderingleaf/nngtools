package org.nngtools.calendar
{
	import org.nngtools.calendar.CalendarController;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author tfaas
	 */
	public class DateItem extends Sprite
	{
		public var active:Boolean;
		protected var myDate:Date;
		
		public function DateItem(aDate:Date, thisMonth:Boolean = false) 
		{
			myDate = aDate;
			active = false;
		}
		
		public function unset():void {
			
		}
	}
}