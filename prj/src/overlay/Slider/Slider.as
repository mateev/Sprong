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
		
		protected function drawGraphics():void
		{
			if (endPoints.length < 2)
				return;
				
			var thirdPoint:Point = RandomThirdPoint;
			
			graphics.lineStyle(4, 0x000000, 1); 
			graphics.moveTo(RightEndPoint.x,RightEndPoint.y);
			graphics.curveTo(thirdPoint.x - ExtraMath.RandomNumber(-100,-115), thirdPoint.y + ExtraMath.RandomNumber(-100,-115), OtherEndPoint.x, OtherEndPoint.y);
			graphics.endFill();
			
			
			
			graphics.beginFill(0x000000);
			graphics.drawRect(RightEndPoint.x, RightEndPoint.y, 20, 20);
			graphics.endFill();


			graphics.beginFill(0x000000);
			graphics.drawRect(OtherEndPoint.x, OtherEndPoint.y, 20, 20);
			graphics.endFill();
		}
	}

}