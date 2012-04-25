package placeable 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ivan
	 */
	public class Trampoline extends Placeable 
	{
		
		public function Trampoline() 
		{
			super();
		}

		public override function onStage(e:Event=null):void
		{	
			super.onStage(e);
			
			graphics.beginFill(0x0000FF);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();			
		}
	}

}