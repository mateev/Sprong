package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class SelectionBox extends Sprite 
	{
		public function SelectionBox(center:Point, offsetX:Number, offsetY:Number) 
		{
			graphics.beginFill(0xff0000);
			graphics.drawRect(center.x+offsetX, center.y-offsetY, 50, 50);
			graphics.endFill();
						
			//visible = false;
		}
		
		public function get Enabled():Boolean
		{
			return visible;
		}
		
		public function Enable(origin:Point, offset:Number):void
		{	
//			x = origin.x + offset;
//			y = origin.y;
			trace(x,y);
			visible = true;			
		}
		
		public function Disable():void
		{
			visible = false;
		}
	}

}