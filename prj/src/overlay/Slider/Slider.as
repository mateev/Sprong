package overlay.Slider 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ivan
	 */
	public class Slider extends Sprite
	{
		protected var endPoints:Vector.<Point>;
		protected const xOffsetValue:Number = 60;
		
		public function Slider()
		{
			super();
			
			endPoints = new Vector.<Point>();
			
			if (stage) onStage();
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		public function onStage(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			endPoints.push(new Point(stage.stageWidth - xOffsetValue, stage.stageHeight - xOffsetValue));	//	Right point
		}
		
		public function get RightEndPoint():Point
		{
			return endPoints[1];
		}
		
		public function get OtherEndPoint():Point
		{
			return endPoints[0];
		}
		
		public function get RandomThirdPoint():Point
		{
			return ExtraMath.RandomSign() < 0 ? ThirdPoint : TwoThirdPoint;
		}
		
		public function get ThirdPoint():Point
		{
			return Point.interpolate(RightEndPoint, OtherEndPoint, 0.33);
		}
		
		public function get TwoThirdPoint():Point
		{
			return Point.interpolate(RightEndPoint, OtherEndPoint, 0.66);
		}
		
		public function get MidPoint():Point
		{
			return Point.interpolate(RightEndPoint, OtherEndPoint, 0.5);
		}
		
		public function get ControlPoint():Point
		{
			var interpolatedPoint:Point = RandomThirdPoint;
			
			if (RightEndPoint.y == OtherEndPoint.y)
				interpolatedPoint.y += ExtraMath.RandomNumber( 50, 75);
			
			if (RightEndPoint.x == OtherEndPoint.x)
				interpolatedPoint.x += ExtraMath.RandomNumber( 50, 75);
			
			return interpolatedPoint;
			
		}
		
		protected function drawGraphics():void
		{
			if (endPoints.length < 2)
				return;
				
			var controlPoint:Point = ControlPoint;
			
			graphics.lineStyle(4, 0x000000, 1); 
			graphics.moveTo(RightEndPoint.x, RightEndPoint.y);
			graphics.curveTo(controlPoint.x, controlPoint.y, OtherEndPoint.x, OtherEndPoint.y);
			graphics.endFill();			
			
			graphics.beginFill(0x000000);
			graphics.drawRect(RightEndPoint.x, RightEndPoint.y, 20, 20);
			graphics.endFill();


			graphics.beginFill(0x000000);
			graphics.drawRect(OtherEndPoint.x, OtherEndPoint.y, 20, 20);
			graphics.endFill();
		}
		
		public function fireMovementEvent(eventType:String):void
		{
			var movementEvent:SliderEvent = new SliderEvent(SliderEvent.SLIDE,eventType);
			
			dispatchEvent(movementEvent);
		}
		
		protected function isNearRightPoint(location:Point):Boolean
		{
			return Point.distance(location, RightEndPoint) < Point.distance(location, OtherEndPoint);
		}
	}

}