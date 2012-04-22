package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class CartoonyLine extends Sprite 
	{
		// Special thanks to: http://www.republicofcode.com/tutorials/flash/as3drawvectors/
		private var dashL:Number;
		
		private var beginning:Point;
		private var end:Point;
		
		public function CartoonyLine(XBegin:Number, YBegin:Number, XEnd:Number, YEnd:Number, dashLength:Number) 
		{
			super();
			
			beginning = new Point(XBegin, YBegin);
			end = new Point(XEnd, YEnd);
			
			dashL = dashLength;
			
			drawLine();
		}
		
		public function get Length():Number
		{
			return Point.distance(beginning, end);
		}
		
		private function get unit():Point
		{
			var returnValue:Point = new Point((end.x - beginning.x)/slope, (end.y-beginning.y)/slope);
			
			return returnValue;
		}
		
		private function drawLine():void
		{
			var pointLocation:Point = beginning;
			var move:Boolean = true;

			graphics.lineStyle(2, 0xFF00FF, 1);
			
			while (Point.distance(pointLocation, end) < Point.distance()
			{
				if (move)
					graphics.moveTo(pointLocation.x, pointLocation.y);
				else
					graphics.lineTo(pointLocation.x, pointLocation.y);
				
				move = !move;
				
				pointLocation.x += unit.x;
				pointLocation.y += unit.y;
			}
		}
				
		
	}

}