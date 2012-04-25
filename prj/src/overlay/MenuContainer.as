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
//			var topMenu:Menu  = new HorizontalMenu(100, Main.GeneratedCannonID);
//			var topMenu2:Menu = new HorizontalMenu(100+Menu.ButtonSide, Main.GeneratedCannonID);
//			var sideMenu:Menu = new VerticalMenu(100+Menu.ButtonWidth(true), Main.GeneratedCannonID);
			
//			addChild(topMenu);
//			addChild(topMenu2);
//			addChild(sideMenu);
		}
		
		public function AddMenu(generatedID:int):void
		{
			var newMenu:HorizontalMenu = new HorizontalMenu(100 + topMenus.length * Menu.ButtonSide, generatedID);
			
			topMenus.push(newMenu);
			
			addChild(newMenu);
		}
		
	}

}