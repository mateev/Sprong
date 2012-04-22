package overlay
{
	import flash.display.Sprite;
	import overlay.SideMenu.Menu;
	public class MenuContainer extends Sprite
	{		
		public function MenuContainer() 
		{
			var topMenu:Menu = new Menu(100, Main.GeneratedCannonID);
			var topMenu2:Menu = new Menu(100+Menu.ButtonWidth(true), Main.GeneratedCannonID);
			var sideMenu:Menu = new Menu(100+Menu.ButtonWidth(true), Main.GeneratedCannonID,false);
			
			addChild(topMenu);
			addChild(topMenu2);
			addChild(sideMenu);
		}
		
	}

}