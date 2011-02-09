package org.nngtools.form {
	
	import org.nngtools.InputBG;
	
	public class Validators {
		
		/**
		 * Makes sure there is something there
		 * @returns boolean
		 */
		static public function notEmpty(val:String, bg:InputBG = null):Boolean {
		
			if (val == "" || val == null) {
				if(bg!=null)
					bg.highlight();
					
				return false;
			}
			
			//we made it
			return true;
		}
		
		/**
		 * Makes sure there is not less than the secified number of characters in a string
		 * Assumes the date is in "mm/dd/yyyy" format.
		 * @returns boolean
		 */
		static public function notLessThanChars(t:Number, val:String, bg:InputBG = null) {
			
			if (val.length < t) {
				if (bg != null) {
					bg.highlight();
				}
				
				return false;
			}
			
			//we made it
			return true;
		}
		 
		/**
		 * Makes sure a date is a date
		 * Assumes the date is in "mm/dd/yyyy" format.
		 * @returns boolean
		 */
		static public function validateDOB(dat:String):Boolean {
			var splitDate:Array = dat.split("/");
			
			//we're not going to make it
			//check to see if the month is out of line
			if(Number(splitDate[0]) > 12 || Number(splitDate[0]) < 1  ) return false;
			//make sure the date is in order
			if(Number(splitDate[1]) > 31 || Number(splitDate[1]) < 1 ) return false;
			//ascertain the year is in a year-like format (4 digits)
			if(splitDate[2].length != 4) return false;
			
			//we made it
			return true;
		}
		
		/**
		* Makes sure a phone is a phone
		* Assumes area code is included
		* @returns boolean
		*/
		static public function validatePhone(pho:String) {
			//regular expressions rock
			var pat:RegExp = /[^0-9]*/g;
			var cleanPhone:String = pho.replace(pat, "");
			
			//make sure there is the 10 digits needed for the phone
			if(cleanPhone.length != 10) return false;
			
			//we made it
			return true;
		}

		
		
	}
}