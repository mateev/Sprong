package overlay.SideMenu.menuGraphic
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import overlay.SideMenu.Menu.Menu;
	
	public class buttonGraphic extends Sprite 
	{	
		public static const MARGIN_SIZE:Number = 10;
		public static const DEF_NUMBER_CLR:uint = 0xf6ff00;
		
		private var isHorizontal:Boolean;
		public var isEmpty:Boolean;
		private var number:int;
		private var numberRepr:TextField;

		// Used http://www.republicofcode.com/tutorials/flash/as3text/
		private function updateNumber():void
		{
			if (numberRepr)
				removeChild(numberRepr);
			
			var numberFormat:TextFormat = new TextFormat();
			numberFormat.size = 20;
			numberFormat.bold = true;
			numberFormat.color = DEF_NUMBER_CLR;
				
			numberRepr = new TextField();
			numberRepr.x += MARGIN_SIZE;
			numberRepr.y += MARGIN_SIZE;
			numberRepr.defaultTextFormat = numberFormat;
			numberRepr.text = number.toString();
			addChild(numberRepr);			
		}
		
		// NB: Too much function calls!
		public function buttonGraphic(offset:Number, horizontal:Boolean = true, empty:Boolean = false, color:uint = 0xb1b1b1, cap:Boolean = false,  inputNumber:int=-1)
		{
			number = inputNumber;
			
			isHorizontal = horizontal;
			isEmpty = empty;

			drawBackground();
				
			if (!isEmpty)
				drawForeground(color,MARGIN_SIZE);
			
			if (isHorizontal)
				x = offset;
			else
				y = offset;
		}
		
		public function Click():void
		{
			if (number <= 0)
				return;
				
			number -= 1;
			
			updateNumber();
		}
		
		public function get HasNumber():Boolean
		{
			return number>=0;
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
		
		public function Update(graphic:Bitmap, inputNumber:int=-1):void
		{				
			var appearance:Bitmap = graphic;
			
			appearance.width = Menu.ButtonSide-2 * MARGIN_SIZE;
			appearance.height = Menu.ButtonSide-2 * MARGIN_SIZE;
		
			appearance.x += MARGIN_SIZE;
			appearance.y += MARGIN_SIZE;
			
			number = inputNumber;
			
			addChild(appearance);
			
			if (HasNumber)
				updateNumber();
			
			isEmpty = false;
		}
		
		public function Replenish():void
		{
			number++;
			
			updateNumber();
		}
	}

}