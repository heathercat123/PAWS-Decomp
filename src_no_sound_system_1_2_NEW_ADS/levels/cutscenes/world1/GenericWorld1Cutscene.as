package levels.cutscenes.world1
{
   import entities.*;
   import entities.enemies.GenieEnemy;
   import entities.npcs.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cameras.behaviours.VerTweenShiftBehaviour;
   import levels.collisions.DoorExitCollision;
   import levels.cutscenes.*;
   import levels.items.BellItem;
   import levels.items.KeyItem;
   import sprites.GameSprite;
   import sprites.cats.CatSprite;
   import states.LevelState;
   
   public class GenericWorld1Cutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var npc:GenericNPC;
      
      protected var twelve:TwelveNPC;
      
      protected var olli:CatNPC;
      
      protected var lizardNPC:CutsceneNPC;
      
      protected var enemy:GenieEnemy;
      
      protected var TYPE:int;
      
      protected var cameraTween1:HorTweenShiftBehaviour;
      
      protected var cameraTween2:VerTweenShiftBehaviour;
      
      protected var door:DoorExitCollision;
      
      protected var custom_var_1:int;
      
      protected var counter_2:int;
      
      protected var condition_1:Boolean;
      
      protected var condition_2:Boolean;
      
      protected var lizard_xVel:Number;
      
      protected var cutscene_counter:int;
      
      public function GenericWorld1Cutscene(_level:Level, _cutscene_counter:int = 0)
      {
         this.cutscene_counter = _cutscene_counter;
         super(_level);
         counter1 = counter2 = counter3 = this.counter_2 = this.custom_var_1 = 0;
         this.lizard_xVel = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.hero = null;
         this.npc = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         ++counter1;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_5)
         {
            this.hero.xPos = 464;
            if(PROGRESSION == 0)
            {
               this.hero.xVel = 0;
               this.hero.DIRECTION = Entity.RIGHT;
               if(this.npc.DIRECTION == Entity.RIGHT)
               {
                  this.npc.stateMachine.performAction("CHANGE_DIR_ACTION");
               }
               ++PROGRESSION;
            }
            else if(PROGRESSION == 1)
            {
               if(this.npc.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene3_1"),this.hero,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 3)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene3_2"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene3_3"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 7)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene3_4"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 9)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene3_5"),this.hero,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 11)
            {
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_6)
         {
            if(PROGRESSION == 0)
            {
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 304 - Utils.WIDTH * 0.5;
               this.cameraTween1.time = 2;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 1)
            {
               if(level.camera.xPos <= level.camera.LEFT_MARGIN || level.camera.xPos - 1 <= int(304 - Utils.WIDTH * 0.5) || counter1 >= 120)
               {
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_1"),this.twelve,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
            {
               SoundSystem.PlaySound("cat_mcmeow");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_2"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 6)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_3"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 8)
            {
               this.npc.setEmotionParticle(Entity.EMOTION_SHOCKED);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_4"),this.twelve,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               this.twelve.stateMachine.performAction("CHANGE_DIR_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 11)
            {
               if(this.twelve.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.twelve.stateMachine.setState("IS_WALKING_STATE");
                  this.twelve.speed = 0.4;
                  this.twelve.onTop();
                  counter1 = 0;
                  PROGRESSION = 600;
               }
            }
            else if(PROGRESSION == 600)
            {
               if(this.twelve.xPos >= level.hero.xPos - 32)
               {
                  this.twelve.stateMachine.setState("IS_STANDING_STATE");
                  this.twelve.xPos = level.hero.xPos - 32;
                  this.twelve.xVel = 0;
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_4_0"),this.twelve,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 602)
            {
               level.leftPressed = true;
               if(this.hero.xPos <= this.twelve.xPos - 16)
               {
                  level.leftPressed = false;
                  this.hero.stateMachine.setState("IS_STANDING_STATE");
                  this.twelve.stateMachine.setState("IS_WALKING_STATE");
                  this.hero.DIRECTION = Entity.RIGHT;
                  counter1 = 0;
                  PROGRESSION = 12;
               }
            }
            else if(PROGRESSION == 12)
            {
               if(this.twelve.xPos >= 464)
               {
                  this.twelve.stateMachine.setState("IS_STANDING_STATE");
                  this.twelve.xPos = 464;
                  this.twelve.xVel = 0;
                  ++PROGRESSION;
                  counter1 = 0;
               }
            }
            else if(PROGRESSION == 13)
            {
               this.door.stateMachine.performAction("OPEN_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 14)
            {
               if(counter1 >= 10)
               {
                  this.twelve.stateMachine.setState("IS_WALKING_STATE");
                  this.twelve.speed = 0.4;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 15)
            {
               if(this.twelve.xPos >= 416)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  this.hero.stateMachine.setState("IS_TURNING_STATE");
               }
            }
            else if(PROGRESSION == 16)
            {
               if(counter1 >= 15)
               {
                  this.door.stateMachine.performAction("CLOSE_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 17)
            {
               if(counter1 == 30)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_5"),this.npc,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 19)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 20)
            {
               if(this.hero.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 21)
            {
               level.leftPressed = true;
               if(this.hero.xPos <= 336)
               {
                  level.leftPressed = false;
                  this.hero.stateMachine.setState("IS_STANDING_STATE");
                  this.hero.xPos = 336;
                  this.hero.xVel = 0;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 22)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_6"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 24)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_mcmeow_1"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 26)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_8"),this.hero,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 28)
            {
               if(counter1 == 15)
               {
                  this.createKeyItem();
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 29)
            {
               if(counter1 == 75)
               {
                  SoundSystem.PlaySound("cat_mcmeow");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene4_9"),this.npc,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 31)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 32)
            {
               if(counter1 >= 40)
               {
                  level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level),true);
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_4)
         {
            if(PROGRESSION <= 4)
            {
               this.hero.xPos = 272;
            }
            if(PROGRESSION == 0)
            {
               this.hero.xVel = 0;
               this.hero.stateMachine.setState("IS_STANDING_STATE");
               counter1 = 0;
               if(this.cutscene_counter == 2 && (Utils.Slot.gameProgression[10] >> 0 & 1) == 0)
               {
                  PROGRESSION = 10;
               }
               else
               {
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene11_1"),this.npc,this.advance,30);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene11_2"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               level.rightPressed = true;
               if(this.hero.xPos >= 288)
               {
                  level.rightPressed = false;
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 10)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene11_3"),this.npc,this.advance,30);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 12)
            {
               LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_CANDY_1);
               Utils.Slot.gameProgression[10] |= 1 << 0;
               SaveManager.SaveGameProgression();
               ++PROGRESSION;
               counter1 = 0;
            }
            else if(PROGRESSION == 13)
            {
               if(counter1 >= 150)
               {
                  PROGRESSION = 5;
                  counter1 = 0;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_3)
         {
            if(this.TYPE != 1)
            {
               if(this.TYPE == 2)
               {
                  if(PROGRESSION == 0)
                  {
                     this.hero.xPos = 656;
                     this.hero.xVel = 0;
                     this.hero.stateMachine.setState("IS_STANDING_STATE");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
                  else if(PROGRESSION == 1)
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene10_1"),this.hero,this.advance,30);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
                  else if(PROGRESSION == 3)
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene10_2"),this.hero,this.advance);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
                  else if(PROGRESSION == 5)
                  {
                     level.leftPressed = true;
                     if(this.hero.xPos <= 640)
                     {
                        level.leftPressed = false;
                        stateMachine.performAction("END_ACTION");
                        counter1 = 0;
                        ++PROGRESSION;
                     }
                  }
               }
               else if(PROGRESSION == 0)
               {
                  if(counter1 >= 30)
                  {
                     this.olli.setEmotionParticle(Entity.EMOTION_SHOCKED);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 1)
               {
                  if(counter1 >= 25)
                  {
                     this.olli.stateMachine.setState("IS_WALKING_STATE");
                     this.olli.DIRECTION = Entity.LEFT;
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 2)
               {
                  if(this.olli.xPos <= 224)
                  {
                     this.olli.xPos = 224;
                     this.olli.xVel = 0;
                     this.olli.stateMachine.setState("IS_STANDING_STATE");
                     if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] == 0)
                     {
                        level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene5_1"),this.olli,this.advance);
                     }
                     else
                     {
                        level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene5_2"),this.olli,this.advance);
                     }
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 4)
               {
                  level.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene5_3"),this.olli,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 6)
               {
                  if(counter1 == 30)
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene5_4"),this.olli,this.advance);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 8)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene5_5"),this.olli,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 10)
               {
                  this.olli.stateMachine.performAction("CHANGE_DIR_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 11)
               {
                  if(this.olli.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     SoundSystem.PlaySound("rigs_angry");
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene5_6"),this.olli,this.advance,15);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 13)
               {
                  SoundSystem.PlaySound("cat_run");
                  this.olli.stateMachine.setState("IS_WALKING_STATE");
                  this.olli.DIRECTION = Entity.RIGHT;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 14)
               {
                  if(this.olli.xPos >= level.camera.xPos + Utils.WIDTH + 32)
                  {
                     counter1 = 0;
                     ++PROGRESSION;
                     level.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
                  }
               }
               else if(PROGRESSION == 15)
               {
                  if(counter1 >= 30)
                  {
                     stateMachine.performAction("END_ACTION");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_8)
         {
            if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
            {
               this.hero.xVel = 0;
               this.hero.xPos = 304;
               if(PROGRESSION == 0)
               {
                  this.olli.setEmotionParticle(Entity.EMOTION_SHOCKED);
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 1)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("halloween_cutscene_0_0"),this.olli,this.advance,30);
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 3)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("halloween_cutscene_0_1"),this.olli,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 5)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("halloween_cutscene_0_2"),this.olli,this.advance,30);
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 7)
               {
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_10)
         {
            this.hero.xVel = 0;
            this.hero.xPos = 464;
            if(PROGRESSION == 0)
            {
               this.npc.setEmotionParticle(Entity.EMOTION_SHOCKED);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 1)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_white_mouse_2"),this.npc,this.advance,30);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               SoundSystem.PlaySound("explosion_medium");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_white_mouse_3"),this.npc,this.advance);
               level.camera.shake();
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               Utils.INVENTORY_NOTIFICATION_ID = LevelItems.ITEM_ICE_CREAM_1;
               Utils.INVENTORY_NOTIFICATION_ACTION = -1;
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 6)
            {
               if(counter1 >= 60)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_white_mouse_4"),this.npc,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 8)
            {
               this.createBellReward();
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 9)
            {
               if(counter1 >= 60)
               {
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_13)
         {
            this.hero.xVel = 0;
            if(PROGRESSION == 0)
            {
               if(this.npc.DIRECTION == Entity.RIGHT)
               {
                  this.npc.stateMachine.setState("IS_TURNING_STATE");
               }
               counter1 = 0;
               ++PROGRESSION;
            }
            if(PROGRESSION == 1)
            {
               if(this.npc.stateMachine.currentState == "IS_STANDING_STATE" && this.npc.DIRECTION == Entity.LEFT)
               {
                  this.npc.allowTurn = false;
                  this.npc.setEmotionParticle(Entity.EMOTION_SHOCKED);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_acorn_7"),this.npc,this.advance,30);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_acorn_8"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 6)
            {
               this.createBellReward();
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 7)
            {
               if(counter1 >= 60)
               {
                  this.npc.stringId = 7;
                  this.npc.allowTurn = true;
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_6_1)
         {
            level.hero.xVel = 0;
            level.hero.xPos = 344;
            if(PROGRESSION == 0)
            {
               level.hero.xVel = 0;
               level.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene6_1"),this.hero,this.advance,15);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 2)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene6_2"),this.hero,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
            {
               level.hero.stateMachine.setState("IS_TURNING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               if(level.hero.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene6_3"),this.hero,this.advance,15);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 7)
            {
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_8_1)
         {
            if(PROGRESSION == 0)
            {
               level.hero.xVel = 0;
               level.hero.xPos = 472;
               if(level.hero.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.custom_var_1 = Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT];
                  if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] == 0)
                  {
                     this.olli = new CatNPC(level,level.hero.xPos,level.hero.yPos,Entity.RIGHT,0,CatNPC.PASCAL);
                  }
                  else
                  {
                     this.olli = new CatNPC(level,level.hero.xPos,level.hero.yPos,Entity.RIGHT,0,CatNPC.ROSE);
                  }
                  this.olli.updateScreenPosition(level.camera);
                  level.npcsManager.npcs.push(this.olli);
                  level.hero.sprite.visible = false;
                  ++PROGRESSION;
                  counter1 = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               CatSprite(this.olli.sprite).playSpecialAnim(CatSprite.LOOK_UP);
               this.olli.setEmotionParticle(Entity.EMOTION_SHOCKED);
               ++PROGRESSION;
               counter1 = 0;
            }
            else if(PROGRESSION == 2)
            {
               if(counter1 >= 30)
               {
                  this.counter_2 = level.camera.y;
                  this.cameraTween2 = new VerTweenShiftBehaviour(level);
                  this.cameraTween2.y_start = level.camera.y;
                  this.cameraTween2.y_end = 96 + level.camera.getVerticalOffsetFromGroundLevel() - int(level.camera.HEIGHT);
                  this.cameraTween2.time = 1;
                  this.cameraTween2.tick = 0;
                  level.camera.changeVerBehaviour(this.cameraTween2);
                  level.camera.changeHorBehaviour(new StaticHorBehaviour(level,level.camera.x));
                  counter1 = 0;
                  ++PROGRESSION;
                  level.changeCat(2,false,true);
                  level.hero.xPos = level.camera.xPos - 32;
                  level.hero.yPos = 304;
               }
            }
            else if(PROGRESSION == 3)
            {
               if(counter1 == 64)
               {
                  SoundSystem.PlaySound("mesa_laugh");
                  this.lizardNPC.sprite.gfxHandle().gotoAndStop(3);
                  this.lizardNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
               else if(counter1 == 90)
               {
                  level.particlesManager.createDust(this.lizardNPC.xPos + 8,this.lizardNPC.yPos + 32,Entity.LEFT);
                  level.particlesManager.createDust(this.lizardNPC.xPos + 32 - 8,this.lizardNPC.yPos + 32,Entity.RIGHT);
                  level.camera.shake();
                  SoundSystem.PlaySound("woosh");
                  this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
               }
               else if(counter1 > 90 && counter1 < 120)
               {
                  this.lizard_xVel += 1;
                  this.lizardNPC.yPos -= 6;
                  this.lizardNPC.xPos += this.lizard_xVel;
               }
               else if(counter1 >= 120)
               {
                  this.cameraTween2 = new VerTweenShiftBehaviour(level);
                  this.cameraTween2.y_start = level.camera.y;
                  this.cameraTween2.y_end = this.counter_2;
                  this.cameraTween2.time = 0.25;
                  this.cameraTween2.tick = 0;
                  level.camera.changeVerBehaviour(this.cameraTween2);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 4)
            {
               level.rightPressed = true;
               if(level.hero.xPos >= 424)
               {
                  level.rightPressed = false;
                  level.hero.xPos = 424;
                  level.hero.xVel = 0;
                  counter1 = 0;
                  ++PROGRESSION;
                  this.olli.stateMachine.setState("IS_TURNING_STATE");
               }
            }
            else if(PROGRESSION == 5)
            {
               if(counter1 == 15)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene7_1"),this.olli,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 7)
            {
               if(counter1 == 1)
               {
                  CatSprite(level.hero.sprite).playSpecialAnim(CatSprite.LOOK_UP);
                  this.enemy = new GenieEnemy(level,496,level.camera.y - 24,Entity.LEFT,1);
                  this.enemy.ai_index = 1;
                  level.enemiesManager.enemies.push(this.enemy);
                  this.enemy.updateScreenPosition(level.camera);
               }
               else if(counter1 >= 5)
               {
                  if(this.enemy.yPos >= 232)
                  {
                     SoundSystem.PlaySound("rigs_angry");
                     level.hero.stateMachine.setState("IS_STANDING_STATE");
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene7_2"),level.hero,this.advance,40);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 9)
            {
               level.hero.stateMachine.setState("IS_RUNNING_STATE");
               level.rightPressed = true;
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               if(level.hero.xPos >= this.olli.xPos)
               {
                  this.olli.stateMachine.setState("IS_TURNING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
               level.rightPressed = true;
            }
            else if(PROGRESSION == 11)
            {
               counter2 = level.camera.RIGHT_MARGIN;
               level.camera.RIGHT_MARGIN *= 2;
               level.rightPressed = true;
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 12)
            {
               level.rightPressed = true;
               if(level.hero.xPos >= level.camera.xPos + level.camera.WIDTH + 24)
               {
                  level.camera.RIGHT_MARGIN = counter2;
                  level.hero.xPos = this.olli.xPos;
                  level.hero.yPos = this.olli.yPos;
                  level.hero.stateMachine.setState("IS_STANDING_STATE");
                  level.hero.xVel = 0;
                  level.rightPressed = false;
                  this.olli.dead = true;
                  level.changeCat(this.custom_var_1,false);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 13)
            {
               level.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 14)
            {
               if(counter1 >= 15)
               {
                  level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
      }
      
      protected function createKeyItem() : void
      {
         var l_index:int = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
         var item:KeyItem = new KeyItem(level,272,128,1);
         item.level_index = l_index;
         item.stateMachine.setState("IS_BONUS_STATE");
         item.updateScreenPosition(level.camera);
         level.itemsManager.items.push(item);
         item.onTop();
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
         super.initState();
         this.TYPE = 0;
         this.npc = null;
         this.twelve = null;
         this.door = null;
         this.hero = level.hero;
         this.hero.xVel = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_3)
         {
            if(this.hero.xPos <= 592)
            {
               this.TYPE = 0;
            }
            else if(this.hero.xPos >= 656)
            {
               this.TYPE = 2;
            }
            else
            {
               this.TYPE = 1;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_8_1)
         {
            this.lizardNPC = new CutsceneNPC(level,584,64,Entity.LEFT,0,0);
            level.npcsManager.npcs.push(this.lizardNPC);
            this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
            this.lizardNPC.updateScreenPosition(level.camera);
         }
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_3)
               {
                  if(this.TYPE == 0)
                  {
                     if(level.npcsManager.npcs[i] is CatNPC)
                     {
                        this.olli = level.npcsManager.npcs[i] as CatNPC;
                     }
                  }
               }
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_4)
               {
                  if(level.npcsManager.npcs[i].xPos <= 448)
                  {
                     this.npc = level.npcsManager.npcs[i];
                  }
               }
               else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_5)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC && level.npcsManager.npcs[i].xPos >= 480)
                  {
                     this.npc = level.npcsManager.npcs[i] as GenericNPC;
                     this.npc.allowTurn = false;
                  }
               }
               else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_6)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC)
                  {
                     this.npc = level.npcsManager.npcs[i] as GenericNPC;
                  }
                  else if(level.npcsManager.npcs[i] is TwelveNPC)
                  {
                     this.twelve = level.npcsManager.npcs[i] as TwelveNPC;
                  }
               }
               else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_13)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC)
                  {
                     if(level.npcsManager.npcs[i].xPos < 416)
                     {
                        this.npc = level.npcsManager.npcs[i] as GenericNPC;
                        if(this.npc.dialog != null)
                        {
                           this.npc.dialog.endRendering();
                        }
                     }
                  }
               }
               else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_10)
               {
                  this.npc = level.npcsManager.npcs[i] as GenericNPC;
               }
               else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_8)
               {
                  if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
                  {
                     if(level.npcsManager.npcs[i] is CatNPC)
                     {
                        this.olli = level.npcsManager.npcs[i] as CatNPC;
                     }
                  }
               }
            }
         }
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_6)
               {
                  if(level.collisionsManager.collisions[i] is DoorExitCollision)
                  {
                     this.door = level.collisionsManager.collisions[i] as DoorExitCollision;
                  }
               }
            }
         }
         this.condition_1 = false;
         this.condition_2 = false;
      }
      
      override protected function execState() : void
      {
      }
      
      protected function createBellReward() : void
      {
         var l_index:int = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
         var bell_item:BellItem = null;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_13)
         {
            bell_item = new BellItem(level,240,112,1);
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_10)
         {
            bell_item = new BellItem(level,544,96,2);
         }
         if(bell_item != null)
         {
            bell_item.level_index = l_index;
            bell_item.stateMachine.setState("IS_BONUS_STATE");
            bell_item.updateScreenPosition(level.camera);
            level.itemsManager.items.push(bell_item);
         }
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_5)
         {
            this.npc.allowTurn = true;
            this.npc.stringId = 1;
            Utils.Slot.gameProgression[5] = 1;
            SaveManager.SaveGameProgression();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_3)
         {
            if(this.TYPE == 0)
            {
               SoundSystem.StopMusic(true);
               SoundSystem.PlayMusic("paws_base");
               this.olli.dead = true;
               Utils.Slot.gameProgression[6] = 1;
               SaveManager.SaveGameProgression();
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_6)
         {
            this.twelve.dead = true;
            this.npc.stringId = 1;
            SoundSystem.StopMusic(true);
            SoundSystem.PlayMusic("paws_base");
            Utils.Slot.gameProgression[6] = 2;
            SaveManager.SaveGameProgression();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_8_1)
         {
            this.lizardNPC.dead = true;
            Utils.Slot.gameProgression[7] = 1;
            SaveManager.SaveGameProgression();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_8)
         {
            if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
            {
               LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,500);
               Utils.Slot.gameProgression[21] = 1;
               this.olli.stringId = 1;
               SaveManager.SaveGameProgression();
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_10)
         {
            LevelItems.RemoveItem(LevelItems.ITEM_ICE_CREAM_1,1);
            SaveManager.SaveInventory();
            Utils.Slot.gameProgression[19] = 1;
            SaveManager.SaveGameProgression();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_13)
         {
            Utils.Slot.gameProgression[18] = 1;
            SaveManager.SaveGameProgression();
         }
      }
   }
}
