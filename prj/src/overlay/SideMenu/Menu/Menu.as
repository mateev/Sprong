package overlay.SideMenu.Menu 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import overlay.SideMenu.menuGraphic.MenuGraphic;
	import overlay.SideMenu.menuGraphic.buttonGraphic;
	import overlay.SideMenu.menuLogic;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class Menu extends Sprite 
	{
		public static const MOVEMENT_RATE:int = ExtraMath.TWELVE;
		
		private var size:int;

		protected var cap:buttonGraphic;
		protected var appearance:MenuGraphic;
		
		protected var logic:menuLogic;
		
		protected var status:uint;	// 0 - static, 1 - expanding, 2 - retracting
		
		protected var ID:uint;
		
		protected var inputCornerOffset:Number;
		
		public function Menu(cornerOffset:Number,capColor:uint) 
		{
			inputCornerOffset = cornerOffset;
			
			ID = capColor;
			
			status = 0;
			size = 0;
			
			logic = new menuLogic(inputCornerOffset, IsHorizontal);	
			cap = buttonGraphic.CapButton(inputCornerOffset, IsHorizontal, ID);
			
			if (stage) onStage();
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		public function get IsHorizontal():Boolean
		{
			return getDefinitionByName(getQualifiedClassName(this)) == HorizontalMenu;
		}
		
		public function onStage(ev:Event = null):void 
		{			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);

			forceClick();
		}
		
		public function onClick(ev:MouseEvent=null):void{}
		
		private function forceClick():void
		{
			logic.Switch();
			expandedSwitch();
		}
		
		public function clickOperation(clickedButton:int=0):void
		{				
			if (IsCapClicked(clickedButton))
			{
				forceClick();
				return;
			}
			
			logic.Click(clickedButton / 100);
		}
		
		public function move(isExpanding:Boolean):void {}
		public function IsRetracted():Boolean { return false; }
		public function IsExpanded():Boolean { return !IsRetracted(); }
		
		
		// [TOOD] Fix bug where cap can partialy go off-screen if MOVE_SPEED is too big
		public function onTock(e:Event):void
		{
			switch(status)
			{
				case 0:
					break;
				case 1:
					if (IsExpanded()) status = 0;
					break;
				case 2:
					if (IsRetracted()) status = 0;
					break;	
			}
		}
		
		public function onTick(e:Event):void
		{
			if (status == 0)
				return;
				
			move(status == 1);			
		}
				
		public function IsCapClicked(clickedButton:int):Boolean
		{
			if (IsRetracted())
				return clickedButton == 0;
				
			return false;
		}						
		
		private function expandedSwitch():void
		{
			if (IsExpanded())
				status = 2;
			else if (IsRetracted())
				status = 1;
		}
		
		public static function get ButtonSide():Number
		{
			return 70;
		}
				
		public static function get CapHeight():Number
		{
			return 0.3*ButtonSide;
		}
		
		public function get MenuID():int
		{
			return ID;
		}
		
		public function AddButton(graphic:Bitmap=null):void
		{
			appearance.AddButton(graphic);
		}
	}
}