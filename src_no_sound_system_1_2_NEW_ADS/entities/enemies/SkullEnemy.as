package entities.enemies
{
   import entities.Hero;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.SkullEnemySprite;
   
   public class SkullEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var IS_ON_TOP_WORLD:Boolean;
      
      public function SkullEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         this.wait_time = int(Math.random() * 5);
         sprite = new SkullEnemySprite();
         Utils.world.addChild(sprite);
         if(ai_index == 0)
         {
            MAX_X_VEL = 2;
         }
         this.IS_ON_TOP_WORLD = true;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         speed = 2.5;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_SLEEPING_STATE","WAKE_UP_ACTION","IS_SHAKING_STATE");
         stateMachine.setRule("IS_SHAKING_STATE","END_ACTION","IS_WAKING_UP_STATE");
         stateMachine.setRule("IS_WAKING_UP_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WAKING_UP_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_SHAKING_STATE",this.shakingAnimation);
         stateMachine.setFunctionToState("IS_WAKING_UP_STATE",this.wakingUpAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 1)
         {
            stateMachine.setState("IS_SLEEPING_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
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
         if(ai_index == 1)
         {
            stateMachine.setState("IS_SLEEPING_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         energy = 2;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE")
         {
            super.checkHeroCollisionDetection(hero);
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
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            x_diff = Math.abs(xPos + WIDTH * 0.5 - (level.hero.xPos + level.hero.WIDTH * 0.5));
            y_diff = Math.abs(yPos + HEIGHT * 0.5 - (level.hero.yPos + level.hero.HEIGHT * 0.5));
            if(x_diff <= Utils.TILE_WIDTH * 3)
            {
               if(y_diff <= Utils.TILE_HEIGHT)
               {
                  stateMachine.performAction("WAKE_UP_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_SHAKING_STATE")
         {
            ++counter1;
            if(counter1 > 2)
            {
               counter1 = 0;
               ++counter2;
               if(xPos == originalXPos)
               {
                  if(DIRECTION == RIGHT)
                  {
                     xPos = originalXPos - 2;
                  }
                  else
                  {
                     xPos = originalXPos + 2;
                  }
               }
               else
               {
                  xPos = originalXPos;
               }
               if(counter2 > 10 + this.wait_time)
               {
                  xPos = originalXPos;
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_WAKING_UP_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               if(level.hero.xPos + level.hero.WIDTH * 0.5 > xPos + WIDTH * 0.5)
               {
                  if(DIRECTION == LEFT)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
               else if(DIRECTION == RIGHT)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               else
               {
                  stateMachine.performAction("END_ACTION");
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
            if(ai_index == 1)
            {
               if(counter2-- < 0)
               {
                  counter2 = int(Math.random() * 5 + 2) * 5;
                  if(Math.random() * 100 > 50)
                  {
                     MAX_X_VEL += 0.25;
                  }
                  else
                  {
                     MAX_X_VEL -= 0.25;
                  }
                  if(speed < 2)
                  {
                     speed = 2;
                  }
                  else if(speed > 2.5)
                  {
                     speed = 2.5;
                  }
               }
               if(DIRECTION == RIGHT)
               {
                  xVel += speed;
               }
               else
               {
                  xVel += -speed;
               }
               if(counter3++ > 6)
               {
                  counter3 = -Math.random() * 3;
                  level.particlesManager.groundSmokeParticles(this);
               }
            }
            else
            {
               speed = 0.8;
               if(DIRECTION == RIGHT)
               {
                  xVel += speed;
               }
               else
               {
                  xVel += -speed;
               }
               this.boundariesCheck();
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
         var x_t:int = 0;
         var y_t:int = 0;
         if(ai_index == 0)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            x_t = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
            y_t = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
            if(DIRECTION == RIGHT)
            {
               if(level.levelData.getTileValueAt(x_t + 1,y_t - 1) == 0)
               {
                  yVel = -4;
               }
               else
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(level.levelData.getTileValueAt(x_t - 1,y_t - 1) == 0)
            {
               yVel = -4;
            }
            else
            {
               stateMachine.performAction("TURN_ACTION");
            }
         }
      }
      
      public function sleepingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         x_friction = 0.8;
         xVel = yVel = 0;
         if(!this.IS_ON_TOP_WORLD)
         {
            this.IS_ON_TOP_WORLD = true;
         }
      }
      
      public function shakingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("skull_wake_up");
         }
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         counter2 = 0;
         xVel = 0;
      }
      
      public function wakingUpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.IS_ON_TOP_WORLD)
         {
            this.IS_ON_TOP_WORLD = false;
         }
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(ai_index == 0)
         {
            x_friction = 0.8;
            MAX_X_VEL = 1;
         }
         else if(ai_index == 1)
         {
            x_friction = 1;
            gravity_friction = 1.2;
            MAX_X_VEL = 2.5;
            MAX_Y_VEL = 4;
         }
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
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
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
   }
}
