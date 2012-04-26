package overlay.SideMenu 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class SideButtonEvent extends Event 
	{
		public static const BUTTON_PRESS:String = "Pressed side menu button";
		private var pressedID:int;
		
		public function SideButtonEvent(type:String, id:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			pressedID = id;
		} 
		
		public function get PressedID():int
		{
			return pressedID;
		}
		
		public override function clone():Event 
		{ 
			return new SideButtonEvent(type, pressedID, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SideButtonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}