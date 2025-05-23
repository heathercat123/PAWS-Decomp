package game_utils
{
   import com.distriqt.extension.gameservices.savedgames.SavedGame;
   import flash.display.*;
   import flash.net.*;
   import flash.utils.ByteArray;
   
   public class SaveManager
   {
      
      public static var LocalData:SharedObject;
      
      public static var TempLocalData:SharedObject;
      
      protected static var dataName:String = "sct_paws_000";
      
      protected static var dataName_Android:String = "android_sct_paws_000";
      
      protected static var CurrentSavedGame:SavedGame = null;
      
      public function SaveManager()
      {
         super();
      }
      
      public static function Init() : void
      {
         var i:int = 0;
         registerClassAlias("game_utils.GameSlot",GameSlot);
         if(Utils.IS_ANDROID)
         {
            LocalData = SharedObject.getLocal(dataName_Android);
         }
         else
         {
            LocalData = SharedObject.getLocal(dataName);
         }
         TempLocalData = SharedObject.getLocal("temp_local_data_cat_game_10");
         if(LocalData.data.init != null)
         {
            Utils.MusicOn = LocalData.data.MusicOn;
            Utils.SoundOn = LocalData.data.SoundOn;
            Save(true);
         }
         else
         {
            LocalData.data.slot = new Array();
            for(i = 0; i < 3; i++)
            {
               LocalData.data.slot.push(new GameSlot());
            }
            LocalData.data.MusicOn = true;
            LocalData.data.SoundOn = true;
            Utils.MusicOn = true;
            Utils.SoundOn = true;
            LocalData.data.init = true;
            Save(true);
         }
         if(TempLocalData.data.init == null)
         {
            TempLocalData.data.slot = new Array();
            for(i = 0; i < 3; i++)
            {
               TempLocalData.data.slot.push(new GameSlot());
            }
            TempLocalData.data.MusicOn = true;
            TempLocalData.data.SoundOn = true;
            TempLocalData.data.init = true;
            SaveTempLocalData();
         }
      }
      
      public static function GameSlotToByteArray() : ByteArray
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(Utils.Slot);
         bytes.position = 0;
         return bytes;
      }
      
      public static function ByteArrayToGameSlot(byteArray:ByteArray) : void
      {
         byteArray.position = 0;
         Utils.Slot = byteArray.readObject() as GameSlot;
         SaveSlot(true);
      }
      
      public static function Reset() : void
      {
         var i:int = 0;
         var _VARIABLE_GOOGLE_SIGN_IN:int = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_GOOGLE_SIGN_IN]);
         for(i = 0; i < 1000; i++)
         {
            Utils.Slot.levelUnlocked[i] = false;
            Utils.Slot.levelPerfect[i] = false;
            Utils.Slot.levelSeqUnlocked[i] = false;
            Utils.Slot.doorUnlocked[i] = false;
            Utils.Slot.worldUnlocked[i] = false;
            Utils.Slot.levelTime[i] = -1;
            Utils.Slot.fishRecords[i] = -1;
            Utils.Slot.levelItems[i] = 0;
            Utils.Slot.gameProgression[i] = 0;
            Utils.Slot.playerInventory[i] = 0;
            Utils.Slot.gameVariables[i] = 0;
         }
         Utils.Slot.gameDate1 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate2 = new Date();
         Utils.Slot.gameDate3 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate4 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate5 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate6 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate7 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate8 = new Date(1986,11,19,1,20);
         Utils.Slot.gameDate9 = new Date(1986,11,19,1,20);
         Utils.Slot.levelSeqUnlocked[0] = true;
         Utils.Slot.gameVariables[GameSlot.VARIABLE_GOOGLE_SIGN_IN] = _VARIABLE_GOOGLE_SIGN_IN;
         SaveSlot();
      }
      
      public static function Save(_no_cloud_update:Boolean = false) : void
      {
         LocalData.flush();
      }
      
      public static function SaveTempLocalData() : void
      {
         TempLocalData.flush();
      }
      
      public static function LoadSlot() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.levelUnlocked.length; i++)
         {
            Utils.Slot.levelUnlocked[i] = LocalData.data.slot[Utils.CurrentSlot].levelUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelPerfect.length; i++)
         {
            Utils.Slot.levelPerfect[i] = LocalData.data.slot[Utils.CurrentSlot].levelPerfect[i];
         }
         for(i = 0; i < Utils.Slot.levelSeqUnlocked.length; i++)
         {
            Utils.Slot.levelSeqUnlocked[i] = LocalData.data.slot[Utils.CurrentSlot].levelSeqUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.doorUnlocked.length; i++)
         {
            Utils.Slot.doorUnlocked[i] = LocalData.data.slot[Utils.CurrentSlot].doorUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.worldUnlocked.length; i++)
         {
            Utils.Slot.worldUnlocked[i] = LocalData.data.slot[Utils.CurrentSlot].worldUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelTime.length; i++)
         {
            Utils.Slot.levelTime[i] = LocalData.data.slot[Utils.CurrentSlot].levelTime[i];
         }
         for(i = 0; i < Utils.Slot.fishRecords.length; i++)
         {
            Utils.Slot.fishRecords[i] = LocalData.data.slot[Utils.CurrentSlot].fishRecords[i];
         }
         for(i = 0; i < Utils.Slot.levelItems.length; i++)
         {
            Utils.Slot.levelItems[i] = LocalData.data.slot[Utils.CurrentSlot].levelItems[i];
         }
         for(i = 0; i < Utils.Slot.gameProgression.length; i++)
         {
            Utils.Slot.gameProgression[i] = LocalData.data.slot[Utils.CurrentSlot].gameProgression[i];
         }
         for(i = 0; i < Utils.Slot.playerInventory.length; i++)
         {
            Utils.Slot.playerInventory[i] = LocalData.data.slot[Utils.CurrentSlot].playerInventory[i];
         }
         for(i = 0; i < Utils.Slot.gameVariables.length; i++)
         {
            Utils.Slot.gameVariables[i] = LocalData.data.slot[Utils.CurrentSlot].gameVariables[i];
         }
         Utils.Slot.gameDate1 = LocalData.data.slot[Utils.CurrentSlot].gameDate1;
         Utils.Slot.gameDate2 = LocalData.data.slot[Utils.CurrentSlot].gameDate2;
         Utils.Slot.gameDate3 = LocalData.data.slot[Utils.CurrentSlot].gameDate3;
         Utils.Slot.gameDate4 = LocalData.data.slot[Utils.CurrentSlot].gameDate4;
         Utils.Slot.gameDate5 = LocalData.data.slot[Utils.CurrentSlot].gameDate5;
         Utils.Slot.gameDate6 = LocalData.data.slot[Utils.CurrentSlot].gameDate6;
         Utils.Slot.gameDate7 = LocalData.data.slot[Utils.CurrentSlot].gameDate7;
         Utils.Slot.gameDate8 = LocalData.data.slot[Utils.CurrentSlot].gameDate8;
         Utils.Slot.gameDate9 = LocalData.data.slot[Utils.CurrentSlot].gameDate9;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOUBLE_TAP] == 0)
         {
            Utils.DOUBLE_TAP_RATIO = Utils.DOUBLE_TAP_RATIO_LOW;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOUBLE_TAP] == 1)
         {
            Utils.DOUBLE_TAP_RATIO = Utils.DOUBLE_TAP_RATIO_NORMAL;
         }
         else
         {
            Utils.DOUBLE_TAP_RATIO = Utils.DOUBLE_TAP_RATIO_HIGH;
         }
      }
      
      public static function TraceSlot() : void
      {
         trace("levelUnlocked___");
         trace(Utils.Slot.levelUnlocked);
         trace("levelPerfect___");
         trace(Utils.Slot.levelPerfect);
         trace("levelSeqUnlocked___");
         trace(Utils.Slot.levelSeqUnlocked);
         trace("doorUnlocked___");
         trace(Utils.Slot.doorUnlocked);
         trace("worldUnlocked___");
         trace(Utils.Slot.worldUnlocked);
         trace("levelTime___");
         trace(Utils.Slot.levelTime);
         trace("fishRecords___");
         trace(Utils.Slot.fishRecords);
         trace("levelItems___");
         trace(Utils.Slot.levelItems);
         trace("gameProgression___");
         trace(Utils.Slot.gameProgression);
         trace("playerInventory___");
         trace(Utils.Slot.playerInventory);
         trace("gameVariables___");
         trace(Utils.Slot.gameVariables);
         trace("___");
      }
      
      public static function SaveSlot(_no_cloud_update:Boolean = false) : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.levelUnlocked.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].levelUnlocked[i] = Utils.Slot.levelUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelPerfect.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].levelPerfect[i] = Utils.Slot.levelPerfect[i];
         }
         for(i = 0; i < Utils.Slot.levelSeqUnlocked.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].levelSeqUnlocked[i] = Utils.Slot.levelSeqUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.doorUnlocked.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].doorUnlocked[i] = Utils.Slot.doorUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.worldUnlocked.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].worldUnlocked[i] = Utils.Slot.worldUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelTime.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].levelTime[i] = Utils.Slot.levelTime[i];
         }
         for(i = 0; i < Utils.Slot.fishRecords.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].fishRecords[i] = Utils.Slot.fishRecords[i];
         }
         for(i = 0; i < Utils.Slot.levelItems.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].levelItems[i] = Utils.Slot.levelItems[i];
         }
         for(i = 0; i < Utils.Slot.gameProgression.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].gameProgression[i] = Utils.Slot.gameProgression[i];
         }
         for(i = 0; i < Utils.Slot.playerInventory.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].playerInventory[i] = Utils.Slot.playerInventory[i];
         }
         for(i = 0; i < Utils.Slot.gameVariables.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].gameVariables[i] = Utils.Slot.gameVariables[i];
         }
         LocalData.data.slot[Utils.CurrentSlot].gameDate1 = Utils.Slot.gameDate1;
         LocalData.data.slot[Utils.CurrentSlot].gameDate2 = Utils.Slot.gameDate2;
         LocalData.data.slot[Utils.CurrentSlot].gameDate3 = Utils.Slot.gameDate3;
         LocalData.data.slot[Utils.CurrentSlot].gameDate4 = Utils.Slot.gameDate4;
         LocalData.data.slot[Utils.CurrentSlot].gameDate5 = Utils.Slot.gameDate5;
         LocalData.data.slot[Utils.CurrentSlot].gameDate6 = Utils.Slot.gameDate6;
         LocalData.data.slot[Utils.CurrentSlot].gameDate7 = Utils.Slot.gameDate7;
         LocalData.data.slot[Utils.CurrentSlot].gameDate8 = Utils.Slot.gameDate8;
         LocalData.data.slot[Utils.CurrentSlot].gameDate9 = Utils.Slot.gameDate9;
         Save(_no_cloud_update);
      }
      
      public static function SaveBackupSlot() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.levelUnlocked.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].levelUnlocked[i] = Utils.Slot.levelUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelPerfect.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].levelPerfect[i] = Utils.Slot.levelPerfect[i];
         }
         for(i = 0; i < Utils.Slot.levelSeqUnlocked.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].levelSeqUnlocked[i] = Utils.Slot.levelSeqUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.doorUnlocked.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].doorUnlocked[i] = Utils.Slot.doorUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.worldUnlocked.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].worldUnlocked[i] = Utils.Slot.worldUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelTime.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].levelTime[i] = Utils.Slot.levelTime[i];
         }
         for(i = 0; i < Utils.Slot.fishRecords.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].fishRecords[i] = Utils.Slot.fishRecords[i];
         }
         for(i = 0; i < Utils.Slot.levelItems.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].levelItems[i] = Utils.Slot.levelItems[i];
         }
         for(i = 0; i < Utils.Slot.gameProgression.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].gameProgression[i] = Utils.Slot.gameProgression[i];
         }
         for(i = 0; i < Utils.Slot.playerInventory.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].playerInventory[i] = Utils.Slot.playerInventory[i];
         }
         for(i = 0; i < Utils.Slot.gameVariables.length; i++)
         {
            TempLocalData.data.slot[Utils.CurrentSlot].gameVariables[i] = Utils.Slot.gameVariables[i];
         }
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate1 = Utils.Slot.gameDate1;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate2 = Utils.Slot.gameDate2;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate3 = Utils.Slot.gameDate3;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate4 = Utils.Slot.gameDate4;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate5 = Utils.Slot.gameDate5;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate6 = Utils.Slot.gameDate6;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate7 = Utils.Slot.gameDate7;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate8 = Utils.Slot.gameDate8;
         TempLocalData.data.slot[Utils.CurrentSlot].gameDate9 = Utils.Slot.gameDate9;
         SaveTempLocalData();
      }
      
      public static function SaveDate1() : void
      {
         Utils.Slot.gameDate1 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate1 = Utils.Slot.gameDate1;
         Save();
      }
      
      public static function SaveDate2() : void
      {
         Utils.Slot.gameDate2 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate2 = Utils.Slot.gameDate2;
         Save();
      }
      
      public static function SaveDate3() : void
      {
         Utils.Slot.gameDate3 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate3 = Utils.Slot.gameDate3;
         Save();
      }
      
      public static function SaveDate4() : void
      {
         Utils.Slot.gameDate4 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate4 = Utils.Slot.gameDate4;
         Save();
      }
      
      public static function SaveDate5() : void
      {
         Utils.Slot.gameDate5 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate5 = Utils.Slot.gameDate5;
         Save();
      }
      
      public static function SaveDate6() : void
      {
         Utils.Slot.gameDate6 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate6 = Utils.Slot.gameDate6;
         Save();
      }
      
      public static function SaveDate7() : void
      {
         Utils.Slot.gameDate7 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate7 = Utils.Slot.gameDate7;
         Save();
      }
      
      public static function SaveDate8() : void
      {
         Utils.Slot.gameDate8 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate8 = Utils.Slot.gameDate8;
         Save();
      }
      
      public static function SaveDate9() : void
      {
         Utils.Slot.gameDate9 = new Date();
         LocalData.data.slot[Utils.CurrentSlot].gameDate9 = Utils.Slot.gameDate9;
         Save();
      }
      
      public static function resetItems() : void
      {
         Utils.Slot.playerInventory[LevelItems.ITEM_BAND_AID] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_FEATHER] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_SCUBA_MASK] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_SHIELD_] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_SHOWEL] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_ICE_POP] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_FIRE] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_FLUTE] = 0;
         Utils.Slot.playerInventory[LevelItems.ITEM_GENIES_LAMP] = 0;
         Save();
      }
      
      public static function LoadBackupSlot() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.levelUnlocked.length; i++)
         {
            Utils.Slot.levelUnlocked[i] = TempLocalData.data.slot[Utils.CurrentSlot].levelUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelPerfect.length; i++)
         {
            Utils.Slot.levelPerfect[i] = TempLocalData.data.slot[Utils.CurrentSlot].levelPerfect[i];
         }
         for(i = 0; i < Utils.Slot.levelSeqUnlocked.length; i++)
         {
            Utils.Slot.levelSeqUnlocked[i] = TempLocalData.data.slot[Utils.CurrentSlot].levelSeqUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.doorUnlocked.length; i++)
         {
            Utils.Slot.doorUnlocked[i] = TempLocalData.data.slot[Utils.CurrentSlot].doorUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.worldUnlocked.length; i++)
         {
            Utils.Slot.worldUnlocked[i] = TempLocalData.data.slot[Utils.CurrentSlot].worldUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.levelTime.length; i++)
         {
            Utils.Slot.levelTime[i] = TempLocalData.data.slot[Utils.CurrentSlot].levelTime[i];
         }
         for(i = 0; i < Utils.Slot.fishRecords.length; i++)
         {
            Utils.Slot.fishRecords[i] = TempLocalData.data.slot[Utils.CurrentSlot].fishRecords[i];
         }
         for(i = 0; i < Utils.Slot.levelItems.length; i++)
         {
            Utils.Slot.levelItems[i] = TempLocalData.data.slot[Utils.CurrentSlot].levelItems[i];
         }
         for(i = 0; i < Utils.Slot.gameProgression.length; i++)
         {
            Utils.Slot.gameProgression[i] = TempLocalData.data.slot[Utils.CurrentSlot].gameProgression[i];
         }
         for(i = 0; i < Utils.Slot.playerInventory.length; i++)
         {
            Utils.Slot.playerInventory[i] = TempLocalData.data.slot[Utils.CurrentSlot].playerInventory[i];
         }
         for(i = 0; i < Utils.Slot.gameVariables.length; i++)
         {
            Utils.Slot.gameVariables[i] = TempLocalData.data.slot[Utils.CurrentSlot].gameVariables[i];
         }
         Utils.Slot.gameDate1 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate1;
         Utils.Slot.gameDate2 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate2;
         Utils.Slot.gameDate3 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate3;
         Utils.Slot.gameDate4 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate4;
         Utils.Slot.gameDate5 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate5;
         Utils.Slot.gameDate6 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate6;
         Utils.Slot.gameDate7 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate7;
         Utils.Slot.gameDate8 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate8;
         Utils.Slot.gameDate9 = TempLocalData.data.slot[Utils.CurrentSlot].gameDate9;
         SaveSlot();
      }
      
      public static function SaveItemsAndDoors() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.doorUnlocked.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].doorUnlocked[i] = Utils.Slot.doorUnlocked[i];
         }
         for(i = 0; i < Utils.Slot.playerInventory.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].playerInventory[i] = Utils.Slot.playerInventory[i];
         }
         Save();
      }
      
      public static function SaveWorlds() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.worldUnlocked.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].worldUnlocked[i] = Utils.Slot.worldUnlocked[i];
         }
         Save();
      }
      
      public static function SaveInventory(justCoins:Boolean = false) : void
      {
         var i:int = 0;
         if(justCoins == false)
         {
            for(i = 0; i < Utils.Slot.playerInventory.length; i++)
            {
               LocalData.data.slot[Utils.CurrentSlot].playerInventory[i] = Utils.Slot.playerInventory[i];
            }
            Save();
         }
         else
         {
            LocalData.data.slot[Utils.CurrentSlot].playerInventory[LevelItems.ITEM_COIN] = Utils.Slot.playerInventory[LevelItems.ITEM_COIN];
            Save();
         }
      }
      
      public static function SaveQuestData() : void
      {
         LocalData.data.slot[Utils.CurrentSlot].gameVariables[GameSlot.VARIABLE_QUEST_ACTION] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_ACTION];
         LocalData.data.slot[Utils.CurrentSlot].gameVariables[GameSlot.VARIABLE_QUEST_OLD_DAY] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_OLD_DAY];
         LocalData.data.slot[Utils.CurrentSlot].gameVariables[GameSlot.VARIABLE_QUEST_DAY] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_DAY];
         LocalData.data.slot[Utils.CurrentSlot].gameVariables[GameSlot.VARIABLE_QUEST_INDEX] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_INDEX];
         LocalData.data.slot[Utils.CurrentSlot].gameVariables[GameSlot.VARIABLE_QUEST_STATUS] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS];
         LocalData.data.slot[Utils.CurrentSlot].gameVariables[GameSlot.VARIABLE_QUEST_STREAK] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK];
         Save();
      }
      
      public static function SaveFishRecords() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.fishRecords.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].fishRecords[i] = Utils.Slot.fishRecords[i];
         }
         Save();
      }
      
      public static function SaveGameProgression() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.gameProgression.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].gameProgression[i] = Utils.Slot.gameProgression[i];
         }
         Save();
      }
      
      public static function SaveGameVariables() : void
      {
         var i:int = 0;
         for(i = 0; i < Utils.Slot.gameVariables.length; i++)
         {
            LocalData.data.slot[Utils.CurrentSlot].gameVariables[i] = Utils.Slot.gameVariables[i];
         }
         Save();
      }
      
      public static function CustomInit() : void
      {
         LocalData.data.slot[Utils.CurrentSlot].levelUnlocked = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
         ,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
         LocalData.data.slot[Utils.CurrentSlot].levelPerfect = [true,true,true,true,true,true,false,true,true,false,true,true,true,false,false,false,false,false,true,false,true,false,false,false,false,false,false,false,true,false,false,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
         ,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
         LocalData.data.slot[Utils.CurrentSlot].levelSeqUnlocked = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
         ,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
         LocalData.data.slot[Utils.CurrentSlot].doorUnlocked = [true,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
         ,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
         LocalData.data.slot[Utils.CurrentSlot].worldUnlocked = [true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
         ,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
         LocalData.data.slot[Utils.CurrentSlot].levelTime = [17,42,55,67,32,51,83,98,53,97,57,80,34,59,70,126,90,148,72,58,43,87,110,180,92,106,150,117,24,155,45,96,125,133,37,150,34,74,116,98,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
         LocalData.data.slot[Utils.CurrentSlot].levelItems = [3,0,0,0,2,4,4,4,1,2,0,2,2,0,7,1,0,0,1,0,0,1,2,0,0,0,2,5,4,4,7,0,0,2,0,0,6,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         LocalData.data.slot[Utils.CurrentSlot].gameProgression = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,3,15,1,1,1,1,1,1,2,1,2,1,0,0,2,1,2,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         LocalData.data.slot[Utils.CurrentSlot].playerInventory = [21,0,1,1,1331,1,1,0,1,0,1,0,1,0,0,3,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         LocalData.data.slot[Utils.CurrentSlot].gameVariables = [0,47,207,1,1,3,16,0,0,0,0,1,0,1,1,70,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         LoadSlot();
      }
   }
}

