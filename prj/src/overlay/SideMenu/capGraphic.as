package overlay.SideMenu 
{
	/**
	 * ...
	 * @author ivan
	 */
	public class capGraphic extends buttonGraphic 
	{
		private var isCap:Boolean;
		
		public function capGraphic(offset:Number, horizontal:Boolean=true, empty:Boolean=false, capColor:uint=0xb1b1b1, margin:Number=MARGIN_SIZE) 
		{
			super(offset, horizontal, empty, capColor, true, margin);
			
			drawBackground(horizontal);
			drawForeground(capColor, horizontal,margin);
		}
		
		private function drawForeground(color:uint, isHorizontal:Boolean, margin:Number):void
		{
			draw5Shape(color, isHorizontal, margin);
		}
		
		private function drawBackground(isHorizontal:Boolean)
		{
			draw5Shape(0x000000, isHorizontal);
		}
		
		private function draw5Shape(cap:uint,isHorizontal:Boolean,margin:Number=0):void
		{
			graphics.beginFill(cap)
			
			var drawCommands:Vector.<int> = new Vector.<int>();
			drawCommands.push(1, 2, 2, 2, 2);
			
			trace(margin, margin);
			
			var drawPoints:Vector.<Number> = new Vector.<Number>();
			drawPoints.push(margin, margin, Menu.ButtonWidth(isHorizontal)-2*margin,margin, Menu.ButtonWidth(isHorizontal)-2*margin, Menu.ButtonHeight(isHorizontal)-2*margin, (Menu.ButtonWidth(isHorizontal) / 3)-2*margin, Menu.ButtonHeight(isHorizontal)-2*margin, 0, (Menu.ButtonHeight(isHorizontal) / 3)-2*margin);
						
			graphics.drawPath(drawCommands, drawPoints);
			
			graphics.endFill();
		}
		
	}

}