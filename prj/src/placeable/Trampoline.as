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
			
			graphics.beginFill(ID);
			graphics.drawRect(0, 0, 50, 50);
			graphics.endFill();			
		}
	}

}