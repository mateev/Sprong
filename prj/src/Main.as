package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import overlay.MenuContainer;
	import overlay.SideMenu.capGraphic;
	import overlay.Slider.HorizontalSlider;
	import overlay.Slider.VerticalSlider;
	import overlay.Slider.SliderEvent;
	import ramps.RampContentClass;
	
	//	SPAGHETTICODE!!!!1111111SHIFT+ELEVEN
	public class Main extends Sprite 
	{		
		private var test:LevelOBJClass;
		private var pl:Player;
		
		public static var CannonIDs:Array = null;
		
		private var menusAndScreens:MenuContainer;
		
		public function Main():void 
		{			
			if (stage) init();			
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var assets:AssetsManager = new AssetsManager();
			
			test = new LevelOBJClass();

			var man:CloudManager = CloudManager.CloudManagerObject(test.width, test.height);
			addChild(man);
			
			for (var index:int = 0; index < test.numChildren; index++)
				if (test.getChildAt(index) as Player != null)
					pl = (test.getChildAt(index) as Player);
			
			addChild(test);
			
			initMenus();
			addChild(menusAndScreens);

			//showMenus();
			var sltest:HorizontalSlider = new HorizontalSlider();
			var sltest2:VerticalSlider = new VerticalSlider();
			
			addChild(sltest2);
			addChild(sltest);
			
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
			addEventListener(SliderEvent.SLIDE, onSlide);
		}
		
		private function onSlide(slide:SliderEvent):void
		{
			var slideDisplacement:Number = ExtraMath.TWELVE;
			
			switch(slide.direction)
			{
				case SliderEvent.UP:
					test.y-=slideDisplacement;
					break;
				case SliderEvent.DOWN:
					test.y+=slideDisplacement;
					break;
				case SliderEvent.LEFT:
					test.x-=slideDisplacement;
					break;
				case SliderEvent.RIGHT:
					test.x+=slideDisplacement;
					break;
			}
		}
		
		private function onTock(e:Event):void
		{
			var playerLocation:Rectangle = pl.getBounds(stage);
			
	//		trace(pl.getBounds(stage).x);
		}
		
		private function drawFrame():void
		{
			graphics.clear();
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
		}
		
		private function onTick(event:Event):void
		{
			for (var index:int = 0; index < test.numChildren; index++)
			{
				var child:RampContentClass = test.getChildAt(index) as RampContentClass;
				
				if (child)
				{
					if (child.hitTestObject(pl))
					{
							pl.Collides(child);
					}
				}
			}
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