package levels.cutscenes
{
   import entities.npcs.FishermanNPC;
   import entities.npcs.GenericNPC;
   import entities.npcs.NPC;
   import entities.npcs.ShopNPC;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.behaviours.*;
   
   public class MoneyQuestionCutscene extends Cutscene
   {
      
      public static var BOAT_TRIP:int = 0;
      
      public static var FISHING_ROD_UPGRADE:int = 1;
      
      public static var PORTOBELLO_INN:int = 2;
      
      public static var ICECREAM:int = 3;
      
      public static var LIFT_TRIP:int = 4;
      
      public static var VENDING_MACHINE_CANDY:int = 5;
       
      
      protected var RESULT:Boolean;
      
      protected var INDEX:int;
      
      protected var PRICE:int;
      
      protected var npc1:NPC;
      
      protected var npc2:NPC;
      
      protected var originalXPos:Number;
      
      public function MoneyQuestionCutscene(_level:Level, _index:int, _result:Boolean, _price:int)
      {
         this.INDEX = _index;
         this.RESULT = _result;
         this.PRICE = _price;
         super(_level);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.npc1 = null;
         this.npc2 = null;
      }
      
      override public function update() : void
      {
         ++counter1;
         if(this.RESULT == false)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > 20)
               {
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               if(this.INDEX == MoneyQuestionCutscene.VENDING_MACHINE_CANDY)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_vending_2"),this.npc1,this.advance);
               }
               else
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("money_answer_cutscene_0"),this.npc1,this.advance);
               }
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(this.INDEX == MoneyQuestionCutscene.FISHING_ROD_UPGRADE)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > 20)
               {
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_fisherman_3"),this.npc1,this.advance);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               this.npc1.stateMachine.performAction("CHANGE_DIR_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
            {
               if(this.npc1.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.npc1.stateMachine.setState("IS_FISHING_STATE");
                  counter1 = 0;
                  this.originalXPos = this.npc1.xPos;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 5)
            {
               if(counter1 >= 30)
               {
                  counter1 = 0;
                  ++counter2;
                  if(this.npc1.xPos >= this.originalXPos)
                  {
                     this.npc1.xPos = this.originalXPos - 1;
                  }
                  else
                  {
                     this.npc1.xPos = this.originalXPos;
                  }
                  if(counter2 >= 4)
                  {
                     this.npc1.xPos = this.originalXPos;
                     counter1 = counter2 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 6)
            {
               if(counter1 >= 60)
               {
                  this.npc1.stateMachine.setState("IS_TURNING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 7)
            {
               if(this.npc1.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_fisherman_4"),this.npc1,this.advance);
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 9)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(this.INDEX == MoneyQuestionCutscene.PORTOBELLO_INN)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > 20)
               {
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_shop_inn_2"),this.npc1,this.advance);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(this.INDEX == MoneyQuestionCutscene.ICECREAM)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > 20)
               {
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_9"),this.npc1,this.advance);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(this.INDEX == MoneyQuestionCutscene.LIFT_TRIP)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > 20)
               {
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_mole_3"),this.npc1,this.advance);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 0)
         {
            if(counter1 > 20)
            {
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 1)
         {
            SoundSystem.PlaySound("dog");
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_guy_2"),this.npc1,this.advance);
            ++PROGRESSION;
         }
         else if(PROGRESSION == 3)
         {
            SoundSystem.StopMusic();
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         var genericNPC:GenericNPC = null;
         super.initState();
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(this.INDEX == 0)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC)
                  {
                     genericNPC = level.npcsManager.npcs[i] as GenericNPC;
                     if(genericNPC.NPC_TYPE == GenericNPC.NPC_GUY)
                     {
                        this.npc1 = level.npcsManager.npcs[i];
                     }
                  }
               }
               else if(this.INDEX == MoneyQuestionCutscene.LIFT_TRIP)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC)
                  {
                     genericNPC = level.npcsManager.npcs[i] as GenericNPC;
                     if(genericNPC.NPC_TYPE == GenericNPC.NPC_MOLE_GREY)
                     {
                        this.npc1 = level.npcsManager.npcs[i];
                     }
                  }
               }
               else if(this.INDEX == MoneyQuestionCutscene.FISHING_ROD_UPGRADE)
               {
                  if(level.npcsManager.npcs[i] is FishermanNPC)
                  {
                     this.npc1 = level.npcsManager.npcs[i];
                  }
               }
               else if(this.INDEX == MoneyQuestionCutscene.PORTOBELLO_INN || this.INDEX == MoneyQuestionCutscene.ICECREAM || this.INDEX == MoneyQuestionCutscene.VENDING_MACHINE_CANDY)
               {
                  if(level.npcsManager.npcs[i] is ShopNPC)
                  {
                     this.npc1 = level.npcsManager.npcs[i];
                  }
               }
            }
         }
         if(this.RESULT)
         {
            LevelItems.AddCoinsAndSave(-this.PRICE);
            SoundSystem.PlaySound("purchase");
            if(this.INDEX != 0)
            {
               if(this.INDEX == MoneyQuestionCutscene.FISHING_ROD_UPGRADE)
               {
                  ++Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1];
                  SaveManager.SaveInventory();
               }
               else if(this.INDEX == MoneyQuestionCutscene.PORTOBELLO_INN)
               {
                  Utils.LEVEL_LOCAL_PROGRESSION_1 = 1;
               }
               else if(this.INDEX == MoneyQuestionCutscene.ICECREAM)
               {
               }
            }
         }
         else
         {
            SoundSystem.PlaySound("error");
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(this.RESULT == false)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
            {
               Utils.ShopOn = true;
               Utils.LAST_SHOP_MENU = 3;
            }
         }
         else if(this.INDEX == 0)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 5;
            level.CHANGE_ROOM_FLAG = true;
         }
         else if(this.INDEX == MoneyQuestionCutscene.LIFT_TRIP)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 2;
            level.CHANGE_ROOM_FLAG = true;
         }
         else if(this.INDEX == MoneyQuestionCutscene.FISHING_ROD_UPGRADE)
         {
            FishermanNPC(this.npc1).checkFishingRodUpgrade();
         }
         else if(this.INDEX == MoneyQuestionCutscene.PORTOBELLO_INN)
         {
            this.npc1.stringId = 2;
         }
      }
   }
}
