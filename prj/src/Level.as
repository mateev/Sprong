package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import placeable.Cannon;
	import placeable.Placeable;
	import placeable.Trampoline;
	import ramps.RampContentClass;
	import flash.utils.Dictionary;

	public class Level extends Sprite 
	{
		private var sky:CloudManager;
		private var levelObject:LevelOBJClass;

		private var placeables:Vector.<Placeable>;
		
		private var pl:Placeable;
		
		private var trampolines:Vector.<Trampoline>;
		
		public function Level() 
		{
			trampolines = new Vector.<Trampoline>();
			placeables = new Vector.<Placeable>();
			
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

		
		private function collideWithTrampoline(object:*):int
		{
			var collideIndex:int;

			for (collideIndex = 0; collideIndex < trampolines.length; collideIndex++)
				if (trampolines[collideIndex].hitTestObject(object))
					return collideIndex;
			
			return -1;
		}

		//	Returns the ramp with which the object collided
		private function collideWithRamp(object:*):RampContentClass
		{
			if (object == null)
				return null;
			
			var ramp:RampContentClass;

			for (var index:int = 0; index < levelObject.numChildren; index++)
			{
				ramp = levelObject.getChildAt(index) as RampContentClass;
				
				if (ramp)
					if (ramp.hitTestObject(object))
						return ramp;
			}			
			
			return null;
		}
		
		private function onTick(event:Event):void
		{
			for each(var pl:Placeable in placeables)
			{				
				var rampCollisionObject:RampContentClass = collideWithRamp(pl);

				if (rampCollisionObject)
					pl.Collides(rampCollisionObject);
			}
		}
		
		public function place(location:Point,id:int=-1):void
		{
			if(id>0)
				cannon(location,id);
			else
				trampoline(location);
		}

		public function trampoline(location:Point):void
		{
			var pl:Trampoline = new Trampoline();
			pl.x = mouseX;
			pl.y = mouseY;
				
			placeables.push(pl);
			addChild(pl);				
		}
		
		public function cannon(location:Point,id:int):void
		{
			var pl:Cannon = new Cannon(id);
			pl.x = mouseX;
			pl.y = mouseY;
			
			placeables.push(pl);
			addChild(pl);
		}
	}

}