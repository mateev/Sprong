package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class SelectionBox extends Sprite
	{
	
		private var locationX:Number;
		private var locationY:Number;
		private var isActive:Boolean;
		
		public function SelectionBox(inputX:Number,inputY:Number,active:Boolean=false) 
		{
			super();
			
			locationX = inputX;
			locationY = inputY;
		
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function get IsActive():Boolean
		{
			return isActive;
		}
		
		public function activate(location:Point, color:uint = 0xFF0000, innterRadius:uint = 55, radiiCount:int=3):void
		{
			x = location.x;
			y = location.y;
			
			isActive = true;
			
			for (var radIndex:int = 0; radIndex < radiiCount; radIndex++)
			{
				graphics.lineStyle(1, color/Math.pow(2,radIndex), 1);
				graphics.drawCircle(0, 0, innterRadius+10*radIndex);				
			}

			/*
			graphics.lineStyle(1, color, 1);
			graphics.drawCircle(0, 0, innterRadius);
			graphics.lineStyle(1, color/2, 1);
			graphics.drawCircle(0, 0, innterRadius+10);
			graphics.lineStyle(1, color/4, 1);
			graphics.drawCircle(0, 0, innterRadius+25);
			*/
			trace(x, y);
		}
		
		public function deactivate():void
		{
			isActive = false;
			
			graphics.clear();
		}
		
		//	Todo: maybe remove this!
		private function onInit(event:Event = null):void{}
		
	}

}