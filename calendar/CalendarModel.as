package org.nngtools.calendar
{
	/**
	 * ...
	 * @author tfaas
	 * Model for this kraazy calendar class
	 */
	public class CalendarModel
	{
		
		//var var, banana var
		static public var _current_date:Date;
		static public var xml:XML;
		static protected var _currentYear:Number;
		static protected var _currentMonth:Number;
		static protected var _lastMonth:Number;	
		static protected var _nextMonth:Number;
		
		//dang leap years
		static protected var monthdaysOlympic_arr = new Array(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		static protected var monthdaysNormal_arr = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		
		//my stupid way of doing a singleton
		//for the love of all that is holy, only call this function once
		static public function init():void
		{
			_current_date = new Date();
			_currentYear = _current_date.getFullYear();
			_currentMonth = _current_date.getMonth();
			_lastMonth = monthAddition(_currentMonth, -1);
			_nextMonth = monthAddition(_currentMonth, 1);
		}
		
		static public function monthsFrom(nm:Number):void {
			//check to see if we should change the year
			if (_currentMonth + nm > 11) {
				yearsFrom(1);
			} else if (_currentMonth + nm < 0) {
				yearsFrom(-1);
			} 
			
			//change the month
			_currentMonth = monthAddition(_currentMonth, nm);
		}
		
		static public function yearsFrom(yn:Number):void {
			_currentYear += yn;
		}
		
		static public function daysMonth(month:Number, year:Number):Number {
			var tmp:Number = year % 4;
			if (tmp == 0) {
				return (monthdaysOlympic_arr[month]);
			} else {
				return (monthdaysNormal_arr[month]);
			}
		}
		
		static public function dayStart(month:Number, year:Number):Number {
			var tmpDate:Date = new Date(year, month, 1);
			return (tmpDate.getDay());
		}
		
		static public function prevYear():void {
			yearsFrom(-1);
			//builtCalendar();
		}
		
		static public function nextYear():void {
			yearsFrom(1);
			//builtCalendar();
		}
		
		/*
		 * Oh yes, it adds months in a realistic way
		 */
		static protected function monthAddition(mn:Number, ma:Number):Number {
			var rn:Number = 0;
			var amt:Number = mn + ma;
			if (amt < 0) {
				rn = 12 + amt;
			} else if ( amt > 11) {
				rn = -1 + (amt - 11);
			} else {
				rn = amt;
			}
			
			return(rn);
		}
		
		//GETTERS AND SETTERS
		static public function get currentYear():Number { return _currentYear; }
		static public function set currentYear(y:Number):void { 
			_currentYear = y; 
		}
		
		static public function get currentMonth():Number { return _currentMonth; }
		static public function set currentMonth(m:Number):void { 
			_currentMonth = m;
			_lastMonth = monthAddition(_currentMonth, -1);
			_nextMonth = monthAddition(_currentMonth, 1);
		}
		
		static public function get lastMonth():Number { return _lastMonth; }
		static public function set lastMonth(lm:Number):void { _lastMonth = lm; }
		
		static public function get nextMonth():Number { return _nextMonth; }
		static public function set nextMonth(nm:Number):void { _nextMonth = nm; }
		
		
	}

}