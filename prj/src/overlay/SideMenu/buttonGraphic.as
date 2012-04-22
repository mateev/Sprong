package overlay.SideMenu 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class buttonGraphic extends Sprite 
	{	
		public static const SIZE_FACTOR_1:Number = 70;
		public static const SIZE_FACTOR_2:Number = 100;
		public static const MARGIN_SIZE:Number = 10;
		
		private var isHorizontal:Boolean;
		private var isEmpty:Boolean;

		// NB: Too much function calls!
		public function buttonGraphic(offset:Number, horizontal:Boolean = true, empty:Boolean = false, color:uint = 0xb1b1b1, cap:Boolean = false,  margin:Number = MARGIN_SIZE)
		{
			isHorizontal = horizontal;
			isEmpty = empty;

			drawBackground();
				
			if (!isEmpty)
				drawForeground(color,margin);
			
			if (isHorizontal)
				x = offset;
			else
				y = offset;
		}
		
		private function drawBackground():void
		{
			graphics.beginFill(0x00000);
			graphics.drawRect(0, 0, Menu.ButtonWidth(isHorizontal), Menu.ButtonHeight(isHorizontal));
			graphics.endFill();
		}
		
		private function drawForeground(color:uint,margin:Number):void
		{
			graphics.beginFill(color);
			graphics.drawRect(margin, margin, Menu.ButtonWidth(isHorizontal) - 2*margin, Menu.ButtonHeight(isHorizontal) - 2*margin);
			graphics.endFill();
		}
		
		public static function CapButton(offset:int,isHorizontal:Boolean,capColor:uint):buttonGraphic
		{
			var returnValue:buttonGraphic = new buttonGraphic(0, isHorizontal,false, capColor, true);
			
			if (isHorizontal)
			{
				returnValue.scaleY = 0.5;
				returnValue.y = Menu.ButtonHeight(isHorizontal);
				returnValue.x = offset;
			}
			else
			{
				returnValue.scaleX = 0.5;
				returnValue.x = Menu.ButtonWidth(isHorizontal);
				returnValue.y = offset;
			}
			
			return returnValue;			
		}
		
		public static function EmptyButton(offset:Number, isHorizontal:Boolean):buttonGraphic
		{
			return new buttonGraphic(offset, isHorizontal,true);
		}
		
	}

}