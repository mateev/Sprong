package overlay.SideMenu 
{
	import flash.events.Event;
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
		
		override public function onStage(ev:Event = null):void 
		{
			appearance = menuGraphic.MenuGraphic(inputCornerOffset,false);
			logic = new menuLogic(inputCornerOffset,false);			
			
			addChild(appearance);

			cap = buttonGraphic.CapButton(inputCornerOffset,false,ID);
			addChild(cap);
			
			super.onStage(ev);
		}
				
		override public function onClick(ev:MouseEvent=null):void 
		{
			clickOperation();
		}
		
		override public function clickOperation(clickedButton:int=0):void 
		{
			var clickedButton:int = (mouseY - height - inputCornerOffset) / 100;			
			
			super.clickOperation(clickedButton);
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
			
			if (!superValue)
			{
				if ((mouseX > ButtonSide) && (mouseX < ButtonSide + CapHeight))
					return true;
				
				return false;
			}
			
			return superValue;
		}
		
	}

}