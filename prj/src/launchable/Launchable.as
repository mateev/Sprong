package launchable 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class Launchable extends MovieClip 
	{
		public var Angle:Point;
		public var velocity:Number = 10;
		
		public function Launchable() 
		{
			super();
			
			visible = false;
			
			if (stage)	onStage();
			else	addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.ENTER_FRAME, onTick);
//			addEventListener(Event.EXIT_FRAME, onTock);

		}
		
		private function onTick(e:Event = null):void
		{
		}
		
		private function onStage(e:Event = null):void
		{
			var appearance:Bitmap = AssetsManager.Puppy;
			
			appearance.width /= 4;
			appearance.height /= 4;
			
			addChild(appearance);
		}
		
	}

}