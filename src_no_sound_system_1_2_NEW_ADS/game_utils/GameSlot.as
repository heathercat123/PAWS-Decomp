package game_utils
{
   import flash.display.*;
   import flash.net.*;
   
   public class GameSlot
   {
      
      public static const VARIABLE_CAT:int = 0;
      
      public static const VARIABLE_MAP:int = 1;
      
      public static const VARIABLE_LEVEL:int = 2;
      
      public static const VARIABLE_DOOR:int = 3;
      
      public static const VARIABLE_HERO_POSITION_ID:int = 4;
      
      public static const VARIABLE_WORLD_MAP_ID:int = 5;
      
      public static const VARIABLE_HELPER_EQUIPPED:int = 6;
      
      public static const VARIABLE_QUEST_DAY:int = 7;
      
      public static const VARIABLE_QUEST_ACTION:int = 8;
      
      public static const VARIABLE_QUEST_INDEX:int = 9;
      
      public static const VARIABLE_QUEST_STATUS:int = 10;
      
      public static const VARIABLE_QUEST_STREAK:int = 18;
      
      public static const VARIABLE_QUEST_OLD_DAY:int = 19;
      
      public static const VARIABLE_RATE_GAME:int = 11;
      
      public static const VARIABLE_DOUBLE_TAP:int = 12;
      
      public static const VARIABLE_IS_PREMIUM:int = 13;
      
      public static const VARIABLE_CROSS_PROMOTION_SLOT:int = 14;
      
      public static const VARIABLE_GAME_SESSIONS:int = 15;
      
      public static const VARIABLE_FREQ_CROSS_PROMOTION:int = 16;
      
      public static const VARIABLE_GOOGLE_SIGN_IN:int = 17;
      
      public static const VARIABLE_SKIP_INTRO:int = 50;
      
      public static const VARIABLE_GFX:int = 51;
      
      public static const VARIABLE_CLOUD_SAVE:int = 52;
      
      public static const VARIABLE_IS_PLAYPASS:int = 20;
      
      public static const VARIABLE_RATE_REWARD:int = 21;
      
      public static const VARIABLE_APPAREL_CAT_0_EQUIPPED:int = 22;
      
      public static const VARIABLE_APPAREL_CAT_1_EQUIPPED:int = 23;
      
      public static const VARIABLE_APPAREL_CAT_2_EQUIPPED:int = 24;
      
      public static const VARIABLE_APPAREL_CAT_3_EQUIPPED:int = 25;
      
      public static const VARIABLE_APPAREL_CAT_4_EQUIPPED:int = 26;
      
      public static const VARIABLE_APPAREL_CAT_5_EQUIPPED:int = 27;
      
      public static const VARIABLE_APPAREL_CAT_6_EQUIPPED:int = 28;
      
      public static const VARIABLE_APPAREL_CAT_7_EQUIPPED:int = 29;
      
      public static const VARIABLE_HELPER_COCONUT_EXP:int = 400;
      
      public static const VARIABLE_HELPER_CLOUD_EXP:int = 401;
      
      public static const VARIABLE_HELPER_JELLYFISH_EXP:int = 402;
      
      public static const VARIABLE_HELPER_CUPID_EXP:int = 403;
      
      public static const VARIABLE_HELPER_BAT_EXP:int = 404;
      
      public static const VARIABLE_HELPER_ROCK_EXP:int = 405;
      
      public static const VARIABLE_HELPER_GHOST_EXP:int = 406;
      
      public static const VARIABLE_HELPER_FIRE_EXP:int = 407;
      
      public static const VARIABLE_HELPER_ICE_EXP:int = 408;
      
      public static const VARIABLE_HELPER_1_EXP:int = 409;
      
      public static const VARIABLE_HELPER_2_EXP:int = 410;
      
      public static const VARIABLE_HELPER_3_EXP:int = 411;
      
      public static const VARIABLE_HELPER_4_EXP:int = 412;
      
      public static const VARIABLE_HELPER_5_EXP:int = 413;
      
      public static const VARIABLE_HELPER_6_EXP:int = 414;
      
      public static const VARIABLE_HELPER_7_EXP:int = 415;
      
      public static const VARIABLE_HELPER_8_EXP:int = 416;
      
      public static const VARIABLE_HELPER_9_EXP:int = 417;
      
      public static const VARIABLE_FISHING_POINTS:int = 499;
      
      public static const VARIABLE_ARCADE_1_RECORD:int = 500;
      
      public static const VARIABLE_GACHA_0_SPAWN_0:int = 501;
      
      public static const VARIABLE_GACHA_0_SPAWN_1:int = 502;
      
      public static const VARIABLE_GACHA_0_SPAWN_2:int = 503;
      
      public static const VARIABLE_GACHA_0_SPAWN_3:int = 504;
      
      public static const VARIABLE_GACHA_0_SPAWN_4:int = 505;
      
      public static const VARIABLE_GACHA_0_SPAWN_5:int = 506;
      
      public static const VARIABLE_GACHA_0_SPAWN_6:int = 507;
      
      public static const VARIABLE_GACHA_0_SPAWN_7:int = 508;
      
      public static const VARIABLE_GACHA_0_SPAWN_8:int = 509;
      
      public static const VARIABLE_GACHA_0_SPAWN_9:int = 510;
      
      public static const VARIABLE_GACHA_0_SPAWN_10:int = 511;
      
      public static const VARIABLE_GACHA_0_SPAWN_11:int = 512;
      
      public static const VARIABLE_GACHA_0_SPAWN_12:int = 513;
      
      public static const VARIABLE_GACHA_0_SPAWN_13:int = 514;
      
      public static const VARIABLE_GACHA_0_SPAWN_14:int = 515;
      
      public static const VARIABLE_GACHA_0_SPAWN_15:int = 516;
      
      public static const VARIABLE_GACHA_0_SPAWN_16:int = 517;
      
      public static const VARIABLE_GACHA_0_SPAWN_17:int = 518;
      
      public static const VARIABLE_GACHA_0_SPAWN_18:int = 519;
      
      public static const VARIABLE_GACHA_0_SPAWN_19:int = 520;
      
      public static const VARIABLE_ARCADE_2_RECORD:int = 521;
       
      
      public var levelUnlocked:Array;
      
      public var levelSeqUnlocked:Array;
      
      public var doorUnlocked:Array;
      
      public var worldUnlocked:Array;
      
      public var levelTime:Array;
      
      public var levelItems:Array;
      
      public var fishRecords:Array;
      
      public var levelPerfect:Array;
      
      public var gameProgression:Array;
      
      public var gameVariables:Array;
      
      public var gameDate1:Date;
      
      public var gameDate2:Date;
      
      public var gameDate3:Date;
      
      public var gameDate4:Date;
      
      public var gameDate5:Date;
      
      public var gameDate6:Date;
      
      public var gameDate7:Date;
      
      public var gameDate8:Date;
      
      public var gameDate9:Date;
      
      public var playerInventory:Array;
      
      public function GameSlot()
      {
         var i:int = 0;
         super();
         this.levelUnlocked = new Array();
         this.levelSeqUnlocked = new Array();
         this.levelPerfect = new Array();
         this.doorUnlocked = new Array();
         this.worldUnlocked = new Array();
         this.levelTime = new Array();
         this.levelItems = new Array();
         this.fishRecords = new Array();
         this.gameProgression = new Array();
         this.gameVariables = new Array();
         this.playerInventory = new Array();
         this.gameDate1 = new Date(1986,11,19,1,20);
         this.gameDate2 = new Date();
         this.gameDate3 = new Date(1986,11,19,1,20);
         this.gameDate4 = new Date(1986,11,19,1,20);
         this.gameDate5 = new Date(1986,11,19,1,20);
         this.gameDate6 = new Date(1986,11,19,1,20);
         this.gameDate7 = new Date(1986,11,19,1,20);
         this.gameDate8 = new Date(1986,11,19,1,20);
         this.gameDate9 = new Date(1986,11,19,1,20);
         for(i = 0; i < 1000; i++)
         {
            this.levelUnlocked.push(false);
            this.levelSeqUnlocked.push(false);
            this.doorUnlocked.push(false);
            this.worldUnlocked.push(false);
            this.levelTime.push(-1);
            this.levelItems.push(0);
            this.levelPerfect.push(false);
            this.gameProgression.push(0);
            this.fishRecords.push(-1);
            this.playerInventory.push(0);
            this.gameVariables.push(0);
         }
         this.levelSeqUnlocked[0] = true;
      }
   }
}
