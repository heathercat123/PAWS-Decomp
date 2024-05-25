package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.WindEggEnemySprite;
   
   public class CactusEnemy extends Enemy
   {
       
      
      protected var slide_y_pos:Number;
      
      protected var bounce_amount:int;
      
      protected var IS_SPIKES_OUT:Boolean;
      
      protected var IS_SPIKES_OUT_ORIGINAL:Boolean;
      
      protected var fall_offset:int;
      
      protected var spikes_switch_counter:int;
      
      public function CactusEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _is_spikes_in:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 24;
         HEIGHT = 23;
         speed = 0.8;
         this.fall_offset = 0;
         this.spikes_switch_counter = 0;
         MAX_Y_VEL = 0.5;
         if(_is_spikes_in == 0)
         {
            this.IS_SPIKES_OUT = false;
         }
         else
         {
            this.IS_SPIKES_OUT = true;
         }
         this.IS_SPIKES_OUT_ORIGINAL = this.IS_SPIKES_OUT;
         sprite = new WindEggEnemySprite(1);
         Utils.world.addChild(sprite);
         aabbPhysics.x = 1;
         aabbPhysics.y = 0 + 6;
         aabbPhysics.width = 22;
         aabbPhysics.height = 23 - 6;
         aabb.x = 1;
         aabb.y = 0 + 6 + 3;
         aabb.width = 22;
         aabb.height = 23 - 6 - 3;
         ground_friction_time = 0.5;
         ground_friction = 1;
         this.slide_y_pos = 0;
         this.bounce_amount = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SPIKES_OUT_ACTION","IS_SPIKES_OUT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SPIKES_IN_ACTION","IS_SPIKES_IN_STATE");
         stateMachine.setRule("IS_SPIKES_OUT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_SPIKES_IN_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SPIKES_OUT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SPIKES_IN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_SPIKES_OUT_STATE",this.spikesOutAnimation);
         stateMachine.setFunctionToState("IS_SPIKES_IN_STATE",this.spikesInAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         energy = 1;
      }
      
      override public function reset() : void
      {
         super.reset();
         energy = 2;
         this.spikes_switch_counter = 0;
         this.IS_SPIKES_OUT = this.IS_SPIKES_OUT_ORIGINAL;
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         x_friction = 1;
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame % 2 == 1)
            {
               if(DIRECTION == LEFT)
               {
                  xVel = -1;
               }
               else
               {
                  xVel = 1;
               }
            }
            else
            {
               xVel = 0;
            }
            if(path_start_x != 0)
            {
               if(DIRECTION == LEFT && xPos < path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               else if(DIRECTION == RIGHT && xPos + WIDTH > path_end_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            if(this.spikes_switch_counter++ > 180)
            {
               this.spikes_switch_counter = 0;
               if(this.IS_SPIKES_OUT)
               {
                  stateMachine.performAction("SPIKES_IN_ACTION");
               }
               else
               {
                  stateMachine.performAction("SPIKES_OUT_ACTION");
               }
            }
            yVel += 0.25;
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
            yVel += 0.25;
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
            yVel += 0.25;
         }
         else if(stateMachine.currentState == "IS_SPIKES_OUT_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().frame == 1)
            {
               if(counter2++ > 1)
               {
                  counter2 = 0;
                  ++counter3;
                  if(xPos >= counter1)
                  {
                     xPos = counter1 - 1;
                  }
                  else
                  {
                     xPos = counter1 + 1;
                  }
                  if(counter3 >= 20)
                  {
                     if(this.isInsideScreen())
                     {
                        SoundSystem.PlaySound("dig");
                     }
                     sprite.gfxHandle().gfxHandleClip().gotoAndPlay(2);
                     xPos = counter1;
                     yVel = -2;
                  }
                  else if(this.isInsideScreen())
                  {
                     SoundSystem.PlaySound("blue_platform");
                  }
               }
            }
            else
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  this.IS_SPIKES_OUT = true;
                  stateMachine.performAction("END_ACTION");
               }
               yVel += 0.25;
            }
         }
         else if(stateMachine.currentState == "IS_SPIKES_IN_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               this.IS_SPIKES_OUT = false;
               stateMachine.performAction("END_ACTION");
            }
            yVel += 0.25;
         }
         if(this.IS_SPIKES_OUT)
         {
            aabbSpike.x = -2;
            aabbSpike.y = 4;
            aabbSpike.width = 28;
            aabbSpike.height = 16;
         }
         else
         {
            aabbSpike.width = aabbSpike.height = 0;
         }
         MAX_X_VEL = 2;
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
      
      override public function noGroundCollision() : void
      {
         stateMachine.performAction("NO_GROUND_ACTION");
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(yVel >= 0)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
         yVel = 0;
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         stateMachine.performAction("TURN_ACTION");
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         super.checkHeroCollisionDetection(hero);
      }
      
      override protected function specialAttackCondition() : Boolean
      {
         if(level.hero.stateMachine.currentState == "IS_FALLING_STATE" && level.hero.stateMachine.lastState == "IS_FALLING_RUNNING_STATE" && stateMachine.currentState == "IS_BLOWING_STATE")
         {
            return true;
         }
         return false;
      }
      
      public function walkingAnimation() : void
      {
         if(this.IS_SPIKES_OUT)
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(1);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         if(this.IS_SPIKES_OUT)
         {
            sprite.gfxHandle().gotoAndStop(4);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(3);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function hitAnimation() : void
      {
         if(this.IS_SPIKES_OUT)
         {
            sprite.gfxHandle().gotoAndStop(8);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(7);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         level.camera.shake(6);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      protected function fallingAnimation() : void
      {
         if(DIRECTION == Entity.RIGHT)
         {
            this.fall_offset = 8;
         }
         else
         {
            this.fall_offset = -8;
         }
         xVel = 0;
      }
      
      public function spikesInAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.IS_SPIKES_OUT = false;
         counter1 = counter2 = 0;
         xVel = 0;
         yVel = -2;
         SoundSystem.PlaySound("enemy_jump_low");
      }
      
      public function spikesOutAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = xPos;
         counter2 = counter3 = 0;
         xVel = 0;
         yVel = 0;
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(this.IS_SPIKES_OUT)
         {
            if(level.hero.getAABB().intersects(getAABBSpike()))
            {
               return false;
            }
         }
         return true;
      }
      
      override protected function removeGroundFriction() : void
      {
         ground_friction = 1;
         ground_friction_tick = ground_friction_time;
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
