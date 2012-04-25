package  
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class Level extends Sprite 
	{
		private var test:LevelOBJClass;
		private var pl:Cannon;
		
		
		public function Level() 
		{
			if (stage) onStage;
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);

			test = new LevelOBJClass();
			addChild(test);
		}
	}

}