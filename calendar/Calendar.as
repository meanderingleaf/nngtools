package org.nngtools.calendar {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.nngtools.calendar.CalendarController;
	import org.nngtools.calendar.CalendarModel;
	import org.nngtools.dateUtils.DateWords;
	import org.nngtools.calendar.DateItem;
	
	public class Calendar extends Sprite {
		
		protected var calendarYOffset:Number;
		protected var calendarXOffset:Number;
		
		protected var calendarContainer:Sprite;
		protected var gapX:Number;
		protected var gapY:Number;

		protected var dateDisplay:Class;

		public function Calendar(dDisplay:Class, gX:Number = 100, gY:Number = 100, oX:Number = 0, oY:Number = 0, dat:XML = null) {
			CalendarController.calendar = this;
			CalendarModel.init();
			CalendarModel.xml = dat;
			
			gapX = gX;
			gapY = gY;
			calendarYOffset = oY;
			calendarXOffset = oX;
			dateDisplay = dDisplay;
			
			calendarContainer = new Sprite();
			calendarContainer.y = calendarYOffset;
			calendarContainer.x = calendarXOffset;
			this.addChild(calendarContainer);
			
			buildCalendar();
		}
			
		private function clearCalendar():void {
			var total:Number = calendarContainer.numChildren;
			for (var i:Number = 0; i < total; i++) {
				var di:DateItem = DateItem(calendarContainer.getChildAt(0));
				di.unset();
				calendarContainer.removeChildAt(0);
			}
		}
		
		public function buildCalendar():void {
			clearCalendar();
			
			var _lastMonth:Number = CalendarModel.lastMonth;
			var _nextMonth:Number = CalendarModel.nextMonth;
			var _currentYear:Number = CalendarModel.currentYear;
			var _currentMonth:Number = CalendarModel.currentMonth;
			
			//get all the days in this month and year
			var totalDay:Number = CalendarModel.daysMonth(CalendarModel.currentMonth, CalendarModel.currentYear);
			//get the first day in this month
			var firstDay:Number = CalendarModel.dayStart(CalendarModel.currentMonth, CalendarModel.currentYear);
			
			var hisY:Number = 0;
			
			//fill in any of the previous month's days
			var lastMonthLastDay:Number = firstDay - 1;
			if (lastMonthLastDay < 0) {
				lastMonthLastDay = 6;
			}
			
			var lastMonthYear:Number = (_lastMonth == 11) ? _currentYear - 1 : _currentYear;
			var lastMonthTotalDay:Number = CalendarModel.daysMonth(_lastMonth, lastMonthYear);
			
			var subitr:Number = 0;
			for (var li:Number = lastMonthLastDay; li > -1; li-- ) {
				var lday:Date = new Date(lastMonthYear, _lastMonth, lastMonthTotalDay - subitr);
				
				var litem:* = new dateDisplay(lday, false);
				litem.x = gapX * lday.getDay();
				litem.y = hisY;
				calendarContainer.addChild(litem);

				subitr ++;
			}
			
			if (lastMonthLastDay == 6) {
				hisY += gapY;
			}
			
			//for each day in this month
			for (var i:Number = 1; i <= totalDay; i++) {

				var dday:Date = new Date(_currentYear, _currentMonth, i);

				var item:* = new dateDisplay(dday, true);
				item.x = gapX * firstDay;
				item.y = hisY;
				
				if (firstDay >= 6) {
					firstDay = 0;
					hisY += gapY;
				} else {
					firstDay++;
				}
				
				calendarContainer.addChild(item);
			}
			
			//fill in any of next month's days
			var nextMonthFistDay:Number = firstDay + 1;
			var nextMonthYear:Number = (_nextMonth == 0) ? _currentYear + 1 : _currentYear;
			var nextMonthTotalDay:Number = CalendarModel.daysMonth(_nextMonth, nextMonthYear);
			
			subitr = 0;
			for (var ni:Number = nextMonthFistDay; ni < 8; ni ++ ) {
				var nday:Date = new Date(nextMonthYear, _nextMonth, 1 + subitr);
				
				var nitem:* = new dateDisplay(nday, false);
				nitem.x = gapX * nday.getDay();
				nitem.y = hisY;

				calendarContainer.addChild(nitem);
				
				subitr ++;
			}
			
			//if there is less than 6 rows
			if (hisY < gapY*5) {
				hisY += gapY;
				var dayStart:Number = subitr;
				
				for ( var ii:Number = 0; ii < 7; ii++) {
					var iday:Date = new Date(nextMonthYear, _nextMonth, 1 + subitr);
					
					var iitem:* = new dateDisplay(iday, false);
					
					iitem.x = gapX * iday.getDay();
					iitem.y = hisY;
					calendarContainer.addChild(iitem);
					
					subitr ++;
				}
			}
		}
		
	}
}