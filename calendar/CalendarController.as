package org.nngtools.calendar
{
	
	import org.nngtools.calendar.*;
	
	/**
	 * ...
	 * @author tfaas
	 */
	public class CalendarController
	{
		
		static protected var _calendar:Calendar;
		static protected var _currentDay:DateItem;
		static protected var eventInformees:Array;
		
		/* Totoro....
		 *     _____
              /     \
              vvvvvvv  /|__/|
                 I   /O,O   |
                 I /_____   |      /|/|
                J|/^ ^ ^ \  |    /00  |    _//|
                 |^ ^ ^ ^ |W|   |/^^\ |   /oo |
                  \m___m__|_|    \m_m_|   \mm_|
		*/
		
		static public function set calendar(c:Calendar):void {
			if(_calendar == null) {
				_calendar = c;
			}
		}
		
		static public function informEventChange(of:Object):void {
			if (eventInformees == null) {
				eventInformees = new Array();
			}
			eventInformees.push(of);
		}
		
		static public function dateClicked(di:DateItem, d:Date):void {
			//switch the visible active days
			if (_currentDay != null) {
				_currentDay.active = false;
			}
			_currentDay = di;
		}
		
		/*
		 * Sets the calendar to the specified year and month
		 */
		static public function gotoYearMonth(yeer:Number, moonth:Number):void {
			CalendarModel.currentYear = yeer;
			CalendarModel.currentMonth = moonth;
			_calendar.buildCalendar();
		}
		
		static public function nextMonth():void {
			CalendarModel.monthsFrom(1);
			_calendar.buildCalendar();
		}
		
		static public function prevMonth():void {
			CalendarModel.monthsFrom(-1);
			_calendar.buildCalendar();
		}
		
	}

}