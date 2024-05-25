package game_utils
{
   import states.LevelState;
   
   public class RoomsManager
   {
       
      
      public function RoomsManager()
      {
         super();
      }
      
      public static function EvaluateRoom() : void
      {
         var LEVEL:int = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL]);
         var DOOR:int = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR]);
         var array:Array = RoomsManager.GetDoorAndPosition(LEVEL,DOOR);
         Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = array[0];
         Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = array[1];
      }
      
      public static function GetDoorAndPosition(LEVEL:int, DOOR:int) : Array
      {
         var POSITION:int = 0;
         if(LEVEL == LevelState.LEVEL_1_1_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_1_2;
               POSITION = 0;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_1_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_1_3;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_1_3)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_1_2;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_1_4;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_1_5;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_1_5)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_1_3;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_1_4;
               POSITION = 4;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_1_4;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_1_4)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_1_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_2_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_2_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_2_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_2_2;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_2_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_2_3;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_3_2;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_3_6;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_3_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_3_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_3_2;
               POSITION = 2;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_3_4;
               POSITION = 4;
            }
            else if(DOOR == 6)
            {
               LEVEL = LevelState.LEVEL_1_3_5;
               POSITION = 6;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_4)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_3_3;
               POSITION = 4;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_3_5;
               POSITION = 3;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_3_5;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_5)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_3_4;
               POSITION = 5;
            }
            else if(DOOR == 6)
            {
               LEVEL = LevelState.LEVEL_1_3_3;
               POSITION = 6;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_6)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_3_1;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_4_2;
               POSITION = 1;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_4_6;
               POSITION = 3;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_4_5;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_4_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_4_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_4_2;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_4_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_4_3;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_4_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_5)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_4_1;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_6)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_4_7;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_7)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_4_1;
               POSITION = 5;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_4_8;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_8)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_4_7;
               POSITION = 4;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_4_9;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_9)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_1_4_1;
               POSITION = 6;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_2;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_1;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_1;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_4;
               POSITION = 1;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_5_7;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_4)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_3;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_6;
               POSITION = 2;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_5_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_5)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_5_4;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_6)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_4;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_7)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_5_3;
               POSITION = 4;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_8;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_9;
               POSITION = 2;
            }
            else if(DOOR == 8)
            {
               LEVEL = LevelState.LEVEL_1_5_10;
               POSITION = 8;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_5_11;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_8)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_7;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_9)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_7;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_10)
         {
            if(DOOR == 8)
            {
               LEVEL = LevelState.LEVEL_1_5_7;
               POSITION = 8;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_11)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_5_7;
               POSITION = 3;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_5_12;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_12)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_13;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_5_13)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_5_11;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_1_5)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_1_2;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_SECRET_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_SECRET_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_SECRET_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_SECRET_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_SECRET_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_SECRET_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_SECRET_2;
               POSITION = 2;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_SECRET_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_SECRET_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_SECRET_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_SECRET_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_SECRET_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_2_2;
               POSITION = 0;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_2_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_2_2;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_2_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_2_3;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_2_5;
               POSITION = 4;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_2_6;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_5)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_2_4;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_2_6)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_2_4;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_3_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_3_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_3_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_3_2;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_3_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_3_4;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_3_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_3_3;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_3_3;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_4_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_4_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_4_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_4_2;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_4_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_4_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_4_3;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_4_5)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_4_3;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_6_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_6_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_6_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_6_3;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_6_1;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_6_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_6_2;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_6_4;
               POSITION = 1;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_6_5;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_6_6;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_6_4)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_6_3;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_6_5)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_6_3;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_6_6)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_6_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_7_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_7_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_7_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_7_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_7_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_7_4;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_7_4)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_7_5;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_7_5)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_7_4;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_8_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_1_8_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_8_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_8_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_8_3)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_1_8_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_8_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_8_4)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_1_8_6;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_1_8_5)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_1_8_3;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_1_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_1_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_1_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_1_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_1_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_1_3)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_1_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_2_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_2_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_2_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_2_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_2_4;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_2_3;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_2_3)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_2_2;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_2_4)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_2_5;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_2_5)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_2_4;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_3_2;
               POSITION = 0;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_3_3;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_3_7;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_3)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_3_2;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_3_4;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_4)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_3_3;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_3_5;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_3_8;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_5)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_3_4;
               POSITION = 3;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_3_6;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_6)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_3_5;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_7)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_3_2;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_3_8)
         {
            if(DOOR == 7)
            {
               LEVEL = LevelState.LEVEL_2_3_4;
               POSITION = 7;
            }
            else if(DOOR == 8)
            {
               LEVEL = LevelState.LEVEL_2_3_5;
               POSITION = 8;
            }
            else if(DOOR == 9)
            {
               LEVEL = LevelState.LEVEL_2_3_5;
               POSITION = 9;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_4_2;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_4_8;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_4_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_4_3;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_4_5;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_4_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_3)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_4_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_4_5;
               POSITION = 4;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_4_6;
               POSITION = 5;
            }
            else if(DOOR == 6)
            {
               LEVEL = LevelState.LEVEL_2_4_7;
               POSITION = 6;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_4_3;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_5)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_4_3;
               POSITION = 4;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_4_2;
               POSITION = 3;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_4_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_6)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_4_3;
               POSITION = 5;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_4_9;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_7)
         {
            if(DOOR == 6)
            {
               LEVEL = LevelState.LEVEL_2_4_3;
               POSITION = 6;
            }
            else if(DOOR == 7)
            {
               LEVEL = LevelState.LEVEL_2_4_8;
               POSITION = 7;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_8)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_4_1;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_4_9)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_4_6;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_5_2;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_5_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_15;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_5_6;
               POSITION = 3;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_5_11;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_1;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_5_7;
               POSITION = 1;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_5_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_5_5;
               POSITION = 4;
            }
            else if(DOOR == 9)
            {
               LEVEL = LevelState.LEVEL_2_5_2;
               POSITION = 9;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_5_3;
               POSITION = 3;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_5_3;
               POSITION = 5;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_5_5;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_5)
         {
            if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_5_3;
               POSITION = 4;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_6;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_5_9;
               POSITION = 3;
            }
            else if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_5_10;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_6)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_5;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_5_2;
               POSITION = 3;
            }
            else if(DOOR == 7)
            {
               LEVEL = LevelState.LEVEL_2_5_14;
               POSITION = 7;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_7)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_5_3;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_8;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_8)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_7;
               POSITION = 2;
            }
            else if(DOOR == 7)
            {
               LEVEL = LevelState.LEVEL_2_5_13;
               POSITION = 7;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_13)
         {
            if(DOOR == 7)
            {
               LEVEL = LevelState.LEVEL_2_5_8;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_9)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_5_5;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_10)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_5_5;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_11)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_12;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_14)
         {
            if(DOOR == 7)
            {
               LEVEL = LevelState.LEVEL_2_5_6;
               POSITION = 7;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_5_15)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_5_2;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_6_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_6_3;
               POSITION = 2;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_6_6;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_3)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_6_2;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_6_7;
               POSITION = 1;
            }
            else if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_6_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_4)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_6_3;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_6_5;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_5)
         {
            if(DOOR == 5)
            {
               LEVEL = LevelState.LEVEL_2_6_1;
               POSITION = 5;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_6)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_6_2;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_6_7)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_6_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_7_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_7_2;
               POSITION = 1;
            }
            else if(DOOR == 9)
            {
               LEVEL = LevelState.LEVEL_2_7_5;
               POSITION = 9;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_7_2)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_7_1;
               POSITION = 1;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_7_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_7_3)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_7_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_7_4;
               POSITION = 4;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_7_5)
         {
            if(DOOR == 9)
            {
               LEVEL = LevelState.LEVEL_2_7_1;
               POSITION = 9;
            }
            else if(DOOR == 8)
            {
               LEVEL = LevelState.LEVEL_2_7_2;
               POSITION = 8;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_1)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_8_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_2)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_8_3;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_8_2;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_3)
         {
            if(DOOR == 3)
            {
               LEVEL = LevelState.LEVEL_2_8_4;
               POSITION = 3;
            }
            else if(DOOR == 4)
            {
               LEVEL = LevelState.LEVEL_2_8_5;
               POSITION = 4;
            }
            else if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_8_3;
               POSITION = 2;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_4)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_8_6;
               POSITION = 2;
            }
            else if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_8_4;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_5)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_8_6;
               POSITION = 1;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_6)
         {
            if(DOOR == 2)
            {
               LEVEL = LevelState.LEVEL_2_8_7;
               POSITION = 3;
            }
         }
         else if(LEVEL == LevelState.LEVEL_2_8_7)
         {
            if(DOOR == 1)
            {
               LEVEL = LevelState.LEVEL_2_8_8;
               POSITION = 1;
            }
         }
         var array:Array = new Array();
         array.push(LEVEL);
         array.push(POSITION);
         return array;
      }
   }
}
