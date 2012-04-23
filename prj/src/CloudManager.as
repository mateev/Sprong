package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//	Todo: Make some clouds appear mirrored along y-axis
	public class CloudManager extends Sprite 
	{
		/*
		 *	Graphics done in Context Free
		 *	http://www.contextfreeart.org
		 */
		
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
		
		//	Constructor
		//	This constructs a CloudManager object
		public function CloudManager(levelWidth:Number, levelHeight:Number, skyColor:uint = 0xA1CAF1, density:int = 20) 
		{
			//	The following define the size of empty sky
			managerWidth = levelWidth * 2;
			managerHeight = levelHeight * 2;			
			
			//	The following create the empty sky
			graphics.beginFill(skyColor);
			graphics.drawRect(0, 0, managerWidth, managerHeight);
			graphics.endFill();
			
			//	Cloud density is defined; this determines how many clouds are there in rotation
			cloudDensity = density;
			
			//	Clouds container is initialized; this will hold the cloud bitmaps
			clouds = new Array();

			//	Event
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}

		//	This is called once the stage is created to initialize the clouds and the clouds array
		private function onStage(e:Event):void
		{
			//	This variable will hold the bitmap
			var newCloudAppearance:Bitmap = null;

			//	The following cerates clouds array ...
			for (var count:int = 0; count < cloudDensity; count++)
			{				
				//	... by selecting the cloud ...
				newCloudAppearance = CloudSelector();
				
				//	...	adding it to the array ...
				clouds.push(newCloudAppearance);

				//	... and appending it to the manager ...
				addChild(newCloudAppearance);

			}

			//	Events
			addEventListener(Event.ENTER_FRAME, onTick);
			addEventListener(Event.EXIT_FRAME, onTock);
		}

		//	This controls cloud movement
		private function onTick(e:Event):void
		{
			//	The following goes over all clouds and makes them move slightly
			for each (var cloud:Bitmap in clouds)
			{
				cloud.x -= 0.1;

				//	... this makes them wobble up and down slightly
				cloud.y += Main.RandomSign() * Math.random()/10;	
			}
		}
		
		//	This checks if any clouds have reached the end of the manager and manages the creation of new ones
		private function onTock(e:Event):void
		{
			//	This will hold the bitmap for a new cloud
			var newCloud:Bitmap = null;
				
			//	This will go over all clouds ...
			for (var index:int = 0; index < clouds.length; index++)
			{
				//	... and if a cloud has escaped the sky boundaries ...
				if (clouds[index].x <= 0 || clouds[index].y <=0 || clouds[index].y>=managerHeight)
				{					
					//	... a new cloud is about to be added at the opposite edge of the sky ...
					newCloud = CloudSelector(managerWidth, Main.RandomNumber(0, managerHeight));
					
					//	... the old cloud will be removed from the sky ...
					removeChild(clouds[index]);

					//	... the new cloud will be added in place of the old one in the array ...
					clouds[index] = newCloud;
					
					//	... and the new one will be added to the sky ...
					addChild(newCloud);
				}				
			}
		}
		
		//	This function selects a cloud bitmap and applies all necesary transformations before passing it on...
		private function CloudSelector(inputX:Number=-1,inputY:Number=-1):Bitmap
		{
			//	This variable holds the chosen bitmap
			var newCloudAppearance:Bitmap;
			
			//	This variable holds how much will the bitmap be scaled
			var scaleFactor:Number = 0.3;							
			
			//	This switch chooses one of the possible bitmaps and passes the value to the cloud appearance variable
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
				case 3:
					newCloudAppearance = new CloudClass4();
					break;
			}				
			
			//	If there hasn't been any real input a random location will be chosen;
			//  Otherwise the x and y values of the chosen bitmap will be set as specified;
			newCloudAppearance.x = inputX ==-1 ? Main.RandomNumber(0, managerWidth) : inputX;
			newCloudAppearance.y = inputY ==-1 ? Main.RandomNumber(0, managerHeight) : inputY;
			
			//	Scale factor is applied
			newCloudAppearance.scaleX = scaleFactor;
			newCloudAppearance.scaleY = scaleFactor;
				
			//	Smoothing is applied to avoid jagged edges
			newCloudAppearance.smoothing = true;
			
			return newCloudAppearance;
		}
		
		//	This will return a properly adjusted CloudManager object
		public static function CloudManagerObject(levelWidth:Number,levelHeight:Number,skyColor:uint = 0xA1CAF1, density:int = 20):CloudManager
		{
			//	This creates the manager
			var manager:CloudManager = new CloudManager(levelWidth, levelHeight,skyColor,density);
			
			//	These adjust it's location on the stage
			manager.x -= levelWidth/2;
			manager.y -= levelHeight/2;
			
			return manager;
		}
		
	}

}