package levels.cutscenes.world2
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.enemies.BossFishEnemy;
   import entities.npcs.CutsceneNPC;
   import game_utils.GameSlot;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cameras.behaviours.VerTweenShiftBehaviour;
   import levels.collisions.PinkBlockCollision;
   import levels.cutscenes.*;
   import levels.worlds.world2.Level_2_8;
   import sprites.GameSprite;
   import sprites.particles.SplashParticleSprite;
   
   public class FishBossCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var fishNPC:CutsceneNPC;
      
      protected var pinkBlocks:Vector.<PinkBlockCollision>;
      
      protected var fishBossEnemy:BossFishEnemy;
      
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
      
      protected var xVel:Number;
      
      protected var lizard_xVel:Number;
      
      protected var IS_BOSS_DEAD:Boolean;
      
      protected var GO_LEFT:Boolean;
      
      protected var QUICK_VERSION:Boolean;
      
      public function FishBossCutscene(_level:Level, isBossDead:Boolean = false)
      {
         this.IS_BOSS_DEAD = isBossDead;
         if(Utils.Slot.gameProgression[14] == 0)
         {
            this.QUICK_VERSION = false;
         }
         else
         {
            this.QUICK_VERSION = true;
         }
         super(_level);
         this.condition_1 = false;
         this.GO_LEFT = false;
         counter1 = counter2 = counter3 = 0;
         this.xVel = this.lizard_xVel = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = this.t_start_2 = this.t_diff_2 = this.t_time_2 = this.t_tick_2 = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var hor_tweenShift:HorTweenShiftBehaviour = null;
         var ver_tweenShift:VerTweenShiftBehaviour = null;
         var foo_1:int = 0;
         ++counter1;
         if(this.IS_BOSS_DEAD)
         {
            if(PROGRESSION == 0)
            {
               if(this.fishBossEnemy.dead)
               {
                  this.fishBossEnemy = null;
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
                  if(Utils.Slot.gameProgression[14] == 1)
                  {
                     PROGRESSION = 100;
                  }
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
                     ver_tweenShift = new VerTweenShiftBehaviour(level);
                     ver_tweenShift.y_start = level.camera.y;
                     ver_tweenShift.y_end = 160 + level.camera.getVerticalOffsetFromGroundLevel() - int(level.camera.HEIGHT);
                     ver_tweenShift.time = 0.25;
                     ver_tweenShift.tick = 0;
                     level.camera.changeVerBehaviour(ver_tweenShift);
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
            else if(PROGRESSION == 100)
            {
               if(counter1 >= 60)
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_4"),level.hero,this.advance);
               }
            }
            else if(PROGRESSION == 102)
            {
               level.hud.showDarkFade(60);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 103)
            {
               if(counter1 >= 60)
               {
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
                     PROGRESSION = 3;
                  }
               }
            }
         }
         else if(PROGRESSION == 3)
         {
            ver_tweenShift = new VerTweenShiftBehaviour(level);
            ver_tweenShift.y_start = level.camera.y;
            ver_tweenShift.y_end = 192 + level.camera.getVerticalOffsetFromGroundLevel() - int(level.camera.HEIGHT);
            ver_tweenShift.time = 2;
            ver_tweenShift.tick = 0;
            level.camera.changeVerBehaviour(ver_tweenShift);
            this.t_time = 1.5;
            this.t_start = this.fishNPC.yPos;
            this.t_diff = 184 - this.t_start;
            this.t_tick = 0;
            this.t_start_2 = 0;
            this.t_diff_2 = 2;
            this.t_time_2 = 2.5;
            this.t_tick_2 = 0;
            SoundSystem.PlaySound("giant_fish_swoosh");
            ++PROGRESSION;
            counter1 = 0;
         }
         else if(PROGRESSION == 4)
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
            this.fishNPC.yPos = Easings.easeOutBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
            level.camera.shake(Easings.linear(this.t_tick_2 + 1,this.t_start_2,this.t_diff_2,this.t_time_2),true);
            if(foo_1 >= 2)
            {
               if(this.QUICK_VERSION)
               {
                  counter1 = 0;
                  PROGRESSION = 12;
               }
               else
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_0"),this.fishNPC,this.advance);
               }
            }
         }
         else if(PROGRESSION == 6)
         {
            counter1 = 0;
            ++PROGRESSION;
            level.hud.catUnlockManager.showBossScene(1);
         }
         else if(PROGRESSION == 7)
         {
            if(level.hud.catUnlockManager.unlockScene == null)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 8)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_1_" + Hero.GetCurrentCat()),this.hero,this.advance,15);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 10)
         {
            if(Hero.GetCurrentCat() == Hero.CAT_PASCAL)
            {
               SoundSystem.PlaySound("giant_fish_roar");
               SoundSystem.PlaySound("explosion_medium");
               level.camera.shake();
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_3"),this.fishNPC,this.advance);
            }
            else
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene5_2"),this.fishNPC,this.advance);
            }
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 12)
         {
            this.t_start = this.fishNPC.yPos;
            this.t_diff = 128 - this.t_start;
            this.t_time = 0.5;
            this.t_tick = 0;
            counter1 = 0;
            ++PROGRESSION;
            SoundSystem.PlaySound("geyser");
            this.condition_1 = false;
         }
         else if(PROGRESSION == 13)
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
               if(this.fishNPC.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.condition_1 = true;
                  level.camera.verShake(6,0.9,0.5);
                  SoundSystem.PlaySound("water_splash");
                  level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fishNPC.xPos + 24,Utils.SEA_LEVEL,0,0,0);
                  level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fishNPC.xPos,Utils.SEA_LEVEL,0,0,0);
                  level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fishNPC.xPos - 24,Utils.SEA_LEVEL,0,0,0);
               }
            }
            this.fishNPC.sin_counter_2 = 0;
            this.fishNPC.yPos = Easings.easeInBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(PROGRESSION == 14)
         {
            ++counter2;
            if(counter2 >= 5)
            {
               ++counter3;
               counter2 = 0;
               this.fishNPC.sprite.rotation -= Math.PI * 0.25;
               if(counter3 == 1 || counter3 == 5 || counter3 == 9)
               {
                  SoundSystem.PlaySound("wing");
               }
               if(counter3 >= 10)
               {
                  this.fishNPC.sprite_3.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  counter1 = counter2 = counter3 = 0;
                  ++PROGRESSION;
                  this.t_start = this.fishNPC.yPos;
                  this.t_diff = 160;
                  this.t_time = 0.5;
                  this.t_tick = 0;
                  this.condition_1 = false;
               }
            }
         }
         else if(PROGRESSION == 15)
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
               this.fishNPC.yPos = Easings.easeInQuad(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            if(this.condition_1 == false)
            {
               if(this.fishNPC.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.condition_1 = true;
                  level.camera.verShake(6,0.95,0.5);
                  SoundSystem.PlaySound("water_splash");
                  level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fishNPC.xPos + 24,Utils.SEA_LEVEL,0,0,0);
                  level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fishNPC.xPos,Utils.SEA_LEVEL,0,0,0);
                  level.topParticlesManager.pushParticle(new SplashParticleSprite(0),this.fishNPC.xPos - 24,Utils.SEA_LEVEL,0,0,0);
               }
            }
         }
         else if(PROGRESSION == 16)
         {
            this.createFishBoss();
            this.fishNPC.dead = true;
            this.fishNPC = null;
            counter1 = counter2 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 17)
         {
            this.fishBossEnemy.stateMachine.setState("IS_UNDERWATER_STATE");
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
         }
      }
      
      protected function createFishBoss() : void
      {
         this.fishBossEnemy = new BossFishEnemy(level,800,304,Entity.LEFT);
         this.fishBossEnemy.updateScreenPosition(level.camera);
         level.enemiesManager.enemies.push(this.fishBossEnemy);
         Level_2_8(level).fishBoss = this.fishBossEnemy;
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
         SoundSystem.StopMusic();
         this.hero = level.hero;
         this.fishNPC = null;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is CutsceneNPC)
               {
                  this.fishNPC = level.npcsManager.npcs[i];
               }
            }
         }
         if(this.IS_BOSS_DEAD)
         {
            for(i = 0; i < level.enemiesManager.enemies.length; i++)
            {
               if(level.enemiesManager.enemies[i] != null)
               {
                  if(level.enemiesManager.enemies[i] is BossFishEnemy)
                  {
                     this.fishBossEnemy = level.enemiesManager.enemies[i] as BossFishEnemy;
                  }
               }
            }
            this.fetchPinkBlocks();
         }
      }
      
      protected function initBricks() : void
      {
         var block:PinkBlockCollision = null;
         var i:int = 0;
         this.pinkBlocks = new Vector.<PinkBlockCollision>();
         block = new PinkBlockCollision(level,608,112,0,1);
         this.pinkBlocks.push(block);
         block = new PinkBlockCollision(level,608,112 + 16,0,1);
         this.pinkBlocks.push(block);
         block = new PinkBlockCollision(level,608,112 + 32,0,1);
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
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(this.IS_BOSS_DEAD)
         {
            if(Utils.Slot.gameProgression[14] == 1)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
               level.CHANGE_ROOM_FLAG = true;
            }
         }
         else
         {
            SoundSystem.PlayMusic("boss");
            if(Utils.Slot.gameProgression[14] == 0)
            {
               Utils.Slot.gameProgression[14] = 1;
               SaveManager.SaveGameProgression();
            }
         }
      }
   }
}
