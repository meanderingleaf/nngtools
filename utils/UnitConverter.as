package org.nngtools.utils
{
	/**
	 * ...
	 * @author tfaas
	 * Converts units into other units, or a base number as-needed.
	 * Feel free to add whatever you want to the package. MORE POWER TO YOU.
	 */
	public class UnitConverter
	{
		
		public function UnitConverter() 
		{
			
		}
		
		/*
		 * Takes a string representation of a length in inches, and converts it
		 * to a number that is easily useable in Flash
		 * Currently only accepts the format "7 INCH" / "7 1/8 INCH" / "5 INCHES" / "6 1/4 INCHES"
		*/
		static public function InchesToNumber(iString:String):Number {
			
			//split at the spaces
			var iArray:Array = iString.split(" ");
			
			//get our base number
			var iNum:Number;
			
			//if our base number is a fraction, calculate and return
			if(iArray[0].match(/\//)) {
				var quickSplit:Array = iArray[0].split("/");
				iNum = Number(quickSplit[0]) / Number(quickSplit[1]);
			} else {
				iNum = Number(iArray[0]);
			}
			
			//a regex that checks to see if the string has "INCH" init
			var inchReg:RegExp = /INCH/i;
			
			//if the second entry in the split string is not blank or the word "INCH"/"INCHES"
			if (iArray[1] != null && iArray[1] != "" && iArray[1].match(inchReg) != true) {
				//try to split that second entry
				var subArray:Array = iArray[1].split("/");
				
				//if the split suceeded, we need to devide the two numbers
				if (subArray[1] != null) {
					var ratio:Number = Number(subArray[0]) / Number(subArray[1]);
					iNum += ratio;
				}
			}
			
			return iNum;
		}
		
	}

}