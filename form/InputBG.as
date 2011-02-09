package org.nngtools.form
{
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author tfaas
	 */
	public class InputBG extends Sprite
	{
		protected const standardColor:uint = 0x535151;
		protected const activeColor:uint = 0x1c80aa;
		protected const highlightColor:uint = 0xff0000;
		
		public var txtRef:TextField;
		protected var firstUse:Boolean;
		
		
		public function InputBG(t:TextField, resetOnFirstUse:Boolean = false) 
		{
			txtRef = t;
			
			//for seeing if its the first time the user uses component
			firstUse = resetOnFirstUse;
			
			//draw bg
			this.graphics.beginFill(0x000000, .2);
			//e08b05
			this.graphics.lineStyle(1, standardColor);
			this.graphics.drawRoundRect(txtRef.x, txtRef.y, txtRef.width, txtRef.height, 3, 3);
			this.graphics.endFill();
			
			//event listeners
			txtRef.addEventListener(FocusEvent.FOCUS_IN, onFin);
			txtRef.addEventListener(FocusEvent.FOCUS_OUT, onFout);
		}
		
		public function highlight():void {
			this.graphics.clear();
			this.graphics.beginFill(0x000000, .2);
			this.graphics.lineStyle(1, highlightColor);
			this.graphics.drawRoundRect(txtRef.x, txtRef.y, txtRef.width, txtRef.height, 3, 3);
			this.graphics.endFill();
		}
		
		public function onFin(e:FocusEvent):void {
			if (firstUse) {
				txtRef.text = "";
				firstUse = false;
			}
			this.graphics.clear();
			this.graphics.beginFill(0x000000, .2);
			this.graphics.lineStyle(1, activeColor);
			this.graphics.drawRoundRect(txtRef.x, txtRef.y, txtRef.width, txtRef.height, 3, 3);
			this.graphics.endFill();
		}
		
		public function onFout(e:FocusEvent):void {
			this.graphics.beginFill(0x000000, .2);
			this.graphics.lineStyle(1, standardColor);
			this.graphics.drawRoundRect(txtRef.x, txtRef.y, txtRef.width, txtRef.height, 3, 3);
			this.graphics.endFill();
		}
		
	}

}