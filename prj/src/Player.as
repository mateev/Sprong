package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class Player extends MovieClip 
	{
		public var collides:Boolean;
		private var offset:Number;
		
		public function Player() 
		{
			super();
			
			
			collides = false;
			
			if (stage)	onStage();
			else	addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
		}
		
		public function onStage(e:Event=null):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			addEventListener(MouseEvent.MOUSE_OVER, onMouse);
		}
		
		private function onMouse(me:MouseEvent):void
		{
			
		}
		
		public function Collides(hit:*):void
		{	
			collides = true;
			y = hit.getRect(hit.parent).top - height / 2;
		}
		
		public function get Center():Point
		{
			return new Point(x, y);
		}
		
		private function onTick(e:Event):void
		{
			if (!collides)
			{
				y += 20;			
			}
			
			rotation = offset;
		}
		
		private function onKey(e:KeyboardEvent):void
		{
			if (e.keyCode == 'W'.charCodeAt())
			{
				if (collides)
				{
					y -= 200;
					collides = false;
				}
			}
			
			if (e.keyCode == 'D'.charCodeAt())
			{
				x += 10;
				collides = false;
			}
			else if (e.keyCode == 'A'.charCodeAt())
			{
				x -= 10;
				collides = false;
			}
		}
				
		private function onTock(e:Event):void
		{
		}
		
	}

}