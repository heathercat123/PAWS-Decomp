package entities.enemies
{
   import entities.Easings;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.collisions.BigIceBlockCollision;
   import levels.collisions.WaterfallCollision;
   import sprites.enemies.*;
   import states.LevelState;
   
   public class RiverFishEnemy extends Enemy
   {
       
      
      protected var speed_multiplier:Number;
      
      protected var jump_counter:int;
      
      protected var IS_ON_GROUND:Boolean;
      
      protected var APPEAR_FIRST_TIME_FLAG:Boolean;
      
      protected var iceBlock:BigIceBlockCollision;
      
      protected var swim_counter:Number;
      
      protected var IS_SWIMMING:Boolean;
      
      protected var stayStill:Boolean;
      
      protected var stayStillCounter:int;
      
      public function RiverFishEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, jump_delay:int, ai:int)
      {
         super(_level,_xPos,_yPos,_direction,ai);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         this.stayStill = true;
         this.stayStillCounter = 0;
         this.iceBlock = null;
         MAX_Y_VEL = 0.5;
         this.IS_ON_GROUND = false;
         this.APPEAR_FIRST_TIME_FLAG = true;
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
         this.swim_counter = Math.random() * 30 + 30;
         this.IS_SWIMMING = true;
         ground_friction_time = 0.5;
         this.speed_multiplier = 1;
         ground_friction = 1;
         this.jump_counter = jump_delay;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STUCK_STATE","JUMP_ACTION","IS_STUCK_JUMPING_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_STUCK_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","GETS_INTO_WATER_ACTION","IS_SUB_DIVING_STATE");
         stateMachine.setRule("IS_STUCK_STATE","GETS_INTO_WATER_ACTION","IS_SUB_DIVING_STATE");
         stateMachine.setRule("IS_SUB_DIVING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_FROZEN_STATE","END_ACTION","IS_UNFREEZING_STATE");
         stateMachine.setRule("IS_UNFREEZING_STATE","END_ACTION","IS_STUCK_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STUCK_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STUCK_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FROZEN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_UNFREEZING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_STUCK_STATE",this.stuckAnimation);
         stateMachine.setFunctionToState("IS_STUCK_JUMPING_STATE",this.stuckJumpingAnimation);
         stateMachine.setFunctionToState("IS_SUB_DIVING_STATE",this.subDivingAnimation);
         stateMachine.setFunctionToState("IS_FROZEN_STATE",this.frozenAnimation);
         stateMachine.setFunctionToState("IS_UNFREEZING_STATE",this.unfreezingAnimation);
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
         else if(Utils.SEA_LEVEL <= 0)
         {
            stateMachine.setState("IS_STUCK_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         energy = 1;
      }
      
      override public function destroy() : void
      {
         this.iceBlock = null;
         super.destroy();
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
            yPos += 2;
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
      
      override protected function allowScubaMaskAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_STUCK_JUMPING_STATE" || stateMachine.currentState == "IS_STUCK_STATE")
         {
            return false;
         }
         return true;
      }
      
      override public function update() : void
      {
         var xDiff:Number = NaN;
         super.update();
         aabbPhysics.height = 10;
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(ai_index == 2)
            {
               if(this.IS_SWIMMING)
               {
                  this.speed_multiplier -= 0.02;
                  if(DIRECTION == LEFT)
                  {
                     xVel -= 0.04;
                  }
                  else
                  {
                     xVel += 0.04;
                  }
                  if(this.swim_counter-- < 0)
                  {
                     this.swim_counter = Math.random() * 60 + 60;
                     this.IS_SWIMMING = !this.IS_SWIMMING;
                  }
               }
               else
               {
                  this.speed_multiplier += 0.01;
                  if(this.swim_counter-- < 0)
                  {
                     this.swim_counter = Math.random() * 120 + 30;
                     this.IS_SWIMMING = !this.IS_SWIMMING;
                  }
               }
               xDiff = originalXPos - xPos;
               xVel += xDiff * 0.005;
               if(DIRECTION == RIGHT)
               {
                  if(xPos < originalXPos)
                  {
                     xVel *= 0.95;
                  }
               }
               else if(xPos > originalXPos)
               {
                  xVel *= 0.95;
               }
            }
            else if(DIRECTION == LEFT)
            {
               xVel -= 0.03;
               if(xPos <= path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else
            {
               xVel += 0.03;
               if(xPos + WIDTH >= path_end_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            if(ai_index == 1)
            {
               if(xPos < 16)
               {
                  dead = true;
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
            if(this.IS_ON_GROUND)
            {
               if(counter1++ > 15)
               {
                  counter1 = 0;
                  stateMachine.performAction("JUMP_ACTION");
               }
            }
            if(ai_index == 1)
            {
               if(Utils.SEA_LEVEL > 0)
               {
                  if(yPos >= Utils.SEA_LEVEL)
                  {
                     DIRECTION = LEFT;
                     originalYPos = Utils.SEA_LEVEL + 16;
                     stateMachine.performAction("GETS_INTO_WATER_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_STUCK_JUMPING_STATE")
         {
            aabbPhysics.height = 13;
            if(Math.abs(yVel) <= 0.1 && this.stayStill && gravity_friction <= 0.25)
            {
               gravity_friction = 0;
               if(this.stayStillCounter++ >= 10)
               {
                  this.stayStill = false;
                  gravity_friction = 0.2;
               }
            }
            if(ai_index == 1)
            {
               if(Utils.SEA_LEVEL > 0)
               {
                  if(yPos >= Utils.SEA_LEVEL)
                  {
                     DIRECTION = LEFT;
                     originalYPos = Utils.SEA_LEVEL + 16;
                     stateMachine.performAction("GETS_INTO_WATER_ACTION");
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
            }
         }
         else if(stateMachine.currentState == "IS_SUB_DIVING_STATE")
         {
            if(counter1 == 0)
            {
               yVel -= 0.05;
            }
            else
            {
               yVel += 0.025;
            }
            yPos += yVel;
            if(counter1 == 0)
            {
               if(yPos <= originalYPos)
               {
                  counter1 = 1;
               }
            }
            else if(yPos >= originalYPos)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(ai_index == 2)
         {
            if(this.speed_multiplier <= 0.25)
            {
               this.speed_multiplier = 0.25;
            }
            else if(this.speed_multiplier >= 0.5)
            {
               this.speed_multiplier = 0.5;
            }
         }
         else
         {
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
         }
         if(!(stateMachine.currentState == "IS_FROZEN_STATE" || stateMachine.currentState == "IS_UNFREEZING_STATE"))
         {
            this.integratePositionAndCollisionDetection();
         }
      }
      
      override public function groundCollision() : void
      {
         var x_diff:Number = NaN;
         stateMachine.performAction("GROUND_COLLISION_ACTION");
         this.IS_ON_GROUND = true;
         if(colliding_platform != null)
         {
            if(colliding_platform is WaterfallCollision)
            {
               x_diff = Math.abs(colliding_platform.xPos + colliding_platform.WIDTH * 0.5 - getMidXPos());
               if(x_diff <= 24)
               {
                  this.IS_ON_GROUND = false;
               }
            }
         }
      }
      
      override protected function integratePositionAndCollisionDetection() : void
      {
         MAX_X_VEL = 1;
         MAX_Y_VEL = 4;
         yVel += 0.4 * gravity_friction;
         if(ai_index == 1)
         {
            if(yPos >= level.camera.yPos - 12 && yPos < level.camera.yPos)
            {
               if(!this.IS_ON_GROUND && this.APPEAR_FIRST_TIME_FLAG)
               {
                  yVel *= 0.5;
               }
            }
         }
         xVel *= x_friction;
         if(xVel > MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel < -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel > MAX_Y_VEL)
         {
            yVel = MAX_Y_VEL;
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
         x_friction = 1;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
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
         counter1 = 0;
      }
      
      public function stuckAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         gravity_friction = 0.4;
         x_friction = 0.8;
         xVel = 0;
      }
      
      public function stuckJumpingAnimation() : void
      {
         var jump_x_mult:Number = 1;
         x_friction = 1;
         this.IS_ON_GROUND = false;
         this.stayStill = false;
         this.stayStillCounter = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_2_5)
         {
            if(this.jump_counter <= 1)
            {
               yVel = -(Math.random() * 1 + 1);
               gravity_friction = 0.4;
               if(ai_index == 1)
               {
                  if(Math.random() * 100 > 50)
                  {
                     jump_x_mult = -1;
                  }
                  else
                  {
                     jump_x_mult = 1;
                  }
                  if(getMidXPos() > 256)
                  {
                     xVel = -(Math.random() * 1 + 1) * 0.5 * jump_x_mult;
                  }
                  else
                  {
                     xVel = (Math.random() * 1 + 1) * 0.5 * jump_x_mult;
                  }
               }
            }
            else
            {
               level.particlesManager.createDewDroplets(xPos + WIDTH * 0.5,yPos + HEIGHT);
               yVel = -2.75;
               if(isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_jump");
               }
               if(ai_index == 1)
               {
                  if(yPos >= 304)
                  {
                     jump_x_mult = 1;
                  }
                  else if(yPos >= 208)
                  {
                     jump_x_mult = -1;
                  }
                  else if(yPos >= 112)
                  {
                     jump_x_mult = 1;
                  }
                  if(getMidXPos() > 256)
                  {
                     xVel = -(Math.random() * 1 + 1) * 0.5 * jump_x_mult;
                  }
                  else
                  {
                     xVel = (Math.random() * 1 + 1) * 0.5 * jump_x_mult;
                  }
               }
               gravity_friction = 0.2;
            }
         }
         else if(this.jump_counter <= 1)
         {
            yVel = -(Math.random() * 1 + 1);
            if(Math.random() * 100 > 50)
            {
               xVel = Math.random() * 1 + 1;
            }
            else
            {
               xVel = -(Math.random() * 1 + 1);
            }
            if(getMidXPos() < originalXPos + 8 - 32)
            {
               xVel = Math.random() * 1 + 1;
            }
            else if(getMidXPos() > originalXPos + 8 + 32)
            {
               xVel = -(Math.random() * 1 + 1);
            }
            gravity_friction = 0.4;
         }
         else
         {
            level.particlesManager.createDewDroplets(xPos + WIDTH * 0.5,yPos + HEIGHT);
            yVel = -2.75;
            xVel = 0;
            if(isInsideInnerScreen())
            {
               SoundSystem.PlaySound("enemy_jump");
            }
            gravity_friction = 0.2;
         }
         ++this.jump_counter;
         if(this.jump_counter > 2)
         {
            this.jump_counter = 0;
         }
         counter1 = 0;
         this.stayStill = true;
         this.stayStillCounter = 0;
         if(Math.random() * 100 > 50)
         {
            changeDirection();
         }
      }
      
      public function subDivingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         xVel = yVel = 0;
         yVel = 0.5;
         counter1 = 0;
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
