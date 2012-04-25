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
		
		public static const SLIDE:String = "Slide";
		
		public var direction:String;
		
		public function SliderEvent(type:String, inputDirection:String, bubbles:Boolean=true, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			direction = inputDirection;
		} 		
		
		override public function clone():flash.events.Event 
		{
			return new SliderEvent(type, direction, bubbles, cancelable);
		}
	}
	
}