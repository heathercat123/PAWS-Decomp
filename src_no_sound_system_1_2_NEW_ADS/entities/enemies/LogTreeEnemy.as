package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.LogTreeEnemySprite;
   import sprites.particles.DirtParticleSprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class LogTreeEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var unhide_distance:Number;
      
      protected var READY_TO_UNHIDE:Boolean;
      
      protected var jump_counter:int;
      
      protected var fall_offset:int;
      
      protected var IS_SMALL_JUMP:Boolean;
      
      protected var time_since_turning:int;
      
      protected var IS_ARMED:Boolean;
      
      public function LogTreeEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _param_2:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.IS_ARMED = false;
         this.READY_TO_UNHIDE = false;
         this.IS_SMALL_JUMP = false;
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         this.unhide_distance = _param_2;
         this.jump_counter = 0;
         this.fall_offset = 0;
         this.time_since_turning = 0;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         if(ai_index == 2)
         {
            this.IS_ARMED = true;
         }
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         if(this.IS_ARMED)
         {
            sprite = new LogTreeEnemySprite(1);
         }
         else
         {
            sprite = new LogTreeEnemySprite();
         }
         Utils.world.addChild(sprite);
         aabb.x = 1 + -4;
         aabb.y = -1;
         aabb.width = 14 + 8;
         aabb.height = 13;
         aabbPhysics.x = 1 - 4;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14 + 8;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 0 || ai_index == 2)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 1)
         {
            stateMachine.setState("IS_HIDDEN_STATE");
         }
         energy = 1;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
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
      
      override public function reset() : void
      {
         super.reset();
         if(ai_index == 0 || ai_index == 2)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else
         {
            stateMachine.setState("IS_HIDDEN_STATE");
         }
      }
      
      override public function update() : void
      {
         super.update();
         ++this.time_since_turning;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index == 2)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            else if(this.walk_counter-- < 0 || ai_index == 1)
            {
               this.walk_counter = int(Math.random() * 2 + 3) * 60;
               stateMachine.performAction("WALK_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               this.smallJump();
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(this.fall_offset != 0)
            {
               if(this.fall_offset > 0)
               {
                  --this.fall_offset;
                  ++xPos;
               }
               else
               {
                  ++this.fall_offset;
                  --xPos;
               }
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.walk_counter-- < 0 && ai_index == 0)
            {
               this.walk_counter = int(Math.random() * 3 + 1) * 30;
               stateMachine.performAction("STOP_ACTION");
            }
            else if(this.jump_counter-- == 0)
            {
               this.smallJump();
            }
            if(DIRECTION == RIGHT)
            {
               xVel += speed;
            }
            else
            {
               xVel += -speed;
            }
            if(Math.abs(yVel) < 0.1)
            {
               frame_speed = 0.2;
            }
            else
            {
               frame_speed = 0.4;
               xVel = 0;
            }
            frame_counter += frame_speed;
            if(frame_counter >= 4)
            {
               frame_counter -= 4;
            }
            this.boundariesCheck();
         }
         else if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               if(level.hero.getMidXPos() > getMidXPos() + this.unhide_distance && this.READY_TO_UNHIDE)
               {
                  stateMachine.performAction("END_ACTION");
               }
               else if(level.hero.getMidXPos() < getMidXPos())
               {
                  this.READY_TO_UNHIDE = true;
               }
            }
            else if(level.hero.getMidXPos() > getMidXPos() - this.unhide_distance && this.READY_TO_UNHIDE)
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(level.hero.getMidXPos() < getMidXPos())
            {
               this.READY_TO_UNHIDE = true;
            }
            xPos = originalXPos;
            yPos = originalYPos;
            xVel = yVel = 0;
         }
         else if(stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            this.walk_counter = 20;
         }
         if(this.IS_ARMED)
         {
            aabbSpike.x = -11;
            aabbSpike.y = -2 + 2;
            aabbSpike.width = 8;
            aabbSpike.height = 18 - 4;
            if(DIRECTION == Entity.RIGHT)
            {
               aabbSpike.x = 19;
            }
            if(stateMachine.currentState == "IS_TURNING_STATE")
            {
               aabbSpike.width = aabbSpike.height = 0;
            }
         }
         integratePositionAndCollisionDetection();
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(!this.IS_ARMED)
         {
            return true;
         }
         if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            return true;
         }
         if(this.time_since_turning >= 10)
         {
            if(level.hero.getAABB().intersects(getAABBSpike()))
            {
               return false;
            }
         }
         return true;
      }
      
      protected function smallJump() : void
      {
         yVel = -2.5;
         this.IS_SMALL_JUMP = true;
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
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            if(yVel >= 0)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
         if(yVel >= 0)
         {
            this.IS_SMALL_JUMP = false;
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         var x_t:int = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         this.time_since_turning = 0;
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      override public function noGroundCollision() : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" && !IS_ON_PLATFORM && !this.IS_SMALL_JUMP)
         {
            if(DIRECTION == Entity.RIGHT)
            {
               this.fall_offset = 8;
            }
            else
            {
               this.fall_offset = -8;
            }
            stateMachine.performAction("NO_GROUND_ACTION");
         }
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame_counter + 1);
         this.jump_counter = Math.random() * 30 + 30;
         counter1 = 0;
         MAX_X_VEL = 0.25;
         speed = 0.8;
         if(ai_index == 1)
         {
            speed = 1.2;
            MAX_X_VEL = 0.4;
         }
         else if(ai_index == 2)
         {
            speed = 1.2;
            MAX_X_VEL = 0.6;
         }
         x_friction = 0.8;
         xVel = 0;
         gravity_friction = 1;
      }
      
      public function hiddenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.READY_TO_UNHIDE = false;
         counter1 = counter2 = counter3 = 0;
      }
      
      public function fallingAnimation() : void
      {
         if(stateMachine.lastState == "IS_HIDDEN_STATE")
         {
            if(isInsideScreen())
            {
               SoundSystem.PlaySound("dig");
            }
            sprite.gfxHandle().gotoAndStop(6);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         counter1 = counter2 = 0;
         gravity_friction = 0.4;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
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
      
      protected function dirtParticles() : void
      {
         var pSprite:DirtParticleSprite = null;
         pSprite = new DirtParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + WIDTH * 0.25,yPos + HEIGHT,-(Math.random() * 1),-(Math.random() * 1 + 2),1);
         pSprite = new DirtParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + WIDTH * 0.75,yPos + HEIGHT,Math.random() * 1,-(Math.random() * 1 + 2),1);
      }
   }
}
