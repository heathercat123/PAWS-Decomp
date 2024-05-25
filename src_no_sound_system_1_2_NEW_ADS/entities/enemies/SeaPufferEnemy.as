package entities.enemies
{
   import entities.Easings;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.SeaPufferEnemySprite;
   
   public class SeaPufferEnemy extends Enemy
   {
       
      
      protected var speed_multiplier:Number;
      
      protected var inflate_counter:int;
      
      public function SeaPufferEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, jump_delay:int, _ai_index:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         sprite = new SeaPufferEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.x = 0;
         aabbPhysics.y = -3;
         aabbPhysics.width = 16;
         aabbPhysics.height = 10;
         x_friction = 1;
         aabbPhysics.height = 10;
         aabb.x = 0;
         aabb.y = -3;
         aabb.width = 16;
         aabb.height = 14;
         ground_friction_time = 0.5;
         this.speed_multiplier = 1;
         ground_friction = 1;
         this.inflate_counter = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","INFLATE_ACTION","IS_INFLATING_STATE");
         stateMachine.setRule("IS_INFLATING_STATE","END_ACTION","IS_INFLATED_STATE");
         stateMachine.setRule("IS_INFLATED_STATE","END_ACTION","IS_DEFLATING_STATE");
         stateMachine.setRule("IS_DEFLATING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STUCK_STATE","END_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_INFLATING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_INFLATED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_DEFLATING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STUCK_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_INFLATING_STATE",this.inflatingAnimation);
         stateMachine.setFunctionToState("IS_INFLATED_STATE",this.inflatedAnimation);
         stateMachine.setFunctionToState("IS_DEFLATING_STATE",this.deflatingAnimation);
         stateMachine.setFunctionToState("IS_STUCK_STATE",this.stuckAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 1)
         {
            stateMachine.setState("IS_STUCK_STATE");
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
         if(stateMachine.currentState != "IS_STUCK_STATE")
         {
            x_friction = 1;
            aabbPhysics.height = 10;
         }
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
            ++this.inflate_counter;
            if(this.inflate_counter > 0)
            {
               this.inflate_counter = 0;
            }
            if(getDistanceFromHero() < 80 && this.inflate_counter >= 0 && isFacingHero())
            {
               stateMachine.performAction("INFLATE_ACTION");
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
         else if(stateMachine.currentState == "IS_INFLATING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_INFLATED_STATE")
         {
            ++this.inflate_counter;
            if(this.inflate_counter >= 240)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_DEFLATING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               this.inflate_counter = -90;
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_STUCK_STATE")
         {
            ++counter1;
            if(counter1 >= 180)
            {
               stateMachine.performAction("END_ACTION");
            }
            if(yVel >= 4)
            {
               yVel = 4;
            }
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
      }
      
      override protected function integratePositionAndCollisionDetection() : void
      {
         MAX_X_VEL = 0.5;
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
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_INFLATING_STATE" || stateMachine.currentState == "IS_INFLATED_STATE" || stateMachine.currentState == "IS_DEFLATING_STATE")
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
      
      public function inflatingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_shoot_bubble");
         }
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         counter1 = 0;
         this.bubbleParticles();
      }
      
      public function inflatedAnimation() : void
      {
         aabb.x = -8;
         aabb.y = -3 - 8;
         aabb.width = 16 + 16;
         aabb.height = 14 + 16;
         this.inflate_counter = 0;
      }
      
      public function deflatingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_shoot_bubble");
         }
         aabb.x = 0;
         aabb.y = -3;
         aabb.width = 16;
         aabb.height = 14;
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_STUCK_STATE")
         {
            return false;
         }
         return true;
      }
      
      public function stuckAnimation() : void
      {
         aabb.x = -8;
         aabb.y = -3 - 8;
         aabb.width = 16 + 16;
         aabb.height = 14 + 16;
         aabbPhysics.x = -8;
         aabbPhysics.y = -3 - 8;
         aabbPhysics.width = 16 + 16;
         aabbPhysics.height = 14 + 16;
         sprite.gfxHandle().scaleY = -1;
         counter1 = 0;
         gravity_friction = 0.4;
         x_friction = 0.8;
         xVel = 0;
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(3);
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         setHitVariables();
         counter1 = counter2 = 0;
      }
      
      protected function bubbleParticles() : void
      {
         var i:int = 0;
         var radius:int = 0;
         var start_angle:Number = Math.random() * Math.PI * 2;
         var step_angle:Number = Math.PI * 2 / 3;
         for(i = 0; i < 3; i++)
         {
            radius = 16 + int(Math.random() * 3) * 4;
            level.topParticlesManager.createClusterBubbles(getMidXPos() + Math.sin(start_angle + step_angle * i) * radius,getMidYPos() + Math.cos(start_angle + step_angle * i) * radius);
         }
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
