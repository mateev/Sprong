package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import overlay.MenuManager;
	import overlay.SideMenu.menuGraphic.buttonGraphic;
	import overlay.SideMenu.capGraphic;
	import overlay.SideMenu.SideButtonEvent;
	import overlay.Slider.HorizontalSlider;
	import overlay.Slider.VerticalSlider;
	import overlay.Slider.SliderEvent;
	import placeable.Cannon;
	import placeable.Placeable;
	import placeable.Trampoline;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import selectionBox.SelectionBox;
	
	//	SPAGHETTICODE!!!!1111111SHIFT+ELEVEN
	public class Main extends Sprite 
	{		
		public static var currentLevel:Level;
		public static var CannonIDs:Array = null;
		public static var TrampolineIDs:Array = null;
		
		private var availablePlaceables:Object;
		
		private var isClassSelected:Boolean;
		private var selectedType:Class;				//	This handles menu selection from left menu
		private var selectedThing:Object;			//	This handles level object selection
		private var activeSelectionBox:SelectionBox;//	This handles the level object selection box
		
		private var menusAndScreens:MenuManager;
		
		public function Main():void 
		{			
			selectedType = null;
			selectedThing = null;
			activeSelectionBox = new SelectionBox();
						
			availablePlaceables = new Object();
			availablePlaceables[getQualifiedClassName(Cannon)] = 1;
			availablePlaceables[getQualifiedClassName(Trampoline)] = 10;				
			
			if (stage) init();						
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var assets:AssetsManager = new AssetsManager();

			currentLevel = new Level();
			addChild(currentLevel);
						
			initMenus();
			addChild(menusAndScreens);

			showMenus();

			var sltest:HorizontalSlider = new HorizontalSlider();
			var sltest2:VerticalSlider = new VerticalSlider();
			
			addChild(sltest2);
			addChild(sltest);
			
			addEventListener(Event.EXIT_FRAME, onTock);
			addEventListener(SliderEvent.SLIDE, onSlide);
			addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(SideButtonEvent.BUTTON_PRESS, onPress);
			
			addChild(activeSelectionBox);
		}
		
		public function onPress(e:SideButtonEvent):void
		{
			//	If something is selected
			if (selectedType)
			{
				// It will get unselected
				unselect(selectedType);
				trace("unselected");
			}
				
			selectedType = (getDefinitionByName(e.PressedID) as Class);
		}
		
		private function unselect(type:Class):void
		{
			menusAndScreens.unselect(type);
		}
		
		//	TODO: Move this somewhere else
		//	This function returns the index of an element in an array if that element satisfies a predicate and -1 if no such exist
		private function getElementIndexFromArray(array:Array, predicate:Function):int
		{
			if (array.length == 0)
				return -1;
				
			for (var index:int = 0; index < array.length; index++)
				if (predicate(array[index]))
					return index;
					
			return -1;		
		}
		
		private function onClick(me:MouseEvent):void
		{			
			//	This returns an array of all the things under the pointer
			var clickTargets:Array = stage.getObjectsUnderPoint(new Point(mouseX, mouseY));
						
			//	This checks if one of the targets is a menu
			var isMenuClick:Boolean = clickTargets.some(function(elem:*, index:*, array:*):Boolean { return elem is buttonGraphic; }) ;
			
			//	If user didn't click a menu ....
			if (!isMenuClick)
			{
				//	This tries to determine if something from the level has been selected and returns the index in the clickTargets array
				var selectedLevelObjectIndex:int = getElementIndexFromArray(clickTargets, function(elem:*):Boolean { return elem is Placeable; });

				//	If a valid index has been returned, something has been selected
				if (selectedLevelObjectIndex>=0)
				{
					selectedThing = (clickTargets[selectedLevelObjectIndex] as Placeable);
					activeSelectionBox.deactivate();
					activeSelectionBox.activate(currentLevel.localToGlobal(selectedThing.Center),selectedThing.GetID(),selectedThing.width);
					return;
				}
				
				//	Note to self: [Not as useless anymore, it seems...]
				if (selectedType)
				{
					place(new Point(mouseX, mouseY), selectedType);
					selectedType = null;
					selectedThing = null;	// A menu selection cancels an object selection!
					
					activeSelectionBox.deactivate();
				}
			}
			else
			{
				activeSelectionBox.deactivate();
			}
		}
		
		private function place(location:Point, type:Class):void
		{			
			var generatedID:int = selectedType == Cannon ? GeneratedCannonID : -1;
			
			currentLevel.place(new Point(mouseX, mouseY), generatedID);	
			
			if(generatedID>=0)
				stage.dispatchEvent(new PlaceEvent(PlaceEvent.PLACE_CANNON, generatedID));
		}
		
		//	TODO: Too many variables
		private function onSlide(slide:SliderEvent):void
		{	
			var levelX:int = currentLevel.x;
			var levelY:int = currentLevel.y;
			
			var activeSelectionX:Number = activeSelectionBox.x;
			var activeSelectionY:Number = activeSelectionBox.y;
				
			var slideDisplacement:Number = ExtraMath.TWELVE;
			
			switch(slide.direction)
			{
				case SliderEvent.UP:
					levelY += slideDisplacement;
					activeSelectionY += slideDisplacement;
					break;
				case SliderEvent.DOWN:
					levelY-=slideDisplacement;
					activeSelectionY -= slideDisplacement;
					break;
				case SliderEvent.LEFT:
					levelX += slideDisplacement;
					activeSelectionX += slideDisplacement;
					break;
				case SliderEvent.RIGHT:
					levelX-=slideDisplacement;
					activeSelectionX -= slideDisplacement;
					break;
			}
			
			if (currentLevel.HasReachedEdge(new Point(levelX,levelY)))
				return;
				
			activeSelectionBox.x = activeSelectionX;
			activeSelectionBox.y = activeSelectionY;
				
			currentLevel.x = levelX;
			currentLevel.y = levelY;
		}
		
		private function onTock(e:Event):void {}
		
		private function drawFrame():void
		{
			graphics.clear();
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		}
						
		private function initMenus():void
		{
			menusAndScreens = new MenuManager(availablePlaceables);
			menusAndScreens.visible = false;
		}
		
		public function showMenus():void
		{
			menusAndScreens.visible = true;
		}	
		
		// Generates an ID for a menu, which is actualy it's cap color and the cannon that it will correspond to
		// based on http://www.nunomira.com/blog/2009/11/convert-decimal-to-hex-and-back/
		public static function get GeneratedCannonID():int
		{			
			var generatedID:int;
			
			if(CannonIDs == null)
				CannonIDs = new Array();
				
			do
			{
				generatedID = int("0x" + ExtraMath.RandomColorComponent().toString(16) + ExtraMath.RandomColorComponent().toString(16) + ExtraMath.RandomColorComponent().toString(16));
			}
			while (IsExistingID(generatedID));
			
			CannonIDs.push(generatedID);
			
			return generatedID;
		}
		
		public static function get GeneratedTrampolineID():int
		{
			var generatedID:int;
			
			if (TrampolineIDs == null)
				TrampolineIDs = new Array();
				
			do
			{
				generatedID = int("0x0000"+ ExtraMath.RandomColorComponent(255/2).toString(16));
			}
			while (IsExistingID(generatedID));
			
			TrampolineIDs.push(generatedID);
			
			return generatedID;
			
		}
		
		//	Todo: Explain how this works, lol
		public static function IsExistingID(generatedID:int):Boolean
		{
			return (TrampolineIDs == null ? false : TrampolineIDs.some(function(id:uint, index:int, MenuIDs:*):Boolean { return id == generatedID; } )) &&
					(CannonIDs == null ? false : CannonIDs.some(function(id:uint, index:int, MenuIDs:*):Boolean { return id == generatedID; } ));			
		}


	}
	
}