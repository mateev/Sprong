package selectionBox
{
	import flash.display.ColorCorrectionSupport;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import placeable.Placeable;
	import placeable.Trampoline;
	import selectionBox.SelectionBoxEvent;
	
	/*
	 * TODO:
		 * Make it so the selection box will know the current rotation angle;
		 * Make it so rotation angle is dispatched
		 * Make it so the events will get handled by main
	 */
	public class SelectionBox extends Sprite
	{
		private var buttonEvent:SelectionBoxEvent;
		
		private var circleCenter:Point;

		private var isRotation:Boolean;	
		
		
		private var isMovement:Boolean;
		
		private var isActive:Boolean;
		private var id:Number;
		
		private var menuLocation:Point;
		private var menuWidth:Number;
		
		
		private function getClickedMenuButton(mouseLocation:Point):int
		{
			return int(Point.distance(mouseLocation, menuLocation) / menuButtonWidth);
		}
		
		private function get menuButtonWidth():Number
		{
			return menuHeight;
		}
		
		private function get menuHeight():Number
		{
			return menuWidth / 3;
		}
		
		public function SelectionBox(active:Boolean=false) 
		{
			super();
			
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onTick(e:Event):void
		{
			if (isRotation)
			{
				//drawGFX();
			}
		}
		
		private function onClick(me:MouseEvent):void
		{
			if (!isActive)
				return;

			var clickedButton:int = getClickedMenuButton(new Point(mouseX, mouseY));
				
			if (isMovement)
			{
				if (clickedButton == 0)
					trace(buttonEvent.value);
					//stage.dispatchEvent(buttonEvent);
				
				isMovement = false;
				drawGFX();				

				return;	
			}
			
			if (isRotation)
			{
				if (clickedButton == 1)
				{
					stage.dispatchEvent(buttonEvent);
					isRotation = false;
					drawGFX();
					return;
				}
				
				if (mouseY > 0)
					return;
				
				drawGFX(0);
				
				graphics.moveTo(0, 0);
				graphics.lineTo(mouseX, mouseY);
				
				buttonEvent.value = (new Point(mouseX, mouseY).normalize(1) as Object);
								
				
				return;
			}
	
			//	Todo: Explain
			if(mouseX>menuLocation.x && mouseY>menuLocation.y)
			{
				buttonEvent = null;
				
				switch(clickedButton)
				{
					case 0:
						trace("move");
						isMovement = true;
						drawGFX(2);
						buttonEvent = new SelectionBoxEvent(id, SelectionBoxEvent.MOVE);
						buttonEvent.value = new Point(x, y);
						return;
					case 1:
						trace("rotate");
						isRotation = true;
						drawGFX(0);
						buttonEvent = new SelectionBoxEvent(id, SelectionBoxEvent.ROTATE);
						buttonEvent.value = new Point(1, 1);
						return;
					case 2:
						trace("remove");
						buttonEvent = new SelectionBoxEvent(id, SelectionBoxEvent.REMOVE);
						stage.dispatchEvent(buttonEvent);
						break;
					default:
						throw Error("Invalid selection box menu button id " + clickedButton.toString());
						

				}
				
				return;
			}
		}
		
		private function drawGFX(radiiCount:int=4):void 
		{
			graphics.clear();
			
			//	Todo: explain how this works
			for (var radIndex:int = 0; radIndex < radiiCount; radIndex++)
			{
				graphics.lineStyle(1, id / Math.pow(2, radIndex), 1);
				graphics.drawCircle( 0, 0, menuWidth - radIndex*5);
			}
						
			graphics.beginFill(id, 0.5);
			graphics.drawRect( menuLocation.x, menuLocation.y, menuWidth, menuHeight );
			graphics.endFill();

			if (isRotation)
			{
				graphics.lineStyle(5, id , 1);			
				graphics.drawCircle(0, 0, 3*menuWidth/2);
			}
			
		}
		
		public function get IsActive():Boolean
		{
			return isActive;
		}
		
		public function reactivate(isRotate:Boolean,location:Point, color:uint = 0xFF0000, outerRadius:uint = 110, radiiCount:int = 4):void
		{
			deactivate();
			activate(location, color, outerRadius, radiiCount);
			
			isRotation = isRotate;
		}
		
		public function activate(location:Point, color:uint = 0xFF0000, outerRadius:uint = 110, radiiCount:int=4):void
		{
			x = location.x;
			y = location.y;
			
			id = color;
			isActive = true;
			
			menuLocation = new Point(outerRadius / 2, outerRadius / 3);
			menuWidth = outerRadius;
						
			drawGFX();
		}
		
		public function deactivate():void
		{
			isActive = false;
			isRotation = false;
			isMovement = false;
			graphics.clear();
		}
		
		public static function SelectionBoxRings(object:Object):int
		{
			if (object is Trampoline)
				return 2;
			
			return 4;
		}		
	}

}