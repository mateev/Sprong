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
	import overlay.MenuContainer;
	import overlay.SideMenu.buttonGraphic;
	import overlay.SideMenu.capGraphic;
	import overlay.Slider.HorizontalSlider;
	import overlay.Slider.VerticalSlider;
	import overlay.Slider.SliderEvent;
	import placeable.Cannon;
	import placeable.Trampoline;

	
	//	SPAGHETTICODE!!!!1111111SHIFT+ELEVEN
	public class Main extends Sprite 
	{		
		public static var currentLevel:Level;
		public static var CannonIDs:Array = null;
		
		private var selectedType:Class;
		
		private var menusAndScreens:MenuContainer;
		
		public function Main():void 
		{			
			selectedType = Cannon;	//	ONLY FOR TESTING PURPOSES! INITIAL VALUE SHOULD BE NULL
			
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
		}
		
		private function onClick(me:MouseEvent):void
		{
			var isMenuClick:Boolean = stage.getObjectsUnderPoint(new Point(mouseX, mouseY)).some(function(elem:*, index:*, array:*):Boolean { return elem is buttonGraphic; } );
			
			if (!isMenuClick && selectedType)
			{
				place(new Point(mouseX, mouseY), selectedType);
			}
		}
		
		private function place(location:Point, type:Class)
		{
			var generatedID:int = selectedType == Cannon ? GeneratedCannonID : -1;
			
			currentLevel.place(new Point(mouseX, mouseY),generatedID);			
		}
		
		//	TODO: Too many variables
		private function onSlide(slide:SliderEvent):void
		{	
			var levelX:int = currentLevel.x;
			var levelY:int = currentLevel.y;
				
			var slideDisplacement:Number = ExtraMath.TWELVE;
			
			switch(slide.direction)
			{
				case SliderEvent.UP:
					levelY+=slideDisplacement;
					break;
				case SliderEvent.DOWN:
					levelY-=slideDisplacement;
					break;
				case SliderEvent.LEFT:
					levelX+=slideDisplacement;
					break;
				case SliderEvent.RIGHT:
					levelX-=slideDisplacement;
					break;
			}
			
			if (currentLevel.HasReachedEdge(new Point(levelX,levelY)))
				return;
				
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
			menusAndScreens = new MenuContainer();
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
			while (CannonIDs.some(function(id:uint, index:int, MenuIDs:*):Boolean { return id == generatedID; } ));
			
			CannonIDs.push(generatedID);
			
			return generatedID;
		}


	}
	
}