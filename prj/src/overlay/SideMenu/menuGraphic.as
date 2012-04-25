package overlay.SideMenu 
{
	import flash.display.Sprite;
	
	public class menuGraphic extends Sprite 
	{
		private var isHorizontal:Boolean;
		private var buttons:Array;
		
		public function menuGraphic(horizontal:Boolean=true,capColor:uint=0x00ff00)
		{
			isHorizontal = horizontal;
			buttons = new Array();
			
			var emptyButton:buttonGraphic = buttonGraphic.EmptyButton(0,isHorizontal);
			buttons.push(emptyButton);
			addChild(emptyButton);			
		}
		
		public function AddButton():void
		{
			var newButtonOffset:Number = (isHorizontal ? Menu.ButtonWidth(isHorizontal) : Menu.ButtonHeight(isHorizontal)) * buttons.length;

			var newButton:buttonGraphic = buttonGraphic.EmptyButton(newButtonOffset, isHorizontal);
			
			buttons.push(newButton);
			
			addChild(newButton);			
		}
		
		public static function MenuGraphic(offset:Number, horizontal:Boolean = true, capColor:uint = 0x00ff00):menuGraphic
		{
			var graphic:menuGraphic = new menuGraphic(horizontal, capColor);

			if (horizontal)
				graphic.x = offset;
			else
				graphic.y = offset;
				
			return graphic;
		}
	}

}