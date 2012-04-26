package overlay.SideMenu.menuGraphic 
{
	import flash.display.Bitmap;
	import overlay.SideMenu.menuGraphic.buttonGraphic;
	import overlay.SideMenu.Menu.Menu;
	/**
	 * ...
	 * @author ivan
	 */
	public class HorizontalMenuGraphic extends MenuGraphic 
	{
		
		public function HorizontalMenuGraphic(inputCornerOffset:Number = 0) 
		{
			super(inputCornerOffset);			

			var emptyButton:buttonGraphic = buttonGraphic.EmptyButton(cornerOffset,true);
			
			buttons.push(emptyButton);
			
			addChild(emptyButton);			

		}
		
		override public function AddButton(graphic:Bitmap,number:int=-1):void 
		{			
			super.AddButton(graphic);
			
			var newButtonOffset:Number = cornerOffset + Menu.ButtonSide * buttons.length;

			var newButton:buttonGraphic = new buttonGraphic(newButtonOffset, true);
			
			newButton.Update(graphic);
				
			buttons.push(newButton);
			
			addChild(newButton);			

		}
		
	}

}