package  
{
	public final dynamic class ExtraMath
	{
		public static const TWELVE:int = 12;			// Twelve is the 42 of Sprong
		
		public function ExtraMath() {}
		
		// Generates a random color component
		public static function RandomColorComponent(begin:uint=0,end:uint=255):uint
		{
			if (begin<0 || begin>255 || end<0 || end>255)
				throw ArgumentError("Invalid color range");
				
			return RandomUnsigned(begin, end);
		}
		
		//	Generates a random uint
		public static function RandomUnsigned(begin:uint = 0, end:uint = uint.MAX_VALUE):uint
		{
			if (begin < 0 || end < 0 )
				throw ArgumentError("Invalid argument " + begin + " is negative"); 
				
			return RandomInteger(begin, end);			
		}
		
		// Based on http://www.actionscript.org/forums/showthread.php3?t=178123		
		public static function RandomInteger(begin:int = int.MIN_VALUE, end:int = int.MAX_VALUE):int
		{
			//	A few words on XOR Swaps in AS3 - http://jacksondunstan.com/articles/318
			if (begin > end)
			{
				begin ^= end;
				end ^= begin;
				begin ^ end;
			}
			
			return Math.floor( begin + ( Math.random() * ( end - begin + 1 ) ));
		}
		
		//	This generates a random number in a range
		public static function RandomNumber(begin:Number, end:Number):Number
		{
			var generatedNumber:Number;
			
			if (begin > end)
			{
				//	XOR Swap fails for non-integers in AS3, so...
				var swapValue:Number = begin;
				begin = end;
				end = begin;
			}
			
			do
			{
				generatedNumber = RandomInteger(Math.floor(begin), Math.ceil(end)) + RandomSign() * Math.random();
			}
			while (generatedNumber<begin || generatedNumber>end);

			
			return generatedNumber;
		}

		//	Generates a random sign
		public static function RandomSign():int
		{
			return RandomInteger(0, 1) ? -1 : 1;
		}
	}

}