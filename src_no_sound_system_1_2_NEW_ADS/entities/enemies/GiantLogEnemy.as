package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.*;
   import sprites.particles.WorriedParticleSprite;
   import states.LevelState;
   
   public class GiantLogEnemy extends GiantEnemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var attack_counter:int;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var IS_TOUCHING_GROUND:Boolean;
      
      protected var spin_speed:Number;
      
      protected var spin_frame:Number;
      
      protected var hits_amount:int;
      
      protected var sound_amount:int;
      
      public function GiantLogEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         IS_MINIBOSS = true;
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         ai_index = _ai;
         this.hits_amount = 0;
         this.attack_counter = 60;
         this.IS_TOUCHING_GROUND = true;
         this.t_start = this.t_diff = this.t_tick = this.t_time = 0;
         this.sound_amount = 0;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.walk_counter = 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new GiantTurnipEnemySprite(1);
         Utils.world.addChild(sprite);
         aabb.x = -1;
         aabb.y = 4;
         aabb.width = 34;
         aabb.height = 28;
         aabbPhysics.x = -1;
         aabbPhysics.y = 4;
         aabbPhysics.width = 34;
         aabbPhysics.height = 28;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_INTO_LOG_ACTION","IS_LOG_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_INTO_LOG_ACTION","IS_LOG_STATE");
         stateMachine.setRule("IS_LOG_STATE","END_ACTION","IS_SPINNING_STATE");
         stateMachine.setRule("IS_SPINNING_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","END_ACTION","IS_TRANSFORMING_STATE");
         stateMachine.setRule("IS_TRANSFORMING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_LOG_STATE",this.logAnimation);
         stateMachine.setFunctionToState("IS_SPINNING_STATE",this.spinningAnimation);
         stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_TRANSFORMING_STATE",this.transformingAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 2;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_LOG_STATE" || stateMachine.currentState == "IS_SPINNING_STATE" || stateMachine.currentState == "IS_FLYING_STATE" || stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_TRANSFORMING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            if(stunHandler.IS_STUNNED)
            {
               SoundSystem.PlaySound("big_enemy_hurt");
            }
            else
            {
               SoundSystem.PlaySound("big_enemy_hit");
            }
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(level.stateMachine.currentState != "IS_CUTSCENE_STATE")
            {
               if(_isFacingHero(true))
               {
                  if(this.attack_counter-- <= 0)
                  {
                     stateMachine.performAction("TURN_INTO_LOG_ACTION");
                  }
               }
               else
               {
                  if(this.attack_counter-- <= 30)
                  {
                     this.attack_counter = 30;
                  }
                  if(this.walk_counter-- < 0)
                  {
                     stateMachine.performAction("WALK_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(level.stateMachine.currentState != "IS_CUTSCENE_STATE")
            {
               if(_isFacingHero(true))
               {
                  if(this.attack_counter-- <= 0)
                  {
                     stateMachine.performAction("TURN_INTO_LOG_ACTION");
                  }
               }
               else if(this.attack_counter-- <= 30)
               {
                  this.attack_counter = 30;
               }
            }
            else
            {
               ++counter3;
               if(counter3 >= 15)
               {
                  counter3 = 0;
                  SoundSystem.PlaySound("wiggle");
               }
            }
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
            }
            else
            {
               xVel = -speed;
            }
            this.boundariesCheck();
         }
         else if(stateMachine.currentState == "IS_LOG_STATE")
         {
            ++counter1;
            if(counter1 >= 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SPINNING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               stateMachine.performAction("END_ACTION");
            }
            frame_speed = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            counter1 += frame_speed;
            if(counter1 >= 5)
            {
               counter1 = 0;
               this.dust();
            }
            this.updateSpinFrame();
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            this.updateSpinFrame();
            if(this.hits_amount >= 8)
            {
               if(yPos <= 80)
               {
                  if(Math.abs(getMidXPos() - level.hero.getMidXPos()) <= 12)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            if(yPos >= 112)
            {
               ++counter3;
               if(counter3 >= 10)
               {
                  this.dust();
                  counter3 = 0;
               }
            }
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(counter3 <= 50)
            {
               ++counter1;
               if(counter1 >= 2)
               {
                  ++counter2;
                  counter1 = 0;
                  if(xPos >= originalXPos)
                  {
                     xPos = originalXPos - 1;
                  }
                  else
                  {
                     xPos = originalXPos + 1;
                  }
                  if(counter2 >= 8)
                  {
                     counter3 = 100;
                     xPos = originalXPos;
                  }
               }
            }
            else if(counter3 <= 150)
            {
               ++counter1;
               if(counter1 >= 60)
               {
                  SoundSystem.PlaySound("flyingship_falldown");
                  yVel = -4;
                  gravity_friction = 1;
                  counter3 = 200;
               }
            }
            if(this.IS_TOUCHING_GROUND)
            {
               ++counter3;
               if(counter3 >= 230)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         integratePositionAndCollisionDetection();
      }
      
      protected function updateSpinFrame() : void
      {
         frame_counter += frame_speed;
         if(frame_counter >= 4)
         {
            if(this.sound_amount <= 5)
            {
               SoundSystem.PlaySound("wing");
               ++this.sound_amount;
            }
            frame_counter -= 4;
         }
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      protected function boundariesCheck() : void
      {
         if(path_start_x != 0)
         {
            if(DIRECTION == LEFT)
            {
               if(xPos <= path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(xPos + WIDTH >= path_end_x)
            {
               stateMachine.performAction("TURN_ACTION");
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
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               sprite.gfxHandle().scaleX = -1;
            }
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
         else if(stateMachine.currentState == "IS_SPINNING_STATE" || stateMachine.currentState == "IS_FLYING_STATE")
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override public function noGroundCollision() : void
      {
         this.IS_TOUCHING_GROUND = false;
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(!this.IS_TOUCHING_GROUND)
            {
               SoundSystem.PlaySound("ground_stomp");
               level.camera.shake(6);
               this.dust();
            }
         }
         else if(stateMachine.currentState == "IS_LOG_STATE")
         {
            if(!this.IS_TOUCHING_GROUND)
            {
               SoundSystem.PlaySound("ground_stomp");
               level.camera.shake(2);
               this.dust();
            }
         }
         else if(stateMachine.currentState == "IS_TRANSFORMING_STATE")
         {
            if(!this.IS_TOUCHING_GROUND)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
               SoundSystem.PlaySound("ground_stomp");
               level.camera.shake(2);
               this.dust();
            }
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            yVel = -2;
            this.shakeCamera();
            SoundSystem.PlaySound("rock_stomp");
         }
         this.IS_TOUCHING_GROUND = true;
         if(stateMachine.currentState != "IS_FLYING_STATE")
         {
            gravity_friction = 1;
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         var x_t:int = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            xVel *= -1;
            this.shakeCamera();
            SoundSystem.PlaySound("rock_stomp");
         }
         else if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      override public function ceilCollision() : void
      {
         if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            yVel = 2;
            this.shakeCamera();
            SoundSystem.PlaySound("rock_stomp");
         }
      }
      
      protected function dust() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_4_4)
         {
            level.particlesManager.createDust(xPos,160,Entity.LEFT);
            level.particlesManager.createDust(xPos + WIDTH,160,Entity.RIGHT);
         }
         else
         {
            level.particlesManager.createDust(xPos,yPos + HEIGHT,Entity.LEFT);
            level.particlesManager.createDust(xPos + WIDTH,yPos + HEIGHT,Entity.RIGHT);
         }
      }
      
      protected function shakeCamera() : void
      {
         level.camera.shake(2);
         ++this.hits_amount;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.walk_counter = 30;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter3 = 0;
         speed = 1.5;
         x_friction = 0.8;
         xVel = 0;
      }
      
      protected function logAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         yPos -= 8;
         yVel = -2;
         counter1 = 0;
      }
      
      protected function spinningAnimation() : void
      {
         this.sound_amount = 0;
         frame_speed = 0;
         this.spin_speed = 0;
         this.spin_frame = 0;
         this.t_tick = 0;
         this.t_time = 1.5;
         this.t_start = 0;
         this.t_diff = 0.25;
         counter1 = counter2 = 0;
      }
      
      protected function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         originalXPos = xPos;
         xVel = yVel = 0;
         counter1 = counter2 = counter3 = 0;
         if(level.hero.getMidXPos() > getMidXPos())
         {
            DIRECTION = Entity.RIGHT;
         }
         else
         {
            DIRECTION = Entity.LEFT;
         }
      }
      
      protected function transformingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         yPos -= 8;
         yVel = -2;
         this.attack_counter = 240;
         counter1 = 0;
      }
      
      protected function flyingAnimation() : void
      {
         gravity_friction = 0;
         x_friction = 1;
         y_friction = 1;
         this.hits_amount = 0;
         counter1 = counter2 = counter3 = 0;
         if(DIRECTION == Entity.LEFT)
         {
            xVel = -2;
         }
         else
         {
            xVel = 2;
         }
         yVel = -2;
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(level.hero.getMidXPos() > getMidXPos())
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
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         SoundSystem.PlaySound("giant_turnip_defeat");
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
