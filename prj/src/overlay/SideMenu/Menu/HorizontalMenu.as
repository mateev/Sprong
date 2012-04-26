package overlay.SideMenu.Menu 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import overlay.SideMenu.menuGraphic.HorizontalMenuGraphic;

	public class HorizontalMenu extends Menu 
	{
		
		public function HorizontalMenu(cornerOffset:Number, capColor:uint) 
		{
			super(cornerOffset, capColor);
			
			appearance = new HorizontalMenuGraphic(inputCornerOffset);
		}
				
		override public function onStage(ev:Event = null):void 
		{								
			addChild(cap);
			
			super.onStage(ev);
			
			addChild(appearance);			
		}
		
		override public function onClick(ev:MouseEvent=null):void 
		{
			clickOperation();
		}
		
		override public function clickOperation(clickedButton:int=0):void 
		{
			var clickedButton:int = int((mouseX-inputCornerOffset)/ButtonSide);
			
			super.clickOperation(clickedButton);
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