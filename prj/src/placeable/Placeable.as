package placeable 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	public class Placeable extends MovieClip 
	{
		public static const MAX_FACING:Number = 50;
		protected var facing:Number;
		public var collides:Boolean;
		protected var offset:Number;
		
		protected var ID:int;
		
		public function Placeable(inputID:int=-1) 
		{
			super();
			
			facing = Math.PI/4;
			
			ID = inputID == -1 ? Main.GeneratedTrampolineID : inputID;
						
			collides = false;			

			if (stage)	onStage();
			else	addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		public function changeFacing(value:Number):void
		{
			facing = value;
		}
		
		public function get Facing():Number
		{
			return facing;
		}
		
		public function onKey(ke:KeyboardEvent):void
		{
		}
		
		public function GetID():int
		{
			return ID;
		}
		
		public function IsTrampoline():Boolean
		{
			return ID == 0;
		}
		
		public function onStage(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		protected function onTick(e:Event):void
		{			
			if (!collides)
			{
				y += ExtraMath.TWELVE;			
			}
			
			rotation = offset;
		}
		
		public function Collides(hit:*):void
		{	
			collides = true;
			
			y = hit.getRect(hit.parent).top - height;
		}
		
		public function get Center():Point
		{
			return new Point(x+this.width/2, y+this.height/2);
		}
	}

}