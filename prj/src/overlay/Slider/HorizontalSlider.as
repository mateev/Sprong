package overlay.Slider 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ivan
	 */
	public class HorizontalSlider extends Slider 
	{
		
		public function HorizontalSlider() 
		{
			super();
		}
		
		override public function onStage(e:Event = null):void 
		{
			super.onStage(e);
			
			
			endPoints.unshift(new Point(xOffsetValue, stage.stageHeight - xOffsetValue));
			
			drawGraphics();
		}
	}

}