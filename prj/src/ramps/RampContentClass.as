package ramps 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ivan
	 */
	public class RampContentClass extends MovieClip 
	{
		
		public function RampContentClass() 
		{
			super();
			
		}
		
		public function get Center():Point
		{
			return new Point(x, y);
		}
				
	}

}