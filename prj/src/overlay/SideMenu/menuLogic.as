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
		
		public function Click(buttonLocation:int):Boolean
		{
			if (!isEnabled || !logicContainer.hasOwnProperty(buttonLocation))
				return false;

			
			var clickEvent:SideButtonEvent = new SideButtonEvent(SideButtonEvent.BUTTON_PRESS, logicContainer[buttonLocation]);
			
			return (stage.dispatchEvent(clickEvent))
		}
		
		public function AddButton(location:int,functionality:int):void
		{
			if (logicContainer.hasOwnProperty(location))
				throw new Error("Already exists");
			
			logicContainer[location] = functionality;
		}
	}

}