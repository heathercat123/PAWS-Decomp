package
{
   import flash.geom.*;
   import flash.ui.*;
   import flash.utils.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.LevelTimer;
   import game_utils.Random;
   import game_utils.SaveManager;
   import starling.animation.Juggler;
   import starling.display.*;
   import starling.textures.TextureSmoothing;
   
   public class Utils
   {
      
      public static var VERSION_STRING:String = "1.0.58";
      
      public static var ANDROID_VERSION_STRING:String = "1.0.59";
      
      public static var AMAZON_VERSION_STRING:String = "1.0.0";
      
      public static var GFX_SCALE:Number;
      
      public static var GFX_INV_SCALE:Number;
      
      public static var KEY_RIGHT:int = 39;
      
      public static var KEY_LEFT:int = 37;
      
      public static var KEY_UP:int = 38;
      
      public static var KEY_DOWN:int = 40;
      
      public static var KEY_X:int = 88;
      
      public static var KEY_Z:int = 90;
      
      public static var KEY_ENTER:int = 13;
      
      public static var KEY_SPACE:int = 32;
      
      public static var LAST_DIALOG:int = 0;
      
      public static var AIR_MESSAGE:String = "";
      
      public static var LEVEL_RUNTIME:Boolean;
      
      public static var ROOT_PATH:String = "C:/flash_projects/CatGamePaws_code/maps";
      
      public static var CONSUME_LIFE_REFILL:Boolean = false;
      
      public static var CONSUME_GOLDEN_CAT:Boolean = false;
      
      public static var CONSUME_GATE_TICKET:Boolean = false;
      
      public static var IS_GOOGLE_GAMES_LOGGED:Boolean = false;
      
      public static var IS_AMAZON_LOGGED:Boolean = false;
      
      public static var BACK_BUTTON_PRESSED:Boolean = false;
      
      public static var IS_RANDOM_HELPER_AD:Boolean = false;
      
      public static var IS_GOLDEN_CAT_AD:Boolean = false;
      
      public static var IS_REFILL_AD:Boolean = false;
      
      public static var FLAIR:int = 0;
      
      public static var FLAIR_NONE:int = 0;
      
      public static var FLAIR_HALLOWEEN:int = 1;
      
      public static var IS_GAME_MAP:Boolean = false;
      
      public static var SHOW_BOOT_AD:Boolean = false;
      
      public static var IS_FIRST_BOOTUP_OF_THE_DAY:Boolean = true;
      
      public static var CROSS_PROMOTION_SHOWN:Boolean = false;
      
      public static var SLEEPING_POLLEN_HIT:Boolean = false;
      
      public static var IS_SEASONAL:Boolean = false;
      
      public static var MINIGAME_ID:int = 0;
      
      public static var GACHA_INDEX:int = 0;
      
      public static var TIME:int = 1;
      
      public static var DAYLIGHT:int = 0;
      
      public static var DUSK:int = 1;
      
      public static var NIGHT:int = 2;
      
      public static var DOUBLE_TAP_RATIO:Number = 1;
      
      public static var DOUBLE_TAP_RATIO_LOW:Number = 1.33;
      
      public static var DOUBLE_TAP_RATIO_NORMAL:Number = 1;
      
      public static var DOUBLE_TAP_RATIO_HIGH:Number = 0.67;
      
      public static var DOUBLE_TAP_MIN:Number = 50;
      
      public static var DOUBLE_TAP_MAX:Number = 200;
      
      public static var MAP_AD_COUNTER:int = 0;
      
      public static var LEVEL_REPEAT_FLAG:Boolean = false;
      
      public static var ADMOB_INTERSTITIAL_ID_IOS:String = "ca-app-pub-6892794320149398/3340846348";
      
      public static var ADMOB_INTERSTITIAL_ID_ANDROID:String = "ca-app-pub-6892794320149398/1055875187";
      
      public static var ADMOB_INTERSTITIAL_FISHING_ID_ANDROID:String = "ca-app-pub-6892794320149398/8979172594";
      
      public static var ANDROID_BILLING_KEY:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwIqFnR2nImVBxi4qtNbB1vq2HLqYnZ5q9Val+8+/Z5fHaA0+UJrVkwDbpuArDKqGB4FxTjvooBADWgAPSdm0daheVBKZhg1KgY3mKZs+0C2c+Oegc5uF2LzvoKTYWx8TR3/OuwmWurSYt8cXbEgYbeUWCFH97HwOI6X4bAeukbbPUt+o2TnASE/35qM+5bUUBLMSjCcEujifzseFZvxvRU8+CuizBNEntIV2qJuBv8v9u/Cr1lAs9pmwGoYfbgH+t84mD6tuohaaHpHaCulP34cngBOlD9Mc+gzrtaEN6Yl9Jr4ceE/s9aQIiXqYQLIrO5+Q11g4rMo/XKss4VFc3QIDAQAB";
      
      public static var ANDROID_INAPP_PREMIUM_PRODUCT:String = "sctpaws_premium";
      
      public static var ANDROID_INAPP_GATE_PRODUCT:String = "sctpaws_ticket";
      
      public static var ANDROID_INAPP_TIER1_PRODUCT:String = "sctpaws_tier1";
      
      public static var ANDROID_INAPP_TIER2_PRODUCT:String = "sctpaws_tier2";
      
      public static var ANDROID_INAPP_TIER3_PRODUCT:String = "sctpaws_tier3";
      
      public static var PURCHASE_ORIGIN:int = 0;
      
      public static var SHOW_AD_FIRST_MAP:Boolean = true;
      
      public static var IS_BROWSER:Boolean = false;
      
      public static var IS_IPAD:Boolean = false;
      
      public static var IS_IPHONE:Boolean = false;
      
      public static var IS_16_9:Boolean = false;
      
      public static var IS_6:Boolean = false;
      
      public static var IS_6_PLUS:Boolean = false;
      
      public static var IS_RETINA:Boolean = false;
      
      public static var IS_IPHONE_X:Boolean = false;
      
      public static var OS:String = "";
      
      public static var VER:int = 7;
      
      public static var VER_ANDROID:int = 4;
      
      public static var MODEL:String = "";
      
      public static var IS_ON_WINDOWS:Boolean = false;
      
      public static var IS_ANDROID:Boolean = false;
      
      public static var LOW_RES:Boolean = false;
      
      public static var PPI_RATIO:Number = 1;
      
      public static var X_SCREEN_MARGIN:Number = 0;
      
      public static var Y_SCREEN_MARGIN:Number = 0;
      
      public static var SCREEN_WIDTH:int = 320;
      
      public static var SCREEN_HEIGHT:int = 240;
      
      public static var WIDTH:int;
      
      public static var HEIGHT:int;
      
      public static var SEA_LEVEL:int = 0;
      
      public static var SAND_LEVEL:int = 0;
      
      public static var SEA_X_SHIFT:int = 0;
      
      public static var MUD_LEVEL:int = 0;
      
      public static var IS_DARK:Boolean = false;
      
      public static var IS_LAVA:Boolean = false;
      
      public static var ICE_TYPE:int = 0;
      
      public static var WIND_X_VEL:Number = 0;
      
      public static var GLOBAL_VAR_1:Number = 0;
      
      public static var DRACULA_GONE:Boolean = false;
      
      public static var PERFECT_GAME:Boolean = false;
      
      public static var IS_SECRET_EXIT:Boolean = false;
      
      public static var PERFECT_ROOM:Boolean = false;
      
      public static var LAST_SHOP_MENU:int = 0;
      
      public static var INVENTORY_NOTIFICATION_ID:int = -1;
      
      public static var INVENTORY_NOTIFICATION_AMOUNT:int = -1;
      
      public static var INVENTORY_NOTIFICATION_ACTION:int = -1;
      
      public static var INVENTORY_QUEST_NOTIFICATION:Boolean = false;
      
      public static var FORCE_NOTIFICATION:int = 0;
      
      public static var EXIT_DIRECTION:int = -1;
      
      public static var BEACH_BALL_BOUNCES:int = 0;
      
      public static var TILE_WIDTH:int = 16;
      
      public static var TILE_HEIGHT:int = 16;
      
      public static var IS_TICK:Boolean = true;
      
      public static var ratio:Number;
      
      public static var __width:Number;
      
      public static var __height:Number;
      
      public static var SpeedUpMapMusic:Boolean = false;
      
      public static var NoMusicBeingPlayed:Boolean = false;
      
      public static var STOP_INTRO_TWEENS:Boolean = false;
      
      public static var UP:int = 1;
      
      public static var RIGHT:int = 2;
      
      public static var DOWN:int = 3;
      
      public static var LEFT:int = 4;
      
      public static var MOUSE_CONTROLS:Boolean = false;
      
      public static var QUALITY:int = 0;
      
      public static var HIGH:int = 0;
      
      public static var MEDIUM:int = 1;
      
      public static var LOW:int = 2;
      
      public static var GameStartAd:Boolean = true;
      
      public static var rootStage:Stage;
      
      public static var rootMovie:Sprite;
      
      public static var gameMovie:Sprite;
      
      public static var gamePanel:Sprite;
      
      public static var shadows:Sprite;
      
      public static var world:Sprite;
      
      public static var darkWorld:Sprite;
      
      public static var backWorld:Sprite;
      
      public static var topWorld:Sprite;
      
      public static var foregroundWorld:Sprite;
      
      public static var backgroundWorld:Sprite;
      
      public static var CurrentLevel:int = 1;
      
      public static var CurrentChapter:int = 1;
      
      public static var CurrentSubLevel:int = 1;
      
      public static var juggler:Juggler;
      
      public static var freeze_juggler:Juggler;
      
      public static var random:Random;
      
      public static var SoundOn:Boolean = true;
      
      public static var MusicOn:Boolean = true;
      
      public static var CheckPause:Boolean = false;
      
      public static var PauseOn:Boolean = false;
      
      public static var ShopOn:Boolean = false;
      
      public static var QuestOn:Boolean = false;
      
      public static var PremiumOn:Boolean = false;
      
      public static var GateUnlockOn:Boolean = false;
      
      public static var QuestAvailablePanelOn:Boolean = false;
      
      public static var ShopIndex:int = -1;
      
      public static var ShopHintLevel:int = -1;
      
      public static var HintCounter:int = 0;
      
      public static var HintHurtCounter:int = 0;
      
      public static var FreezeOn:Boolean = false;
      
      public static var CatOn:Boolean = false;
      
      public static var HelperOn:Boolean = false;
      
      public static var HelpOn:Boolean = false;
      
      public static var RateOn:Boolean = false;
      
      public static var GameOverOn:Boolean = false;
      
      public static var DoubleCoinsOn:Boolean = false;
      
      public static var IsInstaGameOver:Boolean = false;
      
      public static var IsEvent:Boolean = false;
      
      public static var QuickHelp:Boolean = false;
      
      public static var SettingsOn:Boolean = false;
      
      public static var RestartOn:Boolean = false;
      
      public static var ChapterCompleted:Boolean = false;
      
      public static var UnlockFirstTime:Boolean = false;
      
      public static var ChapterToUnlock:int = 0;
      
      public static var GLIDE_ACHIEVEMENT_JUST_ONCE:Boolean = false;
      
      public static var EnableFontStrings:Boolean = false;
      
      public static var IsLanguageWithNoSpaces:Boolean = false;
      
      public static var MapFromLevelWon:Boolean = false;
      
      public static var TimerPlayStartedAt:int = -1;
      
      public static var TimerPauseStartedAt:int = -1;
      
      public static var TimerPauseTotal:int = -1;
      
      public static var TimerPenalty:int = -1;
      
      private static var LevelTime:int = -1;
      
      public static var PauseTimeToDisplay:int = 0;
      
      public static var IS_NEW_RECORD:Boolean = false;
      
      public static var IS_GOLDEN_CAT:Boolean = false;
      
      public static var LEVEL_LOCAL_PROGRESSION_1:int = 0;
      
      public static var LEVEL_LOCAL_PROGRESSION_2:int = 0;
      
      public static var RESET_LEVEL_STATS:Boolean = false;
      
      public static var LEVEL_LEVER:Array = new Array(false,false,false,false,false,false,false,false);
      
      public static var LEVEL_ITEMS:Array = new Array();
      
      public static var LEVEL_EXP:Array = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
      
      public static var LEVEL_DECORATION_ITEMS:Array = new Array();
      
      public static var LEVEL_COLLISION_ITEMS:Array = new Array();
      
      public static var LEVEL_CLOD_STATE:Array = new Array();
      
      public static var ITEMS_PER_LEVEL:int = 50;
      
      public static var CutsceneDelayTime:int = 120;
      
      public static var PlayerItemsToGet:int = 0;
      
      public static var PlayerItemsAlreadyGot:int = 0;
      
      public static var PlayerItems:int = 0;
      
      public static var PlayerCoins:Number = 0;
      
      public static var CurrentSlot:int = 0;
      
      public static var Slot:GameSlot;
      
      public static var Lang:String = "_en";
      
      public static var DEBUG:Boolean = false;
      
      public static var DEBUG_MODE:Boolean = true;
      
      public static var DEBUG_FIRST_TIME:Boolean = true;
      
      public static var MAX_TIME:int = 5940000;
      
      public static var TOP_DOWN:int = 1;
      
      public static var DOWN_TOP:int = 2;
      
      public static var WHITE:int = 1;
      
      public static var BLACK:int = 2;
      
      public static var date:Date;
      
      public static var CustomContextMenu:ContextMenu;
      
      public static var QUEST_ENEMY_DEFEATED_FLAG:Boolean = false;
      
      public static var QUEST_HERO_GAME_OVER_FLAG:Boolean = false;
      
      public static var QUEST_HERO_DAMAGE_FLAG:Boolean = false;
      
      public static var QUEST_HERO_JUMP_FLAG:Boolean = false;
      
      public static var QUEST_COIN_COLLECTED_BY_HERO_FLAG:Boolean = false;
      
      public static var QUEST_BELL_COLLECTED_FLAG:Boolean = false;
      
      public static var QUEST_CAT_CHANGED_FLAG:Boolean = false;
       
      
      public function Utils()
      {
         super();
      }
      
      public static function Init(stage:Stage) : void
      {
         var i:int = 0;
         LEVEL_RUNTIME = false;
         CustomContextMenu = new ContextMenu();
         CustomContextMenu.hideBuiltInItems();
         date = new Date();
         Utils.juggler = new Juggler();
         Utils.freeze_juggler = new Juggler();
         Utils.random = new Random(1);
         rootStage = stage;
         LEVEL_ITEMS = new Array();
         LEVEL_DECORATION_ITEMS = new Array();
         LEVEL_COLLISION_ITEMS = new Array();
         LEVEL_CLOD_STATE = new Array();
         for(i = 0; i < 1000; i++)
         {
            LEVEL_ITEMS.push(false);
            LEVEL_DECORATION_ITEMS.push(false);
            LEVEL_COLLISION_ITEMS.push(false);
            LEVEL_CLOD_STATE.push(0);
         }
         GFX_SCALE = EvaluateGfxScale();
         GFX_INV_SCALE = 1 / GFX_SCALE;
         SCREEN_WIDTH = __width;
         SCREEN_HEIGHT = __height;
         WIDTH = int(Math.ceil(__width * Utils.GFX_INV_SCALE));
         HEIGHT = int(Math.ceil(__height * Utils.GFX_INV_SCALE));
         if(IS_IPHONE_X)
         {
            X_SCREEN_MARGIN = 24;
         }
         Slot = new GameSlot();
      }
      
      protected static function EvaluateGfxScale() : Number
      {
         var minimumSizeInsideScreen:Number = 292;
         var minimumHeight:Number = 160;
         var start_zoom_value:Number = 10;
         var zoom_result:int = 0;
         var found:Boolean = false;
         while(found == false)
         {
            zoom_result = Utils.__width / start_zoom_value;
            if(minimumSizeInsideScreen > zoom_result)
            {
               if(start_zoom_value > 2)
               {
                  if(Utils.IS_IPAD)
                  {
                     start_zoom_value -= 0.5;
                  }
                  else
                  {
                     start_zoom_value--;
                  }
               }
               else
               {
                  start_zoom_value -= 0.5;
               }
            }
            else
            {
               found = true;
            }
         }
         found = false;
         while(found == false)
         {
            zoom_result = Utils.__height / start_zoom_value;
            if(minimumHeight > zoom_result)
            {
               if(start_zoom_value > 2)
               {
                  if(Utils.IS_IPAD)
                  {
                     start_zoom_value -= 0.5;
                  }
                  else
                  {
                     start_zoom_value--;
                  }
               }
               else
               {
                  start_zoom_value -= 0.5;
               }
            }
            else
            {
               found = true;
            }
         }
         return start_zoom_value;
      }
      
      public static function SetCurrentTime() : void
      {
         var date:Date = new Date();
         if(date.hours >= 6 && date.hours < 18)
         {
            Utils.TIME = Utils.DAYLIGHT;
         }
         else if(date.hours >= 18 && date.hours < 20)
         {
            Utils.TIME = Utils.DUSK;
         }
         else
         {
            Utils.TIME = Utils.NIGHT;
         }
      }
      
      public static function SetPremium() : void
      {
         Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] = 1;
         SaveManager.SaveGameVariables();
      }
      
      public static function SetPlayPass(_value:Boolean) : void
      {
         if(_value)
         {
            Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] = 1;
         }
         else
         {
            Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] = 0;
         }
         SaveManager.SaveGameVariables();
      }
      
      public static function AddCoins(amount:Number) : void
      {
         PlayerCoins += amount;
      }
      
      public static function StartTimer() : void
      {
         TimerPlayStartedAt = getTimer();
      }
      
      public static function StopTimer() : void
      {
         var total_time:int = getTimer() - TimerPlayStartedAt;
         var pause_time:int = TimerPauseTotal;
         LevelTime = total_time - pause_time + TimerPenalty;
      }
      
      public static function GetLevelTimeSeconds() : int
      {
         if(TimerPlayStartedAt < 0)
         {
            return -1;
         }
         var play_time:int = getTimer() - TimerPlayStartedAt;
         var pause_time:int = TimerPauseTotal;
         var seconds:int = int((play_time - pause_time) / 1000);
         return seconds + TimerPenalty;
      }
      
      public static function StartPause() : void
      {
         if(TimerPlayStartedAt > 0)
         {
            TimerPauseStartedAt = getTimer();
         }
         PauseTimeToDisplay = GetLevelTimeSeconds();
      }
      
      public static function EndPause() : void
      {
         var accum_pause:int = 0;
         if(Utils.TimerPlayStartedAt > 0)
         {
            accum_pause = getTimer() - Utils.TimerPauseStartedAt;
            Utils.TimerPauseTotal += accum_pause;
         }
      }
      
      public static function GetFormattedTimeString(_value:int) : String
      {
         var i:int = 0;
         if(_value < 0)
         {
            return "---";
         }
         var seconds:int = _value;
         var formattedString:String = new String("");
         var seconds_string:String = new String(seconds);
         for(i = 0; i < 3 - seconds_string.length; i++)
         {
            formattedString = formattedString.concat("0");
         }
         for(i = 0; i < seconds_string.length; i++)
         {
            formattedString = formattedString.concat(seconds_string.charAt(i));
         }
         return formattedString;
      }
      
      public static function getSmoothing() : String
      {
         return TextureSmoothing.NONE;
      }
      
      public static function ResetGameplay() : void
      {
         var i:int = 0;
         ResetTimer();
         PlayerItems = 0;
         PlayerItemsToGet = 0;
         PlayerItemsAlreadyGot = Slot.levelItems[Utils.CurrentLevel - 1];
         PlayerCoins = 0;
         PERFECT_GAME = true;
         IS_SECRET_EXIT = false;
         for(i = 0; i < LEVEL_LEVER.length; i++)
         {
            LEVEL_LEVER[i] = false;
         }
         for(i = 0; i < LEVEL_ITEMS.length; i++)
         {
            LEVEL_ITEMS[i] = false;
         }
         for(i = 0; i < LEVEL_DECORATION_ITEMS.length; i++)
         {
            LEVEL_DECORATION_ITEMS[i] = false;
         }
         for(i = 0; i < LEVEL_COLLISION_ITEMS.length; i++)
         {
            LEVEL_COLLISION_ITEMS[i] = false;
         }
         for(i = 0; i < LEVEL_CLOD_STATE.length; i++)
         {
            LEVEL_CLOD_STATE[i] = 0;
         }
         for(i = 0; i < LEVEL_EXP.length; i++)
         {
            LEVEL_EXP[i] = 0;
         }
         var _length:int = int(LevelItems.Items[Utils.CurrentLevel - 1].length);
         if(_length == 1)
         {
            Utils.PlayerItemsToGet = 1;
         }
         else if(_length == 2)
         {
            Utils.PlayerItemsToGet = 3;
         }
         else
         {
            Utils.PlayerItemsToGet = 7;
         }
         ResetFlags();
         ResetQuestFlags();
      }
      
      public static function ResetQuestFlags() : void
      {
         QUEST_ENEMY_DEFEATED_FLAG = QUEST_HERO_GAME_OVER_FLAG = QUEST_HERO_DAMAGE_FLAG = QUEST_HERO_JUMP_FLAG = QUEST_COIN_COLLECTED_BY_HERO_FLAG = QUEST_BELL_COLLECTED_FLAG = QUEST_CAT_CHANGED_FLAG = false;
      }
      
      public static function ResetTimer() : void
      {
         TimerPauseTotal = 0;
         TimerPenalty = 0;
         TimerPlayStartedAt = -1;
         TimerPauseStartedAt = -1;
         LevelTime = -1;
         PauseTimeToDisplay = 0;
         IS_NEW_RECORD = false;
         LevelTimer.getInstance().resetTimer();
      }
      
      public static function ResetFlags() : void
      {
         PauseOn = false;
         ShopOn = false;
         FreezeOn = false;
         CatOn = false;
         HelperOn = false;
         QuestOn = false;
      }
      
      public static function ItemCollected(_index:int) : void
      {
         var add_amount:* = 0;
         if(_index == 0)
         {
            add_amount = 1;
         }
         else if(_index == 1)
         {
            add_amount = 2;
         }
         else if(_index == 2)
         {
            add_amount = 4;
         }
         PlayerItems |= add_amount;
      }
      
      public static function CircleRectHitTest(cx:Number, cy:Number, radius:Number, left:Number, top:Number, right:Number, bottom:Number) : Boolean
      {
         var closestX:Number = cx < left ? left : (cx > right ? right : cx);
         var closestY:Number = cy < top ? top : (cy > bottom ? bottom : cy);
         var dx:Number = closestX - cx;
         var dy:Number = closestY - cy;
         return dx * dx + dy * dy <= radius * radius;
      }
      
      public static function CircleCircleHitTest(circleOrigin:Point, circleRadius:Number, point:Point) : Boolean
      {
         var xDiff:Number = point.x - circleOrigin.x;
         var yDiff:Number = point.y - circleOrigin.y;
         var distance:Number = xDiff * xDiff + yDiff * yDiff;
         if(distance < circleRadius * circleRadius)
         {
            return true;
         }
         return false;
      }
      
      public static function RectPointHitTest(tailRectangle:Rectangle, brickPoint:Point) : Boolean
      {
         if(tailRectangle.containsPoint(brickPoint))
         {
            return true;
         }
         return false;
      }
      
      public static function GetBigFont() : String
      {
         return "Upheaval Pro";
      }
      
      public static function GetBigFontWhite() : String
      {
         return "Upheaval Pro White";
      }
      
      public static function GetSmallFont() : String
      {
         return "04b11";
      }
      
      public static function GetSmallFontWhite() : String
      {
         return "04b11 White";
      }
   }
}
