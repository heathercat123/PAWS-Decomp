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
   import sprites.bullets.PollenBulletSprite;
   import sprites.enemies.SeedPollenEnemySprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class SeedPollenEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var unhide_distance:Number;
      
      public function SeedPollenEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = 0;
         this.unhide_distance = 64;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new SeedPollenEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13 + 12;
         aabbPhysics.x = 1;
         aabbPhysics.y = 11;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SCARED_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SCARED_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_SCARED_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","TURN_ACTION","IS_TURNING_RUNNING_STATE");
         stateMachine.setRule("IS_TURNING_RUNNING_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SCARED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_RUNNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_SCARED_STATE",this.scaredAnimation);
         stateMachine.setFunctionToState("IS_RUNNING_STATE",this.runningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_RUNNING_STATE",this.turnRunningAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         if(ai_index == 0)
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
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 2) + 0.5));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 2 + 3) * 60;
               stateMachine.performAction("WALK_ACTION");
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
         else if(stateMachine.currentState == "IS_SCARED_STATE")
         {
            if(counter1++ > 20)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 3 + 1) * 30;
               stateMachine.performAction("STOP_ACTION");
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
         else if(stateMachine.currentState == "IS_RUNNING_STATE")
         {
            if(DIRECTION == RIGHT)
            {
               xVel += speed;
            }
            else
            {
               xVel += -speed;
            }
            this.boundariesCheck();
            if(counter2-- < 0)
            {
               stateMachine.performAction("END_ACTION");
            }
            if(counter3++ > 6)
            {
               counter3 = 0;
               level.particlesManager.groundSmokeParticles(this);
            }
         }
         else if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            if(Math.abs(level.hero.getMidXPos() - getMidXPos()) < this.unhide_distance)
            {
               counter3 = 1;
            }
            if(counter3 > 0)
            {
               if(counter1++ > 1)
               {
                  counter1 = 0;
                  if(xPos <= originalXPos)
                  {
                     SoundSystem.PlaySound("blue_platform");
                     xPos = originalXPos + 2;
                  }
                  else
                  {
                     xPos = originalXPos;
                  }
               }
               if(counter2++ > 30)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            this.walk_counter = 20;
         }
         integratePositionAndCollisionDetection();
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
      
      public function turnRunningAnimation() : void
      {
         changeDirection();
         stateMachine.performAction("END_ACTION");
         counter1 = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame_counter + 1);
         counter1 = 0;
         MAX_X_VEL = 0.5;
         speed = 1;
         x_friction = 0.8;
         xVel = 0;
         gravity_friction = 1;
      }
      
      public function runningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         MAX_X_VEL = 3;
         speed = 1;
         x_friction = 0.8;
         xVel = 0;
         gravity_friction = 1;
      }
      
      public function scaredAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter3 = 0;
         counter2 = int(Math.round(Math.random() * 2 + 4)) * 60;
         xVel = yVel = 0;
         this.setEmotionParticle(Entity.EMOTION_SHOCKED);
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function isInsideInnerScreen(offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      protected function pollenExplosion() : void
      {
         var i:int = 0;
         var pSprite:PollenBulletSprite = null;
         var angle:Number = NaN;
         var radius:Number = NaN;
         SoundSystem.PlaySound("dig");
         for(i = 0; i < 3; i++)
         {
            if(i == 0)
            {
               angle = Math.PI * 0.6;
            }
            else if(i == 1)
            {
               angle = Math.PI * 0.5 + Math.PI * 0.25;
            }
            else if(i == 2)
            {
               angle = Math.PI * 0.5 + Math.PI * 0.75;
            }
            else
            {
               angle = Math.PI * 0.9;
            }
            radius = 4 + Math.random() * 4;
            pSprite = new PollenBulletSprite();
            level.bulletsManager.pushBackBullet(pSprite,xPos + 8 + Math.sin(angle) * radius,yPos + Math.cos(angle) * radius,Math.sin(angle) * radius,Math.cos(angle) * radius,0.9 + Math.random() * 0.05,Math.random() * Math.PI * 2);
         }
      }
      
      override public function deadAnimation() : void
      {
         super.deadAnimation();
         this.pollenExplosion();
      }
   }
}
