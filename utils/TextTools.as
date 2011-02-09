package org.nngtools.utils
{
	
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author tfaas
	 */
	public class TextTools
	{
	
		static public function lastLineLength(tf:TextField):Number {
			var txtArray:Array = tf.text.split("\r\n");
			var tempField:TextField = new TextField;
			trace("ll", txtArray[txtArray.length - 1]);
			tempField.text=txtArray[txtArray.length-1];
			return(tempField.textWidth);
		}
		
	}

}