package overlay.SideMenu 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ivan
	 */
	public class HorizontalMenu extends Menu 
	{
		
		public function HorizontalMenu(cornerOffset:Number, capColor:uint) 
		{
			super(cornerOffset, capColor);
			
		}
		
		override public function mv(ev:MouseEvent):void 
		{
			mvOperation();
		}
		
		override public function mvOperation(clickedButton:int=0):void 
		{
			var clickedButton:int = (mouseX - width - inputCornerOffset) / 100;			
			
			super.mvOperation(clickedButton);
		}
		
		public override function move(isExpanding:Boolean):void
		{
			super.move(isExpanding);
			
			cap.y += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
			appearance.y += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
		}
		
		public override function IsRetracted():Boolean
		{
			return cap.y <= 0;
		}
		
		public override function IsExpanded():Boolean
		{
			return cap.y >= ButtonSide;
		}
		
		public override function IsCapClicked(clickedButton:int):Boolean
		{
			var superValue:Boolean = super.IsCapClicked(clickedButton);
			
			if (superValue == false)
			{
				if ((mouseY > ButtonSide) && (mouseY < ButtonSide + CapHeight))
				{
					return true;
				}
				
				return false;
			}
			
			return true;
		}

	}

}