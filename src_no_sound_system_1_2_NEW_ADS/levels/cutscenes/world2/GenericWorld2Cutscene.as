package levels.cutscenes.world2
{
   import entities.*;
   import entities.npcs.*;
   import game_utils.*;
   import interfaces.texts.GameText;
   import levels.*;
   import levels.cameras.*;
   import levels.cameras.behaviours.*;
   import levels.collisions.*;
   import levels.cutscenes.*;
   import sprites.*;
   import sprites.cats.CatSprite;
   import sprites.enemies.FoxBossEnemySprite;
   import sprites.particles.SplashParticleSprite;
   import starling.display.Sprite;
   import states.*;
   
   public class GenericWorld2Cutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var npc:GenericNPC;
      
      protected var shop_npc:ShopNPC;
      
      protected var pascal:CatNPC;
      
      protected var rose:CatNPC;
      
      protected var rigs:CatNPC;
      
      protected var cat1:CatNPC;
      
      protected var fox:CutsceneNPC;
      
      protected var fish:CutsceneNPC;
      
      protected var lace:CutsceneNPC;
      
      protected var original_camera_xPos:Number;
      
      protected var original_camera_yPos:Number;
      
      protected var TYPE:int;
      
      protected var cameraTween1:HorTweenShiftBehaviour;
      
      protected var cameraTween2:VerTweenShiftBehaviour;
      
      protected var door:DoorExitCollision;
      
      protected var custom_var_1:int;
      
      protected var counter_2:int;
      
      protected var condition_1:Boolean;
      
      protected var condition_2:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var t_start_2:Number;
      
      protected var t_diff_2:Number;
      
      protected var t_time_2:Number;
      
      protected var t_tick_2:Number;
      
      protected var text_container:Sprite;
      
      protected var text:GameText;
      
      public function GenericWorld2Cutscene(_level:Level)
      {
         super(_level);
         counter1 = counter2 = counter3 = this.counter_2 = this.custom_var_1 = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = this.t_start_2 = this.t_diff_2 = this.t_time_2 = this.t_tick_2 = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.hero = null;
         this.npc = null;
         this.fish = null;
         this.fox = null;
         this.lace = null;
         this.shop_npc = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var foo_1:int = 0;
         var foxParticle:FoxBossEnemySprite = null;
         ++counter1;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_1_1)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 >= 120)
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  this.cat1.stateMachine.setState("IS_WALKING_STATE");
               }
               if(counter1 == 90)
               {
                  this.cameraTween1 = new HorTweenShiftBehaviour(level);
                  this.cameraTween1.x_start = level.camera.x;
                  this.cameraTween1.x_end = 256 - Utils.WIDTH * 0.5;
                  this.cameraTween1.time = 2;
                  this.cameraTween1.tick = 0;
                  level.camera.changeHorBehaviour(this.cameraTween1);
               }
            }
            else if(PROGRESSION == 1)
            {
               if(this.cat1.xPos >= 216)
               {
                  this.cat1.xPos = 216;
                  this.cat1.stateMachine.setState("IS_STANDING_STATE");
                  this.rigs.stateMachine.setState("IS_TURNING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
            {
               if(this.rigs.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_1_cutscene0_1"),this.rigs,this.advance,30);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 4)
            {
               this.rigs.stateMachine.setState("IS_TURNING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               if(this.rigs.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.rigs.sprite.gfxHandle().gfxHandleClip().gotoAndStop(4);
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_1_cutscene0_2"),this.rigs,this.advance,30);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 7)
            {
               counter1 = 0;
               PROGRESSION = 9;
            }
            else if(PROGRESSION == 9)
            {
               this.rigs.stateMachine.setState("IS_WALKING_STATE");
               this.rigs.SPEED = 4;
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               if(this.rigs.xPos >= level.camera.xPos + Utils.WIDTH + 16)
               {
                  if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] == 0)
                  {
                     this.cat1.setEmotionParticle(Entity.EMOTION_WORRIED);
                     counter1 = 0;
                     PROGRESSION = 12;
                  }
                  else
                  {
                     CatSprite(this.cat1.sprite).playSpecialAnim(CatSprite.PANT);
                     this.cat1.sprite.gfxHandle().gfxHandleClip().gotoAndStop(3);
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 11)
            {
               if(counter1 == 15)
               {
                  this.cat1.setEmotionParticle(Entity.EMOTION_WORRIED);
                  this.cat1.sprite.gfxHandle().gfxHandleClip().gotoAndStop(4);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 12)
            {
               if(counter1 == 60)
               {
                  counter1 = 0;
                  PROGRESSION = 18;
               }
            }
            else if(PROGRESSION == 18)
            {
               this.hero.xPos = this.cat1.xPos;
               this.cat1.dead = true;
               this.rigs.dead = true;
               this.hero.sprite.visible = true;
               level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_1)
         {
            this.hero.xVel = 0;
            this.hero.xPos = 864;
            this.hero.DIRECTION = Entity.RIGHT;
            if(PROGRESSION == 0)
            {
               if(counter1 >= 30)
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  this.cat1.stateMachine.performAction("CHANGE_DIR_ACTION");
               }
            }
            else if(PROGRESSION == 1)
            {
               if(this.cat1.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.cat1.setEmotionParticle(Entity.EMOTION_SHOCKED);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
            {
               if(counter1 >= 30)
               {
                  SoundSystem.PlayMusic("cutscene_cats");
                  this.cat1.stateMachine.performAction("WALK_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 3)
            {
               if(this.cat1.xPos <= 928)
               {
                  this.cat1.xPos = 928;
                  this.cat1.stateMachine.performAction("STOP_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 4)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene1_1"),this.cat1,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 6)
            {
               if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene1_2_2"),this.hero,this.advance);
               }
               else if(Hero.GetCurrentCat() == Hero.CAT_ROSE)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene1_2_1"),this.hero,this.advance);
               }
               else
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene1_2_0"),this.hero,this.advance);
               }
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 8)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene1_3"),this.cat1,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene1_4"),this.cat1,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 12)
            {
               this.cat1.stateMachine.performAction("CHANGE_DIR_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 13)
            {
               if(this.cat1.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  SoundSystem.PlaySound("cat_run");
                  this.cat1.stateMachine.performAction("WALK_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 14)
            {
               if(this.cat1.xPos >= level.camera.xPos + Utils.WIDTH + 16)
               {
                  SoundSystem.StopMusic();
                  this.hero.setEmotionParticle(Entity.EMOTION_QUESTION);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 15)
            {
               if(counter1 >= 30)
               {
                  level.levelData.setTileValueAt(65,9,1);
                  level.levelData.setTileValueAt(68,8,1);
                  this.cat1.dead = true;
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_4)
         {
            this.hero.xVel = 0;
            this.hero.DIRECTION = Entity.LEFT;
            this.hero.xPos = 256;
            if(PROGRESSION == 0)
            {
               if(counter1 >= 100)
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  this.cat1.stateMachine.performAction("CHANGE_DIR_ACTION");
               }
               else if(counter1 == 60)
               {
                  SoundSystem.PlayMusic("cutscene_cats");
               }
               else if(counter1 == 2)
               {
                  SoundSystem.StopMusic();
                  this.cameraTween1 = new HorTweenShiftBehaviour(level);
                  this.cameraTween1.x_start = level.camera.x;
                  this.cameraTween1.x_end = 232 - Utils.WIDTH * 0.5;
                  this.cameraTween1.time = 2;
                  this.cameraTween1.tick = 0;
                  level.camera.changeHorBehaviour(this.cameraTween1);
               }
            }
            else if(PROGRESSION == 1)
            {
               if(this.cat1.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_1"),this.cat1,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 3)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_2"),this.cat1,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               level.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_3_1"),level.hero,this.advance,30);
               }
               else
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_3_0"),level.hero,this.advance,30);
               }
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 7)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_4"),this.cat1,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 9)
            {
               this.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
               this.cat1.stateMachine.performAction("CHANGE_DIR_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               if(this.cat1.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_5"),this.cat1,this.advance,60);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 12)
            {
               this.cat1.stateMachine.performAction("CHANGE_DIR_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 13)
            {
               if(counter1 >= 60)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_6"),this.cat1,this.advance);
                  this.cat1.setEmotionParticle(Entity.EMOTION_SHOCKED);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 15)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene2_7"),this.cat1,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 17)
            {
               LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_FISHING_ROD_1);
               Utils.Slot.gameProgression[12] = 2;
               SaveManager.SaveGameProgression();
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 18)
            {
               if(counter1 >= 150)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_mara_1"),this.cat1,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 20)
            {
               this.cat1.setTurnToHero(true);
               this.cat1.stringId = 1;
               level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_11)
         {
            this.hero.xVel = 0;
            this.hero.DIRECTION = Entity.RIGHT;
            if(PROGRESSION == 0)
            {
               if(counter1 >= 30)
               {
                  SoundSystem.PlaySound("dog");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene6_0"),this.npc,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene6_1"),this.npc,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
            {
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_7)
         {
            if(PROGRESSION < 5)
            {
               this.hero.xVel = 0;
               this.hero.xPos = 544;
            }
            if(PROGRESSION == 0)
            {
               this.shop_npc.DIRECTION = Entity.RIGHT;
               level.hud.dialogsManager.createCaptionNoCameraAt(StringsManager.GetString("world_2_cutscene7_0"),int(Utils.WIDTH * 0.25),int(Utils.HEIGHT * 0.5),this.advance);
               this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 2)
            {
               this.custom_var_1 = level.camera.x;
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 144;
               this.cameraTween1.time = 0.75;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(counter1 >= 60)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene7_1"),this.shop_npc,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 5)
            {
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = int(496 + 8 - Utils.WIDTH * 0.5);
               this.cameraTween1.time = 0.75;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 6)
            {
               if(counter1 >= 30)
               {
                  level.leftPressed = true;
                  if(counter1 >= 60 && this.hero.xPos <= 496)
                  {
                     level.leftPressed = false;
                     ++PROGRESSION;
                     level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_8)
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
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_rose_2"),this.cat1,this.advance);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_6)
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
               SoundSystem.PlaySound("merchant_voice_1");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_beach_6"),this.npc,this.advance);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_8_8)
         {
            if(PROGRESSION == 0)
            {
               level.camera.changeHorBehaviour(new StaticHorBehaviour(level,0));
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 1)
            {
               level.hud.hideDarkFade(120);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 2)
            {
               if(counter1 >= 60)
               {
                  this.cameraTween1 = new HorTweenShiftBehaviour(level);
                  this.cameraTween1.x_start = level.camera.x;
                  this.cameraTween1.x_end = int(408 - level.camera.HALF_WIDTH);
                  this.cameraTween1.time = 4;
                  this.cameraTween1.tick = 0;
                  level.camera.changeHorBehaviour(this.cameraTween1);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 3)
            {
               if(counter1 >= 240)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_6"),this.lace,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 5)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_7"),this.fox,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 7)
            {
               if(counter1 >= 60)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_8"),this.lace,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 9)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_9"),this.lace,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 11)
            {
               this.lace.sprite.gfxHandle().gotoAndStop(1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 12)
            {
               if(counter1 >= 30)
               {
                  SoundSystem.PlaySound("lace");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_10"),this.lace,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 14)
            {
               if(counter1 >= 30)
               {
                  level.hud.showDarkFade(0.1);
                  Utils.rootMovie.setChildIndex(this.text_container,Utils.rootMovie.numChildren - 1);
                  this.text.visible = true;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 15)
            {
               if(counter1 >= 120)
               {
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_7_2)
         {
            this.hero.xVel = 0;
            this.hero.DIRECTION = Entity.RIGHT;
            this.hero.xPos = 1536;
            if(PROGRESSION == 0)
            {
               this.original_camera_xPos = level.camera.xPos;
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 1624 - Utils.WIDTH * 0.5;
               this.cameraTween1.time = 0.5;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 1)
            {
               if(counter1 >= 15)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_0"),this.fox,this.advance);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 3)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_1"),this.fox,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               this.original_camera_yPos = level.camera.yPos;
               this.cameraTween2 = new VerTweenShiftBehaviour(level);
               this.cameraTween2.y_start = level.camera.y;
               this.cameraTween2.y_end = 224 + level.camera.getVerticalOffsetFromGroundLevel() - int(level.camera.HEIGHT);
               this.cameraTween2.time = 2;
               this.cameraTween2.tick = 0;
               level.camera.changeVerBehaviour(this.cameraTween2);
               this.t_time = 1.5;
               this.t_start = this.fish.yPos;
               this.t_diff = 216 - this.t_start;
               this.t_tick = 0;
               this.t_start_2 = 0;
               this.t_diff_2 = 2;
               this.t_time_2 = 2.5;
               this.t_tick_2 = 0;
               SoundSystem.PlaySound("giant_fish_swoosh");
               ++PROGRESSION;
               counter1 = 0;
            }
            else if(PROGRESSION == 6)
            {
               foo_1 = 0;
               this.t_tick_2 += 1 / 60;
               if(this.t_tick_2 >= this.t_time_2)
               {
                  this.t_tick_2 = this.t_time_2;
                  foo_1++;
               }
               if(this.t_tick_2 >= 2)
               {
                  this.t_tick += 1 / 60;
                  if(this.t_tick >= this.t_time)
                  {
                     this.t_tick = this.t_time;
                     foo_1++;
                  }
               }
               this.fish.yPos = Easings.easeOutBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
               level.camera.shake(Easings.linear(this.t_tick_2 + 1,this.t_start_2,this.t_diff_2,this.t_time_2),true);
               if(foo_1 >= 2)
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               }
            }
            else if(PROGRESSION == 7)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_2"),this.fox,this.advance,30);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 9)
            {
               level.camera.shake();
               this.fish.setEmotionParticle(Entity.EMOTION_SHOCKED);
               SoundSystem.PlaySound("giant_fish_roar");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_3"),this.fish,this.advance,15);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 12)
            {
               if(Hero.GetCurrentCat() == Hero.CAT_PASCAL || Hero.GetCurrentCat() == Hero.CAT_ROSE)
               {
                  this.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
               }
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_4_" + Hero.GetCurrentCat()),this.hero,this.advance,15);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 14)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_5"),this.fish,this.advance,15);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 16)
            {
               this.t_start = this.fish.yPos;
               this.t_diff = 160 - this.t_start;
               this.t_time = 0.5;
               this.t_tick = 0;
               SoundSystem.PlaySound("swoosh");
               counter1 = 0;
               ++PROGRESSION;
               this.condition_1 = false;
            }
            else if(PROGRESSION == 17)
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               if(this.condition_1 == false)
               {
                  if(this.fish.yPos <= 208)
                  {
                     this.condition_1 = true;
                     level.camera.verShake(6,0.9,0.5);
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fish.xPos + 24,Utils.SEA_LEVEL,0,0,0);
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fish.xPos,Utils.SEA_LEVEL,0,0,0);
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fish.xPos - 24,Utils.SEA_LEVEL,0,0,0);
                  }
               }
               this.fish.sin_counter_2 = 0;
               this.fish.yPos = Easings.easeInBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else if(PROGRESSION == 18)
            {
               ++counter2;
               if(counter2 >= 5)
               {
                  ++counter3;
                  counter2 = 0;
                  this.fish.sprite.rotation -= Math.PI * 0.25;
                  if(counter3 == 1 || counter3 == 5 || counter3 == 9)
                  {
                     SoundSystem.PlaySound("wing");
                  }
                  if(counter3 >= 10)
                  {
                     this.fish.sprite_3.gfxHandle().gfxHandleClip().gotoAndStop(1);
                     counter1 = counter2 = counter3 = 0;
                     ++PROGRESSION;
                     this.t_start = this.fish.yPos;
                     this.t_diff = 160;
                     this.t_time = 0.5;
                     this.t_tick = 0;
                     this.condition_1 = false;
                  }
               }
            }
            else if(PROGRESSION == 19)
            {
               if(counter1 >= 20)
               {
                  this.t_tick += 1 / 60;
                  if(this.t_tick >= this.t_time)
                  {
                     this.t_tick = this.t_time;
                     counter1 = 0;
                     ++PROGRESSION;
                  }
                  this.fish.yPos = Easings.easeInQuad(this.t_tick,this.t_start,this.t_diff,this.t_time);
               }
               if(this.condition_1 == false)
               {
                  if(this.fish.yPos >= 216)
                  {
                     this.condition_1 = true;
                     level.camera.verShake(6,0.95,0.5);
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fish.xPos + 24,Utils.SEA_LEVEL,0,0,0);
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fish.xPos,Utils.SEA_LEVEL,0,0,0);
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fish.xPos - 24,Utils.SEA_LEVEL,0,0,0);
                  }
               }
            }
            else if(PROGRESSION == 20)
            {
               this.fox.sprite.gfxHandle().gotoAndStop(3);
               this.fox.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               SoundSystem.PlaySound("fox_laugh");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene4_6"),this.fox,this.advance,30);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 22)
            {
               this.t_start = this.fox.xPos;
               this.t_diff = 160;
               this.t_time = 0.5;
               this.t_tick = 0;
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween2 = new VerTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween2.y_start = level.camera.y;
               this.cameraTween1.x_end = this.original_camera_xPos;
               this.cameraTween2.y_end = this.original_camera_yPos;
               if(this.cameraTween2.y_end + Utils.WIDTH >= 1712)
               {
                  this.cameraTween2.y_end = 1712 - Utils.WIDTH;
               }
               this.cameraTween1.time = this.cameraTween2.time = 0.75;
               this.cameraTween1.tick = this.cameraTween2.tick = 0;
               SoundSystem.PlaySound("dash");
               level.camera.changeHorBehaviour(this.cameraTween1);
               level.camera.changeVerBehaviour(this.cameraTween2);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 23)
            {
               if(counter1 % 2 == 0)
               {
                  foxParticle = new FoxBossEnemySprite();
                  foxParticle.alpha = 0.9;
                  foxParticle.gfxHandle().scaleX = 1;
                  foxParticle.gfxHandle().gotoAndStop(1);
                  foxParticle.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  level.particlesManager.pushBackParticle(foxParticle,this.fox.xPos,this.fox.yPos,0,0,0);
               }
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  counter1 = 0;
                  ++PROGRESSION;
                  level.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
                  SoundSystem.StopMusic();
               }
               this.fox.xPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else if(PROGRESSION == 24)
            {
               if(counter1 >= 30)
               {
                  this.fox.dead = true;
                  this.fish.dead = true;
                  level.setCameraBehaviours();
                  stateMachine.performAction("END_ACTION");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
      }
      
      override public function postUpdate() : void
      {
         super.postUpdate();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_8_8)
         {
            Utils.rootMovie.setChildIndex(this.text_container,Utils.rootMovie.numChildren - 1);
         }
      }
      
      protected function createKeyItem() : void
      {
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
         this.text_container = this.text = null;
         this.npc = null;
         this.door = null;
         this.pascal = this.rose = this.rigs = null;
         this.hero = level.hero;
         this.hero.xVel = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_1_1)
         {
            this.hero = level.hero;
            level.hero.sprite.visible = false;
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] == 0)
            {
               this.cat1 = new CatNPC(level,8,144,Entity.RIGHT,0,CatNPC.PASCAL);
            }
            else
            {
               this.cat1 = new CatNPC(level,8,144,Entity.RIGHT,0,CatNPC.ROSE);
            }
            this.rigs = new CatNPC(level,280,144,Entity.RIGHT,0,CatNPC.RIGS);
            level.npcsManager.npcs.push(this.rigs);
            level.npcsManager.npcs.push(this.cat1);
            this.rigs.updateScreenPosition(level.camera);
            this.cat1.updateScreenPosition(level.camera);
            for(i = 0; i < level.enemiesManager.enemies.length; i++)
            {
               if(level.enemiesManager.enemies[i] != null)
               {
                  if(level.enemiesManager.enemies[i].xPos <= 304)
                  {
                     level.enemiesManager.enemies[i].dead = true;
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_4)
         {
            this.hero = level.hero;
            SoundSystem.StopMusic();
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is CatNPC)
                  {
                     this.cat1 = level.npcsManager.npcs[i];
                  }
               }
            }
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_1)
            {
               level.levelData.setTileValueAt(65,9,5);
               level.levelData.setTileValueAt(68,8,5);
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_7_2)
         {
            this.hero = level.hero;
            SoundSystem.PlayMusic("bandits");
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is CutsceneNPC)
                  {
                     this.fox = level.npcsManager.npcs[i];
                  }
               }
            }
            this.fish = new CutsceneNPC(level,1624,336,Entity.LEFT,0,2);
            level.npcsManager.npcs.push(this.fish);
            this.fish.updateScreenPosition(level.camera);
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_11)
         {
            this.hero = level.hero;
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC)
                  {
                     this.npc = level.npcsManager.npcs[i];
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_7)
         {
            this.hero = level.hero;
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is ShopNPC)
                  {
                     this.shop_npc = level.npcsManager.npcs[i];
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_8)
         {
            this.hero = level.hero;
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is CatNPC)
                  {
                     if(CatNPC(level.npcsManager.npcs[i]).ID == CatNPC.ROSE)
                     {
                        this.cat1 = level.npcsManager.npcs[i];
                     }
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_6)
         {
            this.hero = level.hero;
            SoundSystem.StopMusic();
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is GenericNPC)
                  {
                     if(GenericNPC(level.npcsManager.npcs[i]).NPC_TYPE == GenericNPC.NPC_BEACH_2)
                     {
                        this.npc = level.npcsManager.npcs[i];
                     }
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_8_8)
         {
            for(i = 0; i < level.npcsManager.npcs.length; i++)
            {
               if(level.npcsManager.npcs[i] != null)
               {
                  if(level.npcsManager.npcs[i] is CutsceneNPC)
                  {
                     if(level.npcsManager.npcs[i].xPos <= 432)
                     {
                        this.lace = level.npcsManager.npcs[i];
                     }
                     else
                     {
                        this.fox = level.npcsManager.npcs[i];
                     }
                  }
               }
            }
            this.text_container = new Sprite();
            this.text_container.scaleX = this.text_container.scaleY = Utils.GFX_SCALE;
            Utils.rootMovie.addChild(this.text_container);
            this.text = new GameText(StringsManager.GetString("game_ending_continue"),GameText.TYPE_BIG);
            this.text_container.addChild(this.text);
            this.text.visible = false;
            this.text.x = int((Utils.WIDTH - this.text.WIDTH) * 0.5);
            this.text.y = int(Utils.HEIGHT * 0.5 - this.text.HEIGHT * 0.5);
         }
         this.condition_1 = false;
         this.condition_2 = false;
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_1_1)
         {
            Utils.Slot.gameProgression[9] = 1;
            SaveManager.SaveGameProgression();
            level.levelStart();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_1)
         {
            SoundSystem.PlayMusic("portobello");
            Utils.Slot.gameProgression[12] = 1;
            SaveManager.SaveGameProgression();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_4)
         {
            SoundSystem.PlayMusic("portobello");
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_7_2)
         {
            SoundSystem.PlayMusic("ocean");
            Utils.Slot.gameProgression[13] = 1;
            SaveManager.SaveGameProgression();
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_11)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 2;
            level.CHANGE_ROOM_FLAG = true;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_8)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 7;
            level.CHANGE_ROOM_FLAG = true;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_6)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 7;
            level.CHANGE_ROOM_FLAG = true;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_8_8)
         {
            Utils.Slot.gameProgression[14] = 2;
            SaveManager.SaveGameProgression();
            level.won();
         }
      }
   }
}
