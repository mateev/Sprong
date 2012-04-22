package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class CloudManager extends Sprite 
	{
		[Embed(source = "../assets/clouds/cloud1.png")]
		private var CloudClass1:Class;

		[Embed(source = "../assets/clouds/cloud2.png")]
		private var CloudClass2:Class;

		[Embed(source = "../assets/clouds/cloud3.png")]
		private var CloudClass3:Class;

		[Embed(source = "../assets/clouds/cloud4.png")]
		private var CloudClass4:Class;
		
		private var managerWidth:Number;
		private var managerHeight:Number;
		
		private var cloudDensity:int;
		
		private var clouds:Array;
		
		public function CloudManager(levelWidth:Number, levelHeight:Number, density:int = 20 ) 
		{
			managerWidth = levelWidth * 2;
			managerHeight = levelHeight * 2;			
			
			cloudDensity = density;
			
			clouds = new Array();
			
			graphics.beginFill(0xA1CAF1);
			graphics.drawRect(0, 0, managerWidth, managerHeight);
			graphics.endFill();

			addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
		}
		
		private function onStage(e:Event):void
		{
			var newCloudAppearance:Bitmap = null;
			var scaleFactor:Number;
			
			for (var count:int = 0; count < cloudDensity; count++)
			{
				scaleFactor = Math.random()/2;
				
				newCloudAppearance = CloudSelector();
				
				clouds.push(newCloudAppearance);

				addChild(newCloudAppearance);

			}
			
			trace(clouds.length);
		}
		
		private function onTick(e:Event):void
		{
			for each (var cloud:Bitmap in clouds)
			{
				cloud.x -= 0.1;	
				cloud.y += Main.RandomSign() * Math.random()/10;	// Wobble				
			}
		}
		
		private function onTock(e:Event):void
		{
			if (!clouds)
				return;
				
			var newCloud:Bitmap = null;
				
			for (var index:int = 0; index < clouds.length; index++)
			{
				if (clouds[index].x <= 0)
				{					
					newCloud = CloudSelector(managerWidth, Main.RandomNumber(0, managerHeight));

					removeChild(clouds[index]);

					clouds[index] = newCloud;
					
					addChild(newCloud);
				}				
			}
		}
		
		
		private function CloudSelector(inputX:Number=-1,inputY:Number=-1):Bitmap
		{
			var newCloudAppearance:Bitmap;
			var scaleFactor:Number = 0.3;
			
			switch(Main.RandomInteger(0, 3))
			{
				case 0:
					newCloudAppearance = new CloudClass1();
					break;
				case 1:
					newCloudAppearance = new CloudClass2();
					break;
				case 2:
					newCloudAppearance = new CloudClass3();
					break;
				default:
					newCloudAppearance = new CloudClass4();
					break;
			}				

			newCloudAppearance.x = inputX ==-1 ? Main.RandomNumber(0, managerWidth) : inputX;
			newCloudAppearance.y = inputY ==-1 ? Main.RandomNumber(0, managerHeight) : inputY;

			newCloudAppearance.scaleX = scaleFactor;
			newCloudAppearance.scaleY = scaleFactor;
				
			newCloudAppearance.smoothing = true;
			
			
			return newCloudAppearance;
		}
		
		public static function CloudManagerObject(levelWidth:Number,levelHeight:Number):CloudManager
		{
			var manager:CloudManager = new CloudManager(levelWidth, levelHeight);
			
			manager.x -= levelWidth/2;
			manager.y -= levelHeight/2;
			
			return manager;
		}
		
	}

}