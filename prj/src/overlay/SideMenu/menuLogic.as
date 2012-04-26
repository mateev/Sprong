package overlay.SideMenu
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ivan
	 */
	public class menuLogic extends Sprite
	{
		private var isHorizontal:Boolean;
		
		private var logicContainer:Array;
		
		private var isEnabled:Boolean;
		
		public function menuLogic(offset:Number, horizontal:Boolean = true)
		{
			logicContainer = new Vector.<int>;			
			isHorizontal = horizontal;
			isEnabled = true;
			//logicContainer = new Vector.<int>();
			if (stage) onStage
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void
		{
		}
				
		public function Switch():void
		{
			isEnabled = !isEnabled;
		}
		
		public function Click(buttonLocation:int):Boolean
		{			
			if (!isEnabled || buttonLocation>logicContainer.length)
				return false;

			var clickEvent:SideButtonEvent = new SideButtonEvent(SideButtonEvent.BUTTON_PRESS, logicContainer[buttonLocation]);
						
			return stage.dispatchEvent(clickEvent);
		}
		
		public function AddButton(functionality:*):void
		{			
			logicContainer.push(functionality);
		}
	}

}