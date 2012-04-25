package overlay.Slider 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ivan
	 */
	public class VerticalSlider extends Slider 
	{
		
		public function VerticalSlider() 
		{
			super();
			
		}
		
		override public function onStage(e:Event = null):void 
		{
			super.onStage(e);
			
			
			endPoints.unshift(new Point(stage.stageWidth - xOffsetValue, xOffsetValue/2));
			
			drawGraphics();
		}
		
	}

}