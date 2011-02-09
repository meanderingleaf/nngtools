package org.nngtools.calendar
{
	import flash.display.Sprite;
	import com.msgSuites.controller.CalendarController;
	import com.msgSuites.components.blocks.CalendarEventBlock;
	
	/**
	 * Calendary dayary summary-ary
	 * @author tfaas
	 */
	public class DaySummary extends Sprite
	{
		
		protected var _container:Sprite;
		
		public function DaySummary() 
		{
			CalendarController.informEventChange(this);
		}
		
		public function updateEvents(evts:Array):void {
			if (_container != null) {
				this.removeChild(_container);
			}
			_container = new Sprite();
			this.addChild(_container);
			
			var nBlock:CalendarEventBlock;
			var runningHeight:Number = 0;
			trace('eee');
			for (var i:String in evts) {
				
				nBlock = new CalendarEventBlock(evts[i]);
				nBlock.y = runningHeight;
				_container.addChild(nBlock);
				runningHeight += nBlock;
			}
		}
		
	}

}