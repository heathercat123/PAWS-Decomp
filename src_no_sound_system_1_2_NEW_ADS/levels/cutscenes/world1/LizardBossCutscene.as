package levels.cutscenes.world1
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.enemies.BossLizardEnemy;
   import entities.npcs.CutsceneNPC;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cameras.behaviours.VerTweenShiftBehaviour;
   import levels.collisions.PinkBlockCollision;
   import levels.cutscenes.*;
   import levels.worlds.world1.Level_1_8;
   import sprites.GameSprite;
   import sprites.cats.CatSprite;
   import sprites.enemies.FoxBossEnemySprite;
   import starling.display.MovieClip;
   
   public class LizardBossCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var lizardNPC:CutsceneNPC;
      
      protected var pinkBlocks:Vector.<PinkBlockCollision>;
      
      protected var lizardBossEnemy:BossLizardEnemy;
      
      protected var spinningDataDrive:MovieClip;
      
      protected var foxNPC:CutsceneNPC;
      
      protected var dataDrive_xPos:Number;
      
      protected var dataDrive_yPos:Number;
      
      protected var dataDrive_yVel:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var t_start_y:Number;
      
      protected var t_diff_y:Number;
      
      protected var xVel:Number;
      
      protected var lizard_xVel:Number;
      
      protected var IS_BOSS_DEAD:Boolean;
      
      protected var GO_LEFT:Boolean;
      
      public function LizardBossCutscene(_level:Level, isBossDead:Boolean = false)
      {
         this.IS_BOSS_DEAD = isBossDead;
         super(_level);
         this.GO_LEFT = false;
         this.dataDrive_yVel = 0;
         counter1 = counter2 = counter3 = 0;
         this.xVel = this.lizard_xVel = 0;
         this.t_start = this.t_diff = this.t_tick = this.t_time = this.t_start_y = this.t_diff_y = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.spinningDataDrive != null)
         {
            Utils.topWorld.removeChild(this.spinningDataDrive);
            this.spinningDataDrive.dispose();
            this.spinningDataDrive = null;
         }
         this.hero = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var hor_tweenShift:HorTweenShiftBehaviour = null;
         var ver_tweenShift:VerTweenShiftBehaviour = null;
         var foxParticle:FoxBossEnemySprite = null;
         ++counter1;
         if(this.IS_BOSS_DEAD)
         {
            if(PROGRESSION == 0)
            {
               if(Utils.Slot.gameProgression[8] == 1)
               {
                  PROGRESSION = 10;
                  this.spinningDataDrive.visible = true;
               }
               else if(this.lizardBossEnemy.dead)
               {
                  this.lizardBossEnemy = null;
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               if(counter1 > 15)
               {
                  counter1 = 0;
                  this.pinkBlocks[counter2++].explode();
                  if(counter2 >= this.pinkBlocks.length)
                  {
                     counter1 = counter2 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               level.camera.LEFT_MARGIN = level.camera.xPos;
               level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level),true);
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
            else if(PROGRESSION == 10)
            {
               if(this.hero.xPos > 800)
               {
                  this.GO_LEFT = true;
               }
               else
               {
                  this.GO_LEFT = false;
               }
               this.t_start = this.dataDrive_xPos;
               this.t_diff = 752 - this.t_start;
               this.t_start_y = this.dataDrive_yPos;
               this.t_diff_y = 240 - this.t_start_y;
               this.t_tick = 0;
               this.t_time = 1;
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 11)
            {
               if(!Utils.FreezeOn && this.lizardBossEnemy.dead)
               {
                  this.t_tick += 1 / 60;
                  if(this.t_tick >= this.t_time)
                  {
                     this.t_tick = this.t_time;
                  }
               }
               this.dataDrive_xPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
               this.dataDrive_yPos = Easings.easeOutBack(this.t_tick,this.t_start_y,this.t_diff_y,this.t_time);
               if(this.GO_LEFT)
               {
                  level.leftPressed = true;
                  level.rightPressed = false;
                  if(this.hero.xPos <= 800)
                  {
                     this.hero.xPos = 800;
                     this.hero.xVel = 0;
                     this.hero.DIRECTION = Entity.LEFT;
                     level.leftPressed = false;
                     this.hero.stateMachine.setState("IS_STANDING_STATE");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else
               {
                  level.leftPressed = false;
                  level.rightPressed = true;
                  if(this.hero.xPos >= 800)
                  {
                     this.hero.xPos = 800;
                     this.hero.xVel = 0;
                     this.hero.DIRECTION = Entity.LEFT;
                     level.rightPressed = false;
                     this.hero.stateMachine.setState("IS_STANDING_STATE");
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 12)
            {
               if(!Utils.FreezeOn && this.lizardBossEnemy.dead)
               {
                  this.t_tick += 1 / 60;
                  if(this.t_tick >= this.t_time)
                  {
                     this.t_tick = this.t_time;
                     this.spinningDataDrive.currentFrame = 7;
                     this.spinningDataDrive.pause();
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               this.dataDrive_xPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
               this.dataDrive_yPos = Easings.easeOutBack(this.t_tick,this.t_start_y,this.t_diff_y,this.t_time);
            }
            else if(PROGRESSION == 13)
            {
               if(counter1++ > 15)
               {
                  this.dataDrive_yVel += 0.2;
                  if(this.dataDrive_yVel >= 8)
                  {
                     this.dataDrive_yVel = 8;
                  }
                  this.dataDrive_yPos += this.dataDrive_yVel;
                  if(this.dataDrive_yPos >= 320 - 5)
                  {
                     this.dataDrive_yPos = 320 - 5;
                     this.dataDrive_yVel = -2;
                     ++counter2;
                     SoundSystem.PlaySound("seed_impact");
                     if(counter2 >= 2)
                     {
                        counter1 = 0;
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 14)
            {
               this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene9_0"),this.hero,this.advance,20);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 16)
            {
               this.foxNPC.sprite.gfxHandle().gotoAndStop(2);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 17)
            {
               this.foxNPC.yPos += 6;
               if(this.foxNPC.yPos >= 320 - 16)
               {
                  SoundSystem.PlaySound("enemy_jump_low");
                  this.foxNPC.sprite.gfxHandle().gotoAndStop(1);
                  this.foxNPC.yPos = 320 - 16;
                  SoundSystem.PlayMusic("bandits");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene9_1"),this.foxNPC,this.advance,30);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 19)
            {
               SoundSystem.PlaySound("fox_laugh");
               this.foxNPC.sprite.gfxHandle().gotoAndStop(3);
               this.foxNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 20)
            {
               if(counter1 >= 60)
               {
                  this.t_start = this.foxNPC.xPos;
                  this.t_diff = int(level.hero.xPos + 24 - this.t_start);
                  this.t_time = 0.25;
                  this.t_tick = 0;
                  this.foxNPC.DIRECTION = Entity.LEFT;
                  this.foxNPC.sprite.gfxHandle().gotoAndStop(1);
                  counter1 = 0;
                  ++PROGRESSION;
                  SoundSystem.PlaySound("dash");
               }
            }
            else if(PROGRESSION == 21)
            {
               if(counter1 % 2 == 0)
               {
                  foxParticle = new FoxBossEnemySprite();
                  foxParticle.alpha = 0.9;
                  foxParticle.gfxHandle().scaleX = 1;
                  foxParticle.gfxHandle().gotoAndStop(1);
                  foxParticle.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  level.particlesManager.pushBackParticle(foxParticle,this.foxNPC.xPos,this.foxNPC.yPos,0,0,0);
               }
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               this.foxNPC.xPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else if(PROGRESSION == 22)
            {
               if(counter1 == 1)
               {
                  this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               }
               else if(counter1 >= 15)
               {
                  this.foxNPC.setEmotionParticle(Entity.EMOTION_LOVE);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 23)
            {
               if(counter1 >= 30)
               {
                  this.foxNPC.sprite.gfxHandle().gotoAndStop(3);
                  this.foxNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene9_2"),this.foxNPC,this.advance,0);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 25)
            {
               this.foxNPC.sprite.gfxHandle().gotoAndStop(1);
               this.foxNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               this.t_start = this.foxNPC.xPos;
               this.t_diff = -100;
               this.t_time = 0.125;
               this.t_tick = 0;
               this.foxNPC.DIRECTION = Entity.RIGHT;
               SoundSystem.PlaySound("dash");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 26)
            {
               if(counter1 % 2 == 0)
               {
                  foxParticle = new FoxBossEnemySprite();
                  foxParticle.alpha = 0.9;
                  foxParticle.gfxHandle().scaleX = -1;
                  foxParticle.gfxHandle().gotoAndStop(1);
                  foxParticle.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  level.particlesManager.pushBackParticle(foxParticle,this.foxNPC.xPos,this.foxNPC.yPos,0,0,0);
               }
               if(counter1 == 2)
               {
                  SoundSystem.PlaySound("cat_hurt");
                  level.camera.shake();
                  this.hero.sprite.gfxHandle().gotoAndStop(12);
                  this.hero.sprite.gfxHandle().y = this.hero.sprite.gfxHandle().y + 2;
                  this.hero.stun();
                  level.particlesManager.hurtImpactParticle(level.hero,level.hero.xPos + level.hero.WIDTH,level.hero.getMidYPos());
               }
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               this.foxNPC.xPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else if(PROGRESSION == 27)
            {
               if(counter1 >= 90)
               {
                  SoundSystem.PlaySound("fox_laugh");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene9_3"),this.foxNPC,this.advance);
                  this.foxNPC.sprite.gfxHandle().gotoAndStop(3);
                  this.foxNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 29)
            {
               this.spinningDataDrive.visible = false;
               this.foxNPC.sprite.gfxHandle().gotoAndStop(2);
               SoundSystem.PlaySound("woosh");
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 30)
            {
               this.foxNPC.yPos -= 6;
               this.foxNPC.xPos += 4;
               if(this.foxNPC.yPos <= level.camera.yPos - 24)
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  this.hero.sprite.gfxHandle().y = this.hero.sprite.gfxHandle().y - 2;
                  this.hero.stateMachine.setState("IS_STANDING_STATE");
               }
            }
            else if(PROGRESSION == 31)
            {
               if(counter1 == 5)
               {
                  this.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
               }
               else if(counter1 >= 30)
               {
                  counter1 = 0;
                  counter2 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 32)
            {
               if(counter1 > 15)
               {
                  counter1 = 0;
                  this.pinkBlocks[counter2++].explode();
                  if(counter2 >= this.pinkBlocks.length)
                  {
                     this.hero.stateMachine.setState("IS_TURNING_STATE");
                     counter1 = counter2 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 33)
            {
               if(this.hero.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.foxNPC.dead = true;
                  level.camera.LEFT_MARGIN = level.camera.xPos;
                  level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level),true);
                  SoundSystem.StopMusic();
                  stateMachine.performAction("END_ACTION");
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 0)
         {
            level.rightPressed = true;
            hor_tweenShift = new HorTweenShiftBehaviour(level);
            hor_tweenShift.x_start = level.camera.x;
            hor_tweenShift.x_end = 752 - Utils.WIDTH * 0.5;
            hor_tweenShift.tick = 0;
            hor_tweenShift.time = 1.5;
            level.camera.changeHorBehaviour(hor_tweenShift,true);
            ++PROGRESSION;
         }
         else if(PROGRESSION == 1)
         {
            level.rightPressed = true;
            if(this.hero.xPos >= 672)
            {
               this.hero.xPos = 672;
               this.hero.xVel = 0;
               this.hero.stateMachine.setState("IS_STANDING_STATE");
               level.rightPressed = false;
               this.initBricks();
               ++PROGRESSION;
               counter1 = counter2 = 0;
            }
         }
         else if(PROGRESSION == 2)
         {
            if(Math.abs(level.camera.xPos - (752 - Utils.WIDTH * 0.5)) < 2)
            {
               if(counter1 > 15)
               {
                  counter1 = 0;
                  this.pinkBlocks[counter2++].appear();
                  if(counter2 >= this.pinkBlocks.length)
                  {
                     counter1 = counter2 = 0;
                     if(Utils.Slot.gameProgression[8] == 0)
                     {
                        PROGRESSION = 3;
                     }
                     else
                     {
                        PROGRESSION = 50;
                     }
                  }
               }
            }
         }
         else if(PROGRESSION == 3)
         {
            CatSprite(this.hero.sprite).playSpecialAnim(CatSprite.LOOK_UP);
            this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 4)
         {
            if(counter1 >= 60)
            {
               hor_tweenShift = new HorTweenShiftBehaviour(level);
               hor_tweenShift.x_start = level.camera.x;
               hor_tweenShift.x_end = 816 - Utils.WIDTH * 0.5;
               hor_tweenShift.tick = 0;
               hor_tweenShift.time = 0.5;
               level.camera.changeHorBehaviour(hor_tweenShift,true);
               ver_tweenShift = new VerTweenShiftBehaviour(level);
               ver_tweenShift.y_start = level.camera.y;
               ver_tweenShift.y_end = 192 + level.camera.getVerticalOffsetFromGroundLevel() - Utils.HEIGHT;
               ver_tweenShift.tick = 0;
               ver_tweenShift.time = 0.5;
               level.camera.changeVerBehaviour(ver_tweenShift,true);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 5)
         {
            if(counter1 >= 40)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene8_1"),this.lizardNPC,this.advance);
               level.camera.shake();
               SoundSystem.PlaySound("explosion_medium");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 7)
         {
            if(counter1 == 1)
            {
               SoundSystem.PlaySound("mesa_snarl");
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(3);
               this.lizardNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            else if(counter1 == 30)
            {
               SoundSystem.PlaySound("woosh");
               level.particlesManager.createDust(this.lizardNPC.xPos + 8,this.lizardNPC.yPos + 32,Entity.LEFT);
               level.particlesManager.createDust(this.lizardNPC.xPos + 32 - 8,this.lizardNPC.yPos + 32,Entity.RIGHT);
               level.camera.shake();
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
               ver_tweenShift = new VerTweenShiftBehaviour(level);
               ver_tweenShift.y_start = level.camera.y;
               ver_tweenShift.y_end = 0;
               ver_tweenShift.tick = 0;
               ver_tweenShift.time = 0.25;
               level.camera.changeVerBehaviour(ver_tweenShift,true);
               hor_tweenShift = new HorTweenShiftBehaviour(level);
               hor_tweenShift.x_start = level.camera.x;
               hor_tweenShift.x_end = 752 - Utils.WIDTH * 0.5;
               hor_tweenShift.tick = 0;
               hor_tweenShift.time = 0.5;
               level.camera.changeHorBehaviour(hor_tweenShift,true);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 8)
         {
            this.lizardNPC.yPos -= 12;
            if(counter1 >= 60)
            {
               counter1 = 0;
               ++PROGRESSION;
               ver_tweenShift = new VerTweenShiftBehaviour(level);
               ver_tweenShift.y_start = level.camera.y;
               ver_tweenShift.y_end = 320 + level.camera.getVerticalOffsetFromGroundLevel() - Utils.HEIGHT;
               ver_tweenShift.tick = 0;
               ver_tweenShift.time = 0.5;
               level.camera.changeVerBehaviour(ver_tweenShift,true);
            }
         }
         else if(PROGRESSION == 9)
         {
            this.lizardNPC.yPos -= 12;
            if(counter1 >= 40)
            {
               this.createLizardBoss();
               this.lizardNPC.dead = true;
               this.hero.stateMachine.setState("IS_STANDING_STATE");
               counter1 = counter2 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 10)
         {
            if(this.lizardBossEnemy.stateMachine.currentState == "IS_INTRO_IMPACT_STATE")
            {
               ++counter2;
               if(counter2 == 1)
               {
                  SoundSystem.PlaySound("ground_stomp");
               }
               if(counter2 >= 90)
               {
                  SoundSystem.PlaySound("enemy_jump_low");
                  this.lizardBossEnemy.stateMachine.performAction("END_ACTION");
                  this.lizardBossEnemy.yPos = 256;
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 11)
         {
            if(counter1 >= 60)
            {
               level.hud.catUnlockManager.showBossScene(0);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 12)
         {
            if(level.hud.catUnlockManager.unlockScene == null)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 13)
         {
            SoundSystem.PlaySound("mesa_snarl");
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene8_2"),this.lizardBossEnemy,this.advance);
            this.lizardBossEnemy.sprite.gfxHandle().gotoAndStop(2);
            this.lizardBossEnemy.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 15)
         {
            PROGRESSION = 52;
            this.lizardBossEnemy.yPos -= 24;
            counter1 = 0;
         }
         else if(PROGRESSION == 50)
         {
            if(counter1 >= 40)
            {
               this.createLizardBoss();
               this.hero.stateMachine.setState("IS_STANDING_STATE");
               counter1 = counter2 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 51)
         {
            if(this.lizardBossEnemy.stateMachine.currentState == "IS_INTRO_IMPACT_STATE")
            {
               ++counter2;
               if(counter2 == 1)
               {
                  SoundSystem.PlaySound("ground_stomp");
               }
               if(counter2 >= 90)
               {
                  SoundSystem.PlaySound("enemy_jump_low");
                  this.lizardBossEnemy.stateMachine.performAction("END_ACTION");
                  this.lizardBossEnemy.yPos = 256;
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 52)
         {
            if(counter1 > 15)
            {
               this.lizardBossEnemy.stateMachine.setState("IS_STANDING_STATE");
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
      }
      
      protected function createLizardBoss() : void
      {
         this.lizardBossEnemy = new BossLizardEnemy(level,784,level.camera.yPos - 32,Entity.LEFT);
         this.lizardBossEnemy.stateMachine.setState("IS_FALLING_FROM_SKY_STATE");
         this.lizardBossEnemy.updateScreenPosition(level.camera);
         level.enemiesManager.enemies.push(this.lizardBossEnemy);
         Level_1_8(level).lizardBoss = this.lizardBossEnemy;
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
         SoundSystem.StopMusic(false,false);
         this.hero = level.hero;
         this.lizardNPC = null;
         this.spinningDataDrive = null;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is CutsceneNPC)
               {
                  this.lizardNPC = level.npcsManager.npcs[i];
               }
            }
         }
         if(this.IS_BOSS_DEAD)
         {
            for(i = 0; i < level.enemiesManager.enemies.length; i++)
            {
               if(level.enemiesManager.enemies[i] != null)
               {
                  if(level.enemiesManager.enemies[i] is BossLizardEnemy)
                  {
                     this.lizardBossEnemy = level.enemiesManager.enemies[i] as BossLizardEnemy;
                  }
               }
            }
            this.fetchPinkBlocks();
            this.spinningDataDrive = new MovieClip(TextureManager.sTextureAtlas.getTextures("dataDriveSpinAnim_"));
            this.spinningDataDrive.pivotX = this.spinningDataDrive.pivotY = 8;
            this.spinningDataDrive.touchable = false;
            Utils.juggler.add(this.spinningDataDrive);
            Utils.topWorld.addChild(this.spinningDataDrive);
            this.spinningDataDrive.visible = false;
            if(this.lizardBossEnemy.DIRECTION == Entity.LEFT)
            {
               this.dataDrive_xPos = this.lizardBossEnemy.xPos + 0;
            }
            else
            {
               this.dataDrive_xPos = this.lizardBossEnemy.xPos + 30;
            }
            this.dataDrive_yPos = this.lizardBossEnemy.yPos + 9;
            for(i = 0; i < 8; i++)
            {
               this.spinningDataDrive.setFrameDuration(i,0.1);
            }
            this.foxNPC = new CutsceneNPC(level,672,level.camera.yPos - 32,Entity.RIGHT,0,CutsceneNPC.BOSS_FOX);
            level.npcsManager.npcs.push(this.foxNPC);
            this.foxNPC.updateScreenPosition(level.camera);
         }
      }
      
      protected function initBricks() : void
      {
         var block:PinkBlockCollision = null;
         var i:int = 0;
         this.pinkBlocks = new Vector.<PinkBlockCollision>();
         block = new PinkBlockCollision(level,608,272,0,1);
         this.pinkBlocks.push(block);
         block = new PinkBlockCollision(level,608,272 + 16,0,1);
         this.pinkBlocks.push(block);
         block = new PinkBlockCollision(level,608,272 + 32,0,1);
         this.pinkBlocks.push(block);
         for(i = 0; i < this.pinkBlocks.length; i++)
         {
            this.pinkBlocks[i].updateScreenPosition(level.camera);
            level.collisionsManager.collisions.push(this.pinkBlocks[i]);
         }
      }
      
      protected function fetchPinkBlocks() : void
      {
         var i:int = 0;
         this.pinkBlocks = new Vector.<PinkBlockCollision>();
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is PinkBlockCollision)
               {
                  if(level.collisionsManager.collisions[i].xPos >= 832)
                  {
                     this.pinkBlocks.push(level.collisionsManager.collisions[i] as PinkBlockCollision);
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.spinningDataDrive != null)
         {
            this.spinningDataDrive.x = int(Math.floor(this.dataDrive_xPos - camera.xPos));
            this.spinningDataDrive.y = int(Math.floor(this.dataDrive_yPos - camera.yPos));
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(this.IS_BOSS_DEAD)
         {
            SoundSystem.PlayMusic("outside_desert");
            if(Utils.Slot.gameProgression[8] == 1)
            {
               Utils.Slot.gameProgression[8] = 2;
               SaveManager.SaveGameProgression();
            }
         }
         else
         {
            SoundSystem.PlayMusic("boss");
            if(Utils.Slot.gameProgression[8] == 0)
            {
               Utils.Slot.gameProgression[8] = 1;
               SaveManager.SaveGameProgression();
            }
         }
      }
   }
}
