package org.nngtools.calendar.buttons 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author tfaas
	 */
	public class PrevYearButton extends Sprite
	{
		
		protected var _year:Number;
		
		public function PrevYearButton() 
		{
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		public function set year(n:Number):void {
			_year = n;
			this.txtYear.text = n.toString();
		}
		
		public function get year():Number { return _year; }
		
	}

}