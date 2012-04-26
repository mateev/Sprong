package overlay.SideMenu.menuGraphic 
{
	import flash.display.Bitmap;
	import overlay.SideMenu.menuGraphic.buttonGraphic;
	import overlay.SideMenu.Menu.Menu;

	public class VerticalMenuGraphic extends MenuGraphic 
	{
		
		public function VerticalMenuGraphic(inputCornerOffset:Number=0) 
		{
			super(inputCornerOffset);
			
			var emptyButton:buttonGraphic = buttonGraphic.EmptyButton(cornerOffset, false);
			
			buttons.push(emptyButton);
			
			addChild(emptyButton);			

		}
		
		override public function AddButton(graphic:Bitmap,number:int=-1):void 
		{			
			super.AddButton(graphic);
			
			var newButtonOffset:Number = cornerOffset + Menu.ButtonSide * buttons.length;

			var newButton:buttonGraphic = new buttonGraphic(newButtonOffset, false);
			
			newButton.Update(graphic,number);
				
			buttons.push(newButton);
			
			addChild(newButton);			

		}
		
	}

}