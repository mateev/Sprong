package overlay.Slider 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
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
			
			addEventListener(MouseEvent.MOUSE_OVER, onClick);
		}
		
		private function onClick(me:MouseEvent):void
		{			
			var clickDirection:String;
			if (isNearRightPoint(new Point(mouseX, mouseY)))
				clickDirection = SliderEvent.DOWN;
			else
				clickDirection = SliderEvent.UP;
				
			fireMovementEvent(clickDirection);
		}
	}

}