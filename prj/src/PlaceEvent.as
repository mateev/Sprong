package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class PlaceEvent extends Event 
	{
		public static const PLACE_CANNON:String = "Cannon placement";
		public static const PLACE_TRAMPOLINE:String = "Trampoline placement";
		
		private var cannonID:int;
		
		public function PlaceEvent(type:String, id:int = -1, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			
			cannonID = id;
		} 
		
		public function get ID():int
		{
			return cannonID;
		}
		
		public override function clone():Event 
		{ 
			return new PlaceEvent(type, cannonID, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlaceEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}