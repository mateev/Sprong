package placeable
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Cannon extends Placeable 
	{		
		public function Cannon(inputID:uint) 
		{
			super(inputID);
			
			if (inputID == 0)
				throw ArgumentError("Only trampoline IDs are 0");
			
		}
		
		public override function onStage(e:Event=null):void
		{	
			super.onStage(e);
			
			graphics.beginFill(0x00FF00);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();			
		}
	}

}