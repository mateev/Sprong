package overlay
{
	import flash.display.Sprite;
	import overlay.SideMenu.HorizontalMenu;
	import overlay.SideMenu.Menu;
	import overlay.SideMenu.VerticalMenu;
	
	public class MenuContainer extends Sprite
	{
		private var topMenus:Vector.<HorizontalMenu>;
		private var sideMenu:VerticalMenu;
		
		public function MenuContainer() 
		{
			sideMenu = new VerticalMenu(100, Main.GeneratedCannonID);
			topMenus = new Vector.<HorizontalMenu>();
			
			AddMenu(Main.GeneratedCannonID);
			AddMenu(Main.GeneratedCannonID);
		}
		
		public function AddMenu(generatedID:int):void
		{
			var newMenu:HorizontalMenu = new HorizontalMenu(100 + topMenus.length * Menu.ButtonSide, generatedID);

			topMenus.push(newMenu);
			
			addChild(newMenu);
		}
		
	}

}