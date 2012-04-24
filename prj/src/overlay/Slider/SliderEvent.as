package overlay.Slider 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class SliderEvent extends Event 
	{
		public static const LEFT:String = "LEFT_SLIDE";
		public static const RIGHT:String = "RIGHT_SLIDE";

		public static const UP:String = "UP_SLIDE";
		public static const DOWN:String = "DOWN_SLIDE";
		
		public function SliderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SliderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SliderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
	}
	
}