package overlay.SideMenu
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ivan
	 */
	public class menuLogic extends Sprite
	{
		private var isHorizontal:Boolean;
		
		private var logicContainer:Vector.<int>;
		
		private var isEnabled:Boolean;
		
		public function menuLogic(offset:Number, horizontal:Boolean = true)
		{
			isEnabled = true;
			isHorizontal = horizontal;
			logicContainer = new Vector.<int>();
		}
				
		public function Switch():void
		{
			isEnabled = !isEnabled;
		}
		
		public function Click(buttonLocation:int):void
		{
			if (!isEnabled || !logicContainer.hasOwnProperty(buttonLocation))
				return;

			
			var clickEvent:SideButtonEvent = new SideButtonEvent(SideButtonEvent.BUTTON_PRESS, logicContainer[buttonLocation]);
			
			if (stage.dispatchEvent(clickEvent))
				trace("Event dispatched");
		}
		
		public function AddButton(location:int,functionality:int):void
		{
			if (logicContainer.hasOwnProperty(location))
				throw new Error("Already exists");
			
			logicContainer[location] = functionality;
		}
	}

}