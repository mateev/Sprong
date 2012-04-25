package overlay.SideMenu 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Menu extends Sprite 
	{
		public static const MOVEMENT_RATE:int = ExtraMath.TWELVE;
		
		private var size:int;

		private var cap:buttonGraphic;
		private var appearance:menuGraphic;

		private var logic:menuLogic;
		private var isHorizontal:Boolean;
		
		private var status:uint;	// 0 - static, 1 - expanding, 2 - retracting
		
		private var ID:uint;
		
		private var inputCornerOffset:Number;
		
		public function Menu(cornerOffset:Number,capColor:uint,horizontal:Boolean = true) 
		{
			inputCornerOffset = cornerOffset;
			
			ID = capColor;
			
			status = 0;
			
			isHorizontal = horizontal;

			size = 0;
			
			appearance = menuGraphic.MenuGraphic(cornerOffset, isHorizontal);
			logic = new menuLogic(cornerOffset, isHorizontal);			
			
			addChild(appearance);

			cap = buttonGraphic.CapButton(cornerOffset,isHorizontal,capColor);
			addChild(cap);
			
			addEventListener(MouseEvent.CLICK, mv);
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
		}
		
		// [TOOD] Fix bug where cap can partialy go off-screen if MOVE_SPEED is too big
		private function onTock(e:Event):void
		{
			switch(status)
			{
				case 0:
					break;
				case 1:
					if (isExpanded) status = 0;
					break;
				case 2:
					if (isRetracted) status = 0;
					break;	
			}
		}
		
		private function onTick(e:Event):void
		{
			if (status == 0)
				return;
				
			if (isHorizontal)
				moveHorizontal(status == 1);
			else
				moveVertical(status == 1);			
			
		}
		
		private function moveVertical(isExpanding:Boolean):void
		{
			cap.x += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
			appearance.x += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
		}
		
		private function moveHorizontal(isExpanding:Boolean=true):void
		{
			cap.y += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
			appearance.y += (isExpanding ? 1 : -1)*MOVEMENT_RATE;
		}
		
		private function get isRetracted():Boolean
		{
			return isHorizontal ? cap.y <= 0 : cap.x <= 0;
		}
		
		private function get isExpanded():Boolean
		{
			return isHorizontal ? cap.y >= ButtonHeight(isHorizontal) : cap.x >= ButtonWidth(isHorizontal);
		}
	
		private function isCapClicked(clickedButton:int):Boolean
		{
			if (clickedButton != 0)
				return false;

			if (isRetracted && clickedButton == 0)
				return true;
				
			if (isHorizontal)
			{
				if ((mouseY > ButtonHeight(isHorizontal)) && (mouseY < ButtonHeight(isHorizontal) + CapHeight(isHorizontal)))
				{
					return true;
				}
			}
			else
			{
				if ((mouseX > ButtonWidth(isHorizontal)) && (mouseX < ButtonWidth(isHorizontal) + CapWidth(isHorizontal)))
				{
					return true;
				}
			}
			
			return false;
		}
				
		private function mv(ev:MouseEvent):void
		{				
			var clickedButton:int = isHorizontal ? (mouseX - width - inputCornerOffset) / 100 : (mouseY - height - inputCornerOffset) / 100;
			
			if (isCapClicked(clickedButton))
			{
				logic.Switch();
				expandedSwitch();
				return;
			}
			
			logic.Click(clickedButton / 100);
		}
		
		private function expandedSwitch():void
		{
			if (isExpanded)
				status = 2;
			else if (isRetracted)
				status = 1;
		}
		
		public static function ButtonWidth(isHorizontal:Boolean):Number
		{
			return isHorizontal ? 100 : 70;
		}
		
		public static function ButtonHeight(isHorizontal:Boolean):Number
		{
			return isHorizontal ? 70 : 100;
		}
		
		public static function CapWidth(isHorizontal:Boolean):Number
		{
			return isHorizontal ? ButtonWidth(isHorizontal) : ButtonWidth(isHorizontal)*0.5;
		}
		
		public static function CapHeight(isHorizontal:Boolean):Number
		{
			return isHorizontal ? ButtonHeight(isHorizontal) * 0.5 : ButtonHeight(isHorizontal);
		}
	}
}