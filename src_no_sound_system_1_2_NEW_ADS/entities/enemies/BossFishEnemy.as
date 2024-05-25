package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.*;
   import sprites.particles.*;
   import starling.display.Image;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class BossFishEnemy extends GiantEnemy
   {
       
      
      protected var HITS:int;
      
      protected var IS_ON_TOP_WORLD:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var JUMP_AMOUNTS:int;
      
      protected var IS_ON_GROUND:Boolean;
      
      protected var IS_POST_STUCK:Boolean;
      
      public var sprite_0:GameSprite;
      
      public var mouth:GameSprite;
      
      public var sprite_2:GameSprite;
      
      public var tail:GameSprite;
      
      public var eye:Image;
      
      protected var splash_particle_counter:int;
      
      protected var IS_HIT_HIGHLIGHT:Boolean;
      
      protected var IS_YELLOW:Boolean;
      
      protected var SMASH_WALL_FLAG:Boolean;
      
      protected var hit_highlight_counter_1:int;
      
      protected var hit_hightlight_counter_2:int;
      
      protected var jump_x_pos:Number;
      
      protected var PROGRESSION:int;
      
      protected var small_jump_1:int;
      
      protected var small_jump_2:int;
      
      public function BossFishEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         IS_BOSS = true;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.PROGRESSION = 0;
         this.IS_HIT_HIGHLIGHT = this.IS_YELLOW = this.IS_ON_GROUND = this.IS_POST_STUCK = this.SMASH_WALL_FLAG = false;
         this.hit_highlight_counter_1 = this.hit_hightlight_counter_2 = this.jump_x_pos = this.splash_particle_counter = 0;
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.HITS = 0;
         this.JUMP_AMOUNTS = 0;
         IS_IN_WATER = true;
         sprite = new GameSprite();
         Utils.world.addChild(sprite);
         this.sprite_0 = new FishBossEnemySprite(0);
         this.sprite_0.x = -28;
         this.sprite_0.y = -33;
         sprite.addChild(this.sprite_0);
         this.eye = new Image(TextureManager.sTextureAtlas.getTexture("bossFishEye"));
         this.eye.touchable = false;
         sprite.addChild(this.eye);
         this.eye.visible = false;
         this.mouth = new FishBossEnemySprite(1);
         this.mouth.gfxHandle().gfxHandleClip().gotoAndStop(1);
         sprite.addChild(this.mouth);
         this.mouth.x = -33;
         this.sprite_2 = new FishBossEnemySprite(2);
         sprite.addChild(this.sprite_2);
         this.sprite_2.x = this.sprite_2.y = 3;
         this.tail = new FishBossEnemySprite(3);
         sprite.addChild(this.tail);
         this.tail.x = 21;
         this.addFragmentFilter();
         aabb.x = aabb.y = -24;
         aabb.width = aabb.height = 48;
         aabbPhysics.x = aabbPhysics.y = -24;
         aabbPhysics.width = aabbPhysics.height = 48;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WAITING_STATE","END_ACTION","IS_UNDERWATER_STATE");
         stateMachine.setRule("IS_UNDERWATER_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_UNDERWATER_STATE","ATTACK_ACTION","IS_EMERGING_STATE");
         stateMachine.setRule("IS_EMERGING_STATE","END_ACTION","IS_ATTACKING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","END_ACTION","IS_MID_AIR_STATE");
         stateMachine.setRule("IS_MID_AIR_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","END_ACTION","IS_UNDERWATER_STATE");
         stateMachine.setRule("IS_MID_AIR_STATE","STUCK_ACTION","IS_STUCK_STATE");
         stateMachine.setRule("IS_STUCK_STATE","END_ACTION","IS_STUCK_JUMPING_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","END_ACTION","IS_MID_AIR_STATE");
         stateMachine.setRule("IS_UNDERWATER_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_MID_AIR_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_STUCK_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_EMERGING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_EMERGING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","DEAD_ACTION","IS_DEAD_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_STUCK_JUMPING_STATE");
         stateMachine.setRule("IS_HIT_STATE","GROUND_COLLISION_ACTION","IS_STUCK_JUMPING_STATE");
         stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingAnimation);
         stateMachine.setFunctionToState("IS_UNDERWATER_STATE",this.underwaterAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_MID_AIR_STATE",this.midAirAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_STUCK_STATE",this.stuckAnimation);
         stateMachine.setFunctionToState("IS_STUCK_JUMPING_STATE",this.stuckJumpingAnimation);
         stateMachine.setFunctionToState("IS_EMERGING_STATE",this.emergingAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         stateMachine.setState("IS_WAITING_STATE");
         energy = 4;
         stunHandler.stun_x_offset = -12;
         stunHandler.stun_y_offset = -32;
      }
      
      override public function destroy() : void
      {
         sprite.filter = null;
         sprite.removeChild(this.tail);
         sprite.removeChild(this.sprite_2);
         sprite.removeChild(this.mouth);
         sprite.removeChild(this.sprite_0);
         sprite.removeChild(this.eye);
         Utils.world.removeChild(sprite);
         this.tail.destroy();
         this.sprite_2.destroy();
         this.mouth.destroy();
         this.sprite_0.destroy();
         sprite.destroy();
         this.eye.dispose();
         this.tail.dispose();
         this.sprite_2.dispose();
         this.mouth.dispose();
         this.sprite_0.dispose();
         sprite.dispose();
         this.tail = this.sprite_2 = this.mouth = this.sprite_0 = sprite = null;
         this.eye = null;
         if(stateMachine != null)
         {
            stateMachine.destroy();
            stateMachine = null;
         }
         if(stunHandler != null)
         {
            stunHandler.destroy();
            stunHandler = null;
         }
         aabb = aabbPhysics = null;
         level = null;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override protected function isInvulnerableToHelperAttacks() : Boolean
      {
         if(stateMachine.currentState == "IS_STUCK_STATE")
         {
            return false;
         }
         return true;
      }
      
      override protected function allowEnemyDefend() : Boolean
      {
         if(stateMachine.currentState == "IS_STUCK_STATE" || stateMachine.currentState == "IS_HURT_STATE")
         {
            return false;
         }
         return true;
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var wait_time:int = 0;
         if(stunHandler)
         {
            stunHandler.update();
         }
         if(BULLET_HIT_FLAG)
         {
            ++bullet_hit_counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(bullet_hit_counter1 >= wait_time)
            {
               bullet_hit_counter1 = 0;
               ++bullet_hit_counter2;
               sprite.visible = !sprite.visible;
               if(bullet_hit_counter2 > 6)
               {
                  sprite.visible = true;
                  BULLET_HIT_FLAG = false;
               }
            }
         }
         if(stateMachine.currentState == "IS_UNDERWATER_STATE")
         {
            ++counter1;
            if(this.SMASH_WALL_FLAG)
            {
               if(counter1 >= 30)
               {
                  this.SMASH_WALL_FLAG = false;
                  stateMachine.performAction("ATTACK_ACTION");
               }
            }
            else if(counter1 >= 120 - this.HITS * 30)
            {
               stateMachine.performAction("JUMP_ACTION");
            }
            else if(counter1 == 60 - this.HITS * 15)
            {
               this.jump_x_pos = level.hero.getMidXPos();
               for(i = 0; i < 6; i++)
               {
                  level.topParticlesManager.createClusterBubbles(this.jump_x_pos + Math.random() * 80 - 40,level.camera.yPos + Utils.HEIGHT - 16 + Math.random() * 32);
               }
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick > this.t_time)
            {
               this.t_tick = this.t_time;
               stateMachine.performAction("END_ACTION");
            }
            yPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(stateMachine.currentState == "IS_MID_AIR_STATE")
         {
            if(this.JUMP_AMOUNTS < 2 + this.HITS * 2)
            {
               if(counter3 < (this.IS_POST_STUCK ? 6 : 12))
               {
                  ++counter2;
                  if(counter2 >= 5)
                  {
                     ++counter3;
                     counter2 = 0;
                     sprite.rotation -= Math.PI * 0.25;
                     if(counter3 == 1 || counter3 == 5 || counter3 == 9)
                     {
                        SoundSystem.PlaySound("wing");
                     }
                     if(counter3 >= (this.IS_POST_STUCK ? 6 : 12))
                     {
                        this.tail.gfxHandle().gfxHandleClip().gotoAndStop(1);
                     }
                  }
               }
               else
               {
                  ++counter1;
                  if(counter1 >= (this.IS_POST_STUCK ? 0 : 20))
                  {
                     this.IS_POST_STUCK = false;
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(counter3 < 6)
            {
               ++counter2;
               if(counter2 >= 5)
               {
                  ++counter3;
                  counter2 = 0;
                  sprite.rotation -= Math.PI * 0.25;
                  if(counter3 == 1 || counter3 == 5 || counter3 == 9)
                  {
                     SoundSystem.PlaySound("wing");
                  }
                  if(counter3 >= 6)
                  {
                     this.mouth.gfxHandle().gfxHandleClip().gotoAndStop(2);
                     this.tail.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  }
               }
            }
            else
            {
               ++counter1;
               if(counter1 >= 20)
               {
                  stateMachine.performAction("STUCK_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            yPos += 4 + this.HITS;
            if(yPos >= level.camera.yPos + Utils.HEIGHT + 40)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_STUCK_STATE")
         {
            if(this.IS_ON_GROUND)
            {
               if(this.small_jump_1-- < 0)
               {
                  if(this.small_jump_2 < 4 - this.HITS)
                  {
                     SoundSystem.PlaySound("enemy_water");
                     this.IS_ON_GROUND = false;
                     if(this.HITS == 0)
                     {
                        this.small_jump_1 = Math.random() * 10 + 10;
                     }
                     else if(this.HITS == 1)
                     {
                        this.small_jump_1 = Math.random() * 10 + 5;
                     }
                     else
                     {
                        this.small_jump_1 = Math.random() * 5 + 5;
                     }
                     if(Math.random() * 100 > 50)
                     {
                        xVel = Math.random() * 1 + 1;
                     }
                     else
                     {
                        xVel = -(Math.random() * 1 + 1);
                     }
                     if(this.HITS == 0)
                     {
                        yVel = -(Math.random() * 1 + 1);
                     }
                     else if(this.HITS == 1)
                     {
                        yVel = -(Math.random() * 1 + 2);
                     }
                     else
                     {
                        yVel = -(Math.random() * 1 + 3);
                     }
                     level.particlesManager.createDewDroplets(xPos,160);
                     ++this.small_jump_2;
                  }
                  else
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            integratePositionAndCollisionDetection();
         }
         else if(stateMachine.currentState == "IS_STUCK_JUMPING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick > this.t_time)
            {
               this.t_tick = this.t_time;
               stateMachine.performAction("END_ACTION");
            }
            yPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(stunHandler.IS_STUNNED == false)
            {
               this.restoreEnergy();
               stateMachine.performAction("END_ACTION");
            }
            integratePositionAndCollisionDetection();
         }
         else if(stateMachine.currentState == "IS_EMERGING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               yPos = Easings.easeOutBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
               stateMachine.performAction("END_ACTION");
            }
            else
            {
               yPos = Easings.easeOutBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
         }
         else if(stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            if(this.PROGRESSION == 0)
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  ++this.PROGRESSION;
                  SoundSystem.PlaySound("big_impact");
                  this.createFishEnemies();
                  if(DIRECTION == Entity.RIGHT)
                  {
                     level.camera.horShake(24,0.85,0.5);
                  }
                  else
                  {
                     level.camera.horShake(-24,0.85,0.5);
                  }
               }
               else
               {
                  ++this.splash_particle_counter;
                  if(this.splash_particle_counter > 5)
                  {
                     this.splash_particle_counter = 0;
                     level.topParticlesManager.pushParticle(new SplashParticleSprite(0),DIRECTION == Entity.LEFT ? xPos + 32 : xPos - 32,Utils.SEA_LEVEL,0,0,0);
                  }
               }
               xPos = Easings.easeInBack(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else if(this.PROGRESSION == 1)
            {
               if(counter1++ > 20)
               {
                  yPos += 2;
                  if(yPos >= level.camera.yPos + Utils.HEIGHT + 40)
                  {
                     yPos = level.camera.yPos + Utils.HEIGHT + 40;
                     ++counter3;
                     if(counter3 >= 120)
                     {
                        stateMachine.setState("IS_UNDERWATER_STATE");
                     }
                  }
               }
               else if(DIRECTION == Entity.LEFT)
               {
                  xPos += 0.5;
               }
               else
               {
                  xPos -= 0.5;
               }
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            integratePositionAndCollisionDetection();
         }
         else if(stateMachine.currentState == "IS_DEAD_STATE")
         {
            if(counter3++ == 1)
            {
               SoundSystem.PlaySound("flyingship_falldown");
            }
            if(yPos >= 416)
            {
               SoundSystem.PlaySound("big_impact");
               dead = true;
               level.camera.shake();
            }
            integratePositionAndCollisionDetection();
         }
         if(IS_IN_WATER)
         {
            if(yPos <= Utils.SEA_LEVEL - 16)
            {
               IS_IN_WATER = false;
               this.splashParticles();
            }
         }
         else if(yPos >= Utils.SEA_LEVEL + 8)
         {
            IS_IN_WATER = true;
            this.splashParticles();
         }
         --hero_collision_detection_cool_off_counter;
         if(hero_collision_detection_cool_off_counter < 0)
         {
            hero_collision_detection_cool_off_counter = 0;
         }
         if(this.IS_HIT_HIGHLIGHT)
         {
            ++this.hit_highlight_counter_1;
            if(this.hit_highlight_counter_1 > 3)
            {
               this.hit_highlight_counter_1 = 0;
               ++this.hit_hightlight_counter_2;
               if(!this.IS_YELLOW)
               {
                  sprite.filter = new ColorMatrixFilter();
                  ColorMatrixFilter(sprite.filter).adjustBrightness(1);
                  ColorMatrixFilter(sprite.filter).tint(268431360,1);
               }
               else
               {
                  sprite.filter = null;
               }
               this.IS_YELLOW = !this.IS_YELLOW;
               if(this.hit_hightlight_counter_2 > 9)
               {
                  sprite.filter = null;
                  this.setYellowHighlight(false);
                  sprite.filter = new FragmentFilter();
                  FragmentFilter(sprite.filter).resolution = Utils.GFX_INV_SCALE;
                  FragmentFilter(sprite.filter).textureSmoothing = TextureSmoothing.NONE;
               }
            }
         }
      }
      
      override public function setEmotionParticle(emotion_id:int) : void
      {
         var pSprite:GameSprite = null;
         var particle:Particle = null;
         if(emotion_id == Entity.EMOTION_WORRIED)
         {
            pSprite = new WorriedParticleSprite();
            if(DIRECTION == Entity.LEFT)
            {
               particle = level.particlesManager.pushParticle(pSprite,9,-2,0,0,1);
            }
            else
            {
               particle = level.particlesManager.pushParticle(pSprite,0,-2,0,0,1);
            }
            particle.entity = this;
         }
         else if(emotion_id == Entity.EMOTION_SHOCKED)
         {
            super.setEmotionParticle(emotion_id);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         this.eye.x = -23;
         this.eye.y = -14;
         if(DIRECTION == LEFT)
         {
            sprite.scaleX = 1;
         }
         else
         {
            sprite.scaleX = -1;
         }
         this.sprite_0.updateScreenPosition();
         this.mouth.updateScreenPosition();
         this.sprite_2.updateScreenPosition();
         this.tail.updateScreenPosition();
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            this.onTop();
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
      }
      
      override public function noGroundCollision() : void
      {
         this.IS_ON_GROUND = false;
      }
      
      override public function groundCollision() : void
      {
         this.IS_ON_GROUND = true;
         xVel = 0;
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
      }
      
      override public function defend(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : *
      {
      }
      
      protected function createFishEnemies() : void
      {
         var enemy:RiverFishEnemy = null;
         var enemy2:SeaPufferEnemy = null;
         var x_pos1:Number = 640 + Math.random() * 224 - 8;
         var x_pos2:Number = x_pos1;
         var x_pos3:Number = x_pos1;
         while(Math.abs(x_pos1 - x_pos2) < 24)
         {
            x_pos2 = 640 + Math.random() * 224 - 8;
         }
         if(this.HITS > 1)
         {
            while(Math.abs(x_pos2 - x_pos3) < 24 || Math.abs(x_pos1 - x_pos3) < 24)
            {
               x_pos3 = 640 + Math.random() * 224 - 8;
            }
         }
         level.particlesManager.pushParticle(new WaterDropParticleSprite(0),x_pos1,level.camera.yPos - 16,0,0,1);
         level.particlesManager.pushParticle(new WaterDropParticleSprite(0),x_pos2,level.camera.yPos - 16,0,0,1);
         if(this.HITS > 1)
         {
            level.particlesManager.pushParticle(new WaterDropParticleSprite(0),x_pos3,level.camera.yPos - 16,0,0,1);
         }
         enemy = new RiverFishEnemy(level,x_pos1,level.camera.yPos - 16 - 96,Entity.RIGHT,0,0);
         enemy.updateScreenPosition(level.camera);
         level.enemiesManager.enemies.push(enemy);
         enemy = new RiverFishEnemy(level,x_pos2,level.camera.yPos - 128 - 96,Entity.RIGHT,0,0);
         enemy.updateScreenPosition(level.camera);
         level.enemiesManager.enemies.push(enemy);
         if(this.HITS > 1)
         {
            enemy2 = new SeaPufferEnemy(level,x_pos3,level.camera.yPos - 256 - 96,Entity.RIGHT,0,1);
            enemy2.updateScreenPosition(level.camera);
            level.enemiesManager.enemies.push(enemy2);
         }
      }
      
      public function waitingAnimation() : void
      {
      }
      
      public function underwaterAnimation() : void
      {
         counter1 = counter2 = 0;
         DIRECTION = Entity.LEFT;
      }
      
      public function jumpingAnimation() : void
      {
         var i:int = 0;
         ++this.JUMP_AMOUNTS;
         sprite.rotation = Math.PI * 0.5;
         xPos = this.jump_x_pos - 32 + Math.random() * 64;
         yPos = level.camera.yPos + Utils.HEIGHT + 40;
         this.tail.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.t_start = yPos;
         this.t_diff = 112 - this.t_start;
         this.t_time = Math.abs(this.t_diff / 200) - this.HITS * 0.125;
         this.t_tick = 0;
         if(xPos < 648)
         {
            xPos = 648;
         }
         else if(xPos > 856)
         {
            xPos = 856;
         }
      }
      
      public function midAirAnimation() : void
      {
         this.addFragmentFilter();
         counter1 = counter2 = counter3 = 0;
         this.tail.gfxHandle().gfxHandleClip().gotoAndStop(1);
      }
      
      public function fallingAnimation() : void
      {
         sprite.rotation = -Math.PI * 0.5;
         this.tail.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function stuckAnimation() : void
      {
         sprite.filter = null;
         this.mouth.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.tail.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = y_friction = 0.9;
         gravity_friction = 0.4;
         this.small_jump_1 = this.small_jump_2 = 0;
         this.IS_ON_GROUND = false;
      }
      
      public function stuckJumpingAnimation() : void
      {
         this.mouth.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.eye.visible = false;
         this.addFragmentFilter();
         this.JUMP_AMOUNTS = 0;
         this.IS_POST_STUCK = true;
         this.t_start = yPos;
         this.t_diff = 112 - this.t_start;
         this.t_time = 0.25;
         this.t_tick = 0;
         counter1 = counter2 = counter3 = 0;
      }
      
      public function emergingAnimation() : void
      {
         if(level.hero.getMidXPos() > xPos)
         {
            DIRECTION = Entity.RIGHT;
         }
         else
         {
            DIRECTION = Entity.LEFT;
         }
         xPos = 752;
         this.t_time = 1.5;
         this.t_start = yPos;
         this.t_diff = Utils.SEA_LEVEL + 8 - this.t_start;
         this.t_tick = 0;
         sprite.rotation = 0;
         counter1 = counter2 = 0;
      }
      
      public function attackingAnimation() : void
      {
         this.t_start = xPos;
         SoundSystem.PlaySound("geyser");
         if(DIRECTION == Entity.RIGHT)
         {
            this.t_diff = 847 - this.t_start;
         }
         else
         {
            this.t_diff = 656 - this.t_start;
         }
         this.t_tick = 0;
         this.t_time = 1;
         counter1 = counter2 = 0;
         this.PROGRESSION = 0;
      }
      
      override public function hurtAnimation() : void
      {
         this.eye.visible = true;
         sprite.visible = true;
         super.hurtAnimation();
         this.mouth.gfxHandle().gfxHandleClip().gotoAndStop(2);
         this.tail.gfxHandle().gfxHandleClip().gotoAndStop(1);
         energy = 4;
         counter1 = counter2 = counter3 = 0;
         if(level.hero.getMidXPos() > this.getMidXPos())
         {
            xVel = -2;
         }
         else
         {
            xVel = 2;
         }
         yVel = -2;
         gravity_friction = 0.4;
         x_friction = 0.95;
      }
      
      override public function getMidXPos() : Number
      {
         return xPos;
      }
      
      override protected function restoreEnergy() : void
      {
         energy = 4;
      }
      
      public function hitAnimation() : void
      {
         this.SMASH_WALL_FLAG = true;
         sprite.visible = true;
         this.mouth.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.tail.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.eye.visible = false;
         SoundSystem.PlaySound("giant_fish_roar");
         energy = 4;
         stunHandler.unstun();
         ++this.HITS;
         this.setYellowHighlight(true);
         if(level.hero.getMidXPos() > this.getMidXPos())
         {
            xVel = -2;
         }
         else
         {
            xVel = 2;
         }
         yVel = -2;
         gravity_friction = 0.4;
         x_friction = 0.95;
         counter1 = counter2 = counter3 = 0;
         if(this.HITS >= 3)
         {
            stateMachine.performAction("DEAD_ACTION");
         }
      }
      
      override public function deadAnimation() : void
      {
         var i:int = 0;
         counter3 = 0;
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               if(!(level.enemiesManager.enemies[i] is BossFishEnemy))
               {
                  level.enemiesManager.enemies[i].hit(level.hero.getMidXPos(),level.hero.getMidYPos());
               }
            }
         }
         sprite.visible = true;
         this.eye.visible = true;
         this.mouth.gfxHandle().gfxHandleClip().gotoAndStop(2);
         this.tail.gfxHandle().gfxHandleClip().gotoAndStop(1);
         level.freezeAction(60);
         level.camera.shake();
         xVel = 0;
         yVel = -4;
         AVOID_COLLISION_DETECTION = true;
         this.setYellowHighlight(false);
      }
      
      protected function setYellowHighlight(value:Boolean) : void
      {
         this.IS_HIT_HIGHLIGHT = value;
         this.IS_YELLOW = false;
         this.hit_highlight_counter_1 = this.hit_hightlight_counter_2 = 0;
         if(value)
         {
            this.hit_highlight_counter_1 = 30;
         }
      }
      
      override public function onTop() : void
      {
         Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
      }
      
      protected function splashParticles() : void
      {
         level.camera.verShake(6,0.95,0.5);
         SoundSystem.PlaySound("water_splash");
         level.topParticlesManager.pushParticle(new SplashParticleSprite(0),xPos + 24,Utils.SEA_LEVEL,0,0,0);
         level.topParticlesManager.pushParticle(new SplashParticleSprite(0),xPos,Utils.SEA_LEVEL,0,0,0);
         level.topParticlesManager.pushParticle(new SplashParticleSprite(0),xPos - 24,Utils.SEA_LEVEL,0,0,0);
      }
      
      protected function addFragmentFilter() : void
      {
         sprite.filter = new FragmentFilter();
         FragmentFilter(sprite.filter).resolution = Utils.GFX_INV_SCALE;
         FragmentFilter(sprite.filter).textureSmoothing = TextureSmoothing.NONE;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_DEAD_STATE" || dead || hero.stunHandler.IS_STUNNED && hero.stunHandler.stun_counter_1 < 10)
         {
            return;
         }
         if(hero_collision_detection_cool_off_counter > 0)
         {
            return;
         }
         var isCatAttacking:Boolean = false;
         var isEnemyDefending:Boolean = false;
         if(hero.getAABB().intersects(getAABB()))
         {
            if(hero.stateMachine.currentState == "IS_RUNNING_STATE" || hero.stateMachine.currentState == "IS_JUMPING_STATE" || hero.stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || hero.stateMachine.currentState == "IS_HOPPING_STATE" && !hero.wasOnRope() || specialAttackCondition())
            {
               if(allowCatAttack())
               {
                  isCatAttacking = true;
               }
            }
            if(this.allowEnemyDefend())
            {
               isEnemyDefending = true;
            }
            if(hero.stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE" && allowCatAttack())
            {
               isCatAttacking = true;
            }
            if(isCatAttacking)
            {
               if(isEnemyDefending)
               {
                  hero.enemyDefend(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
               }
            }
            else if(hero.stateMachine.currentState != "IS_HEAD_POUND_STATE")
            {
               hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
            }
            if(hero.stateMachine.currentState != "IS_GAME_OVER_STATE")
            {
               if(isEnemyDefending)
               {
                  this.defend(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
               }
               else if(isCatAttacking)
               {
                  hit(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
                  hero.attack(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
                  hero.stateMachine.performAction("WALL_COLLISION_ACTION");
               }
            }
         }
      }
   }
}
