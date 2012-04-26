package overlay.SideMenu.menuGraphic
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import overlay.SideMenu.Menu.Menu;
	
	public class buttonGraphic extends Sprite 
	{	
		public static const MARGIN_SIZE:Number = 10;
		
		private var isHorizontal:Boolean;
		public var isEmpty:Boolean;

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
			graphics.drawRect(0, 0, Menu.ButtonSide, Menu.ButtonSide);
			graphics.endFill();
		}
		
		private function drawForeground(color:uint,margin:Number):void
		{
			graphics.beginFill(color);
			graphics.drawRect(margin, margin, Menu.ButtonSide - 2*margin, Menu.ButtonSide - 2*margin);
			graphics.endFill();
		}
		
		public static function CapButton(offset:int,isHorizontal:Boolean,capColor:uint):buttonGraphic
		{
			var returnValue:buttonGraphic = new buttonGraphic(0, isHorizontal,false, capColor, true);
			
			if (isHorizontal)
			{
				returnValue.scaleY = 0.5;
				returnValue.y = Menu.ButtonSide;
				returnValue.x = offset;
			}
			else
			{
				returnValue.scaleX = 0.5;
				returnValue.x = Menu.ButtonSide;
				returnValue.y = offset;
			}
			
			return returnValue;			
		}
		
		public static function EmptyButton(offset:Number, isHorizontal:Boolean):buttonGraphic
		{
			return new buttonGraphic(offset, isHorizontal, true);
		}
		
		public function Update(graphic:Bitmap):void
		{				
			var appearance:Bitmap = graphic;
			
			appearance.width = Menu.ButtonSide-2 * MARGIN_SIZE;
			appearance.height = Menu.ButtonSide-2 * MARGIN_SIZE;
		
			appearance.x += MARGIN_SIZE;
			appearance.y += MARGIN_SIZE;
			
			addChild(appearance);
		}		
	}

}