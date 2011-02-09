package org.nngtools.form
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author tfaas
	 */
	public class mCheckBox extends MovieClip
	{
		
		protected var _selected:Boolean;
		
		public function mCheckBox() 
		{
			_selected = false;
			this.gotoAndStop(1);
		}
		
		public function set selected(b:Boolean):void {
			
			_selected = b;
			
			if (b) { 
				gotoAndStop(2);
			} else {
				gotoAndStop(1);
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
	}

}