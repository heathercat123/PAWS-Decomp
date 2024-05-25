package entities.enemies
{
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.WallSoldierEnemySprite;
   
   public class WallSoldierEnemy extends TinEnemy
   {
       
      
      protected var IS_GOING_UP:Boolean;
      
      public function WallSoldierEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _go_up:int)
      {
         var offset_x:int = 1;
         if(_direction > 0)
         {
            offset_x = -1;
         }
         super(_level,_xPos + offset_x,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.IS_GOING_UP = false;
         if(_go_up > 0)
         {
            this.IS_GOING_UP = true;
         }
         sprite = new WallSoldierEnemySprite();
         Utils.world.addChild(sprite);
         if(DIRECTION == RIGHT)
         {
            aabb.x = -7;
         }
         else
         {
            aabb.x = -1;
         }
         aabb.y = -6;
         aabb.width = 8;
         aabb.height = 12;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 0;
         aabbPhysics.height = 0;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(path_start_y == 0)
         {
            stateMachine.setState("IS_STANDING_STATE");
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
         if(path_start_y == 0)
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
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
         super.update();
         if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState == "IS_TURNING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  this.IS_GOING_UP = !this.IS_GOING_UP;
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               if(this.IS_GOING_UP)
               {
                  yVel = -speed;
               }
               else
               {
                  yVel = speed;
               }
               this.boundariesCheck();
            }
         }
         gravity_friction = 0;
         this.integratePositionAndCollisionDetection();
      }
      
      override protected function integratePositionAndCollisionDetection() : void
      {
         yVel += 0.4 * gravity_friction;
         xVel *= x_friction;
         if(xVel >= MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel <= -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel >= MAX_Y_VEL)
         {
            yVel = MAX_Y_VEL;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
      }
      
      protected function boundariesCheck() : void
      {
         if(path_start_y != 0)
         {
            if(this.IS_GOING_UP)
            {
               if(yPos <= path_start_y)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(yPos >= path_end_y)
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
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         frame_speed = 0.2;
         speed = 0.5;
         x_friction = 0.8;
         xVel = yVel = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override protected function setHitVariables() : void
      {
         var diff_x_mult:Number = 1;
         t_hurt_start_x = xPos;
         t_hurt_start_y = yPos;
         if(DIRECTION == LEFT)
         {
            diff_x_mult = -1;
         }
         if(Math.random() * 100 > 50)
         {
            t_hurt_diff_x = 16 * diff_x_mult;
         }
         else if(Math.random() * 100 > 50)
         {
            t_hurt_diff_x = 24 * diff_x_mult;
         }
         else
         {
            t_hurt_diff_x = 8 * diff_x_mult;
         }
         if(Math.random() * 100 > 50)
         {
            t_hurt_diff_y = -16;
         }
         else if(Math.random() * 100 > 50)
         {
            t_hurt_diff_y = -24;
         }
         else
         {
            t_hurt_diff_y = -8;
         }
         t_hurt_tick = 0;
         t_hurt_time = 0.25 + int(Math.random() * 3) / 10;
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
