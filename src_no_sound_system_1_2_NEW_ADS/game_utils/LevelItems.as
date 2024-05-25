package game_utils
{
   import entities.fishing.Fish;
   import interfaces.panels.SettingsPanel;
   import sprites.GameSprite;
   import sprites.hud.*;
   
   public class LevelItems
   {
      
      public static var MAX_ITEMS:int = 1000;
      
      public static var Items:Array;
      
      public static const ITEM_BELL:int = 0;
      
      public static const ITEM_KEY:int = 1;
      
      public static const ITEM_BIG_CAT:int = 2;
      
      public static const ITEM_EVIL_CAT:int = 3;
      
      public static const ITEM_COIN:int = 4;
      
      public static const ITEM_WATER_CAT:int = 5;
      
      public static const ITEM_SMALL_CAT:int = 6;
      
      public static const ITEM_GLIDE_CAT:int = 7;
      
      public static const ITEM_FEATHER:int = 8;
      
      public static const ITEM_SHIELD_:int = 9;
      
      public static const ITEM_SCUBA_MASK:int = 10;
      
      public static const ITEM_SHOWEL:int = 11;
      
      public static const ITEM_FIRE:int = 12;
      
      public static const ITEM_ICE_POP:int = 13;
      
      public static const ITEM_GENIES_LAMP:int = 14;
      
      public static const ITEM_FLUTE:int = 15;
      
      public static const ITEM_BAND_AID:int = 16;
      
      public static const ITEM_HAT_YELLOW:int = 18;
      
      public static const ITEM_HAT_80s:int = 19;
      
      public static const ITEM_HAT_RED:int = 20;
      
      public static const ITEM_HAT_GREEN:int = 21;
      
      public static const ITEM_HAT_BEANIE_BLACK:int = 47;
      
      public static const ITEM_HAT_WINTER_PINK:int = 48;
      
      public static const ITEM_HAT_WINTER_BLUE:int = 49;
      
      public static const ITEM_HAT_TOP_HAT_BLACK:int = 50;
      
      public static const ITEM_HAT_TOP_HAT_FANCY:int = 51;
      
      public static const ITEM_HAT_TOP_HAT_GREEN:int = 52;
      
      public static const ITEM_HAT_TOP_HAT_LOVE:int = 53;
      
      public static const ITEM_HAT_COWBOY:int = 54;
      
      public static const ITEM_HAT_PIRATE:int = 55;
      
      public static const ITEM_HAT_PIRATE_RED_BANDANA:int = 56;
      
      public static const ITEM_HAT_PIRATE_BLACK_BANDANA:int = 57;
      
      public static const ITEM_HAT_SUN_WHITE:int = 58;
      
      public static const ITEM_HAT_SUN_PINK:int = 59;
      
      public static const ITEM_HAT_CAPELINE:int = 60;
      
      public static const ITEM_HAT_PAPERBOY:int = 61;
      
      public static const ITEM_HAT_POMMED_BERET:int = 62;
      
      public static const ITEM_HAT_STRAW:int = 63;
      
      public static const ITEM_HAT_CAPTAIN:int = 64;
      
      public static const ITEM_HAT_FISHERMAN:int = 65;
      
      public static const ITEM_HAT_CHEF:int = 66;
      
      public static const ITEM_HAT_WIZARD_BLUE:int = 67;
      
      public static const ITEM_HAT_WIZARD_RED:int = 68;
      
      public static const ITEM_HAT_ACORN:int = 69;
      
      public static const ITEM_HAT_STARGAZERS:int = 70;
      
      public static const ITEM_HAT_MINER:int = 71;
      
      public static const ITEM_HAT_AVIATOR:int = 72;
      
      public static const ITEM_HAT_HELMET_YELLOW:int = 73;
      
      public static const ITEM_HAT_BOX:int = 74;
      
      public static const ITEM_HAT_CROWN_GOLDEN:int = 75;
      
      public static const ITEM_HAT_CROWN_SUPREME:int = 76;
      
      public static const ITEM_HAT_SOMBRERO:int = 77;
      
      public static const ITEM_HAT_WATERMELON:int = 78;
      
      public static const ITEM_HAT_SHARK:int = 79;
      
      public static const ITEM_HAT_PARASOL:int = 80;
      
      public static const ITEM_HAT_DELUXE:int = 81;
      
      public static const ITEM_HAT_UNICORN:int = 82;
      
      public static const ITEM_HAT_FROG:int = 83;
      
      public static const ITEM_HAT_MARIO:int = 84;
      
      public static const ITEM_HAT_SHINJI:int = 85;
      
      public static const ITEM_HAT_DARK_MATTER:int = 86;
      
      public static const ITEM_HAT_JOKER:int = 87;
      
      public static const ITEM_HAT_VIKING:int = 88;
      
      public static const ITEM_HAT_NEUTRONIZED:int = 89;
      
      public static const ITEM_HAT_PUMPKIN:int = 91;
      
      public static const ITEM_HAT_MONSTER:int = 92;
      
      public static const ITEM_HAT_SKULL:int = 93;
      
      public static const ITEM_HAT_VOODOO:int = 94;
      
      public static const ITEM_GACHA_1:int = 90;
      
      public static const ITEM_DATA_DRIVE:int = 22;
      
      public static const ITEM_CANDY_1:int = 23;
      
      public static const ITEM_ICE_CREAM_1:int = 41;
      
      public static const ITEM_KEY_HEART:int = 42;
      
      public static const ITEM_KEY_CLUB:int = 43;
      
      public static const ITEM_KEY_DIAMOND:int = 44;
      
      public static const ITEM_KEY_SPADE:int = 45;
      
      public static const ITEM_EGG:int = 46;
      
      public static const ITEM_FISH_GREEN_CARP:int = 24;
      
      public static const ITEM_FISH_SNAIL:int = 25;
      
      public static const ITEM_FISH_CAT_FISH:int = 26;
      
      public static const ITEM_FISH_GOLDFISH:int = 27;
      
      public static const ITEM_FISH_TADPOLE:int = 28;
      
      public static const ITEM_FISH_SQUID:int = 30;
      
      public static const ITEM_FISH_CRAB:int = 31;
      
      public static const ITEM_FISH_RED_JUMPER:int = 32;
      
      public static const ITEM_FISH_BLOWFISH:int = 33;
      
      public static const ITEM_FISH_SHARK:int = 34;
      
      public static const ITEM_FISH_SALAMANDER:int = 35;
      
      public static const ITEM_FISH_TURTLE:int = 36;
      
      public static const ITEM_FISH_FROG:int = 37;
      
      public static const ITEM_FISH_STINGRAY:int = 38;
      
      public static const ITEM_FISH_OCTOPUS:int = 39;
      
      public static const ITEM_FISH_JELLYFISH:int = 40;
      
      public static const ITEM_FISHING_ROD_1:int = 29;
      
      public static const ITEM_TIER_1:int = 297;
      
      public static const ITEM_TIER_2:int = 298;
      
      public static const ITEM_TIER_3:int = 299;
      
      public static const ITEM_HELPER_COCONUT:int = 400;
      
      public static const ITEM_HELPER_CLOUD:int = 401;
      
      public static const ITEM_HELPER_JELLYFISH:int = 402;
      
      public static const ITEM_HELPER_CUPID:int = 403;
      
      public static const ITEM_HELPER_BAT:int = 404;
      
      public static const ITEM_HELPER_ROCK:int = 405;
      
      public static const ITEM_HELPER_GHOST:int = 406;
      
      public static const ITEM_HELPER_FIRE:int = 407;
      
      public static const ITEM_HELPER_ICE:int = 408;
      
      public static const ITEM_HELPER_1:int = 409;
      
      public static const ITEM_HELPER_2:int = 410;
      
      public static const ITEM_HELPER_3:int = 411;
      
      public static const ITEM_HELPER_4:int = 412;
      
      public static const ITEM_HELPER_5:int = 413;
      
      public static const ITEM_HELPER_6:int = 414;
      
      public static const ITEM_HELPER_7:int = 415;
      
      public static const ITEM_HELPER_8:int = 416;
      
      public static const ITEM_HELPER_9:int = 417;
       
      
      public function LevelItems()
      {
         super();
      }
      
      public static function HasAnItem() : Boolean
      {
         if(HasItem(ITEM_FEATHER))
         {
            return true;
         }
         if(HasItem(ITEM_SHIELD_))
         {
            return true;
         }
         if(HasItem(ITEM_SCUBA_MASK))
         {
            return true;
         }
         if(HasItem(ITEM_SHOWEL))
         {
            return true;
         }
         if(HasItem(ITEM_FIRE))
         {
            return true;
         }
         if(HasItem(ITEM_ICE_POP))
         {
            return true;
         }
         if(HasItem(ITEM_GENIES_LAMP))
         {
            return true;
         }
         if(HasItem(ITEM_FLUTE))
         {
            return true;
         }
         if(HasItem(ITEM_BAND_AID))
         {
            return true;
         }
         return false;
      }
      
      public static function IsApparel(index:int) : Boolean
      {
         if(index == LevelItems.ITEM_HAT_YELLOW || index == LevelItems.ITEM_HAT_80s || index == LevelItems.ITEM_HAT_RED || index == LevelItems.ITEM_HAT_GREEN)
         {
            return true;
         }
         if(index >= LevelItems.ITEM_HAT_BEANIE_BLACK && index <= LevelItems.ITEM_HAT_NEUTRONIZED)
         {
            return true;
         }
         if(index >= LevelItems.ITEM_HAT_PUMPKIN && index <= LevelItems.ITEM_HAT_VOODOO)
         {
            return true;
         }
         return false;
      }
      
      public static function IsTier(index:int) : Boolean
      {
         if(index == LevelItems.ITEM_TIER_1 || index == LevelItems.ITEM_TIER_2 || index == LevelItems.ITEM_TIER_3)
         {
            return true;
         }
         return false;
      }
      
      public static function IsInventory(index:int) : Boolean
      {
         if(index == LevelItems.ITEM_BELL || index == LevelItems.ITEM_KEY || index == LevelItems.ITEM_DATA_DRIVE || index == LevelItems.ITEM_FISHING_ROD_1 || index == LevelItems.ITEM_EGG)
         {
            return true;
         }
         if(index >= LevelItems.ITEM_KEY_HEART && index <= LevelItems.ITEM_KEY_SPADE)
         {
            return true;
         }
         if(index == LevelItems.ITEM_GACHA_1)
         {
            return true;
         }
         if(IsFish(index))
         {
            return true;
         }
         if(IsFood(index))
         {
            return true;
         }
         return false;
      }
      
      public static function IsHelper(index:int) : Boolean
      {
         if(index == LevelItems.ITEM_HELPER_CUPID || index == LevelItems.ITEM_HELPER_CLOUD || index == LevelItems.ITEM_HELPER_COCONUT || index == LevelItems.ITEM_HELPER_FIRE || index == LevelItems.ITEM_HELPER_GHOST || index == LevelItems.ITEM_HELPER_ICE || index == LevelItems.ITEM_HELPER_JELLYFISH || index == LevelItems.ITEM_HELPER_BAT || index == LevelItems.ITEM_HELPER_ROCK)
         {
            return true;
         }
         return false;
      }
      
      public static function HasFish() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < LevelItems.MAX_ITEMS; i++)
         {
            if(IsFish(i))
            {
               if(HasItem(i))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function IsFood(index:int) : Boolean
      {
         if(index == ITEM_CANDY_1 || index == ITEM_ICE_CREAM_1)
         {
            return true;
         }
         return false;
      }
      
      public static function IsFish(index:int) : Boolean
      {
         if(index >= LevelItems.ITEM_FISH_GREEN_CARP && index <= LevelItems.ITEM_FISH_TADPOLE)
         {
            return true;
         }
         if(index >= LevelItems.ITEM_FISH_SQUID && index <= LevelItems.ITEM_FISH_JELLYFISH)
         {
            return true;
         }
         return false;
      }
      
      public static function GetInventoryItemIndexesToDisplayArray() : Array
      {
         var i:int = 0;
         var indexesToInspect:Array = null;
         var resultArray:Array = new Array();
         indexesToInspect = GetPrimaryInventoryItemIndexes();
         for(i = 0; i < indexesToInspect.length; i++)
         {
            if(Utils.Slot.playerInventory[indexesToInspect[i]] > 0)
            {
               resultArray.push(indexesToInspect[i]);
            }
         }
         indexesToInspect = GetFoodItemIndexes();
         for(i = 0; i < indexesToInspect.length; i++)
         {
            if(Utils.Slot.playerInventory[indexesToInspect[i]] > 0)
            {
               resultArray.push(indexesToInspect[i]);
            }
         }
         if(Utils.Slot.playerInventory[LevelItems.ITEM_GACHA_1] > 0)
         {
            resultArray.push(LevelItems.ITEM_GACHA_1);
         }
         indexesToInspect = GetFishItemIndexes();
         for(i = 0; i < indexesToInspect.length; i++)
         {
            if(Utils.Slot.playerInventory[indexesToInspect[i]] > 0)
            {
               resultArray.push(indexesToInspect[i]);
            }
         }
         return resultArray;
      }
      
      public static function GetPrimaryInventoryItemIndexes() : Array
      {
         return new Array(LevelItems.ITEM_BELL,LevelItems.ITEM_KEY,LevelItems.ITEM_DATA_DRIVE,LevelItems.ITEM_FISHING_ROD_1,LevelItems.ITEM_KEY_HEART,LevelItems.ITEM_KEY_CLUB,LevelItems.ITEM_KEY_DIAMOND,LevelItems.ITEM_KEY_SPADE,LevelItems.ITEM_EGG);
      }
      
      public static function GetFoodItemIndexes() : Array
      {
         var _results:Array = new Array();
         _results.push(ITEM_CANDY_1);
         _results.push(ITEM_ICE_CREAM_1);
         return _results;
      }
      
      public static function GetFishItemIndexes() : Array
      {
         var i:int = 0;
         var _results:Array = new Array();
         _results.push(ITEM_FISH_GREEN_CARP);
         _results.push(ITEM_FISH_SNAIL);
         _results.push(ITEM_FISH_GOLDFISH);
         _results.push(ITEM_FISH_TADPOLE);
         _results.push(ITEM_FISH_FROG);
         _results.push(ITEM_FISH_CAT_FISH);
         _results.push(ITEM_FISH_SALAMANDER);
         _results.push(ITEM_FISH_TURTLE);
         _results.push(ITEM_FISH_RED_JUMPER);
         _results.push(ITEM_FISH_JELLYFISH);
         _results.push(ITEM_FISH_BLOWFISH);
         _results.push(ITEM_FISH_SQUID);
         _results.push(ITEM_FISH_CRAB);
         _results.push(ITEM_FISH_SHARK);
         _results.push(ITEM_FISH_STINGRAY);
         _results.push(ITEM_FISH_OCTOPUS);
         return _results;
      }
      
      public static function Init() : void
      {
         var i:int = 0;
         Items = new Array();
         for(i = 0; i < 300; i++)
         {
            Items.push(new Array());
         }
         Items[0].push(ITEM_BELL);
         Items[0].push(ITEM_BELL);
         Items[0].push(ITEM_BELL);
         Items[1].push(ITEM_BELL);
         Items[1].push(ITEM_BELL);
         Items[1].push(ITEM_BELL);
         Items[2].push(ITEM_BELL);
         Items[2].push(ITEM_BELL);
         Items[2].push(ITEM_BELL);
         Items[3].push(ITEM_BELL);
         Items[3].push(ITEM_BELL);
         Items[3].push(ITEM_BELL);
         Items[4].push(ITEM_BELL);
         Items[4].push(ITEM_BELL);
         Items[4].push(ITEM_BELL);
         Items[5].push(ITEM_BELL);
         Items[5].push(ITEM_BELL);
         Items[5].push(ITEM_BELL);
         Items[6].push(ITEM_BELL);
         Items[6].push(ITEM_BELL);
         Items[6].push(ITEM_BELL);
         Items[7].push(ITEM_BELL);
         Items[7].push(ITEM_BELL);
         Items[7].push(ITEM_BELL);
         Items[8].push(ITEM_BELL);
         Items[8].push(ITEM_BELL);
         Items[8].push(ITEM_BELL);
         Items[9].push(ITEM_BELL);
         Items[9].push(ITEM_BELL);
         Items[9].push(ITEM_BELL);
         Items[10].push(ITEM_BELL);
         Items[10].push(ITEM_BELL);
         Items[10].push(ITEM_BELL);
         Items[11].push(ITEM_BELL);
         Items[11].push(ITEM_BELL);
         Items[11].push(ITEM_BELL);
         Items[12].push(ITEM_BELL);
         Items[12].push(ITEM_BELL);
         Items[12].push(ITEM_BELL);
         Items[13].push(ITEM_BELL);
         Items[13].push(ITEM_BELL);
         Items[13].push(ITEM_BELL);
         Items[14].push(ITEM_BELL);
         Items[14].push(ITEM_BELL);
         Items[14].push(ITEM_BELL);
         Items[15].push(ITEM_BELL);
         Items[15].push(ITEM_BELL);
         Items[15].push(ITEM_BELL);
         Items[16].push(ITEM_BELL);
         Items[16].push(ITEM_BELL);
         Items[16].push(ITEM_BELL);
         Items[17].push(ITEM_BELL);
         Items[17].push(ITEM_BELL);
         Items[17].push(ITEM_BELL);
         Items[18].push(ITEM_BELL);
         Items[18].push(ITEM_BELL);
         Items[18].push(ITEM_BELL);
         Items[19].push(ITEM_BELL);
         Items[19].push(ITEM_BELL);
         Items[19].push(ITEM_BELL);
         Items[20].push(ITEM_BELL);
         Items[20].push(ITEM_BELL);
         Items[20].push(ITEM_BELL);
         Items[21].push(ITEM_BELL);
         Items[21].push(ITEM_BELL);
         Items[21].push(ITEM_BELL);
         Items[22].push(ITEM_BELL);
         Items[22].push(ITEM_KEY);
         Items[22].push(ITEM_BELL);
         Items[23].push(ITEM_BELL);
         Items[23].push(ITEM_BELL);
         Items[23].push(ITEM_BELL);
         Items[250].push(ITEM_BELL);
         Items[250].push(ITEM_BELL);
         Items[250].push(ITEM_BELL);
         Items[251].push(ITEM_BELL);
         Items[251].push(ITEM_BELL);
         Items[251].push(ITEM_BELL);
         Items[252].push(ITEM_BELL);
         Items[252].push(ITEM_BELL);
         Items[252].push(ITEM_BELL);
      }
      
      public static function HasLevelItemBeenGot(index:int) : Boolean
      {
         var item_mask:int = int(Utils.Slot.levelItems[Utils.CurrentLevel - 1]);
         if((item_mask >> index & 1) == 1)
         {
            return true;
         }
         return false;
      }
      
      public static function AddBellsAndCoinsToInventory() : void
      {
         var i:int = 0;
         var index:int = 0;
         var old_items:int = int(Utils.Slot.levelItems[Utils.CurrentLevel - 1]);
         var new_items:int = Utils.PlayerItems;
         for(i = 0; i < 3; i++)
         {
            if((new_items >> i & 1) == 1 && (old_items >> i & 1) == 0)
            {
               index = int(Items[Utils.CurrentLevel - 1][i]);
               ++Utils.Slot.playerInventory[index];
            }
         }
         Utils.Slot.playerInventory[ITEM_COIN] += int(Math.round(Utils.PlayerCoins));
      }
      
      public static function GetCoinsAmount() : int
      {
         return Utils.Slot.playerInventory[ITEM_COIN];
      }
      
      public static function AddCoinsAndSave(_amount:int) : void
      {
         Utils.Slot.playerInventory[ITEM_COIN] += _amount;
         SaveManager.SaveInventory(true);
      }
      
      public static function RemoveAllFishFromInventory() : void
      {
         var i:int = 0;
         var amount_removed:int = 0;
         for(i = 0; i < LevelItems.MAX_ITEMS; i++)
         {
            if(IsFish(i))
            {
               amount_removed += Utils.Slot.playerInventory[i];
               Utils.Slot.playerInventory[i] = 0;
            }
         }
         for(i = 0; i < amount_removed; i++)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_FISH_SOLD);
         }
      }
      
      public static function AddItemToInventoryAndSave(item_index:int, amount:int = 1, hud_notification:Boolean = true, is_quest:Boolean = false) : void
      {
         Utils.Slot.playerInventory[item_index] += amount;
         if(Utils.Slot.playerInventory[item_index] < 0)
         {
            Utils.Slot.playerInventory[item_index] = 0;
         }
         SaveManager.SaveInventory();
         SettingsPanel.iCloudSaveCoins();
         if(hud_notification)
         {
            Utils.INVENTORY_QUEST_NOTIFICATION = is_quest;
            Utils.INVENTORY_NOTIFICATION_ID = item_index;
            Utils.INVENTORY_NOTIFICATION_AMOUNT = amount;
            if(amount >= 1)
            {
               Utils.INVENTORY_NOTIFICATION_ACTION = 1;
            }
            else
            {
               Utils.INVENTORY_NOTIFICATION_ACTION = -1;
            }
         }
      }
      
      public static function AddItemToInventory(item_index:int, amount:int = 1, hud_notification:Boolean = true) : void
      {
         Utils.Slot.playerInventory[item_index] += amount;
         if(Utils.Slot.playerInventory[item_index] < 0)
         {
            Utils.Slot.playerInventory[item_index] = 0;
         }
         if(hud_notification)
         {
            Utils.INVENTORY_NOTIFICATION_ID = item_index;
            Utils.INVENTORY_NOTIFICATION_AMOUNT = amount;
            if(amount >= 1)
            {
               Utils.INVENTORY_NOTIFICATION_ACTION = 1;
            }
            else
            {
               Utils.INVENTORY_NOTIFICATION_ACTION = -1;
            }
         }
      }
      
      public static function GetItemAmount(item_index:int) : int
      {
         return Utils.Slot.playerInventory[item_index];
      }
      
      public static function HasItem(item_index:int) : Boolean
      {
         if(Utils.Slot.playerInventory[item_index] > 0)
         {
            return true;
         }
         return false;
      }
      
      public static function HasAllLevelItems(level:int) : Boolean
      {
         var i:int = 0;
         var index:int = level - 1;
         var amount:int = int(Items[index].length);
         for(i = 0; i < amount; i++)
         {
            if((Utils.Slot.levelItems[index] >> i & 1) == 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function RemoveItem(item_index:int, amount:int) : void
      {
         Utils.Slot.playerInventory[item_index] -= amount;
      }
      
      public static function TraceInventory() : void
      {
         trace("INVENTORY ==========");
         trace("BELLS   = " + Utils.Slot.playerInventory[ITEM_BELL]);
         trace("KEYS    = " + Utils.Slot.playerInventory[ITEM_KEY]);
         trace("ROD     = " + Utils.Slot.playerInventory[ITEM_FISHING_ROD_1]);
         trace("====================");
      }
      
      public static function GetFishItemId(_fish_index:int) : int
      {
         if(_fish_index == Fish.CAT_FISH)
         {
            return LevelItems.ITEM_FISH_CAT_FISH;
         }
         if(_fish_index == Fish.GOLDFISH)
         {
            return LevelItems.ITEM_FISH_GOLDFISH;
         }
         if(_fish_index == Fish.SNAIL)
         {
            return LevelItems.ITEM_FISH_SNAIL;
         }
         if(_fish_index == Fish.TADPOLE)
         {
            return LevelItems.ITEM_FISH_TADPOLE;
         }
         if(_fish_index == Fish.SQUID)
         {
            return LevelItems.ITEM_FISH_SQUID;
         }
         if(_fish_index == Fish.CRAB)
         {
            return LevelItems.ITEM_FISH_CRAB;
         }
         if(_fish_index == Fish.RED_JUMPER)
         {
            return LevelItems.ITEM_FISH_RED_JUMPER;
         }
         if(_fish_index == Fish.BLOWFISH)
         {
            return LevelItems.ITEM_FISH_BLOWFISH;
         }
         if(_fish_index == Fish.SHARK)
         {
            return LevelItems.ITEM_FISH_SHARK;
         }
         if(_fish_index == Fish.SALAMANDER)
         {
            return LevelItems.ITEM_FISH_SALAMANDER;
         }
         if(_fish_index == Fish.TURTLE)
         {
            return LevelItems.ITEM_FISH_TURTLE;
         }
         if(_fish_index == Fish.FROG)
         {
            return LevelItems.ITEM_FISH_FROG;
         }
         if(_fish_index == Fish.STINGRAY)
         {
            return LevelItems.ITEM_FISH_STINGRAY;
         }
         if(_fish_index == Fish.OCTOPUS)
         {
            return LevelItems.ITEM_FISH_OCTOPUS;
         }
         if(_fish_index == Fish.JELLYFISH)
         {
            return LevelItems.ITEM_FISH_JELLYFISH;
         }
         return LevelItems.ITEM_FISH_GREEN_CARP;
      }
      
      public static function GetItemSprite(index:int) : GameSprite
      {
         if(index == LevelItems.ITEM_BELL)
         {
            return new BellItemHudSprite();
         }
         if(index == LevelItems.ITEM_KEY)
         {
            return new KeyItemHudSprite();
         }
         if(index == LevelItems.ITEM_BIG_CAT)
         {
            return new BigCatHudSprite();
         }
         if(index == LevelItems.ITEM_EVIL_CAT)
         {
            return new WaterCatHudSprite();
         }
         if(index == LevelItems.ITEM_WATER_CAT)
         {
            return new DarkCatHudSprite();
         }
         if(index == LevelItems.ITEM_SMALL_CAT)
         {
            return new SmallCatHudSprite();
         }
         if(index == LevelItems.ITEM_GLIDE_CAT)
         {
            return new GlideCatHudSprite();
         }
         return new BellItemHudSprite();
      }
      
      public static function GetInventoryNotificationIconImage(_item_id:int) : String
      {
         if(_item_id == LevelItems.ITEM_DATA_DRIVE)
         {
            return "inventoryItemNotificationAnim_b";
         }
         if(IsFood(_item_id))
         {
            return "inventoryItemNotificationAnim_c";
         }
         if(IsFish(_item_id))
         {
            return "inventoryItemNotificationAnim_d";
         }
         if(_item_id == LevelItems.ITEM_FISHING_ROD_1)
         {
            return "inventoryItemNotificationAnim_e";
         }
         if(_item_id == LevelItems.ITEM_COIN)
         {
            return "inventoryItemNotificationAnim_f";
         }
         if(_item_id == LevelItems.ITEM_EGG)
         {
            return "inventoryItemNotificationAnim_g";
         }
         if(_item_id == LevelItems.ITEM_GACHA_1)
         {
            return "inventoryItemNotificationAnim_h";
         }
         return "inventoryItemNotificationAnim_a";
      }
   }
}
