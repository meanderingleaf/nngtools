package org.nngtools.form
{
	import flash.display.MovieClip;
	/**
	 * Takes a movieclip with two frames and turns it into a custom checkbox
	 * The movieclip is the display, but this should be used as entry to all the data from then on
	 * @author tfaas
	 */
	public class checkboxController
	{
		
		protected var _selected:Boolean;
		protected var _view:MovieClip;
		
		
		public function checkboxController(view:MovieClip) 
		{
			_selected = false;
			_view = view;
			_view.gotoAndStop(1);
		}
		
		public function set selected(b:Boolean):void {
			
			_selected = b;
			
			if (b) { 
				_view.gotoAndStop(2);
			} else {
				_view.gotoAndStop(1);
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
	}

}