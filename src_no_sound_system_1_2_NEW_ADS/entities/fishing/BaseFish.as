package entities.fishing
{
   import entities.Easings;
   import entities.Entity;
   import entities.Lure;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.Random;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.worlds.fishing.LevelFishing;
   import sprites.fishing.FishSprite;
   
   public class BaseFish extends Entity
   {
       
      
      public var TYPE:int = 0;
      
      public var SIZE:Number = 1;
      
      public var RANK:int = 0;
      
      protected var STAMINA_DECREASE_MULT:Number = 1;
      
      protected var STAMINA_INCREASE_MULT:Number = 1;
      
      protected var SPEED_MULT:Number = 1;
      
      protected var ESCAPE_DISTANCE:Number;
      
      protected var FIGHT_BASE:Number;
      
      protected var FIGHT_RAND:Number;
      
      protected var POWER_MULT:Number;
      
      protected var float_offset_counter:Number;
      
      protected var float_offset_radius:Number;
      
      protected var xPosWhenCaught:Number;
      
      protected var yPosWhenCaught:Number;
      
      protected var jump_counter_1:int;
      
      protected var jump_counter_2:int;
      
      protected var jump_counter_3:int;
      
      protected var jump_amounts:int;
      
      protected var glitter_particle:int;
      
      protected var yPosBeforeJump:Number;
      
      public var FIGHT_DIRECTION:int;
      
      public var spawn_counter:int;
      
      public var BRAIN_STATE:int;
      
      protected var destX:Number;
      
      protected var destY:Number;
      
      public var IS_ESCAPED:Boolean;
      
      protected var lure:Lure;
      
      public var stamina:Number;
      
      protected var stamina_time:Number;
      
      protected var stamina_tick:Number;
      
      protected var life:Number;
      
      public var direction_change_counter:int;
      
      protected var WRONG_INPUT:Boolean;
      
      public var xForce:Number;
      
      public var yForce:Number;
      
      public var distance_won:Number;
      
      public var previousXPos:Number;
      
      protected var JUMP_MULT:Number;
      
      public var IS_RARE:Boolean;
      
      public var IS_GOLDEN:Boolean;
      
      public function BaseFish(_level:Level, _type:int, _rank:int, _xPos:Number, _yPos:Number, _direction:int, _size:Number)
      {
         super(_level,_xPos,_yPos,_direction);
         this.TYPE = _type;
         this.SIZE = _size;
         this.RANK = _rank;
         this.IS_RARE = false;
         this.IS_GOLDEN = false;
         if(Utils.Slot.gameProgression[15] >= 2)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 65)
            {
               if(int(Math.random() * 192) == 1)
               {
                  this.IS_RARE = true;
               }
               if(int(Math.random() * 768) == 1)
               {
                  this.IS_RARE = false;
                  this.IS_GOLDEN = true;
               }
            }
            else
            {
               if(int(Math.random() * 256) == 1)
               {
                  this.IS_RARE = true;
               }
               if(int(Math.random() * 1024) == 1)
               {
                  this.IS_RARE = false;
                  this.IS_GOLDEN = true;
               }
            }
         }
         this.lure = null;
         this.float_offset_counter = Math.random() * Math.PI * 2;
         this.float_offset_radius = 0;
         this.xForce = this.yForce = 0;
         this.BRAIN_STATE = 0;
         this.WRONG_INPUT = false;
         this.ESCAPE_DISTANCE = 320;
         this.previousXPos = xPos;
         this.jump_amounts = 0;
         this.JUMP_MULT = 1;
         this.spawn_counter = -1;
         this.FIGHT_BASE = 120;
         this.FIGHT_RAND = 480;
         this.stamina = 1;
         this.jump_counter_1 = this.jump_counter_2 = this.jump_counter_3 = this.glitter_particle = 0;
         this.direction_change_counter = 0;
         this.IS_ESCAPED = false;
         x_friction = y_friction = 0.98;
         gravity_friction = 0;
         MAX_X_VEL = MAX_Y_VEL = 0.25;
         this.distance_won = 0;
         sprite = new FishSprite(this.TYPE,this.IS_RARE,this.IS_GOLDEN);
         Utils.world.addChild(sprite);
         sprite.gotoAndStop(1);
         Utils.world.setChildIndex(sprite,0);
         WIDTH = HEIGHT = 16;
         aabb = new Rectangle(-8,-8,16,16);
         aabbPhysics.x = aabbPhysics.y = -8;
         aabbPhysics.width = aabbPhysics.height = 16;
         this.initFishStats();
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","INCREASE_VEL_ACTION","IS_MOVING_STATE");
         stateMachine.setRule("IS_MOVING_STATE","ZERO_VEL_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_MOVING_STATE","OPPOSITE_VEL_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_MOVING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","END_ACTION","IS_MOVING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_MOVING_STATE",this.movingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setState("IS_MOVING_STATE");
      }
      
      protected function initFishStats() : void
      {
         this.POWER_MULT = FishManager.GetFishData()[this.TYPE].getPowerMultiplier(this.SIZE);
         if(this.IS_RARE)
         {
            this.POWER_MULT += 0.1;
         }
         else if(this.IS_GOLDEN)
         {
            this.POWER_MULT += 0.25;
         }
         this.stamina_time = 4 * FishManager.GetFishData()[this.TYPE].STAMINA_INCREASE_MULT * this.POWER_MULT;
         this.FIGHT_BASE = FishManager.GetFishData()[this.TYPE].FIGHT_BASE * (1 / this.POWER_MULT);
         this.FIGHT_RAND = FishManager.GetFishData()[this.TYPE].FIGHT_RAND * (1 / this.POWER_MULT);
         this.STAMINA_INCREASE_MULT = FishManager.GetFishData()[this.TYPE].STAMINA_INCREASE_MULT * this.POWER_MULT;
         this.STAMINA_DECREASE_MULT = FishManager.GetFishData()[this.TYPE].STAMINA_DECREASE_MULT * (1 / this.POWER_MULT);
         this.SPEED_MULT = FishManager.GetFishData()[this.TYPE].SPEED_MULT;
         this.ESCAPE_DISTANCE = FishManager.GetFishData()[this.TYPE].ESCAPE_DISTANCE * (1 / this.POWER_MULT * 0.5);
      }
      
      override public function destroy() : void
      {
         this.lure = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var _x_diff:Number = NaN;
         this.updateBrain();
         if(this.spawn_counter >= 0)
         {
            ++this.spawn_counter;
            if(this.spawn_counter > 3)
            {
               this.spawn_counter = 0;
               sprite.alpha += 0.25;
               if(sprite.alpha >= 1)
               {
                  sprite.alpha = 1;
                  this.spawn_counter = -1;
               }
            }
         }
         this.xForce *= 0.8;
         this.yForce *= 0.8;
         ground_friction_tick += 1 / 60;
         if(ground_friction_tick >= 1)
         {
            ground_friction_tick = 1;
         }
         ground_friction = Easings.easeInQuad(ground_friction_tick,0,1,1);
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(Math.abs(xVel) >= 0.1)
            {
               stateMachine.performAction("INCREASE_VEL_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_MOVING_STATE")
         {
            if(this.isOppositeVelocity())
            {
               stateMachine.performAction("OPPOSITE_VEL_ACTION");
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
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(this.IS_GOLDEN)
            {
               if(this.glitter_particle-- < 0)
               {
                  this.glitter_particle = 8;
                  level.particlesManager.itemSparkles("yellow",xPos,yPos,-1);
               }
            }
            if(this.jump_counter_2 == 0)
            {
               if(yPos <= Utils.SEA_LEVEL)
               {
                  SoundSystem.PlaySound("water_splash");
                  this.jump_counter_2 = 1;
                  if(Utils.TIME == Utils.DUSK)
                  {
                     level.particlesManager.createSplashParticle(xPos,1);
                  }
                  else
                  {
                     level.particlesManager.createSplashParticle(xPos);
                  }
               }
            }
            else if(this.jump_counter_2 == 1)
            {
               if(yVel >= 0)
               {
                  yVel = 0;
                  gravity_friction = 0;
                  if(this.BRAIN_STATE == 4)
                  {
                     ++this.jump_counter_3;
                     if(this.jump_counter_3 >= 20)
                     {
                        gravity_friction = 0.25;
                        this.jump_counter_2 = 2;
                     }
                  }
               }
            }
            else if(this.jump_counter_2 == 2)
            {
               if(yPos >= Utils.SEA_LEVEL)
               {
                  SoundSystem.PlaySound("water_splash");
                  this.jump_counter_2 = 3;
                  if(Utils.TIME == Utils.DUSK)
                  {
                     level.particlesManager.createSplashParticle(xPos,1);
                  }
                  else
                  {
                     level.particlesManager.createSplashParticle(xPos);
                  }
               }
            }
            else if(this.jump_counter_2 == 3)
            {
               if(yPos >= this.yPosBeforeJump)
               {
                  this.BRAIN_STATE = 3;
                  stateMachine.performAction("END_ACTION");
                  yPos = this.yPosBeforeJump;
                  this.randomizeJumpCounter();
               }
            }
         }
         if(this.BRAIN_STATE == 3)
         {
            frame_speed = this.stamina + 0.05;
            this.float_offset_counter += this.stamina * 0.5 + 0.05;
         }
         else if(this.BRAIN_STATE == 5)
         {
            if(yVel >= 0)
            {
               frame_speed = 0;
               this.float_offset_counter = 0;
               sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
            }
         }
         else
         {
            frame_speed = 0.15 + (1 - ground_friction);
            if(frame_speed < MAX_X_VEL * 0.1)
            {
               frame_speed = MAX_X_VEL * 0.1;
            }
            else if(frame_speed >= 1)
            {
               frame_speed = 1;
            }
         }
         frame_counter += frame_speed * 0.5;
         if(frame_counter >= 6)
         {
            frame_counter -= 6;
         }
         this.float_offset_counter += 0.05;
         if(this.float_offset_counter >= Math.PI * 2)
         {
            this.float_offset_counter -= Math.PI * 2;
         }
         this.float_offset_radius = this.getFloatRadius();
         this.integratePositionAndCollisionDetection();
         if(this.BRAIN_STATE == 3)
         {
            if(Utils.Slot.gameProgression[15] >= 2)
            {
               _x_diff = xPos - this.previousXPos;
               if(_x_diff > 0)
               {
                  this.distance_won += _x_diff;
               }
               else if(_x_diff < 0)
               {
                  this.distance_won += _x_diff * 0.5;
                  if(this.distance_won < 0)
                  {
                     this.distance_won = 0;
                  }
               }
               if(this.distance_won >= this.ESCAPE_DISTANCE || xPos >= level.levelData.RIGHT_MARGIN + 16)
               {
                  this.IS_ESCAPED = true;
                  stateMachine.setState("IS_MOVING_STATE");
                  DIRECTION = Entity.RIGHT;
                  this.BRAIN_STATE = 6;
               }
            }
         }
      }
      
      protected function getFloatRadius() : Number
      {
         return 1.5;
      }
      
      protected function updateBrain() : void
      {
      }
      
      protected function getNewInterval() : int
      {
         var base:Number = this.FIGHT_BASE + this.FIGHT_BASE * ((1 - this.stamina) * 0.5);
         var interval:Number = this.FIGHT_RAND * (1 - this.stamina + 0.1);
         return int(Math.random() * interval + base);
      }
      
      public function greatUserInput() : void
      {
         SoundSystem.PlaySound("item_appear");
         this.stamina_tick *= 0.75;
         if(this.stamina_tick <= 0)
         {
            this.stamina_tick = 0;
         }
      }
      
      public function badUserInput() : void
      {
         this.stamina_tick *= 1.25;
         if(this.stamina_tick >= this.stamina_time)
         {
            this.stamina_tick = this.stamina_time;
         }
      }
      
      public function correctUserInput() : void
      {
         this.WRONG_INPUT = false;
         this.stamina_tick -= 1 / 60 * this.STAMINA_DECREASE_MULT * (1 / this.POWER_MULT);
         if(this.stamina_tick <= 0)
         {
            this.stamina_tick = 0;
         }
         this.stamina = Easings.linear(this.stamina_tick,0,1,this.stamina_time);
      }
      
      public function wrongUserInput() : void
      {
         this.WRONG_INPUT = true;
         this.stamina_tick += 1 / 60 * this.STAMINA_INCREASE_MULT * this.POWER_MULT;
         if(this.stamina_tick >= this.stamina_time)
         {
            this.stamina_tick = this.stamina_time;
         }
         this.stamina = Easings.linear(this.stamina_tick,0,1,this.stamina_time);
         this.xForce += 0.2 * this.stamina * this.SPEED_MULT * this.POWER_MULT;
         this.yForce += 0.05 * this.stamina * this.SPEED_MULT * this.POWER_MULT;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.TYPE == Fish.SQUID)
         {
            if(stateMachine.currentState == "IS_MOVING_STATE")
            {
               if(this.BRAIN_STATE != 1)
               {
                  sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
                  sprite.updateScreenPosition();
               }
            }
         }
         else if(stateMachine.currentState == "IS_MOVING_STATE")
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
            sprite.updateScreenPosition();
         }
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos + Math.sin(this.float_offset_counter) * this.float_offset_radius - camera.yPos));
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
      
      protected function isOppositeVelocity() : Boolean
      {
         if(DIRECTION == Entity.LEFT && xVel > 0)
         {
            return true;
         }
         if(DIRECTION == Entity.RIGHT && xVel < 0)
         {
            return true;
         }
         return false;
      }
      
      protected function integratePositionAndCollisionDetection() : void
      {
         yVel += 0.4 * gravity_friction;
         xVel *= x_friction;
         yVel *= y_friction;
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
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function centerToLure() : void
      {
         xPos = this.lure.xPos;
         yPos = this.lure.yPos;
      }
      
      public function setFighting() : void
      {
         this.randomizeJumpCounter();
         this.FIGHT_DIRECTION = Entity.RIGHT;
         this.BRAIN_STATE = 3;
         this.xPosWhenCaught = xPos;
         this.yPosWhenCaught = yPos;
         DIRECTION = Entity.RIGHT;
         this.direction_change_counter = 120;
         this.stamina_tick = this.stamina_time;
         this.stamina = 1;
      }
      
      protected function randomizeJumpCounter() : void
      {
         this.jump_counter_1 = (Math.pow(2,this.jump_amounts) + Random.GaussianRandom() * 10) * 60;
         ++this.jump_amounts;
      }
      
      public function setCaught() : void
      {
         this.jump_counter_1 = -1;
         this.BRAIN_STATE = 5;
         stateMachine.setState("IS_JUMPING_STATE");
      }
      
      protected function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
      }
      
      protected function movingAnimation() : void
      {
         MAX_Y_VEL = 0.25;
         if(this.TYPE == Fish.SNAIL || this.TYPE == Fish.CRAB || this.TYPE == Fish.SALAMANDER || this.TYPE == Fish.OCTOPUS)
         {
            gravity_friction = 0.2;
         }
         else
         {
            gravity_friction = 0;
         }
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
      }
      
      protected function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         ground_friction = 0;
         ground_friction_tick = 0;
      }
      
      protected function jumpingAnimation() : void
      {
         var rand_jump_power:Number = NaN;
         var new_direction_change_time:* = undefined;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         rand_jump_power = Math.random() * 2;
         if(this.BRAIN_STATE == 5)
         {
            yVel = -4.5;
         }
         else
         {
            this.staminaBoost();
            new_direction_change_time = this.getNewInterval();
            if(new_direction_change_time < this.direction_change_counter)
            {
               this.direction_change_counter = new_direction_change_time;
            }
            yVel = -(rand_jump_power + 3);
            this.JUMP_MULT = 0.8 + rand_jump_power / 2 * 0.4;
         }
         gravity_friction = 0.2;
         MAX_Y_VEL = 4;
         this.yPosBeforeJump = yPos;
         this.jump_counter_2 = this.jump_counter_3 = 0;
      }
      
      public function checkLureCollisionDetection(_lure:Lure) : void
      {
         var level:LevelFishing = null;
         this.lure = _lure;
         var lure_aabb:Rectangle = this.lure.getAABB();
         if(lure_aabb.intersects(getAABB()))
         {
            level = level as LevelFishing;
            level.fishBit(this);
         }
      }
      
      protected function staminaBoost() : void
      {
         this.stamina_tick += this.stamina_time * (0.5 * this.JUMP_MULT * this.POWER_MULT - 0.2);
         if(this.stamina_tick >= this.stamina_time)
         {
            this.stamina_tick = this.stamina_time;
         }
         this.stamina = Easings.linear(this.stamina_tick,0,1,this.stamina_time);
      }
   }
}
