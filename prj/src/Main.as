package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import overlay.MenuContainer;
	import overlay.SideMenu.capGraphic;
	import ramps.RampContentClass;
	
	//	SPAGHETTICODE!!!!1111111SHIFT+ELEVEN
	public class Main extends Sprite 
	{		
		private var test:LevelOBJClass;
		private var pl:Player;
		
		public static const TWELVE:int = 12;			// Twelve
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
			
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
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
				generatedID = int("0x" + RandomColorComponent().toString(16) + RandomColorComponent().toString(16) + RandomColorComponent().toString(16));
			}
			while (CannonIDs.some(function(id:uint, index:int, MenuIDs:*):Boolean { return id == generatedID; } ));
			
			CannonIDs.push(generatedID);
			
			return generatedID;
		}

		// Generates a random color component
		public static function RandomColorComponent(begin:int=0,end:int=255):int
		{
			if (begin<0 || begin>255 || end<0 || end>255)
				throw ArgumentError("Invalid color range");
				
			return RandomInteger(begin, end);
		}
		
		// Based on http://www.actionscript.org/forums/showthread.php3?t=178123		
		public static function RandomInteger(begin:int = int.MIN_VALUE, end:int = int.MAX_VALUE):int
		{
			//	A few words on XOR Swaps in AS3 - http://jacksondunstan.com/articles/318
			if (begin > end)
			{
				begin ^= end;
				end ^= begin;
				begin ^ end;
			}
			
			return Math.floor( begin + ( Math.random() * ( end - begin + 1 ) ));
		}
		
		//	This generates a random number in a range
		public static function RandomNumber(begin:Number, end:Number):Number
		{
			var generatedNumber:Number;
			
			if (begin > end)
			{
				//	XOR Swap fails for non-integers in AS3, so...
				var swapValue:Number = begin;
				begin = end;
				end = begin;
			}
			
			do
			{
				generatedNumber = RandomInteger(Math.floor(begin), Math.ceil(end)) + RandomSign() * Math.random();
			}
			while (generatedNumber<begin || generatedNumber>end);

			
			return generatedNumber;
		}
		
		public static function RandomSign():int
		{
			return RandomInteger(0, 1) ? -1 : 1;
		}
	}
	
}