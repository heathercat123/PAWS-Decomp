package entities.enemies
{
   import entities.Easings;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.SeaFishEnemySprite;
   
   public class SeaFishEnemy extends Enemy
   {
       
      
      protected var speed_multiplier:Number;
      
      protected var jump_counter:int;
      
      public function SeaFishEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, jump_delay:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         sprite = new SeaFishEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.x = 0;
         aabbPhysics.y = -3;
         aabbPhysics.width = 16;
         aabbPhysics.height = 10;
         aabb.x = 0;
         aabb.y = -3;
         aabb.width = 16;
         aabb.height = 14;
         ground_friction_time = 0.5;
         this.speed_multiplier = 1;
         ground_friction = 1;
         this.jump_counter = jump_delay;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STUCK_STATE","JUMP_ACTION","IS_STUCK_JUMPING_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_STUCK_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STUCK_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_STUCK_STATE",this.stuckAnimation);
         stateMachine.setFunctionToState("IS_STUCK_JUMPING_STATE",this.stuckJumpingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(Utils.SEA_LEVEL > 0)
         {
            if(yPos < Utils.SEA_LEVEL)
            {
               stateMachine.setState("IS_STUCK_STATE");
            }
            else
            {
               stateMachine.setState("IS_WALKING_STATE");
            }
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         energy = 1;
      }
      
      override public function update() : void
      {
         super.update();
         x_friction = 1;
         aabbPhysics.height = 10;
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel -= 0.03;
               if(path_start_x > 0)
               {
                  if(xPos <= path_start_x)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
            }
            else
            {
               xVel += 0.03;
               if(path_end_x > 0)
               {
                  if(xPos + WIDTH >= path_end_x)
                  {
                     stateMachine.performAction("TURN_ACTION");
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
         else if(stateMachine.currentState == "IS_STUCK_STATE")
         {
            aabbPhysics.height = 13;
            if(counter1++ > 15)
            {
               counter1 = 0;
               stateMachine.performAction("JUMP_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_STUCK_JUMPING_STATE")
         {
            aabbPhysics.height = 13;
         }
         if(xVel <= 0 && DIRECTION == LEFT || xVel >= 0 && DIRECTION == RIGHT)
         {
            this.removeGroundFriction();
            this.speed_multiplier += 0.01;
         }
         else
         {
            this.addGroundFriction();
            this.speed_multiplier -= 0.02;
         }
         if(this.speed_multiplier <= 0.25)
         {
            this.speed_multiplier = 0.25;
         }
         else if(this.speed_multiplier >= 0.5)
         {
            this.speed_multiplier = 0.5;
         }
         this.integratePositionAndCollisionDetection();
      }
      
      override public function groundCollision() : void
      {
         stateMachine.performAction("GROUND_COLLISION_ACTION");
      }
      
      override protected function integratePositionAndCollisionDetection() : void
      {
         MAX_X_VEL = 1;
         yVel += 0.4 * gravity_friction;
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
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE")
         {
            sinCounter1 += 0.1;
            if(sinCounter1 >= Math.PI * 2)
            {
               sinCounter1 -= Math.PI * 2;
            }
            yPos = originalYPos + Math.sin(sinCounter1) * 1.5;
         }
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
         if(sprite.gfxHandle().frame == 1)
         {
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,0.1 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(1,0.2 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(2,0.2 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(3,0.1 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(4,0.2 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(5,0.2 * this.speed_multiplier);
         }
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function stuckAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         gravity_friction = 0.4;
      }
      
      public function stuckJumpingAnimation() : void
      {
         if(this.jump_counter <= 1)
         {
            yVel = -(Math.random() * 1 + 1);
            gravity_friction = 0.4;
         }
         else
         {
            level.particlesManager.createDewDroplets(xPos + WIDTH * 0.5,yPos + HEIGHT);
            yVel = -2.75;
            gravity_friction = 0.2;
         }
         ++this.jump_counter;
         if(this.jump_counter > 2)
         {
            this.jump_counter = 0;
         }
         counter1 = 0;
         if(Math.random() * 100 > 50)
         {
            changeDirection();
         }
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         setHitVariables();
         counter1 = counter2 = 0;
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
   }
}
