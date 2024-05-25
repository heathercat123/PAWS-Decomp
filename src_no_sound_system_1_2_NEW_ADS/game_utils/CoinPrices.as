package game_utils
{
   import entities.fishing.FishData;
   import interfaces.buttons.*;
   import interfaces.panels.*;
   import interfaces.texts.*;
   
   public class CoinPrices
   {
      
      public static var ARCADE_MEGA_PANG:int = 0;
      
      public static var BOAT_TRIP:int = 1;
      
      public static var FISHING_ROD_UPGRADE_1:int = 2;
      
      public static var PORTOBELLO_INN:int = 3;
      
      public static var ICECREAM:int = 4;
      
      public static var QUEST_REWARD:int = 5;
      
      public static var LIFT_TRIP:int = 6;
      
      public static var VENDING_MACHINE_CANDY:int = 7;
      
      public static var GACHAPON:int = 8;
       
      
      public function CoinPrices()
      {
         super();
      }
      
      public static function GetPrice(_index:int) : int
      {
         var amount:int = 0;
         var mult:Number = 1;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            mult = 0.5;
         }
         if(_index == CoinPrices.ARCADE_MEGA_PANG)
         {
            return int(3 * mult);
         }
         if(_index == CoinPrices.GACHAPON)
         {
            return int(40 * mult);
         }
         if(_index == CoinPrices.BOAT_TRIP)
         {
            return int(100 * mult);
         }
         if(_index == CoinPrices.FISHING_ROD_UPGRADE_1)
         {
            return int(200 * mult);
         }
         if(_index == CoinPrices.PORTOBELLO_INN)
         {
            return int(25 * mult);
         }
         if(_index == CoinPrices.ICECREAM)
         {
            return int(5 * mult);
         }
         if(_index == CoinPrices.VENDING_MACHINE_CANDY)
         {
            return int(2 * mult);
         }
         if(_index == CoinPrices.LIFT_TRIP)
         {
            return int(20 * mult);
         }
         if(_index == CoinPrices.QUEST_REWARD)
         {
            amount = 50 + Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK] * 25;
            if(amount > 250)
            {
               amount = 250;
            }
            return amount;
         }
         return 0;
      }
      
      public static function GetFishRareCoinReward(_rank:int) : int
      {
         return (int(_rank / 2) + 1) * 25;
      }
      
      public static function GetFishGoldenCoinReward(_rank:int) : int
      {
         return (int(_rank / 2) + 1) * 100;
      }
      
      public static function GetFishTotalSellPrice() : int
      {
         var i:int = 0;
         var total:int = 0;
         for(i = 0; i < LevelItems.MAX_ITEMS; i++)
         {
            if(LevelItems.IsFish(i))
            {
               if(LevelItems.HasItem(i))
               {
                  total += Utils.Slot.playerInventory[i] * CoinPrices.GetFishSellPrice(i);
               }
            }
         }
         return total;
      }
      
      protected static function GetFishSellPrice(item_index:int) : int
      {
         var amount:int = 0;
         if(!LevelItems.IsFish(item_index))
         {
            return -1000;
         }
         var rank:int = FishData.GetFishRankFromInventoryIndex(item_index);
         if(rank == 0)
         {
            amount = 2;
         }
         else if(rank == 1)
         {
            amount = 3;
         }
         else if(rank == 2)
         {
            amount = 5;
         }
         else if(rank == 3)
         {
            amount = 12;
         }
         else if(rank == 4 || rank == 5)
         {
            amount = 24;
         }
         else
         {
            amount = 32;
         }
         return amount;
      }
      
      public static function GetHelperBasePrice(helper_index:int) : int
      {
         var mult:Number = 1;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            mult = 0.5;
         }
         if(helper_index == 400 || helper_index == 401 || helper_index == 402)
         {
            return int(250 * mult);
         }
         if(helper_index == 403 || helper_index == 405)
         {
            return int(500 * mult);
         }
         if(helper_index == 404)
         {
            return int(1000 * mult);
         }
         return int(1000 * mult);
      }
      
      public static function GetHatPrice(hat_index:int) : int
      {
         var mult:Number = 1;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            mult = 0.5;
         }
         if(hat_index >= LevelItems.ITEM_HAT_DELUXE && hat_index <= LevelItems.ITEM_HAT_NEUTRONIZED)
         {
            return -100;
         }
         if(hat_index == LevelItems.ITEM_HAT_SKULL)
         {
            return -100;
         }
         if(hat_index == LevelItems.ITEM_HAT_YELLOW || hat_index == LevelItems.ITEM_HAT_BEANIE_BLACK)
         {
            return int(50 * mult);
         }
         if(hat_index == LevelItems.ITEM_HAT_TOP_HAT_BLACK || hat_index == LevelItems.ITEM_HAT_COWBOY || hat_index == LevelItems.ITEM_HAT_PIRATE || hat_index == LevelItems.ITEM_HAT_SUN_WHITE || hat_index == LevelItems.ITEM_HAT_SUN_PINK || hat_index == LevelItems.ITEM_HAT_CAPTAIN || hat_index == LevelItems.ITEM_HAT_CHEF)
         {
            return int(250 * mult);
         }
         if(hat_index == LevelItems.ITEM_HAT_FISHERMAN || hat_index == LevelItems.ITEM_HAT_TOP_HAT_FANCY || hat_index == LevelItems.ITEM_HAT_TOP_HAT_GREEN || hat_index == LevelItems.ITEM_HAT_TOP_HAT_LOVE || hat_index == LevelItems.ITEM_HAT_WIZARD_BLUE || hat_index == LevelItems.ITEM_HAT_WIZARD_RED || hat_index == LevelItems.ITEM_HAT_ACORN || hat_index == LevelItems.ITEM_HAT_AVIATOR || hat_index == LevelItems.ITEM_HAT_HELMET_YELLOW || hat_index == LevelItems.ITEM_HAT_WATERMELON)
         {
            return int(500 * mult);
         }
         if(hat_index == LevelItems.ITEM_HAT_MINER || hat_index == LevelItems.ITEM_HAT_STARGAZERS || hat_index == LevelItems.ITEM_HAT_BOX || hat_index == LevelItems.ITEM_HAT_PARASOL || hat_index == LevelItems.ITEM_HAT_MONSTER)
         {
            return int(1000 * mult);
         }
         if(hat_index == LevelItems.ITEM_HAT_CROWN_GOLDEN || hat_index == LevelItems.ITEM_HAT_SOMBRERO || hat_index == LevelItems.ITEM_HAT_PUMPKIN)
         {
            return int(2000 * mult);
         }
         if(hat_index == LevelItems.ITEM_HAT_SHARK || hat_index == LevelItems.ITEM_HAT_VOODOO)
         {
            return int(4000 * mult);
         }
         if(hat_index == LevelItems.ITEM_HAT_CROWN_SUPREME)
         {
            return int(5000 * mult);
         }
         return int(150 * mult);
      }
   }
}
