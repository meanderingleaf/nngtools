package org.nngtools.dateUtils
{
	/**
	 * ...
	 * @author tfaas
	 */
	public class DateWords
	{
		
		static protected var monthArray:Array = new Array("January", "February","March","April","May","June","July","August","September","October","November","December");
		static protected var dayArray:Array =  new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thurdsay", "Friday", "Saturday");
		static protected var minMonthArray = new Array("Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
		
		public function DateWords() 
		{
			
		}

		static public function numToMonth(n:Number):String {
			return monthArray[n];
		}
		
		static public function numToMinMonth(n:Number):String {
			return minMonthArray[n];
		}
		
		static public function numToDay(n:Number):String {
			return dayArray[n];
		}
		
	}

}