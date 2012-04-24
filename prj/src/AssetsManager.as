package  
{
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;

	public class AssetsManager
	{
		/*
		 *	Graphics done in Context Free
		 *	http://www.contextfreeart.org
		 */
		
		[Embed(source = "../assets/clouds/cloud1.png")]
		public static var CloudClass1:Class;

		[Embed(source = "../assets/clouds/cloud2.png")]
		public static var CloudClass2:Class;

		[Embed(source = "../assets/clouds/cloud3.png")]
		public static var CloudClass3:Class;

		[Embed(source = "../assets/clouds/cloud4.png")]
		public static var CloudClass4:Class;		
		
		public static const CLOUDS_COUNT:int = 4;
		
		public function AssetsManager() {}

		//	This chooses one of the possible bitmaps
		public static function get Cloud():*
		{
			//	This chooses the cloud asset by random
			var cloudClass:Class = Class(getDefinitionByName("AssetsManager_CloudClass" + Main.RandomInteger(1, CLOUDS_COUNT)));
			
			return new cloudClass();
		}
	}

}