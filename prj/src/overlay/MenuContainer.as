package overlay
{
	import flash.display.Sprite;
	import overlay.SideMenu.HorizontalMenu;
	import overlay.SideMenu.Menu;
	import overlay.SideMenu.VerticalMenu;
	public class MenuContainer extends Sprite
	{		
		public function MenuContainer() 
		{
			var topMenu:Menu  = new HorizontalMenu(100, Main.GeneratedCannonID);
//			var topMenu2:Menu = new HorizontalMenu(100+Menu.ButtonWidth(true), Main.GeneratedCannonID);
//			var sideMenu:Menu = new VerticalMenu(100+Menu.ButtonWidth(true), Main.GeneratedCannonID);
			
			addChild(topMenu);
//			addChild(topMenu2);
//			addChild(sideMenu);
		}
		
	}

}