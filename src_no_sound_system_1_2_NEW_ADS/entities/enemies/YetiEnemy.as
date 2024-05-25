package entities.enemies
{
   import entities.Entity;
   import entities.particles.Particle;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.collisions.BigIceBlockCollision;
   import sprites.GameSprite;
   import sprites.enemies.*;
   import sprites.particles.WorriedParticleSprite;
   
   public class YetiEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var jump_cool_down_counter:int;
      
      protected var walk_counter:int;
      
      protected var param:int;
      
      protected var jumpAtYPos:Number;
      
      protected var iceBlock:BigIceBlockCollision;
      
      protected var WALK_FLAG:Boolean;
      
      public function YetiEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _param:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         speed = 0.8;
         ai_index = _ai;
         this.param = _param;
         this.iceBlock = null;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         WIDTH = HEIGHT = 16;
         this.WALK_FLAG = false;
         this.jump_cool_down_counter = 0;
         this.wait_time = int(Math.random() * 5);
         sprite = new YetiEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_PRE_JUMPING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","JUMP_ACTION","IS_PRE_JUMPING_STATE");
         stateMachine.setRule("IS_PRE_JUMPING_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_FROZEN_STATE","END_ACTION","IS_UNFREEZING_STATE");
         stateMachine.setRule("IS_UNFREEZING_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_PRE_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FROZEN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_UNFREEZING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_PRE_JUMPING_STATE",this.preJumpingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_FROZEN_STATE",this.frozenAnimation);
         stateMachine.setFunctionToState("IS_UNFREEZING_STATE",this.unfreezingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         energy = 1;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         this.iceBlock = null;
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
      
      override public function postInit() : void
      {
         var i:int = 0;
         var xDiff:Number = NaN;
         var yDiff:Number = NaN;
         var distance:Number = NaN;
         var minDistance:Number = -1;
         var index:int = 0;
         var x_t:int = getTileX(WIDTH * 0.5);
         var y_t:int = getTileY(HEIGHT * 0.5);
         if(level.levelData.getTileValueAt(x_t,y_t) == 13)
         {
            stateMachine.setState("IS_FROZEN_STATE");
            yPos += 6;
            for(i = 0; i < level.collisionsManager.collisions.length; i++)
            {
               if(level.collisionsManager.collisions[i] != null)
               {
                  if(level.collisionsManager.collisions[i] is BigIceBlockCollision)
                  {
                     xDiff = level.collisionsManager.collisions[i].xPos + 16 - getMidXPos();
                     yDiff = level.collisionsManager.collisions[i].yPos + 16 - getMidYPos();
                     distance = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
                     if(distance < minDistance || minDistance < 0)
                     {
                        minDistance = distance;
                        index = i;
                     }
                  }
               }
            }
            this.iceBlock = level.collisionsManager.collisions[index];
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         this.jump_cool_down_counter = 0;
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(this.jump_cool_down_counter-- <= 0)
         {
            this.jump_cool_down_counter = 0;
         }
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index == 1 || this.WALK_FLAG)
            {
               if(this.walk_counter-- < 0)
               {
                  stateMachine.performAction("WALK_ACTION");
               }
               if(!this.WALK_FLAG)
               {
                  this.jumpCheck();
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
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
            }
            else
            {
               xVel = -speed;
            }
            frame_counter += frame_speed;
            if(frame_counter >= 4)
            {
               frame_counter -= 4;
            }
            this.boundariesCheck();
            if(ai_index == 1)
            {
               if(this.walk_counter-- < 0)
               {
                  stateMachine.performAction("STOP_ACTION");
               }
               this.jumpCheck();
            }
         }
         else if(stateMachine.currentState == "IS_PRE_JUMPING_STATE")
         {
            ++counter1;
            if(counter1 >= 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(counter3++ == 5)
            {
               if(this.isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("tongue");
               }
            }
            if(yPos <= this.jumpAtYPos - 40)
            {
               yVel *= 0.9;
               if(Math.abs(yVel) < 0.1)
               {
                  ++counter1;
                  if(counter1 > 60)
                  {
                     stateMachine.performAction("POSITIVE_Y_VEL_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_FROZEN_STATE")
         {
            xVel = yVel = 0;
            if(this.iceBlock.IS_MELTING)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_UNFREEZING_STATE")
         {
            if(counter1++ >= 1)
            {
               counter1 = 0;
               if(xPos <= originalXPos)
               {
                  xPos = originalXPos + 1;
               }
               else
               {
                  xPos = originalXPos - 1;
               }
            }
            if(level.levelData.getTileValueAt(getTileX(WIDTH * 0.5),getTileY(HEIGHT * 0.5)) == 0)
            {
               stateMachine.performAction("END_ACTION");
               this.WALK_FLAG = true;
            }
         }
         if(!(stateMachine.currentState == "IS_FROZEN_STATE" || stateMachine.currentState == "IS_UNFREEZING_STATE"))
         {
            integratePositionAndCollisionDetection();
         }
         if(ai_index == 1 && this.param > 0)
         {
            if(yPos >= this.param)
            {
               yPos = this.param;
               yVel = 0;
               if(stateMachine.currentState == "IS_FALLING_STATE")
               {
                  level.particlesManager.snowParticlesEntity(this);
                  stateMachine.performAction("GROUND_COLLISION_ACTION");
               }
            }
         }
      }
      
      protected function jumpCheck() : void
      {
         var hero_mid_x:Number = NaN;
         var mid_x:Number = NaN;
         if(this.jump_cool_down_counter > 0)
         {
            return;
         }
         if(level.hero.yPos <= yPos + 32)
         {
            hero_mid_x = level.hero.getMidXPos();
            mid_x = getMidXPos();
            if(Math.abs(hero_mid_x - mid_x) <= 64)
            {
               if(hero_mid_x < mid_x && DIRECTION == LEFT)
               {
                  stateMachine.performAction("JUMP_ACTION");
               }
               else if(hero_mid_x > mid_x && DIRECTION == RIGHT)
               {
                  stateMachine.performAction("JUMP_ACTION");
               }
            }
         }
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
         if(sprite.gfxHandle().frame == 3)
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
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
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
      
      override protected function allowCatAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            return true;
         }
         if(level.hero.getMidXPos() < getMidXPos())
         {
            if(DIRECTION == Entity.RIGHT)
            {
               return false;
            }
         }
         else if(DIRECTION == Entity.LEFT)
         {
            return false;
         }
         return true;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.walk_counter = int(Math.random() * 4 + 2) * 30;
         counter1 = 0;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame_counter + 1);
         counter1 = 0;
         frame_speed = 0.2;
         this.walk_counter = int(Math.random() * 4 + 2) * 30;
         this.WALK_FLAG = false;
         speed = 0.75;
         x_friction = 0.8;
         xVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         if(this.isInsideInnerScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         yVel = -2;
         gravity_friction = 0;
         this.jumpAtYPos = yPos;
         counter1 = counter3 = 0;
         this.jump_cool_down_counter = 120;
         frame_speed = 0.4;
         xVel = 0;
      }
      
      public function preJumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.setEmotionParticle(Entity.EMOTION_SHOCKED);
      }
      
      public function fallingAnimation() : void
      {
         gravity_friction = 0.5;
         this.jump_cool_down_counter = 120;
      }
      
      public function unfreezingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         counter1 = counter2 = 0;
      }
      
      public function frozenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         gravity_friction = 0;
         this.walk_counter = 30;
         counter1 = 0;
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
   }
}
