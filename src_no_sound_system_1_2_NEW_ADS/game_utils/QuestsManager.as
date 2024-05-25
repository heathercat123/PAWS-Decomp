package game_utils
{
   import flash.display.*;
   import flash.net.*;
   
   public class QuestsManager
   {
      
      public static var Quests:Vector.<QuestData>;
      
      public static var ACTION_COIN_COLLECTED_BY_ANY_CAT:int = 0;
      
      public static var ACTION_CATCH_ANY_FISH:int = 1;
      
      public static var ACTION_MINIBOSS_DEFEATED_BY_ANY_CAT:int = 2;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_DEFEATING_ANY_ENEMIES:int = 3;
      
      public static var ACTION_WOOD_BEETLE_DEFEATED_BY_ANY_CAT:int = 4;
      
      public static var ACTION_ENEMY_DEFEATED_BY_COCONUT_HELPER:int = 5;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_DYING:int = 6;
      
      public static var ACTION_SAND_CASTLE_DEFEATED_BY_ANY_CAT:int = 7;
      
      public static var ACTION_BELL_COLLECTED_BY_RIGS:int = 8;
      
      public static var ACTION_ENEMY_DEFEATED_BY_JELLYFISH_HELPER:int = 9;
      
      public static var ACTION_CATCH_RED_JUMPER_FISH:int = 10;
      
      public static var ACTION_FINISH_NORMAL_LEVEL_WITH_PASCAL:int = 11;
      
      public static var ACTION_COIN_COLLECTED_BY_PASCAL:int = 12;
      
      public static var ACTION_SMALL_ROCK_DESTROYED_BY_ROCK_HELPER:int = 13;
      
      public static var ACTION_CATCH_GREEN_CARP_FISH:int = 14;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_TAKING_ANY_DAMAGE:int = 15;
      
      public static var ACTION_BAT_DEFEATED_BY_ANY_CAT:int = 16;
      
      public static var ACTION_BELL_COLLECTED_BY_ANY_CAT:int = 17;
      
      public static var ACTION_HEALED_BY_CUPID_HELPER:int = 18;
      
      public static var ACTION_FISH_SOLD:int = 19;
      
      public static var ACTION_FINISH_NORMAL_LEVEL_WITH_ROSE:int = 20;
      
      public static var ACTION_SQUID_DEFEATED_BY_ANY_CAT:int = 21;
      
      public static var ACTION_COIN_COLLECTED_BY_ROSE:int = 22;
      
      public static var ACTION_SEED_PLANTED_BY_COCONUT_HELPER:int = 23;
      
      public static var ACTION_CATCH_GOLDFISH_FISH:int = 24;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_JUMPING:int = 25;
      
      public static var ACTION_ANY_ENEMY_DEFEATED_BY_ANY_CAT:int = 26;
      
      public static var ACTION_ENEMY_DEFEATED_BY_CLOUD_HELPER:int = 27;
      
      public static var ACTION_CATCH_BLOWFISH_FISH:int = 28;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_ANY_COIN:int = 29;
      
      public static var ACTION_BOSS_DEFEATED_BY_ANY_CAT:int = 30;
      
      public static var ACTION_BELL_COLLECTED_BY_ROSE:int = 31;
      
      public static var ACTION_COIN_COLLECTED_BY_GOLDEN_BAT_HELPER:int = 32;
      
      public static var ACTION_CATCH_CRAB_FISH:int = 33;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_COLLECTING_ANY_BELL:int = 34;
      
      public static var ACTION_WILD_HOG_ENEMY_DEFEATED_BY_ANY_CAT:int = 35;
      
      public static var ACTION_COIN_COLLECTED_BY_RIGS:int = 36;
      
      public static var ACTION_CATCH_SQUID_FISH:int = 37;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_CHANGING_CAT:int = 38;
      
      public static var ACTION_ANY_ENEMY_DEFEATED_BY_ROSE:int = 39;
      
      public static var ACTION_BELL_COLLECTED_BY_PASCAL:int = 40;
      
      public static var ACTION_FINISH_VILLAGE_LEVEL_WITH_ANY_CAT:int = 41;
      
      public static var ACTION_ANY_ENEMY_DEFEATED_BY_RIGS:int = 42;
      
      public static var ACTION_YELLOW_SLIME_ENEMY_DEFEATED_BY_ANY_CAT:int = 43;
      
      public static var ACTION_NORMAL_LEVEL_COMPLETED_UNDER_60_SECONDS_BY_ANY_CAT:int = 44;
      
      public static var ACTION_CATCH_CAT_FISH:int = 45;
      
      public static var ACTION_FINISH_NORMAL_LEVEL_WITH_RIGS:int = 46;
      
      public static var QUESTS_AMOUNT:int = 56;
       
      
      public function QuestsManager()
      {
         super();
      }
      
      public static function LoadNewQuest(now:Date) : void
      {
         Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_ACTION] = 0;
         Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_DAY] = QuestsManager.GetYearDay(now.date,now.month,now.fullYear);
         Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_INDEX] = QuestsManager.GetQuestIndexByDate(now);
         Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] = 0;
         if(QuestsManager.WasLastQuestCompletedYesterday() == false)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK] = 0;
         }
         SaveManager.SaveQuestData();
      }
      
      public static function SubmitQuestAction(_index:int) : void
      {
         if(Utils.Slot.levelSeqUnlocked[5] == false)
         {
            return;
         }
         if(_index == Quests[Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_INDEX]].action)
         {
            ++Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_ACTION];
            SaveManager.SaveQuestData();
         }
      }
      
      public static function Init() : void
      {
         Quests = new Vector.<QuestData>();
         var i:int = 0;
         for(i = 0; i < QUESTS_AMOUNT; i++)
         {
            Quests.push(new QuestData(StringsManager.GetString("quest_" + i),GetQuestAmount(i),GetQuestAction(i)));
         }
      }
      
      public static function GetQuestIndexByDate(date:Date) : int
      {
         var current_day:int = GetYearDay(date.date,date.month,date.fullYear);
         return current_day % QUESTS_AMOUNT;
      }
      
      public static function GetYearDay(_day:int, _month:int, _year:int) : int
      {
         var i:int = 0;
         var amount:int = 0;
         var monthsDay:Array = [31,28,31,30,31,30,31,31,30,31,30,31];
         if(_year % 4 == 0)
         {
            monthsDay[1] = 29;
         }
         amount += _day;
         for(i = 0; i < _month; i++)
         {
            amount += monthsDay[i];
         }
         return amount;
      }
      
      public static function WasLastQuestCompletedYesterday() : Boolean
      {
         var today_day_index:int = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_DAY]);
         var yesterday_day_index:int = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_OLD_DAY]);
         if(today_day_index == yesterday_day_index + 1)
         {
            return true;
         }
         var now:Date = new Date();
         var total_days:int = 365;
         if(int(now.fullYear - 1) % 4 == 0)
         {
            total_days = 366;
         }
         if(today_day_index == 1 && yesterday_day_index >= total_days)
         {
            return true;
         }
         return false;
      }
      
      protected static function GetQuestAmount(id:int) : int
      {
         if(id == 0 || id == 10 || id == 11 || id == 15 || id == 20 || id == 25 || id == 30 || id == 31 || id == 35 || id == 39 || id == 42 || id == 47 || id == 51 || id == 52)
         {
            return 5;
         }
         if(id == 1 || id == 6 || id == 16 || id == 19 || id == 21 || id == 36 || id == 45 || id == 55)
         {
            return 20;
         }
         if(id == 2 || id == 12 || id == 22 || id == 27 || id == 37 || id == 44 || id == 53)
         {
            return 200;
         }
         if(id == 33)
         {
            return 100;
         }
         if(id == 3 || id == 8 || id == 18 || id == 28)
         {
            return 40;
         }
         if(id == 4 || id == 46)
         {
            return 25;
         }
         if(id == 5 || id == 9 || id == 14 || id == 23 || id == 24 || id == 29 || id == 34 || id == 38 || id == 50 || id == 54)
         {
            return 10;
         }
         if(id == 7 || id == 17 || id == 32 || id == 41 || id == 49)
         {
            return 15;
         }
         if(id == 13 || id == 26 || id == 40 || id == 43 || id == 48)
         {
            return 50;
         }
         return 0;
      }
      
      protected static function GetQuestAction(id:int) : int
      {
         if(id == 0)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_DEFEATING_ANY_ENEMIES;
         }
         if(id == 1)
         {
            return QuestsManager.ACTION_WOOD_BEETLE_DEFEATED_BY_ANY_CAT;
         }
         if(id == 2)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_ANY_CAT;
         }
         if(id == 3)
         {
            return QuestsManager.ACTION_ENEMY_DEFEATED_BY_COCONUT_HELPER;
         }
         if(id == 4)
         {
            return QuestsManager.ACTION_CATCH_ANY_FISH;
         }
         if(id == 5)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_DYING;
         }
         if(id == 6)
         {
            return QuestsManager.ACTION_SAND_CASTLE_DEFEATED_BY_ANY_CAT;
         }
         if(id == 7)
         {
            return QuestsManager.ACTION_BELL_COLLECTED_BY_RIGS;
         }
         if(id == 8)
         {
            return QuestsManager.ACTION_ENEMY_DEFEATED_BY_JELLYFISH_HELPER;
         }
         if(id == 9)
         {
            return QuestsManager.ACTION_CATCH_RED_JUMPER_FISH;
         }
         if(id == 10)
         {
            return QuestsManager.ACTION_FINISH_NORMAL_LEVEL_WITH_PASCAL;
         }
         if(id == 11)
         {
            return QuestsManager.ACTION_MINIBOSS_DEFEATED_BY_ANY_CAT;
         }
         if(id == 12)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_PASCAL;
         }
         if(id == 13)
         {
            return QuestsManager.ACTION_SMALL_ROCK_DESTROYED_BY_ROCK_HELPER;
         }
         if(id == 14)
         {
            return QuestsManager.ACTION_CATCH_GREEN_CARP_FISH;
         }
         if(id == 15)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_TAKING_ANY_DAMAGE;
         }
         if(id == 16)
         {
            return QuestsManager.ACTION_BAT_DEFEATED_BY_ANY_CAT;
         }
         if(id == 17)
         {
            return QuestsManager.ACTION_BELL_COLLECTED_BY_ANY_CAT;
         }
         if(id == 18)
         {
            return QuestsManager.ACTION_HEALED_BY_CUPID_HELPER;
         }
         if(id == 19)
         {
            return QuestsManager.ACTION_FISH_SOLD;
         }
         if(id == 20)
         {
            return QuestsManager.ACTION_FINISH_NORMAL_LEVEL_WITH_ROSE;
         }
         if(id == 21)
         {
            return QuestsManager.ACTION_SQUID_DEFEATED_BY_ANY_CAT;
         }
         if(id == 22)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_ROSE;
         }
         if(id == 23)
         {
            return QuestsManager.ACTION_SEED_PLANTED_BY_COCONUT_HELPER;
         }
         if(id == 24)
         {
            return QuestsManager.ACTION_CATCH_GOLDFISH_FISH;
         }
         if(id == 25)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_JUMPING;
         }
         if(id == 26)
         {
            return QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_ANY_CAT;
         }
         if(id == 27)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_ANY_CAT;
         }
         if(id == 28)
         {
            return QuestsManager.ACTION_ENEMY_DEFEATED_BY_CLOUD_HELPER;
         }
         if(id == 29)
         {
            return QuestsManager.ACTION_CATCH_BLOWFISH_FISH;
         }
         if(id == 30)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_ANY_COIN;
         }
         if(id == 31)
         {
            return QuestsManager.ACTION_BOSS_DEFEATED_BY_ANY_CAT;
         }
         if(id == 32)
         {
            return QuestsManager.ACTION_BELL_COLLECTED_BY_ROSE;
         }
         if(id == 33)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_GOLDEN_BAT_HELPER;
         }
         if(id == 34)
         {
            return QuestsManager.ACTION_CATCH_CRAB_FISH;
         }
         if(id == 35)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_COLLECTING_ANY_BELL;
         }
         if(id == 36)
         {
            return QuestsManager.ACTION_WILD_HOG_ENEMY_DEFEATED_BY_ANY_CAT;
         }
         if(id == 37)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_RIGS;
         }
         if(id == 38)
         {
            return QuestsManager.ACTION_CATCH_SQUID_FISH;
         }
         if(id == 39)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_CHANGING_CAT;
         }
         if(id == 40)
         {
            return QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_ROSE;
         }
         if(id == 41)
         {
            return QuestsManager.ACTION_BELL_COLLECTED_BY_PASCAL;
         }
         if(id == 42)
         {
            return QuestsManager.ACTION_FINISH_VILLAGE_LEVEL_WITH_ANY_CAT;
         }
         if(id == 43)
         {
            return QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_RIGS;
         }
         if(id == 44)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_ANY_CAT;
         }
         if(id == 45)
         {
            return QuestsManager.ACTION_YELLOW_SLIME_ENEMY_DEFEATED_BY_ANY_CAT;
         }
         if(id == 46)
         {
            return QuestsManager.ACTION_CATCH_ANY_FISH;
         }
         if(id == 47)
         {
            return QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_UNDER_60_SECONDS_BY_ANY_CAT;
         }
         if(id == 48)
         {
            return QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_ANY_CAT;
         }
         if(id == 49)
         {
            return QuestsManager.ACTION_BELL_COLLECTED_BY_ANY_CAT;
         }
         if(id == 50)
         {
            return QuestsManager.ACTION_CATCH_CAT_FISH;
         }
         if(id == 51)
         {
            return QuestsManager.ACTION_FINISH_NORMAL_LEVEL_WITH_RIGS;
         }
         if(id == 52)
         {
            return QuestsManager.ACTION_MINIBOSS_DEFEATED_BY_ANY_CAT;
         }
         if(id == 53)
         {
            return QuestsManager.ACTION_COIN_COLLECTED_BY_ROSE;
         }
         if(id == 54)
         {
            return QuestsManager.ACTION_SEED_PLANTED_BY_COCONUT_HELPER;
         }
         if(id == 55)
         {
            return QuestsManager.ACTION_FISH_SOLD;
         }
         return 0;
      }
   }
}
