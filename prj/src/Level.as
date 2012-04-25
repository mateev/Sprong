package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import placeable.Cannon;
	import placeable.Trampoline;
	import ramps.RampContentClass;
	import flash.utils.Dictionary;

	public class Level extends Sprite 
	{
		private var sky:CloudManager;
		private var levelObject:LevelOBJClass;
		private var pl:Trampoline;
				
		public function Level() 
		{
			if (stage) onStage();
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);

			levelObject = new LevelOBJClass();
			
			sky = CloudManager.CloudManagerObject(levelObject.width, levelObject.height);
			addChild(sky);

			addChild(levelObject);
			
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		public function HasReachedEdge(location:Point):Boolean
		{
			return (!sky.InSky(new Point(-location.x, -location.y)));
		}
		
		private function onTick(event:Event):void
		{
			for (var index:int = 0; index < levelObject.numChildren; index++)
			{
				var child:RampContentClass = levelObject.getChildAt(index) as RampContentClass;
				
				if (pl && child)
				{
						if (child.hitTestObject(pl))
						{
							pl.Collides(child);
						}
				}
			}
		}
		
		public function place(location:Point):void
		{
			cannon(location);
		}
		
		public function cannon(location:Point):void
		{
			if (!pl)
			{
				trace(mouseX, mouseY);
				pl = new Trampoline();
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