package overlay
{
	import flash.display.Sprite;
	import flash.events.Event;
	import overlay.SideMenu.Menu.HorizontalMenu;
	import overlay.SideMenu.Menu.Menu;
	import overlay.SideMenu.Menu.VerticalMenu;
	import placeable.Cannon;
	import placeable.Trampoline;
	
	public class MenuManager extends Sprite
	{
		private var topMenus:Vector.<HorizontalMenu>;
		private var sideMenu:VerticalMenu;
		
		public function MenuManager(availableStuff:Object) 
		{
			Reset(availableStuff);
			
			addChild(sideMenu);
			
			AddSideMenuButton();
			
			if (stage) onStage()
			else	addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(ev:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(PlaceEvent.PLACE_CANNON, onPlace);
		}
		
		private function onPlace(placement:PlaceEvent):void
		{			
			AddMenu(placement.ID);
		}
		
		public function Reset(availableStuff:Object):void
		{
			sideMenu = new VerticalMenu(100, Main.GeneratedCannonID,availableStuff);
			topMenus = new Vector.<HorizontalMenu>();			
		}
		
		public function AddSideMenuButton():void
		{
			sideMenu.AddButton(AssetsManager.GetButton(Trampoline));
		}
		
		public function AddTopButton(id:int=0):void
		{
			var index:int = -1;

			for (var i:int = 0; i < topMenus.length; i++)
				if (topMenus[i].MenuID == id)
				{
					index = i;
					break;
				}
			
			if (index == -1)
				return;
				
			topMenus[index].AddButton(AssetsManager.GetButton(Cannon));
			topMenus[index].AddButton(AssetsManager.GetButton(Cannon));
		}
		
		public function AddMenu(generatedID:int):void
		{
			var newMenu:HorizontalMenu = new HorizontalMenu(100 + topMenus.length * Menu.ButtonSide, generatedID);

			topMenus.push(newMenu);
			
			addChild(newMenu);			
		}
		
	}

}