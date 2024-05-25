package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.bullets.Bullet;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.BoulderEnemySprite;
   
   public class BoulderEnemy extends Enemy
   {
       
      
      protected var slide_y_pos:Number;
      
      protected var bounce_amount:int;
      
      public function BoulderEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 24;
         HEIGHT = 23;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         sprite = new BoulderEnemySprite();
         Utils.world.addChild(sprite);
         AVOID_CEIL_COLLISION_DETECTION = true;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 22;
         aabbPhysics.height = 23;
         aabb.x = 1;
         aabb.y = 0;
         aabb.width = 22;
         aabb.height = 23;
         ground_friction_time = 0.5;
         ground_friction = 1;
         this.slide_y_pos = 0;
         this.bounce_amount = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","ON_TOP_ACTION","IS_TRANSFORM_START_STATE");
         stateMachine.setRule("IS_TRANSFORM_START_STATE","END_ACTION","IS_SLIDING_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","END_ACTION","IS_IMPACT_STATE");
         stateMachine.setRule("IS_IMPACT_STATE","END_ACTION","IS_ROLLING_STATE");
         stateMachine.setRule("IS_ROLLING_STATE","GROUND_ACTION","IS_IMPACT_STATE");
         stateMachine.setRule("IS_IMPACT_STATE","TRANSFORM_ACTION","IS_TRANSFORM_END_STATE");
         stateMachine.setRule("IS_TRANSFORM_END_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TRANSFORM_START_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TRANSFORM_END_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_TRANSFORM_START_STATE",this.transformStartAnimation);
         stateMachine.setFunctionToState("IS_SLIDING_STATE",this.slidingAnimation);
         stateMachine.setFunctionToState("IS_IMPACT_STATE",this.impactAnimation);
         stateMachine.setFunctionToState("IS_ROLLING_STATE",this.rollingAnimation);
         stateMachine.setFunctionToState("IS_TRANSFORM_END_STATE",this.transformEndAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 2;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState != "IS_WALKING_STATE" && stateMachine.currentState != "IS_TURNING_STATE" && stateMachine.currentState != "IS_STANDING_STATE" && stateMachine.currentState != "IS_TRANSFORM_END_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(stateMachine.currentState != "IS_WALKING_STATE" && stateMachine.currentState != "IS_TURNING_STATE" && stateMachine.currentState != "IS_STANDING_STATE" && stateMachine.currentState != "IS_TRANSFORM_END_STATE")
         {
            return;
         }
         super.bulletImpact(bullet);
      }
      
      override public function reset() : void
      {
         super.reset();
         energy = 2;
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         x_friction = 1;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(counter1++ > 20)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel = -1;
            }
            else
            {
               xVel = 1;
            }
            if(DIRECTION == LEFT && xPos < path_start_x)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            else if(DIRECTION == RIGHT && xPos + WIDTH > path_end_x)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
               if(ORIGINAL_DIRECTION == RIGHT)
               {
                  if(xPos >= path_start_x + 32)
                  {
                     stateMachine.performAction("ON_TOP_ACTION");
                  }
               }
               else if(xPos <= path_start_x + 32)
               {
                  stateMachine.performAction("ON_TOP_ACTION");
               }
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_TRANSFORM_START_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SLIDING_STATE")
         {
            if(yPos >= this.slide_y_pos + 2)
            {
               stateMachine.performAction("END_ACTION");
            }
            if(DIRECTION == LEFT)
            {
               xVel = -0.5;
            }
            else
            {
               xVel = 0.5;
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_ROLLING_STATE")
         {
            yVel += 0.1;
            if(DIRECTION == LEFT)
            {
               if(xPos <= path_start_x)
               {
                  xVel *= 0.985;
               }
            }
         }
         else if(stateMachine.currentState == "IS_IMPACT_STATE")
         {
            if(DIRECTION == LEFT && xPos <= path_start_x)
            {
               stateMachine.performAction("TRANSFORM_ACTION");
            }
            else if(DIRECTION == RIGHT && xPos >= path_end_x)
            {
               stateMachine.performAction("TRANSFORM_ACTION");
            }
            else if(counter1++ > 2)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TRANSFORM_END_STATE")
         {
            yVel += 0.5;
            if(counter1++ > 40)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         MAX_X_VEL = 1;
         xVel *= x_friction;
         if(xVel > MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel < -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override protected function allowCatAttack() : Boolean
      {
         return true;
      }
      
      override protected function allowEnemyDefend() : Boolean
      {
         if(stateMachine.currentState == "IS_SLIDING_STATE" || stateMachine.currentState == "IS_IMPACT_STATE" || stateMachine.currentState == "IS_ROLLING_STATE")
         {
            return true;
         }
         return false;
      }
      
      override public function groundCollision() : void
      {
         if(yVel >= 0)
         {
            if(stateMachine.currentState == "IS_ROLLING_STATE")
            {
               if(this.isInsideScreen())
               {
                  SoundSystem.PlaySound("ground_stomp");
               }
               level.particlesManager.createDust(xPos + 4,yPos + HEIGHT,Entity.LEFT);
               level.particlesManager.createDust(xPos + WIDTH - 4,yPos + HEIGHT,Entity.RIGHT);
            }
            stateMachine.performAction("GROUND_ACTION");
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function transformStartAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
         yVel = 0;
      }
      
      public function slidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.bounce_amount = 0;
         yVel = 0;
         this.slide_y_pos = yPos;
      }
      
      public function impactAnimation() : void
      {
         xVel = yVel = 0;
         counter1 = 0;
         if(this.isInsideScreen())
         {
            level.camera.shake(2);
         }
      }
      
      public function rollingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         counter1 = 0;
         ++this.bounce_amount;
         if(DIRECTION == LEFT)
         {
            xVel = -0.5;
         }
         else
         {
            xVel = 0.5;
         }
         yVel = -this.bounce_amount;
         if(yVel <= -3)
         {
            yVel = -3;
         }
      }
      
      public function transformEndAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
         yVel = 0;
         if(this.isInsideScreen())
         {
            level.camera.shake(4);
         }
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         level.camera.shake(6);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override protected function removeGroundFriction() : void
      {
         ground_friction = 1;
         ground_friction_tick = ground_friction_time;
      }
      
      override protected function addGroundFriction() : void
      {
         ground_friction_tick -= 1 / 60;
         if(ground_friction_tick <= 0)
         {
            ground_friction_tick = 0;
         }
         ground_friction = Easings.easeOutExpo(ground_friction_tick,1,-1,ground_friction_time);
      }
      
      override public function isInsideScreen() : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos - 8,level.camera.yPos - 8,level.camera.WIDTH + 16,level.camera.HEIGHT + 16);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
