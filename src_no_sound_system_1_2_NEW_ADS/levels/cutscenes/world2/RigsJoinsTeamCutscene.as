package levels.cutscenes.world2
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.CatNPC;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cutscenes.Cutscene;
   import levels.cutscenes.LevelIntroCutscene;
   import sprites.npcs.*;
   import sprites.particles.GenericParticleSprite;
   import starling.display.*;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class RigsJoinsTeamCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var rigs:CatNPC;
      
      protected var pascal:CatNPC;
      
      protected var rose:CatNPC;
      
      protected var mcMeow:CatNPC;
      
      protected var cameraTween1:HorTweenShiftBehaviour;
      
      protected var helicopterContainer:Sprite;
      
      protected var helicopterBody:Image;
      
      protected var catSprite:GenericNPCSprite;
      
      protected var helicopterBack:Image;
      
      protected var helicopterScrew:Image;
      
      protected var helicopterPropeller1:Image;
      
      protected var helicopterPropeller2:Image;
      
      protected var helicopter_counter1:int;
      
      protected var helicopter_sin:Number;
      
      protected var ropeContainer:Sprite;
      
      protected var ropeTile1:Image;
      
      protected var ropeTile2:Image;
      
      protected var ropeTile3:Image;
      
      protected var rope_yPos:Number;
      
      protected var cutscene_y_offset:Number;
      
      protected var tile_sin_counter:Number;
      
      protected var tile_sin_radius:Number;
      
      protected var helicopter_xPos:Number;
      
      protected var helicopter_yPos:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var particle_counter_1:Number;
      
      protected var particle_counter_2:Number;
      
      protected var wind_power:Number;
      
      protected var justOnce:Boolean;
      
      protected var justOnce2:Boolean;
      
      protected var spring_force:Number;
      
      protected var mcMeow_yDiff:Number;
      
      protected var IS_STRONG_WIND:Boolean;
      
      protected var wind_counter_1:int;
      
      protected var wind_counter_2:int;
      
      public function RigsJoinsTeamCutscene(_level:Level)
      {
         super(_level);
         this.cutscene_y_offset = 0;
         counter1 = counter2 = counter3 = 0;
         this.tile_sin_counter = this.tile_sin_radius = 0;
         this.helicopter_counter1 = this.wind_counter_1 = this.wind_counter_2 = 0;
         this.IS_STRONG_WIND = false;
         this.helicopter_xPos = 416;
         this.helicopter_yPos = 0;
         this.justOnce = this.justOnce2 = true;
         this.rope_yPos = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.particle_counter_1 = this.particle_counter_2 = 0;
         this.wind_power = this.spring_force = this.helicopter_sin = 0;
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GenericParticleSprite = null;
         var condition:int = 0;
         ++counter1;
         if(PROGRESSION == 0)
         {
            if(counter1 >= 120)
            {
               counter1 = 0;
               ++PROGRESSION;
               SoundSystem.PlaySound("cat_run");
               this.pascal.stateMachine.setState("IS_WALKING_STATE");
               this.rose.stateMachine.setState("IS_WALKING_STATE");
               this.rose.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(3);
            }
            if(counter1 == 90)
            {
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 336 - Utils.WIDTH * 0.5;
               this.cameraTween1.time = 4;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
            }
         }
         else if(PROGRESSION == 1)
         {
            if(this.pascal.xPos >= 224)
            {
               this.pascal.stateMachine.setState("IS_STANDING_STATE");
               this.pascal.xPos = 224;
               this.pascal.xVel = 0;
            }
            if(this.rose.xPos >= 256)
            {
               this.rose.stateMachine.setState("IS_STANDING_STATE");
               this.rose.xPos = 256;
               this.rose.xVel = 0;
               counter1 = 0;
               ++PROGRESSION;
               this.t_start = 0;
               this.t_diff = 128;
               this.t_time = 5;
               this.t_tick = 0;
            }
            if(counter1 == 75)
            {
               this.rigs.setEmotionParticle(Entity.EMOTION_SHOCKED);
            }
         }
         else if(PROGRESSION == 2)
         {
            SoundSystem.StopMusic(false);
            SoundSystem.PlaySound("giant_spaceship");
            this.t_start = 0;
            this.t_diff = 112 + 8;
            this.t_time = 3;
            this.t_tick = 0;
            this.spring_force = 1;
            this.rigs.stateMachine.setState("IS_STANDING_STATE");
            this.rigs.changeDirection();
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 3)
         {
            if(counter1 >= 10)
            {
               this.rigs.stateMachine.setState("IS_WALKING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 4)
         {
            if(this.rigs.xPos <= this.rose.xPos + 32)
            {
               this.wind_counter_1 = 0;
               this.rigs.xPos = this.rose.xPos + 32;
               this.rigs.xVel = 0;
               this.rigs.changeDirection();
               this.rigs.stateMachine.setState("IS_STANDING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 6)
         {
            SoundSystem.PlayMusic("cutscene_danger");
            this.t_start = this.helicopter_yPos;
            this.t_diff = -40;
            this.t_time = 2;
            this.t_tick = 0;
            counter1 = 0;
            ++PROGRESSION;
            Utils.world.setChildIndex(this.ropeContainer,Utils.world.numChildren - 1);
            Utils.world.setChildIndex(this.mcMeow.sprite,Utils.world.numChildren - 1);
            Utils.world.setChildIndex(this.helicopterContainer,Utils.world.numChildren - 1);
         }
         else if(PROGRESSION == 8)
         {
            this.rope_yPos += 4;
            if(this.rope_yPos >= 48)
            {
               this.rope_yPos = 48;
            }
            if(this.rope_yPos >= 16)
            {
               this.mcMeow.xPos = 404 + 4;
               if(this.rope_yPos >= 16)
               {
                  this.mcMeow.yPos += 2;
                  if(this.mcMeow.yPos >= 128)
                  {
                     SoundSystem.PlaySound("cat_falls_ground_low");
                     this.mcMeow.yPos = 128;
                     PROGRESSION = 10;
                     counter1 = 0;
                  }
               }
            }
         }
         else if(PROGRESSION == 10)
         {
            if(counter1 >= 10)
            {
               SoundSystem.PlaySound("cat_jump_low");
               this.mcMeow.sprite.gfxHandle().gotoAndStop(4);
               this.mcMeow.sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               this.mcMeow.gravity_friction = 1;
               this.mcMeow.xVel = -4;
               this.mcMeow.yVel = -4;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 11)
         {
            if(this.mcMeow.yPos >= 144)
            {
               SoundSystem.PlaySound("cat_falls_ground_low");
               this.mcMeow.xVel = this.mcMeow.yVel = 0;
               this.mcMeow.stateMachine.setState("IS_STANDING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 12)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_1"),this.mcMeow,this.advance,15);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 14)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_2"),this.mcMeow,this.advance,30);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 16)
         {
            this.mcMeow.sprite.gfxHandle().gotoAndStop(14);
            this.mcMeow.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            this.mcMeow.sprite.gfxHandle().gfxHandleClip().setFrameDuration(5,0);
            this.mcMeow.sprite.gfxHandle().gfxHandleClip().setFrameDuration(6,0);
            this.mcMeow.sprite.gfxHandle().gfxHandleClip().setFrameDuration(7,0);
            this.mcMeow.sprite.gfxHandle().gfxHandleClip().setFrameDuration(8,0);
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_3"),this.mcMeow,this.advance);
            SoundSystem.PlaySound("cat_mcmeow");
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 18)
         {
            this.mcMeow.sprite.gfxHandle().gotoAndStop(1);
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_4"),this.rigs,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 20)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_5"),this.mcMeow,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 22)
         {
            this.rigs.setEmotionParticle(Entity.EMOTION_SHOCKED);
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_6"),this.rigs,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 24)
         {
            this.mcMeow.stateMachine.setState("IS_STANDING_STATE");
            this.mcMeow.sprite.gfxHandle().gotoAndStop(14);
            this.mcMeow.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_7"),this.mcMeow,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 26)
         {
            this.mcMeow.changeDirection();
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 27)
         {
            if(this.mcMeow.DIRECTION == Entity.RIGHT)
            {
               SoundSystem.PlaySound("cat_run_low");
               this.mcMeow.stateMachine.setState("IS_WALKING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 28)
         {
            if(this.mcMeow.xPos >= 384)
            {
               this.mcMeow.stateMachine.setState("IS_STANDING_STATE");
               this.mcMeow.changeDirection();
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 29)
         {
            if(counter1 >= 30)
            {
               SoundSystem.PlaySound("cat_mcmeow");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_8"),this.mcMeow,this.advance,0);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 31)
         {
            this.mcMeow.changeDirection();
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 32)
         {
            if(this.mcMeow.DIRECTION == Entity.RIGHT)
            {
               SoundSystem.PlaySound("cat_run_low");
               this.mcMeow.stateMachine.setState("IS_WALKING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 33)
         {
            if(this.mcMeow.xPos >= 408)
            {
               SoundSystem.PlaySound("giant_spaceship");
               SoundSystem.StopMusic(false);
               this.mcMeow.stateMachine.setState("IS_STANDING_STATE");
               this.mcMeow.changeDirection();
               this.mcMeow.sprite.gfxHandle().gotoAndStop(16);
               this.mcMeow.sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               this.mcMeow.yPos -= 8;
               this.mcMeow.gravity_friction = 0;
               this.t_start = this.helicopter_yPos;
               this.t_diff = -128;
               this.t_tick = 0;
               this.t_time = 4;
               this.mcMeow_yDiff = this.mcMeow.yPos - this.helicopter_yPos;
               this.wind_power = 64;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 34)
         {
            this.mcMeow.yPos = this.helicopter_yPos + this.mcMeow_yDiff;
            if(counter1 == 120)
            {
               SoundSystem.PlayMusic("outside_sea",-1,false,true);
            }
            if(counter1 >= 180)
            {
               SoundSystem.PlaySound("cat_run");
               this.rigs.stateMachine.setState("IS_WALKING_STATE");
               this.rigs.SPEED = 4;
               this.wind_power = 0;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 35)
         {
            if(this.rigs.xPos >= 352 + 16)
            {
               this.rigs.stateMachine.setState("IS_STANDING_STATE");
               this.rigs.xPos = 352 + 16;
               this.rigs.xVel = 0;
               counter1 = 0;
               ++PROGRESSION;
               this.rose.setEmotionParticle(Entity.EMOTION_SHOCKED);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_9"),this.rose,this.advance);
            }
         }
         else if(PROGRESSION == 37)
         {
            SoundSystem.PlaySound("cat_run");
            this.rose.stateMachine.setState("IS_WALKING_STATE");
            this.rose.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(3);
            this.pascal.stateMachine.setState("IS_WALKING_STATE");
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 38)
         {
            condition = 0;
            if(this.pascal.xPos >= 224 + 32)
            {
               condition++;
               this.pascal.stateMachine.setState("IS_STANDING_STATE");
               this.pascal.xPos = 224 + 32;
               this.pascal.xVel = 0;
            }
            if(this.rose.xPos >= 256 + 32)
            {
               condition++;
               this.rose.stateMachine.setState("IS_STANDING_STATE");
               this.rose.xPos = 256 + 32;
               this.rose.xVel = 0;
            }
            if(condition >= 2)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_10"),this.pascal,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 40)
         {
            SoundSystem.PlaySound("rigs_angry");
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_11"),this.rigs,this.advance);
            this.rigs.sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
            this.rigs.setEmotionParticle(Entity.EMOTION_WORRIED);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 42)
         {
            level.hud.catUnlockManager.showUnlockScene(2);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 43)
         {
            if(level.hud.catUnlockManager.unlockScene == null)
            {
               SoundSystem.PlayMusic("outside_sea",-1,false,true);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 44)
         {
            this.rigs.changeDirection();
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 45)
         {
            if(this.rigs.stateMachine.currentState == "IS_STANDING_STATE")
            {
               this.rigs.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene0_12"),this.rigs,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 47)
         {
            this.rigs.DIRECTION = Entity.RIGHT;
            this.rigs.SPEED = 2;
            SoundSystem.PlaySound("cat_run");
            this.rigs.stateMachine.setState("IS_WALKING_STATE");
            this.pascal.stateMachine.setState("IS_WALKING_STATE");
            this.rose.stateMachine.setState("IS_WALKING_STATE");
            this.rose.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(3);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 48)
         {
            if(counter1 == 60 - 59)
            {
               level.hud.showDarkFade(120);
            }
            if(counter1 >= 180 - 59)
            {
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         if(PROGRESSION < 34)
         {
            this.wind_power = this.helicopter_yPos - 64;
         }
         else
         {
            this.mcMeow.yPos = this.helicopter_yPos + this.mcMeow_yDiff;
         }
         if(PROGRESSION < 34)
         {
            if(this.wind_power < 0)
            {
               this.wind_power = 0;
            }
            else
            {
               this.wind_power /= 32;
            }
         }
         else
         {
            this.wind_power *= 0.95;
            if(this.wind_power < 0)
            {
               this.wind_power = 0;
            }
         }
         if(this.wind_power >= 0.8)
         {
            if(!this.IS_STRONG_WIND)
            {
               this.pascal.sprite.gfxHandle().gotoAndStop(14);
               this.pascal.sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
               this.rose.sprite.gfxHandle().gotoAndStop(14);
               this.rose.sprite.gfxHandle().gfxHandleClip().gotoAndStop(4);
               this.rigs.sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
            }
            this.IS_STRONG_WIND = true;
         }
         else
         {
            if(this.IS_STRONG_WIND)
            {
               this.pascal.sprite.gfxHandle().gotoAndStop(1);
               this.rose.sprite.gfxHandle().gotoAndStop(1);
               this.rigs.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            this.IS_STRONG_WIND = false;
         }
         if(PROGRESSION >= 2)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               if(PROGRESSION >= 4 && this.justOnce)
               {
                  PROGRESSION = 6;
                  this.justOnce = false;
               }
               else if(PROGRESSION >= 6 && this.justOnce2)
               {
                  this.mcMeow.xPos = 404;
                  this.mcMeow.yPos = 75;
                  this.mcMeow.sprite.visible = true;
                  PROGRESSION = 8;
                  this.justOnce2 = false;
               }
            }
            if(PROGRESSION >= 6)
            {
               this.helicopter_yPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else
            {
               this.helicopter_yPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            if(this.wind_power > 0)
            {
               this.particle_counter_1 += this.wind_power;
               if(this.particle_counter_1 > 2)
               {
                  this.particle_counter_1 = 0;
                  pSprite = new GenericParticleSprite(GenericParticleSprite.SAND_WIND);
                  pSprite.gfxHandleClip().gotoAndStop(2);
                  if(Math.random() * 100 > 50)
                  {
                     level.particlesManager.pushParticle(pSprite,this.helicopter_xPos,152 + 8,(Math.random() * 4 + 2) * this.wind_power,0,1,Math.random() * 5,Math.random() * Math.PI * 2);
                  }
                  else
                  {
                     level.particlesManager.pushParticle(pSprite,this.helicopter_xPos,152 + 8,-(Math.random() * 4 + 2) * this.wind_power,0,1,Math.random() * 5,Math.random() * Math.PI * 2);
                  }
               }
            }
         }
         this.helicopterContainer.x = int(Math.floor(this.helicopter_xPos - level.camera.xPos));
         this.helicopterContainer.y = int(Math.floor(this.helicopter_yPos - level.camera.yPos));
         this.updateHelicopter();
         if(this.IS_STRONG_WIND)
         {
            ++this.wind_counter_1;
            if(this.wind_counter_1 >= 4)
            {
               if(this.pascal.xPos >= 224)
               {
                  this.pascal.xPos = 223;
               }
               else
               {
                  this.pascal.xPos = 224;
               }
               if(this.rose.xPos >= 256)
               {
                  this.rose.xPos = 255;
               }
               else
               {
                  this.rose.xPos = 256;
               }
               this.wind_counter_1 = 0;
            }
            ++this.wind_counter_2;
            if(this.wind_counter_2 >= 8)
            {
               if(this.rigs.xPos >= 288)
               {
                  this.rigs.xPos = 287;
               }
               else
               {
                  this.rigs.xPos = 288;
               }
               this.wind_counter_2 = 0;
            }
         }
      }
      
      protected function updateHelicopter() : void
      {
         if(this.catSprite.gfxHandle().gfxHandleClip().isComplete)
         {
            this.catSprite.gfxHandle().gfxHandleClip().setFrameDuration(0,Math.random() * 1 + 1);
            this.catSprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         ++this.helicopter_counter1;
         if(this.helicopter_counter1 >= 2)
         {
            this.helicopter_counter1 = 0;
            this.helicopterPropeller1.visible = !this.helicopterPropeller1.visible;
            this.helicopterPropeller2.visible = this.helicopterPropeller1.visible;
         }
         this.spring_force *= 0.99;
         this.helicopter_sin += 0.1;
         if(this.helicopter_sin > Math.PI * 2)
         {
            this.helicopter_sin -= Math.PI * 2;
         }
         this.helicopterContainer.rotation = Math.sin(this.helicopter_sin) * 0.2 * this.spring_force;
         this.ropeContainer.x = this.helicopterContainer.x;
         this.ropeContainer.y = this.helicopterContainer.y - 32 + 8 + this.rope_yPos;
         this.catSprite.updateScreenPosition();
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
         level.hero.sprite.visible = false;
         this.rigs = new CatNPC(level,304 + 48,128,Entity.RIGHT,0,CatNPC.RIGS);
         this.rigs.sprite.gfxHandle().gotoAndStop(19);
         this.rigs.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.pascal = new CatNPC(level,16,144,Entity.RIGHT,0,CatNPC.PASCAL);
         this.rose = new CatNPC(level,16 + 24,144,Entity.RIGHT,0,CatNPC.ROSE);
         this.mcMeow = new CatNPC(level,368,144,Entity.LEFT,0,CatNPC.MC_MEOW);
         this.mcMeow.gravity_friction = 0;
         this.mcMeow.sprite.gfxHandle().gotoAndStop(16);
         this.mcMeow.sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.mcMeow.sprite.visible = false;
         level.npcsManager.npcs.push(this.rigs);
         level.npcsManager.npcs.push(this.pascal);
         level.npcsManager.npcs.push(this.rose);
         level.npcsManager.npcs.push(this.mcMeow);
         this.rigs.updateScreenPosition(level.camera);
         this.pascal.updateScreenPosition(level.camera);
         this.rose.updateScreenPosition(level.camera);
         this.mcMeow.updateScreenPosition(level.camera);
         this.ropeContainer = new Sprite();
         this.ropeTile1 = new Image(TextureManager.sTextureAtlas.getTexture("rope_tile_2"));
         this.ropeTile2 = new Image(TextureManager.sTextureAtlas.getTexture("rope_tile_2"));
         this.ropeTile3 = new Image(TextureManager.sTextureAtlas.getTexture("rope_tile_3"));
         this.ropeTile1.x = this.ropeTile2.x = this.ropeTile3.x = -8;
         this.ropeTile1.y = 0;
         this.ropeTile2.y = 16;
         this.ropeTile3.y = 32;
         this.ropeContainer.addChild(this.ropeTile1);
         this.ropeContainer.addChild(this.ropeTile2);
         this.ropeContainer.addChild(this.ropeTile3);
         Utils.world.addChild(this.ropeContainer);
         this.helicopterContainer = new Sprite();
         this.helicopterBack = new Image(TextureManager.GetBackgroundTexture().getTexture("helicopterBack1"));
         this.catSprite = new GenericNPCSprite(0);
         this.catSprite.gfxHandle().gotoAndStop(1);
         this.catSprite.updateScreenPosition();
         this.helicopterBody = new Image(TextureManager.GetBackgroundTexture().getTexture("helicopter"));
         this.helicopterBack.touchable = this.helicopterBody.touchable = false;
         this.helicopterContainer.addChild(this.helicopterBack);
         this.helicopterContainer.addChild(this.catSprite);
         this.helicopterContainer.addChild(this.helicopterBody);
         Utils.world.addChild(this.helicopterContainer);
         this.helicopterContainer.x = this.helicopterContainer.y = 50;
         this.helicopterBack.x = 16;
         this.helicopterBack.y = 11;
         this.catSprite.x = this.catSprite.y = 26;
         this.helicopterScrew = new Image(TextureManager.GetBackgroundTexture().getTexture("helicopter_screw"));
         this.helicopterPropeller1 = new Image(TextureManager.GetBackgroundTexture().getTexture("background_white"));
         this.helicopterPropeller2 = new Image(TextureManager.GetBackgroundTexture().getTexture("helicopter_fan"));
         this.helicopterPropeller1.width = 96;
         this.helicopterPropeller1.height = 2;
         this.helicopterPropeller2.x = 81;
         this.helicopterPropeller2.y = 8;
         this.helicopterScrew.x = 86;
         this.helicopterScrew.y = 16;
         this.helicopterPropeller1.x = -8;
         this.helicopterPropeller1.y = -4;
         this.helicopterPropeller1.touchable = this.helicopterPropeller2.touchable = this.helicopterScrew.touchable = false;
         this.helicopterContainer.pivotX = int(this.helicopterContainer.width * 0.5);
         this.helicopterContainer.pivotY = int(this.helicopterContainer.height * 0.5);
         this.helicopterContainer.addChild(this.helicopterPropeller2);
         this.helicopterContainer.addChild(this.helicopterScrew);
         this.helicopterContainer.addChild(this.helicopterPropeller1);
         this.helicopterContainer.filter = new FragmentFilter();
         FragmentFilter(this.helicopterContainer.filter).resolution = Utils.GFX_INV_SCALE;
         FragmentFilter(this.helicopterContainer.filter).textureSmoothing = TextureSmoothing.NONE;
      }
      
      override protected function execState() : void
      {
      }
      
      override public function destroy() : void
      {
         this.ropeContainer.removeChild(this.ropeTile1);
         this.ropeContainer.removeChild(this.ropeTile2);
         this.ropeContainer.removeChild(this.ropeTile3);
         this.ropeTile1.dispose();
         this.ropeTile2.dispose();
         this.ropeTile3.dispose();
         this.ropeTile1 = null;
         this.ropeTile2 = null;
         this.ropeTile3 = null;
         Utils.world.removeChild(this.ropeContainer);
         this.ropeContainer.dispose();
         this.ropeContainer = null;
         this.helicopterContainer.filter = null;
         this.helicopterContainer.removeChild(this.helicopterPropeller1);
         this.helicopterContainer.removeChild(this.helicopterScrew);
         this.helicopterContainer.removeChild(this.helicopterPropeller2);
         this.helicopterContainer.removeChild(this.helicopterBody);
         this.helicopterContainer.removeChild(this.catSprite);
         this.helicopterContainer.removeChild(this.helicopterBack);
         this.helicopterPropeller1.dispose();
         this.helicopterScrew.dispose();
         this.helicopterPropeller2.dispose();
         this.helicopterBody.dispose();
         this.helicopterBack.dispose();
         this.catSprite.destroy();
         this.catSprite.dispose();
         this.helicopterPropeller1 = this.helicopterScrew = this.helicopterPropeller2 = this.helicopterBody = this.helicopterBack = null;
         this.catSprite = null;
         Utils.world.removeChild(this.helicopterContainer);
         this.helicopterContainer.dispose();
         this.helicopterContainer = null;
         this.hero = null;
         super.destroy();
      }
      
      override protected function overState() : void
      {
         super.overState();
         LevelIntroCutscene.FORCE_SHORT_INTRO = true;
         this.pascal.dead = true;
         this.rose.dead = true;
         this.mcMeow.dead = true;
         this.rigs.dead = true;
         Utils.Slot.playerInventory[LevelItems.ITEM_EVIL_CAT] = 1;
         SaveManager.SaveInventory();
         level.changeCat(2,false);
         Utils.Slot.gameProgression[11] = 1;
         SaveManager.SaveGameProgression();
         Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
         level.CHANGE_ROOM_FLAG = true;
      }
   }
}
