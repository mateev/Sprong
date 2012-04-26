package  
{
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class AssetsManager
	{
		/*
		 *	Cloud graphics done in Context Free
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

		/*
		 *  The following are done in Photoshop CS3
		 */
		
		[Embed(source = "../assets/cannon_button.png")]
		public static var CannonButtonClass1:Class;	

		[Embed(source = "../assets/trampoline_button.png")]
		public static var TrampolineButtonClass1:Class;	
		
		[Embed(source = "../assets/sun.png")]
		public static var SunClass1:Class;
		
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
		
		public static function get Sun():*
		{
			return Asset("SunClass");
		}
		
		//	Returns a button graphic
		public static function GetButton(type:Class):*
		{
			//	This holds the class' full name
			var className:String = getQualifiedClassName(type);
				
			/*	Since the names of classes that derive are in the form "baseClassName::className", 
			 *	the following will be used to get the className without the baseClassName	*/
			var deriveSymbol:RegExp = /(::)/;
			
			//	This gets the name, devided according to the deriveSymbol in an array
			var newClassName:Array = className.split(deriveSymbol);
			
			/*	The last string of the array is the actual class name
			 * 	this also covers the case where a class doesn't derive from another	*/
			className = newClassName[newClassName.length - 1];
						
			return Asset(className + "ButtonClass");
		}
	}
}