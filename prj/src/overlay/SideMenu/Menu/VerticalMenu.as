package overlay.SideMenu.Menu 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import overlay.SideMenu.menuGraphic.HorizontalMenuGraphic;
	import overlay.SideMenu.menuGraphic.VerticalMenuGraphic;
	import overlay.SideMenu.menuLogic;
	import overlay.SideMenu.menuGraphic.buttonGraphic;
	/**
	 * ...
	 * @author ivan
	 */
	public class VerticalMenu extends Menu 
	{
		
		public function VerticalMenu(cornerOffset:Number, capColor:uint,availableStuff:Object) 
		{
			super(cornerOffset, capColor);			
			
			appearance = new VerticalMenuGraphic(cornerOffset);	
			
			logic = new menuLogic(inputCornerOffset,false);		
			
			cap = buttonGraphic.CapButton(inputCornerOffset,false,ID);
			
			for (var type:* in availableStuff)
				AddButton(type,availableStuff[type]);			
		}
		
		public function unselect(type:Class):void
		{
			var typeLocation:int = logic.unselect(type);
			appearance.Replenish(typeLocation);
		}
		
		override public function onStage(ev:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);			

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
			var clickedButton:int = int((mouseY-inputCornerOffset)/ButtonSide);			
			
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