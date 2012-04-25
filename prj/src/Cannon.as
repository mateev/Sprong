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
	
	public class Cannon extends MovieClip 
	{
		public var collides:Boolean;
		private var offset:Number;
		
		public function Cannon() 
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
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
			
			graphics.beginFill(0x00FF00);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function onClick(me:MouseEvent):void
		{
			delete this;
		}
		
		private function remove():void
		{
			delete this;
		}
		
		public function Collides(hit:*):void
		{	
			collides = true;
			y = hit.getRect(hit.parent).top - height;
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