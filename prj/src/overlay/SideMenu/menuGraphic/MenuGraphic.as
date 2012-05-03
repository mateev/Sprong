package overlay.SideMenu.menuGraphic 
{
	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import overlay.SideMenu.menuGraphic.buttonGraphic;
	
	public class MenuGraphic extends Sprite 
	{
		protected var buttons:Vector.<buttonGraphic>;
		protected var cornerOffset:Number;
		
		public function MenuGraphic(inputCornerOffset:Number = 0)
		{
			cornerOffset = inputCornerOffset;
			
			buttons = new Vector.<buttonGraphic>();
	
		}
		
		public function IsUsable(buttonIndex:int):Boolean
		{
			var isButtonUsable:Boolean;

			try
			{
				isButtonUsable = buttons[buttonIndex].IsUsable;
			}
			catch (rangeError:RangeError)
			{
				/* 
				 * There was an odd bug about index being out of range here;
				 * This happened rarely when the user clicked on the *EXACT* edge of the menu, which is 1 pixel wide;
				 */

				//	TODO: Not sure how to handle this, so I'll just leave it like this for now
				isButtonUsable = ExtraMath.RandomSign() < 0;
			}
			finally
			{
				return isButtonUsable;
			}
		}
		
		public function Click(buttonIndex:int):void
		{
			buttons[buttonIndex].Click();
		}	
		
		public function Replenish(buttonIndex:int):void
		{

			buttons[buttonIndex].Replenish();
		}
		
		public function AddButton(graphic:Bitmap,number:int=-1):void
		{
			if (buttons.length == 1 && buttons[0].isEmpty)
			{
				removeChild(buttons[0]);
				buttons.pop();
			}
		}
		
		public static function AMenuGraphic(offset:Number, horizontal:Boolean = true, capColor:uint = 0x00ff00):MenuGraphic
		{
			var graphic:MenuGraphic = new MenuGraphic();

			if (horizontal)
				graphic.x = offset;
			else
				graphic.y = offset;
				
			return graphic;
		}
	}

}