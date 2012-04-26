package overlay.SideMenu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ivan
	 */
	public class menuLogic extends Sprite
	{
		private var length;
		
		private var isHorizontal:Boolean;
		
		private var logicContainer:Dictionary;
		
		private var isEnabled:Boolean;
		
		public function menuLogic(offset:Number, horizontal:Boolean = true)
		{
			length = 0;
			logicContainer = new Dictionary();			
			isHorizontal = horizontal;
			isEnabled = true;
			//logicContainer = new Vector.<int>();
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function onFrame(e:Event=null):void
		{
			for (var i:String in logicContainer)
				trace(i);
		}
		
		public function Switch():void
		{
			isEnabled = !isEnabled;
		}
		
		public function Click(buttonLocation:int):Boolean
		{				
			if (!isEnabled || (logicContainer[buttonLocation] == undefined))
				return false;
				
			var clickEvent:SideButtonEvent = new SideButtonEvent(SideButtonEvent.BUTTON_PRESS, logicContainer[buttonLocation]);
						
			return stage.dispatchEvent(clickEvent);
		}
		
		public function AddButton(functionality:String):void
		{			
			logicContainer[length] = functionality;
			length++;
		}
	}

}