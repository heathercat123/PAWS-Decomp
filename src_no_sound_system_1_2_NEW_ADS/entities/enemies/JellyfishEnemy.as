package entities.enemies
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.JellyfishEnemySprite;
   
   public class JellyfishEnemy extends Enemy
   {
       
      
      protected var IS_GOING_UP:Boolean;
      
      protected var RADIUS:Number;
      
      protected var original_angle:Number;
      
      protected var angle:Number;
      
      public function JellyfishEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _radius:Number = 0, _angle:Number = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         this.RADIUS = _radius;
         this.original_angle = this.angle = _angle;
         var path_length:Number = path_end_y - path_start_y;
         if(originalYPos < path_start_y + path_length * 0.5)
         {
            this.IS_GOING_UP = false;
         }
         else
         {
            this.IS_GOING_UP = true;
         }
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         sprite = new JellyfishEnemySprite(1);
         Utils.world.addChild(sprite);
         aabb.x = 2;
         aabb.y = -2;
         aabb.width = 12;
         aabb.height = 11;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","SWIM_ACTION","IS_SWIMMING_STATE");
         stateMachine.setRule("IS_SWIMMING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SWIMMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_SWIMMING_STATE",this.swimmingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
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
         var path_length:Number = NaN;
         super.reset();
         if(ai_index == 1)
         {
            this.original_angle = this.original_angle;
         }
         else
         {
            path_length = path_end_y - path_start_y;
            if(originalYPos < path_start_y + path_length * 0.5)
            {
               this.IS_GOING_UP = false;
            }
            else
            {
               this.IS_GOING_UP = true;
            }
         }
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(this.IS_GOING_UP)
         {
            if(yPos <= path_start_y)
            {
               yVel *= 0.95;
            }
         }
         else if(yPos + HEIGHT >= path_end_y)
         {
            yVel *= 0.95;
         }
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index == 0)
            {
               if(counter1++ > 15 && ai_index == 0)
               {
                  this.boundariesCheck();
                  stateMachine.performAction("SWIM_ACTION");
               }
               else
               {
                  this.faceTowardsHero();
               }
            }
            else
            {
               this.angle -= 0.6 * (1 / this.RADIUS);
               if(this.angle < 0)
               {
                  this.angle += Math.PI * 2;
               }
               xPos = originalXPos + Math.sin(this.angle) * this.RADIUS;
               yPos = originalYPos + Math.cos(this.angle) * this.RADIUS;
               this.faceTowardsHero();
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
         else if(stateMachine.currentState == "IS_SWIMMING_STATE")
         {
            if(counter1++ > 15)
            {
               yVel *= y_friction;
            }
            if(Math.abs(yVel) < 0.1)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         integratePositionAndCollisionDetection();
      }
      
      protected function faceTowardsHero() : void
      {
         if(DIRECTION == Entity.LEFT)
         {
            if(level.hero.getMidXPos() > getMidXPos() + 8)
            {
               stateMachine.performAction("TURN_ACTION");
            }
         }
         else if(level.hero.getMidXPos() < getMidXPos() - 8)
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      protected function boundariesCheck() : void
      {
         if(path_start_y != 0)
         {
            if(this.IS_GOING_UP)
            {
               if(yPos <= path_start_y)
               {
                  this.IS_GOING_UP = false;
               }
            }
            else if(yPos + HEIGHT >= path_end_y)
            {
               this.IS_GOING_UP = true;
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
      
      public function standingAnimation() : void
      {
         if(ai_index == 1)
         {
            sprite.gfxHandle().gotoAndStop(3);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            sprite.gfxHandle().gfxHandleClip().loop = true;
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(1);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         counter1 = counter2 = 0;
         xVel = 0;
         gravity_friction = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function swimmingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.IS_GOING_UP)
         {
            yVel = -0.75;
         }
         else
         {
            yVel = 0.75;
         }
         y_friction = 0.95;
         x_friction = 0.98;
         gravity_friction = 0;
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
      
      override public function deadAnimation() : void
      {
         super.deadAnimation();
         level.particlesManager.createClusterBubbles(getMidXPos(),getMidYPos());
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
