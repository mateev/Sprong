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
		
		[Embed(source = "../assets/asset_error.png")]
		public static var AssetErrorClass:Class;	
		
		[Embed(source = "../assets/clouds/cloud1.png")]
		public static var CloudClass1:Class;

		[Embed(source = "../assets/clouds/cloud2.png")]
		public static var CloudClass2:Class;

		[Embed(source = "../assets/clouds/cloud3.png")]
		public static var CloudClass3:Class;

		[Embed(source = "../assets/clouds/cloud4.png")]
		public static var CloudClass4:Class;		
		
		//	This object maps an asset class with a number, indicating how many variants of that asset class there are
		private static var assetsCount:Object;
		
		//	The constructor initializes the assets counters
		public function AssetsManager() 
		{
			AssetsManager.assetsCount = new Object();			
			AssetsManager.assetsCount["CloudClass"] = 4;		
			
		}

		//	This returns how many variants of an asset class exist in the assets library, if there is no record it is assumed that only one variant exists
		public static function AssetsCount(assetType:String):int
		{
			return assetsCount.hasOwnProperty(assetType) ? assetsCount[assetType] : 1;
		}

		//	This returns a random variant of an asset class
		//	If the asset class hasn't been properly implemented yet, an error will be reported and a placeholder will be chosen
		private static function Asset(assetType:String):*
		{
			var returnedAsset:Class;

			try
			{
				returnedAsset = Class(getDefinitionByName("AssetsManager_" + assetType + ExtraMath.RandomInteger(1, AssetsManager.AssetsCount(assetType))));
			}
			catch (error:ReferenceError)
			{
				returnedAsset = AssetErrorClass;
				trace(error);
			}
			finally
			{
				return new returnedAsset;
			}			
		}
		
		//	This returns a Cloud bitmap
		public static function get Cloud():*
		{
			return Asset("CloudClass");
		}
	}
}