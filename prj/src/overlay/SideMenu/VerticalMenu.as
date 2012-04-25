package overlay.SideMenu 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ivan
	 */
	public class VerticalMenu extends Menu 
	{
		
		public function VerticalMenu(cornerOffset:Number, capColor:uint) 
		{
			super(cornerOffset, capColor);
			
		}
		
		override public function mv(ev:MouseEvent):void 
		{
			mvOperation();
		}
		
		override public function mvOperation(clickedButton:int=0):void 
		{
			var clickedButton:int = (mouseY - height - inputCornerOffset) / 100;			
			
			super.mvOperation(clickedButton);
		}

		
		override public function move(isExpanding:Boolean):void 
		{
			super.move(isExpanding);
			
			cap.x += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
			appearance.x += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
		}
			
		public override function IsRetracted():Boolean
		{
			return cap.x <= 0;
		}		
		
		public override function IsExpanded():Boolean
		{
			return cap.x >= ButtonSide;
		}

		public override function IsCapClicked(clickedButton:int):Boolean
		{
			var superValue:Boolean = super.IsCapClicked(clickedButton);
			
			if (superValue == null)
			{
				if ((mouseX > ButtonSide) && (mouseX < ButtonSide + CapHeight))
				{
					return true;
				}
				
				return false;
			}
			
			return superValue;
		}
		
	}

}