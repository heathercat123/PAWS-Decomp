package levels.cutscenes
{
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.*;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   
   public class FishermanTutorialCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var fishermanNPC:FishermanNPC;
      
      protected var TYPE:int;
      
      protected var COUNTER:int;
      
      protected var HIT_FLAG:Boolean;
      
      public function FishermanTutorialCutscene(_level:Level, _counter:int)
      {
         this.TYPE = 0;
         this.COUNTER = _counter;
         this.HIT_FLAG = false;
         super(_level);
      }
      
      override public function destroy() : void
      {
         this.hero = null;
         this.fishermanNPC = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         ++counter1;
         if(this.hero.xPos > 176 + 8)
         {
            this.hero.xPos = 176;
            this.hero.xVel = 0;
         }
         if(Utils.Slot.gameProgression[15] == 0)
         {
            if(this.TYPE == 0 || this.TYPE == 1 || this.TYPE == 2)
            {
               if(PROGRESSION == 0)
               {
                  this.hero.xVel = 0;
                  this.hero.xPos = 176;
                  if(counter1 > 20)
                  {
                     counter1 = 0;
                     if(this.TYPE == 0 || this.TYPE == 2)
                     {
                        ++PROGRESSION;
                        this.fishermanNPC.setEmotionParticle(Entity.EMOTION_SHOCKED);
                     }
                     else
                     {
                        PROGRESSION = 7;
                     }
                  }
               }
               else if(PROGRESSION == 1)
               {
                  if(counter1 >= 40)
                  {
                     this.fishermanNPC.stateMachine.setState("IS_STANDING_STATE");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 2)
               {
                  if(counter1 >= 15)
                  {
                     this.fishermanNPC.stateMachine.performAction("CHANGE_DIR_ACTION");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 3)
               {
                  if(this.fishermanNPC.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     SoundSystem.PlaySound("cat_run_low");
                     this.fishermanNPC.stateMachine.performAction("WALK_ACTION");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 4)
               {
                  if(this.fishermanNPC.xPos <= 216)
                  {
                     this.fishermanNPC.stateMachine.setState("IS_STANDING_STATE");
                     this.fishermanNPC.xPos = 216;
                     this.fishermanNPC.xVel = 0;
                     counter1 = 0;
                     if(this.TYPE == 0)
                     {
                        ++PROGRESSION;
                     }
                     else
                     {
                        PROGRESSION = 50;
                     }
                  }
               }
               else if(PROGRESSION == 5)
               {
                  SoundSystem.PlaySound("fisherman_voice");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_0"),this.fishermanNPC,this.advance);
                  ++PROGRESSION;
                  counter1 = 0;
               }
               else if(PROGRESSION == 7)
               {
                  if(this.COUNTER <= 3)
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_1"),this.fishermanNPC,this.advance);
                  }
                  else if(this.COUNTER <= 6)
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_2"),this.fishermanNPC,this.advance);
                     this.fishermanNPC.setEmotionParticle(Entity.EMOTION_WORRIED);
                  }
                  else
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_3"),this.fishermanNPC,this.advance);
                     this.HIT_FLAG = true;
                  }
                  ++PROGRESSION;
                  counter1 = 0;
               }
               else if(PROGRESSION == 9)
               {
                  if(this.HIT_FLAG)
                  {
                     PROGRESSION = 12;
                  }
                  else
                  {
                     level.leftPressed = true;
                     if(this.hero.xPos <= 128)
                     {
                        level.leftPressed = false;
                        ++PROGRESSION;
                        counter1 = 0;
                        this.hero.xPos = 128;
                        this.hero.xVel = 0;
                     }
                  }
               }
               else if(PROGRESSION == 10)
               {
                  stateMachine.performAction("END_ACTION");
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 12)
               {
                  this.fishermanNPC.xPos = 176 + 16;
                  level.camera.shake();
                  this.hero.hurt(this.hero.xPos + 16,this.hero.getMidYPos(),null);
                  this.hero.xVel = -16;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 13)
               {
                  level.leftPressed = true;
                  if(counter1 >= 30)
                  {
                     counter1 = 0;
                     ++PROGRESSION;
                     stateMachine.performAction("END_ACTION");
                  }
               }
               else if(PROGRESSION == 50)
               {
                  SoundSystem.PlaySound("fisherman_voice");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_0"),this.fishermanNPC,this.advance);
                  ++PROGRESSION;
                  counter1 = 0;
               }
               else if(PROGRESSION == 52)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_4"),this.fishermanNPC,this.advance);
                  ++PROGRESSION;
                  counter1 = 0;
               }
               else if(PROGRESSION == 54)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_5"),this.fishermanNPC,this.advance,30);
                  ++PROGRESSION;
                  counter1 = 0;
               }
               else if(PROGRESSION == 56)
               {
                  SoundSystem.PlaySound("cat_run_low");
                  this.fishermanNPC.stateMachine.setState("IS_WALKING_STATE");
                  this.fishermanNPC.onTop();
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 57)
               {
                  if(this.fishermanNPC.xPos <= 128)
                  {
                     this.fishermanNPC.stateMachine.setState("IS_TURNING_STATE");
                     this.fishermanNPC.xVel = 0;
                     counter1 = 0;
                     ++PROGRESSION;
                  }
                  if(this.hero.DIRECTION == Entity.RIGHT && this.hero.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     if(this.fishermanNPC.xPos < this.hero.xPos)
                     {
                        this.hero.stateMachine.setState("IS_TURNING_STATE");
                     }
                  }
               }
               else if(PROGRESSION == 58)
               {
                  if(this.fishermanNPC.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_6"),this.fishermanNPC,this.advance,15);
                     ++PROGRESSION;
                     counter1 = 0;
                  }
               }
               else if(PROGRESSION == 60)
               {
                  if(this.fishermanNPC.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     SoundSystem.PlaySound("fisherman_voice");
                     level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_fishing_7"),this.fishermanNPC,this.advance);
                     ++PROGRESSION;
                     counter1 = 0;
                  }
               }
               else if(PROGRESSION == 62)
               {
                  this.fishermanNPC.stateMachine.setState("IS_TURNING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
               else if(PROGRESSION == 63)
               {
                  if(this.fishermanNPC.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     SoundSystem.PlaySound("cat_run");
                     this.fishermanNPC.stateMachine.setState("IS_WALKING_STATE");
                     this.fishermanNPC.speed = 0.5;
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 64)
               {
                  if(this.fishermanNPC.xPos <= level.camera.xPos - 32)
                  {
                     this.fishermanNPC.dead = true;
                     this.hero.stateMachine.setState("IS_TURNING_STATE");
                     stateMachine.performAction("END_ACTION");
                     ++PROGRESSION;
                  }
               }
            }
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
         super.initState();
         this.hero = level.hero;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is FishermanNPC)
               {
                  this.fishermanNPC = level.npcsManager.npcs[i];
                  if(this.fishermanNPC.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     this.TYPE = 1;
                  }
               }
            }
         }
         if(LevelItems.HasItem(LevelItems.ITEM_FISHING_ROD_1))
         {
            this.TYPE = 2;
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         level.playMusic();
         super.overState();
         if(this.TYPE == 2)
         {
            Utils.Slot.gameProgression[15] = 1;
            SaveManager.SaveGameProgression();
         }
      }
   }
}
