package game_utils
{
   import interfaces.buttons.*;
   import interfaces.panels.*;
   import interfaces.texts.*;
   import starling.display.Sprite;
   
   public class ShopList
   {
       
      
      public function ShopList()
      {
         super();
      }
      
      public static function Init(_type:int, itemsContainer:Sprite, itemButtons:Array, _WIDTH:int, _HEIGHT:int) : void
      {
         var shopItemButton:ShopItemButton = null;
         var level:int = 0;
         if(_type == 0)
         {
            shopItemButton = new ShopItemButton("shopRemoveIcon",-1,_WIDTH,_HEIGHT,-2);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            level = ShopList.GetLevel(400);
            shopItemButton = new ShopItemButton("shopItem_400_" + level,CoinPrices.GetHelperBasePrice(400),_WIDTH,_HEIGHT,LevelItems.ITEM_HELPER_COCONUT);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            level = ShopList.GetLevel(401);
            shopItemButton = new ShopItemButton("shopItem_401_" + level,CoinPrices.GetHelperBasePrice(401),_WIDTH,_HEIGHT,LevelItems.ITEM_HELPER_CLOUD);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            level = ShopList.GetLevel(402);
            shopItemButton = new ShopItemButton("shopItem_402_" + level,CoinPrices.GetHelperBasePrice(402),_WIDTH,_HEIGHT,LevelItems.ITEM_HELPER_JELLYFISH);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            level = ShopList.GetLevel(403);
            shopItemButton = new ShopItemButton("shopItem_403_" + level,CoinPrices.GetHelperBasePrice(403),_WIDTH,_HEIGHT,LevelItems.ITEM_HELPER_CUPID);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            level = ShopList.GetLevel(405);
            shopItemButton = new ShopItemButton("shopItem_405_" + level,CoinPrices.GetHelperBasePrice(405),_WIDTH,_HEIGHT,LevelItems.ITEM_HELPER_ROCK);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            level = ShopList.GetLevel(404);
            shopItemButton = new ShopItemButton("shopItem_404_" + level,CoinPrices.GetHelperBasePrice(404),_WIDTH,_HEIGHT,LevelItems.ITEM_HELPER_BAT);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopUnknownIcon",-1,_WIDTH,_HEIGHT,-100);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopUnknownIcon",-1,_WIDTH,_HEIGHT,-100);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopUnknownIcon",-1,_WIDTH,_HEIGHT,-100);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopUnknownIcon",-1,_WIDTH,_HEIGHT,-100);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopUnknownIcon",-1,_WIDTH,_HEIGHT,-100);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopUnknownIcon",-1,_WIDTH,_HEIGHT,-100);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
         }
         else if(_type == 3)
         {
            shopItemButton = new ShopItemButton("shopRemoveIcon",-1,_WIDTH,_HEIGHT,-1);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_92",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_MONSTER),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_MONSTER);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_91",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_PUMPKIN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_PUMPKIN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_94",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_VOODOO),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_VOODOO);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_93",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_SKULL),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_SKULL);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_18",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_YELLOW),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_YELLOW);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_81",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_DELUXE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_DELUXE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_19",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_80s),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_80s);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_82",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_UNICORN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_UNICORN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_20",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_RED),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_RED);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_21",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_GREEN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_GREEN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_47",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_BEANIE_BLACK),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_BEANIE_BLACK);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_83",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_FROG),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_FROG);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_48",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_WINTER_PINK),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_WINTER_PINK);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_87",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_JOKER),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_JOKER);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_49",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_WINTER_BLUE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_WINTER_BLUE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_50",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_TOP_HAT_BLACK),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_TOP_HAT_BLACK);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_51",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_TOP_HAT_FANCY),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_TOP_HAT_FANCY);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_52",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_TOP_HAT_GREEN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_TOP_HAT_GREEN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_53",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_TOP_HAT_LOVE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_TOP_HAT_LOVE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_54",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_COWBOY),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_COWBOY);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_55",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_PIRATE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_PIRATE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_85",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_SHINJI),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_SHINJI);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_56",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_PIRATE_RED_BANDANA),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_PIRATE_RED_BANDANA);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_84",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_MARIO),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_MARIO);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_57",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_PIRATE_BLACK_BANDANA),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_PIRATE_BLACK_BANDANA);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_58",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_SUN_WHITE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_SUN_WHITE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_59",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_SUN_PINK),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_SUN_PINK);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_60",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_CAPELINE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_CAPELINE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_61",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_PAPERBOY),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_PAPERBOY);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_62",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_POMMED_BERET),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_POMMED_BERET);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_63",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_STRAW),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_STRAW);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_64",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_CAPTAIN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_CAPTAIN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_65",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_FISHERMAN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_FISHERMAN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_66",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_CHEF),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_CHEF);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_67",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_WIZARD_BLUE),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_WIZARD_BLUE);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_86",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_DARK_MATTER),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_DARK_MATTER);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_68",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_WIZARD_RED),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_WIZARD_RED);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_88",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_VIKING),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_VIKING);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_69",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_ACORN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_ACORN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_70",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_STARGAZERS),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_STARGAZERS);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_71",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_MINER),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_MINER);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_72",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_AVIATOR),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_AVIATOR);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_73",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_HELMET_YELLOW),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_HELMET_YELLOW);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_74",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_BOX),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_BOX);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_75",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_CROWN_GOLDEN),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_CROWN_GOLDEN);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_89",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_NEUTRONIZED),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_NEUTRONIZED);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            shopItemButton = new ShopItemButton("shopItem_76",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_CROWN_SUPREME),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_CROWN_SUPREME);
            itemsContainer.addChild(shopItemButton);
            itemButtons.push(shopItemButton);
            if(Utils.Slot.playerInventory[LevelItems.ITEM_HAT_SOMBRERO] > 0)
            {
               shopItemButton = new ShopItemButton("shopItem_77",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_SOMBRERO),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_SOMBRERO);
               itemsContainer.addChild(shopItemButton);
               itemButtons.push(shopItemButton);
            }
            if(Utils.Slot.playerInventory[LevelItems.ITEM_HAT_WATERMELON] > 0)
            {
               shopItemButton = new ShopItemButton("shopItem_78",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_WATERMELON),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_WATERMELON);
               itemsContainer.addChild(shopItemButton);
               itemButtons.push(shopItemButton);
            }
            if(Utils.Slot.playerInventory[LevelItems.ITEM_HAT_SHARK] > 0)
            {
               shopItemButton = new ShopItemButton("shopItem_79",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_SHARK),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_SHARK);
               itemsContainer.addChild(shopItemButton);
               itemButtons.push(shopItemButton);
            }
            if(Utils.Slot.playerInventory[LevelItems.ITEM_HAT_PARASOL] > 0)
            {
               shopItemButton = new ShopItemButton("shopItem_80",CoinPrices.GetHatPrice(LevelItems.ITEM_HAT_PARASOL),_WIDTH,_HEIGHT,LevelItems.ITEM_HAT_PARASOL);
               itemsContainer.addChild(shopItemButton);
               itemButtons.push(shopItemButton);
            }
         }
      }
      
      protected static function GetLevel(_index:int) : int
      {
         var current_level:int = int(Utils.Slot.playerInventory[_index]);
         if(current_level == 0)
         {
            return 1;
         }
         return Utils.Slot.playerInventory[_index];
      }
   }
}
