package selectionBox 
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class SelectionBoxEvent extends Event 
	{
		public static const REMOVE:String = "SB_REMOVE";
		public static const MOVE:String = "SB_MOVE";
		public static const ROTATE:String = "SB_ROTATE";
		
		public var id:int;
		public var location:Point
		public var value:Object;
		
		public function SelectionBoxEvent(inputId:int,type:String, inputValue:*=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			id = inputId;
			value = inputValue;
		} 
		
		public override function clone():Event 
		{ 
			return new SelectionBoxEvent(id,type, value, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ID", "SelectionBoxEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}