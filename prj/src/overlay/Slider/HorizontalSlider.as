package overlay.Slider 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
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
			
			endPoints.unshift(new Point(xOffsetValue/2, stage.stageHeight - xOffsetValue));
			
			drawGraphics();
					
			addEventListener(MouseEvent.MOUSE_OVER, onClick);
		}
		
		private function onClick(me:MouseEvent):void
		{
			var clickDirection:String;
			if (isNearRightPoint(new Point(mouseX, mouseY)))
				clickDirection = SliderEvent.RIGHT;
			else
				clickDirection = SliderEvent.LEFT;
				
			fireMovementEvent(clickDirection);
		}
	}

}