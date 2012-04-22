package overlay.SideMenu
{
	/**
	 * ...
	 * @author ivan
	 */
	public class menuLogic 
	{
		private var isHorizontal:Boolean;
		
		private var logicContainer:Object;
		
		private var isEnabled:Boolean;
		
		public function menuLogic(offset:Number, horizontal:Boolean = true)
		{
			isEnabled = true;
			isHorizontal = horizontal;
			logicContainer = new Object();
		}
		
		public function Click2(location:int):void
		{
			if (!logicContainer.hasOwnProperty(location))
				return;
			
			trace(logicContainer[location]);
		}
		
		public function Switch():void
		{
			isEnabled = !isEnabled;
		}
		
		public function Click(buttonLocation:int):void
		{
			if (!isEnabled || !logicContainer.hasOwnProperty(buttonLocation))
				return;

			trace(buttonLocation);	
		}
		
		public function AddButton(id:int,location:int):void
		{
			if (logicContainer.hasOwnProperty(location))
				throw new Error("Already exists");
			
			logicContainer[location] = id;
		}
	}

}