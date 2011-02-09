package org.nngtools.calendar
{
	import org.nngtools.calendar.buttons.MonthButton;
	import org.nngtools.calendar.buttons.NextYearButton;
	import org.nngtools.calendar.buttons.PrevYearButton;
	import org.nngtools.calendar.CalendarController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author tfaas
	 */
	public class CalendarYearNav extends Sprite
	{
		
		protected var nButton:NextYearButton;
		protected var pButton:PrevYearButton;
		
		protected var thisMonth:Number;
		protected var thisYear:Number;
		protected var monthArr:Array;
		protected var runningWidth:Number = 0;
		protected var spacing:Number = 14;
		protected var monthSpacing:Number = 61;
		
		public function CalendarYearNav() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event):void {
			
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//rock n/or roll
			
			var today:Date = new Date();
			thisMonth = today.getMonth();
			thisYear = today.getFullYear();
			trace(thisYear);
			
			monthArr = new Array();
			
			runningWidth = 0;
			
			//previous year button
			pButton = new PrevYearButton();
			pButton.addEventListener(MouseEvent.CLICK, prevYear);
			this.addChild(pButton);
			runningWidth += pButton.width + monthSpacing;
			
			//add our month buttons
			var nmButton:MonthButton;
			
			for (var i:Number = 0; i < 12; i++) {
				nmButton = new MonthButton(i);
				nmButton.x = runningWidth;
				nmButton.addEventListener("clicked", onClicked);
				this.addChild(nmButton);
				monthArr[i] = nmButton;
				runningWidth += nmButton.width + spacing;
			}
			
			//previous year button
			nButton = new NextYearButton();
			nButton.addEventListener(MouseEvent.CLICK, nextYear);
			nButton.x = runningWidth + monthSpacing;
			this.addChild(nButton);
			
			//activate most current month
			monthArr[thisMonth].dispatchEvent(new MouseEvent(MouseEvent.CLICK))
			
			setYearButtons();
		}
		
		protected function onClicked(e:Event):void {
			resetActive();
			MonthButton(e.target).setActive();
			setMonth(MonthButton(e.target).monthNumber);
		}
		
		protected function resetActive():void {
			for each(var mb:MonthButton in monthArr) {
				mb.setInactive();
			}
		}
		
		/*
		 * Sets the highligted month on the nav
		 */
		public function setMonth(mn:Number):void {
			thisMonth = mn;
			CalendarController.gotoYearMonth(thisYear, mn);
		}
		
		public function nextYear(e:MouseEvent):void {
			thisYear = nButton.year;
			setYearButtons();
		}
		
		public function prevYear(e:MouseEvent):void {
			thisYear = pButton.year;
			trace(pButton.year);
			setYearButtons();
		}
		
		protected function setYearButtons():void {
			pButton.year = thisYear - 1;
			nButton.year = thisYear + 1;
			setMonth(thisMonth);
		}
		
	}

}