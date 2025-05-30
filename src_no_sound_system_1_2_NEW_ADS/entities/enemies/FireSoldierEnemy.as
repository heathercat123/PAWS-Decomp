package entities.enemies
{
   import entities.Entity;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.bullets.FirePlantBulletSprite;
   import sprites.enemies.FireSoldierEnemySprite;
   import sprites.particles.DarkGreySmokeParticleSprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class FireSoldierEnemy extends TinEnemy
   {
      
      protected var wait_time:int;
      
      protected var small_jump_counter:int;
      
      protected var attack_counter:int;
      
      public function FireSoldierEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.small_jump_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new FireSoldierEnemySprite();
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
         this.attack_counter = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HOP_ACTION","IS_HOPPING_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","GROUND_COLLISION_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","ATTACK_ACTION","IS_ATTACK_START_STATE");
         stateMachine.setRule("IS_ATTACK_START_STATE","END_ACTION","IS_ATTACKING_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_ATTACK_END_STATE");
         stateMachine.setRule("IS_ATTACK_END_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ATTACK_START_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ATTACK_END_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HOPPING_STATE",this.hoppingAnimation);
         stateMachine.setFunctionToState("IS_ATTACK_START_STATE",this.attackStartAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackAnimation);
         stateMachine.setFunctionToState("IS_ATTACK_END_STATE",this.attackEndAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
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
         if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState != "IS_WALKING_STATE" && stateMachine.currentState != "IS_TURNING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function update() : void
      {
         var radius:Number = NaN;
         super.update();
         if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState == "IS_TURNING_STATE")
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
               if(this.attack_counter++ > 120)
               {
                  stateMachine.performAction("ATTACK_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_HOPPING_STATE")
            {
               frame_counter += frame_speed;
               if(frame_counter >= 4)
               {
                  frame_counter -= 4;
               }
            }
            else if(stateMachine.currentState == "IS_ATTACK_START_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_ATTACKING_STATE")
            {
               ++counter1;
               if(counter1 > 2)
               {
                  counter1 = 0;
                  if(sprite.gfxHandle().gfxHandleClip().frame == 1)
                  {
                     sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
                  }
                  else
                  {
                     sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  }
               }
               ++counter2;
               if(counter2 > 15)
               {
                  if(this.isInsideInnerScreen())
                  {
                     SoundSystem.PlaySound("fire_shoot");
                  }
                  counter2 = 0;
                  radius = 2;
                  if(Math.random() * 100 > 50)
                  {
                     level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos + WIDTH * 0.5,yPos,-0.3,-(radius + Math.random() * 0.5),1);
                  }
                  else
                  {
                     level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos + WIDTH * 0.5,yPos,0.3,-(radius + Math.random() * 0.5),1);
                  }
               }
               if(counter3++ > 90)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_ATTACK_END_STATE")
            {
               ++counter1;
               if(counter1 == 15)
               {
                  this.smokeParticles();
               }
               if(counter1 > 60)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         integratePositionAndCollisionDetection();
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
         if(stateMachine.currentState == "IS_HOPPING_STATE")
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
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
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
         speed = 1;
         x_friction = 0.8;
         xVel = 0;
      }
      
      public function hoppingAnimation() : void
      {
         yVel = -2;
         gravity_friction = 0.5;
         this.small_jump_counter = int(Math.random() * 3 + 1) * 60;
         frame_speed = 0.4;
         xVel = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function attackStartAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function attackAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = counter3 = 0;
         counter2 = 30;
         xVel = yVel = 0;
      }
      
      public function attackEndAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.attack_counter = 0;
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
      
      protected function smokeParticles() : void
      {
         var i:int = 0;
         var pSprite:DarkGreySmokeParticleSprite = null;
         for(i = 0; i < 2; i++)
         {
            pSprite = new DarkGreySmokeParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndPlay(1);
            }
            level.particlesManager.pushBackParticle(pSprite,xPos + 8 + (Math.random() * 4 - 2),yPos + i * 8,0,-1,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80);
         }
      }
   }
}

