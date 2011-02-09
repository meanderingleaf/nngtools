package org.nngtools.dateUtils {
	
	public class DateTransform {
		
		public static function getDayWord(d:Date, abbreviate:Boolean = false):String {
			switch(d.getDay) {
				case (0):
					return "Sunday";
					break;
				case (1):
					return "Monday";
					break;
				case (2):
					return "Tuesday";
					break;
				case (3):
					return "Wednesday";
					break;
				case (4):
					return "Thursday";
					break;
				case (5):
					return "Friday";
					break;
				case (6):
					return "Saturday";
					break;
			}
			
			return "Sunday";
		}
		
	}
}