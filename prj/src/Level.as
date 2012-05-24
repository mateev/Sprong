package  
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import launchable.Launchable;
	import placeable.Cannon;
	import placeable.Placeable;
	import placeable.Trampoline;
	import ramps.RampContentClass;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	public class Level extends Sprite 
	{
		private var sky:CloudManager;
		private var levelObject:LevelOBJClass;
		
		private var projectile:Launchable;

		private var placeables:Vector.<Placeable>;
		
		private var pl:Placeable;
		
		private var trampolines:Vector.<Trampoline>;
		
		public function Level() 
		{
			trampolines = new Vector.<Trampoline>();
			placeables = new Vector.<Placeable>();
			projectile = new Launchable();
			
			if (stage) onStage();		
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		public function RotateObject(id:int, value:Number):void
		{
			
			for (var index:int = 0; index < placeables.length; index++)
			{
				if (placeables[index].GetID() == id)
					placeables[index].changeFacing(value);
			}
			
		}
		
		private function onStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);

			levelObject = new LevelOBJClass();
			
			sky = CloudManager.CloudManagerObject(levelObject.width, levelObject.height);
			addChild(sky);

			addChild(levelObject);
			
			addChild(projectile);
			
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
		}
		
		public function HasReachedEdge(location:Point):Boolean
		{
			return (!sky.InSky(new Point(-location.x, -location.y)));
		}

		private function collideWithPlaceable(object:*):int
		{
			var collideIndex:int;

			for (collideIndex = 0; collideIndex < placeables.length; collideIndex++)
				if (placeables[collideIndex].hitTestObject(object))
					return collideIndex;
			
			return -1;			
		}
		
		private function collideWithTrampoline(object:*):int
		{
			var collideIndex:int;

			for (collideIndex = 0; collideIndex < placeables.length; collideIndex++)
				if ((placeables[collideIndex] as Trampoline) && placeables[collideIndex].hitTestObject(object))
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
		
		private function onTock(event:Event):void
		{
			var collide:int = collideWithTrampoline(projectile);
			
			if (collide >= 0)
				projectile.visible = false;
			
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
		
		public function remove(id:int):Class
		{
			var returnType:Class = null;
			var objectIndex:int;
			
			for (var index:int; index < placeables.length; index++)
			{
				if (placeables[index].GetID() == id)
				{
					objectIndex = index;
					returnType = (getDefinitionByName(getQualifiedClassName(placeables[index])) as Class);
					break;
				}
			}

			removeChild(placeables[index]);
			
			placeables[index] = placeables[placeables.length - 1];
			
			placeables.pop();
			
			projectile.visible = false;
			
			return returnType;
		}
		

		public function trampoline(location:Point):void
		{
			var pl:Trampoline = new Trampoline();
			pl.x = mouseX;
			pl.y = mouseY;
				
			placeables.push(pl);
			addChild(pl);				
		}
		
		private var launchY:int;
		
		public function launch(id:int,value:Point):void
		{
			var objectIndex:int;
			
			for (var index:int; index < placeables.length; index++)
			{
				if (placeables[index].GetID() == id)
				{
					objectIndex = index;
					break;
				}
			}	
			
			if (placeables[index] as Cannon == null)
				return;
			
			projectile.Angle = value;
			projectile.x = placeables[index].x;
			projectile.y = placeables[index].y;
			projectile.visible = true;
			launchY = projectile.y;
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