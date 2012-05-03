package overlay.SideMenu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author ivan
	 */
	public class menuLogic extends Sprite
	{
		private var length;
		
		private var isHorizontal:Boolean;
		
		private var logicContainer:Dictionary;
		private var disabledButtons:Vector.<int>;
		
		private var isEnabled:Boolean;
		
		public function menuLogic(offset:Number, horizontal:Boolean = true)
		{
			length = 0;
			logicContainer = new Dictionary();	
			disabledButtons = new Vector.<int>();
			isHorizontal = horizontal;
			isEnabled = true;
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function onFrame(e:Event=null):void
		{
			return;
		}
		
		public function Switch():void
		{
			isEnabled = !isEnabled;
		}
		
		private function isDisabled(buttonLocation:int):Boolean
		{
			return disabledButtons.some(function(elem:*, index:*, array:*):Boolean { return elem == buttonLocation; } );
		}
		
		public function Click(buttonLocation:int):Boolean
		{				
			trace(buttonLocation);
			if (!isEnabled || (!logicContainer.hasOwnProperty(buttonLocation)) || isDisabled(buttonLocation))
				return false;
				
			var clickEvent:SideButtonEvent = new SideButtonEvent(SideButtonEvent.BUTTON_PRESS, logicContainer[buttonLocation]);
						
			return stage.dispatchEvent(clickEvent);
		}
		
		public function unselect(type:Class):int
		{			
			var typeAsString:String = getQualifiedClassName(type);
			
			for (var index:int = 0; index < length; index++)
			{
				if (logicContainer[index] == typeAsString)
					return index;
			}
			
			throw new Error("Invalid unselect for element type " + typeAsString);
		}
		
		public function AddButton(functionality:String):void
		{			
			logicContainer[length] = functionality;
			length++;
		}
	}

}