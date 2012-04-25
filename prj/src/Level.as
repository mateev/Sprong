package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import ramps.RampContentClass;

	public class Level extends Sprite 
	{
		private var sky:CloudManager;
		private var levelObject:LevelOBJClass;
		private var pl:Cannon;
		
		public function Level() 
		{
			if (stage) onStage();
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);

			levelObject = new LevelOBJClass();
			
			sky = CloudManager.CloudManagerObject(test.width, test.height);
			addChild(sky);

			addChild(levelObject);
			
			addEventListener(Event.ENTER_FRAME, onTick);
//			addEventListener(Event.EXIT_FRAME, onTock);
		}
		
		private function onTick(event:Event):void
		{
			for (var index:int = 0; index < test.numChildren; index++)
			{
				var child:RampContentClass = test.getChildAt(index) as RampContentClass;
				
				if (pl && child)
				{
						if (child.hitTestObject(pl))
						{
							pl.Collides(child);
						}
				}
			}
		}
		
		public function cannon(location:Point):void
		{
			if (!pl)
			{
				trace(mouseX, mouseY);
				pl = new Cannon();
				pl.x = mouseX;
				pl.y = mouseY;
				
				addChild(pl);
			}
			else
			{
				trace(pl.x, pl.y);
			}
		}
	}

}