package entities
{
   import entities.enemies.BossFishEnemy;
   import entities.enemies.BossLizardEnemy;
   import flash.geom.*;
   import flash.utils.getTimer;
   import game_utils.*;
   import interfaces.panels.DoubleCoinsPanel;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.collisions.*;
   import levels.worlds.fishing.LevelFishing;
   import sprites.GameSprite;
   import sprites.cats.*;
   import sprites.items.BubbleItemSprite;
   import sprites.particles.*;
   import starling.filters.ColorMatrixFilter;
   
   public class Hero extends BrainEntity
   {
      
      public static var CAT_PASCAL:int = 0;
      
      public static var CAT_ROSE:int = 4;
      
      public static var CAT_RIGS:int = 2;
      
      public static var CAT_MARA:int = 3;
       
      
      public var climb_y_t:int;
      
      protected var drift_counter:Number;
      
      protected var p_counter:int;
      
      protected var LAST_TIME_INPUT_SX:int;
      
      protected var LAST_TIME_INPUT_DX:int;
      
      protected var LAST_TIME_INPUT_VEHICLE_SX:int;
      
      protected var LAST_TIME_INPUT_VEHICLE_DX:int;
      
      public var IS_TAPPING_CONTINUOSLY_SX_FLAG:Boolean;
      
      public var IS_TAPPING_CONTINUOSLY_DX_FLAG:Boolean;
      
      protected var DOUBLE_TAPS_SX_AMOUNT:int;
      
      protected var DOUBLE_TAPS_DX_AMOUNT:int;
      
      protected var JUMP_RUN_FLAG:Boolean;
      
      protected var IS_SUPER_WALL_JUMP:Boolean;
      
      protected var IS_EXTRA_HOP_SPEED:Boolean;
      
      protected var _last_time_input_dx:uint;
      
      protected var _last_time_input_sx:uint;
      
      public var IS_RUN_ALLOWED:Boolean;
      
      public var BUBBLE_STATE:int;
      
      public var bubble_counter_1:int;
      
      public var bubble_counter_2:int;
      
      public var tick_tock_counter:int;
      
      public var ropeMidX:Number;
      
      public var ropeTopY:Number;
      
      public var ropeEndY:Number;
      
      protected var rope_counter_1:int;
      
      protected var rope_counter_2:int;
      
      protected var lastRope:RopeAreaCollision;
      
      protected var WAS_ON_ROPE:Boolean;
      
      public var mudSinCounter:Number;
      
      public var head_pound_counter:int;
      
      public var LOCK_SPEED:int;
      
      protected var checkered_spot_center_x:int;
      
      protected var same_key_counter:int;
      
      protected var slide_counter:int;
      
      protected var climb_max_value:int;
      
      protected var super_wall_jump_counter:int;
      
      protected var gameOverSprite:HeroGameOverParticleSprite;
      
      protected var gameOverYPos:*;
      
      protected var gameOverYVel:Number;
      
      protected var bubbleSprite:BubbleItemSprite;
      
      protected var wiggle_x_offset:Number;
      
      protected var lastStun:Number;
      
      protected var lastEnemyHurt:Entity;
      
      protected var stunAirCounter:int;
      
      protected var gold_counter_1:int;
      
      protected var gold_counter_2:int;
      
      protected var gold_sin_1:Number;
      
      protected var wall_collision_after_slide_cool_off_counter:int;
      
      protected var CURRENT_STATE:String;
      
      protected var current_state_timer:int;
      
      protected var cannonCollision:CannonHeroCollision;
      
      public var xForce:Number;
      
      public var yForce:Number;
      
      protected var debugQuadBuffer:Array;
      
      protected var debugQuadsAmount:int;
      
      protected var debugQuadsCurrent:int;
      
      public function Hero(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
         sprite = this.getHeroSprite();
         Utils.world.addChild(sprite);
         this.bubbleSprite = new BubbleItemSprite();
         Utils.world.addChild(this.bubbleSprite);
         this.bubbleSprite.visible = false;
         this.BUBBLE_STATE = this.bubble_counter_1 = this.bubble_counter_2 = this.tick_tock_counter = 0;
         this.xForce = this.yForce = 0;
         this._last_time_input_dx = this._last_time_input_sx = 0;
         this.wiggle_x_offset = 0;
         stateMachine = new StateMachine(40,40);
         stateMachine.setRule("IS_LEVEL_START_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","INCREASE_VEL_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","ZERO_X_VEL_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","OPPOSITE_VEL_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","OPPOSITE_VEL_ACTION","IS_TURNING_WALKING_STATE");
         stateMachine.setRule("IS_TURNING_WALKING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SAME_KEY_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SAME_KEY_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","OPPOSITE_VEL_ACTION","IS_BRAKING_STATE");
         stateMachine.setRule("IS_TURNING_RUNNING_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","ZERO_X_VEL_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_BRAKING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_BRAKING_STATE","KEY_RELEASE_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_BRAKING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_RUNNING_STATE");
         stateMachine.setRule("IS_FALLING_RUNNING_STATE","ZERO_X_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","WALL_COLLISION_ACTION","IS_HEAD_POUND_STATE");
         stateMachine.setRule("IS_HEAD_POUND_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","WALL_COLLISION_ACTION","IS_HEAD_POUND_STATE");
         stateMachine.setRule("IS_FALLING_RUNNING_STATE","WALL_COLLISION_ACTION","IS_HEAD_POUND_STATE");
         stateMachine.setRule("IS_STANDING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_FALLING_RUNNING_STATE","GROUND_COLLISION_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_WALL_JUMPING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_FALLING_RUNNING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_CLIMBING_STATE","END_ACTION","IS_DRIFTING_STATE");
         stateMachine.setRule("IS_CLIMBING_STATE","KEY_RELEASE_ACTION","IS_SLIDING_STATE");
         stateMachine.setRule("IS_DRIFTING_STATE","KEY_RELEASE_ACTION","IS_SLIDING_STATE");
         stateMachine.setRule("IS_DRIFTING_STATE","POSITIVE_Y_VEL_ACTION","IS_SLIDING_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","NO_WALL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","INCREASE_VEL_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_CLIMBING_STATE","CEIL_COLLISION_ACTION","IS_DRIFTING_STATE");
         stateMachine.setRule("IS_CLIMBING_STATE","HOP_ACTION","IS_HOPPING_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_CLIMBING_STATE","OPPOSITE_KEY_ACTION","IS_WALL_JUMPING_STATE");
         stateMachine.setRule("IS_DRIFTING_STATE","OPPOSITE_KEY_ACTION","IS_WALL_JUMPING_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","OPPOSITE_KEY_ACTION","IS_WALL_JUMPING_STATE");
         stateMachine.setRule("IS_WALL_JUMPING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","INTO_WATER_ACTION","IS_FLOATING_STATE");
         stateMachine.setRule("IS_FLOATING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_WATER_STATE");
         stateMachine.setRule("IS_STANDING_WATER_STATE","NO_GROUND_ACTION","IS_FLOATING_STATE");
         stateMachine.setRule("IS_STANDING_WATER_STATE","INPUT_ACTION","IS_JUMPING_WATER_STATE");
         stateMachine.setRule("IS_JUMPING_WATER_STATE","INPUT_ACTION","IS_JUMPING_WATER_STATE");
         stateMachine.setRule("IS_FLOATING_STATE","INPUT_ACTION","IS_JUMPING_WATER_STATE");
         stateMachine.setRule("IS_JUMPING_WATER_STATE","POSITIVE_Y_VEL_ACTION","IS_FLOATING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","BOUNCE_ACTION","IS_BOUNCING_STATE");
         stateMachine.setRule("IS_FALLING_RUNNING_STATE","BOUNCE_ACTION","IS_BOUNCING_STATE");
         stateMachine.setRule("IS_BOUNCING_STATE","CLIMB_ACTION","IS_CLIMBING_STATE");
         stateMachine.setRule("IS_BOUNCING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","INTO_AIR_ACTION","IS_AIR_FLOATING_STATE");
         stateMachine.setRule("IS_STUN_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STUN_WATER_STATE","END_ACTION","IS_FLOATING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","GAME_OVER_ACTION","IS_GAME_OVER_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","ROPE_COLLISION_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_FALLING_RUNNING_STATE","ROPE_COLLISION_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","ROPE_COLLISION_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_WALL_JUMPING_STATE","ROPE_COLLISION_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","ROPE_COLLISION_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_ROPE_CLIMBING_STATE","KEY_RELEASE_ACTION","IS_ROPE_SLIDING_STATE");
         stateMachine.setRule("IS_ROPE_SLIDING_STATE","INCREASE_VEL_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_ROPE_SLIDING_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_ROPE_CLIMBING_STATE","OPPOSITE_VEL_ACTION","IS_ROPE_TURNING_STATE");
         stateMachine.setRule("IS_ROPE_SLIDING_STATE","OPPOSITE_VEL_ACTION","IS_ROPE_TURNING_STATE");
         stateMachine.setRule("IS_ROPE_TURNING_STATE","END_ACTION","IS_ROPE_CLIMBING_STATE");
         stateMachine.setRule("IS_ROPE_CLIMBING_STATE","SAME_KEY_ACTION","IS_HOPPING_STATE");
         stateMachine.setRule("IS_ROPE_SLIDING_STATE","SAME_KEY_ACTION","IS_HOPPING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","VEHICLE_ACTION","IS_INSIDE_VEHICLE_STATE");
         stateMachine.setRule("IS_GLUED_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","CANNON_ACTION","IS_CANNON_INSIDE_STATE");
         stateMachine.setRule("IS_CANNON_INSIDE_STATE","END_ACTION","IS_CANNON_SHOOT_STATE");
         stateMachine.setRule("IS_FISHING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setRule("IS_WALKING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setRule("IS_TURNING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setRule("IS_TURNING_WALKING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setRule("IS_TURNING_RUNNING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setRule("IS_BRAKING_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         stateMachine.setFunctionToState("IS_LEVEL_START_STATE",this.levelStartAnimation);
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_RUNNING_STATE",this.runningAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_RUNNING_STATE",this.fallingRunningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_WALKING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_RUNNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_CLIMBING_STATE",this.climbingAnimation);
         stateMachine.setFunctionToState("IS_DRIFTING_STATE",this.driftingAnimation);
         stateMachine.setFunctionToState("IS_SLIDING_STATE",this.slidingAnimation);
         stateMachine.setFunctionToState("IS_HOPPING_STATE",this.hoppingAnimation);
         stateMachine.setFunctionToState("IS_WALL_JUMPING_STATE",this.wallJumpingAnimation);
         stateMachine.setFunctionToState("IS_BRAKING_STATE",this.brakingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_HEAD_POUND_STATE",this.headPoundAnimation);
         stateMachine.setFunctionToState("IS_STUN_STATE",this.stunAnimation);
         stateMachine.setFunctionToState("IS_STUN_WATER_STATE",this.stunAnimation);
         stateMachine.setFunctionToState("IS_GAME_OVER_STATE",this.gameOverAnimation);
         stateMachine.setFunctionToState("IS_LEVEL_COMPLETE_STATE",this.levelCompleteAnimation);
         stateMachine.setFunctionToState("IS_FLOATING_STATE",this.floatingAnimation);
         stateMachine.setFunctionToState("IS_AIR_FLOATING_STATE",this.airFloatingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_WATER_STATE",this.jumpingWaterAnimation);
         stateMachine.setFunctionToState("IS_STANDING_WATER_STATE",this.standingWaterAnimation);
         stateMachine.setFunctionToState("IS_ROPE_CLIMBING_STATE",this.ropeClimbingAnimation);
         stateMachine.setFunctionToState("IS_ROPE_SLIDING_STATE",this.ropeSlidingAnimation);
         stateMachine.setFunctionToState("IS_ROPE_TURNING_STATE",this.ropeTurningAnimation);
         stateMachine.setFunctionToState("IS_INSIDE_VEHICLE_STATE",this.insideVehicleAnimation);
         stateMachine.setFunctionToState("IS_BOUNCING_STATE",this.bouncingAnimation);
         stateMachine.setFunctionToState("IS_GLUED_STATE",this.gluedAnimation);
         stateMachine.setFunctionToState("IS_CANNON_INSIDE_STATE",this.cannonInsideAnimation);
         stateMachine.setFunctionToState("IS_CANNON_SHOOT_STATE",this.cannonShootAnimation);
         stateMachine.setFunctionToState("IS_FISHING_STATE",this.fishingAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         this.CURRENT_STATE = stateMachine.currentState;
         this.current_state_timer = 0;
         speed = 0.1;
         WIDTH = 16;
         HEIGHT = 16;
         mass = 1;
         this.checkered_spot_center_x = 0;
         this.LAST_TIME_INPUT_SX = this.LAST_TIME_INPUT_DX = -1;
         this.LAST_TIME_INPUT_VEHICLE_SX = this.LAST_TIME_INPUT_VEHICLE_DX = -1;
         IS_IN_AIR = false;
         this.lastRope = null;
         this.cannonCollision = null;
         this.p_counter = 0;
         this.super_wall_jump_counter = 0;
         this.head_pound_counter = 0;
         this.wall_collision_after_slide_cool_off_counter = 0;
         this.WAS_ON_ROPE = false;
         this.IS_TAPPING_CONTINUOSLY_SX_FLAG = this.IS_TAPPING_CONTINUOSLY_DX_FLAG = false;
         this.DOUBLE_TAPS_SX_AMOUNT = this.DOUBLE_TAPS_DX_AMOUNT = 0;
         this.IS_RUN_ALLOWED = true;
         IS_IN_MUD = false;
         this.mudSinCounter = 0;
         gravity_friction = 1;
         x_friction = 0.7;
         this.LOCK_SPEED = -1;
         this.same_key_counter = 0;
         this.climb_max_value = 3;
         this.stunAirCounter = 0;
         this.ropeMidX = this.ropeTopY = this.ropeEndY = 0;
         aabbPhysics = new Rectangle(4,0,8,16);
         aabb = new Rectangle(1,-1,14,17);
         this.gameOverSprite = null;
         this.gameOverYPos = this.gameOverYVel = 0;
         this.lastStun = getTimer();
         this.lastEnemyHurt = null;
         stunHandler = new StunHandler(level,this,600);
         IS_GOLD = false;
         this.gold_counter_1 = this.gold_counter_2 = 0;
         this.gold_sin_1 = 0;
         MAX_X_VEL = 2;
         if(yPos >= Utils.SEA_LEVEL && Utils.SEA_LEVEL > 0)
         {
            this.setInsideWater();
         }
      }
      
      public static function GetCurrentCat() : int
      {
         return Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT];
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.bubbleSprite);
         this.bubbleSprite.destroy();
         this.bubbleSprite.dispose();
         this.bubbleSprite = null;
         this.cannonCollision = null;
         if(this.gameOverSprite != null)
         {
            Utils.topWorld.removeChild(this.gameOverSprite);
            this.gameOverSprite.destroy();
            this.gameOverSprite.dispose();
            this.gameOverSprite = null;
         }
         super.destroy();
      }
      
      public function setGoldenCat() : void
      {
         IS_GOLD = true;
         this.gold_counter_1 = this.gold_counter_2 = 0;
         this.gold_sin_1 = 0;
         stunHandler.unstun();
      }
      
      public function headPound() : void
      {
         xVel = yVel = 0;
         stateMachine.setState("IS_HEAD_POUND_STATE");
      }
      
      override public function ceilCollision() : void
      {
         if(stateMachine.currentState == "IS_CANNON_SHOOT_STATE")
         {
            stateMachine.setState("IS_HEAD_POUND_STATE");
            this.cannonCollision = null;
            yVel = 0;
         }
         else
         {
            stateMachine.performAction("CEIL_COLLISION_ACTION");
            yVel = 0;
         }
      }
      
      public function wasOnRope() : Boolean
      {
         if(this.WAS_ON_ROPE)
         {
            return true;
         }
         if(stateMachine.lastState == "IS_ROPE_CLIMBING_STATE" || stateMachine.lastState == "IS_ROPE_TURNING_STATE" || stateMachine.lastState == "IS_ROPE_SLIDING_STATE")
         {
            return true;
         }
         return false;
      }
      
      override public function update() : void
      {
         var _frict_value:Number = NaN;
         var _max_vel_value:Number = NaN;
         var _frame:int = 0;
         var climb_y_t_diff:int = 0;
         var tile_1:int = 0;
         var x_t:int = 0;
         var y_t:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var pSprite:GameSprite = null;
         super.update();
         if(this.DOUBLE_TAPS_SX_AMOUNT > 3)
         {
            this.IS_TAPPING_CONTINUOSLY_SX_FLAG = true;
         }
         if(this.IS_TAPPING_CONTINUOSLY_SX_FLAG)
         {
            if(getTimer() - this._last_time_input_sx > 500)
            {
               this.IS_TAPPING_CONTINUOSLY_SX_FLAG = false;
               this.DOUBLE_TAPS_SX_AMOUNT = 0;
            }
         }
         if(this.DOUBLE_TAPS_DX_AMOUNT > 3)
         {
            this.IS_TAPPING_CONTINUOSLY_DX_FLAG = true;
         }
         if(this.IS_TAPPING_CONTINUOSLY_DX_FLAG)
         {
            if(getTimer() - this._last_time_input_dx > 500)
            {
               this.IS_TAPPING_CONTINUOSLY_DX_FLAG = false;
               this.DOUBLE_TAPS_DX_AMOUNT = 0;
            }
         }
         --this.wall_collision_after_slide_cool_off_counter;
         if(this.wall_collision_after_slide_cool_off_counter <= 0)
         {
            this.wall_collision_after_slide_cool_off_counter = 0;
         }
         --this.tick_tock_counter;
         if(this.tick_tock_counter <= 0)
         {
            this.tick_tock_counter = 0;
         }
         Utils.DOUBLE_TAP_RATIO = Utils.DOUBLE_TAP_RATIO_NORMAL;
         if(stateMachine.currentState != this.CURRENT_STATE)
         {
            this.CURRENT_STATE = stateMachine.currentState;
            this.current_state_timer = 0;
         }
         else
         {
            ++this.current_state_timer;
         }
         if(this.same_key_counter > 0)
         {
            --this.same_key_counter;
            if(this.IS_RUN_ALLOWED)
            {
               stateMachine.performAction("SAME_KEY_ACTION");
            }
         }
         if(stateMachine.currentState != "IS_WALL_JUMPING_STATE")
         {
            this.IS_SUPER_WALL_JUMP = false;
         }
         if((level.leftPressed && this.LOCK_SPEED != 1 || this.LOCK_SPEED == 0 || this.IS_TAPPING_CONTINUOSLY_SX_FLAG) && IS_IN_WATER == false)
         {
            if(DIRECTION == LEFT)
            {
               if(stateMachine.currentState == "IS_CLIMBING_STATE")
               {
                  yVel -= 0.1;
               }
               else if(!(stateMachine.currentState == "IS_BRAKING_STATE" || stateMachine.currentState == "IS_HEAD_POUND_STATE" || stateMachine.currentState == "IS_STUN_STATE"))
               {
                  if(stateMachine.currentState == "IS_SLIDING_STATE")
                  {
                     if(this.slide_counter >= 40)
                     {
                        stateMachine.performAction("INCREASE_VEL_ACTION");
                     }
                  }
                  else
                  {
                     stateMachine.performAction("INCREASE_VEL_ACTION");
                     if(stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || stateMachine.currentState == "IS_WALL_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_HOPPING_STATE")
                     {
                        ground_friction = 1;
                        _frict_value = 0.9;
                        if(stateMachine.currentState == "IS_HOPPING_STATE")
                        {
                           _frict_value = 0.85;
                        }
                        if(Utils.IS_ON_WINDOWS)
                        {
                           if(level.rightPressed)
                           {
                              speed *= _frict_value;
                           }
                        }
                        else if(level.rightPressed && level.wasLastRight)
                        {
                           speed *= _frict_value;
                        }
                     }
                     xVel -= speed * ground_friction;
                  }
               }
               if(IS_IN_MUD)
               {
                  if(yPos + HEIGHT > Utils.MUD_LEVEL)
                  {
                     if(stateMachine.currentState == "IS_WALKING_STATE")
                     {
                        yVel -= 0.05;
                     }
                  }
                  else if(stateMachine.currentState != "IS_CLIMBING_STATE")
                  {
                     yPos = Utils.MUD_LEVEL - HEIGHT;
                  }
               }
               removeGroundFriction();
            }
            else if(stateMachine.currentState == "IS_CLIMBING_STATE")
            {
               stateMachine.performAction("OPPOSITE_KEY_ACTION");
            }
            else if(IS_IN_AIR)
            {
               changeDirection();
            }
            else
            {
               stateMachine.performAction("OPPOSITE_VEL_ACTION");
               ground_friction_tick = 0;
            }
            if(stateMachine.currentState == "IS_ROPE_CLIMBING_STATE")
            {
               yVel -= 0.1;
            }
            else if(stateMachine.currentState == "IS_ROPE_SLIDING_STATE")
            {
               if(this.slide_counter >= 6)
               {
                  stateMachine.performAction("INCREASE_VEL_ACTION");
               }
            }
            this.LAST_TIME_INPUT_SX = getTimer();
            this.LAST_TIME_INPUT_DX = -1;
         }
         else if((level.rightPressed && this.LOCK_SPEED != 0 || this.LOCK_SPEED == 1 || this.IS_TAPPING_CONTINUOSLY_DX_FLAG) && !IS_IN_WATER)
         {
            if(DIRECTION == RIGHT)
            {
               if(stateMachine.currentState == "IS_CLIMBING_STATE")
               {
                  yVel -= 0.1;
               }
               else if(!(stateMachine.currentState == "IS_BRAKING_STATE" || stateMachine.currentState == "IS_HEAD_POUND_STATE" || stateMachine.currentState == "IS_STUN_STATE"))
               {
                  if(stateMachine.currentState == "IS_SLIDING_STATE")
                  {
                     if(this.slide_counter >= 40)
                     {
                        stateMachine.performAction("INCREASE_VEL_ACTION");
                     }
                  }
                  else
                  {
                     stateMachine.performAction("INCREASE_VEL_ACTION");
                     if(stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || stateMachine.currentState == "IS_WALL_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_HOPPING_STATE")
                     {
                        ground_friction = 1;
                        _frict_value = 0.9;
                        if(stateMachine.currentState == "IS_HOPPING_STATE")
                        {
                           _frict_value = 0.85;
                        }
                        if(Utils.IS_ON_WINDOWS)
                        {
                           if(level.leftPressed)
                           {
                              speed *= _frict_value;
                           }
                        }
                        else if(level.leftPressed && level.wasLastLeft)
                        {
                           speed *= _frict_value;
                        }
                     }
                     xVel += speed * ground_friction;
                  }
               }
               if(IS_IN_MUD)
               {
                  if(yPos + HEIGHT > Utils.MUD_LEVEL)
                  {
                     if(stateMachine.currentState == "IS_WALKING_STATE")
                     {
                        yVel -= 0.05;
                     }
                  }
                  else if(stateMachine.currentState != "IS_CLIMBING_STATE")
                  {
                     yPos = Utils.MUD_LEVEL - HEIGHT;
                  }
               }
               removeGroundFriction();
            }
            else if(stateMachine.currentState == "IS_CLIMBING_STATE")
            {
               stateMachine.performAction("OPPOSITE_KEY_ACTION");
            }
            else if(IS_IN_AIR)
            {
               changeDirection();
            }
            else
            {
               stateMachine.performAction("OPPOSITE_VEL_ACTION");
               ground_friction_tick = 0;
            }
            if(stateMachine.currentState == "IS_ROPE_CLIMBING_STATE")
            {
               yVel -= 0.1;
            }
            else if(stateMachine.currentState == "IS_ROPE_SLIDING_STATE")
            {
               if(this.slide_counter >= 6)
               {
                  stateMachine.performAction("INCREASE_VEL_ACTION");
               }
            }
            this.LAST_TIME_INPUT_DX = getTimer();
            this.LAST_TIME_INPUT_SX = -1;
         }
         else
         {
            if(stateMachine.currentState == "IS_RUNNING_STATE")
            {
               if(Math.abs(xVel) < 1)
               {
                  stateMachine.performAction("ZERO_X_VEL_ACTION");
               }
            }
            else if(IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != LevelItems.ITEM_ICE_POP)
            {
               stateMachine.performAction("ZERO_X_VEL_ACTION");
            }
            else if(Math.abs(xVel) < 0.1 && walking_counter > 12)
            {
               stateMachine.performAction("ZERO_X_VEL_ACTION");
            }
            addGroundFriction();
         }
         if(IS_IN_MUD || this.IS_RUN_ALLOWED == false)
         {
            if(stateMachine.currentState == "IS_RUNNING_STATE")
            {
               stateMachine.setState("IS_WALKING_STATE");
            }
         }
         if(Utils.SAND_LEVEL > 0)
         {
            if(yPos > Utils.SAND_LEVEL)
            {
               xVel -= 0.1;
            }
         }
         xVel += this.xForce;
         yVel += this.yForce;
         this.xForce *= 0.8;
         this.yForce *= 0.8;
         if(stateMachine.currentState != "IS_JUMPING_STATE" && stateMachine.currentState != "IS_FALLING_RUNNING_STATE" && stateMachine.currentState != "IS_HOPPING_STATE" && stateMachine.currentState != "IS_WALL_JUMPING_STATE" && stateMachine.currentState != "IS_FALLING_STATE")
         {
            this.LOCK_SPEED = -1;
         }
         if(IS_IN_AIR && Math.abs(xVel) < 1)
         {
            this.LOCK_SPEED = -1;
            speed = 0.2;
            x_friction = 0.9;
         }
         if(stateMachine.currentState == "IS_SLIDING_STATE" || stateMachine.currentState == "IS_ROPE_SLIDING_STATE")
         {
            if(yVel < 0)
            {
               yVel *= 0.8;
            }
         }
         if(IS_IN_MUD)
         {
            yVel += level.levelPhysics.gravity * 0.05;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_FEATHER && stateMachine.currentState == "IS_FALLING_RUNNING_STATE")
         {
            yVel += level.levelPhysics.gravity * gravity_friction * 0.2;
         }
         else
         {
            yVel += level.levelPhysics.gravity * gravity_friction;
         }
         if(IS_IN_WATER)
         {
            yVel *= 0.99;
            if(water_counter1-- < 0)
            {
               water_counter1 = 120;
               level.topParticlesManager.createBreatheWaterBubble(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.25);
            }
         }
         if(stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || stateMachine.currentState == "IS_BRAKING_STATE" || stateMachine.currentState == "IS_WALL_JUMPING_STATE" || IS_IN_WATER)
         {
            if(stateMachine.currentState == "IS_BRAKING_STATE")
            {
               if(IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != LevelItems.ITEM_ICE_POP)
               {
                  xVel *= 0.95;
               }
               else
               {
                  xVel *= x_friction;
               }
            }
            else
            {
               xVel *= x_friction;
            }
         }
         else if(!(stateMachine.currentState == "IS_HEAD_POUND_STATE" || stateMachine.currentState == "IS_STUN_STATE"))
         {
            if(!level.leftPressed && !level.rightPressed)
            {
               if(IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != LevelItems.ITEM_ICE_POP)
               {
                  xVel *= 0.97;
               }
               else
               {
                  xVel *= x_friction;
               }
            }
         }
         if(IS_IN_MUD)
         {
            xVel *= 0.9;
         }
         if(xVel <= -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         else if(xVel >= MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         if(IS_IN_AIR && stateMachine.currentState != "IS_BOUNCING_STATE")
         {
            MAX_Y_VEL = 3;
         }
         else if(IS_IN_AIR && stateMachine.currentState == "IS_BOUNCING_STATE")
         {
            MAX_Y_VEL = 4;
         }
         else if(IS_IN_WATER)
         {
            MAX_X_VEL = 1.5;
            MAX_Y_VEL = 1.5;
            gravity_friction = 0.05;
         }
         else
         {
            MAX_Y_VEL = 4;
         }
         if(yVel <= -MAX_Y_VEL)
         {
            yVel = -MAX_Y_VEL;
         }
         else if(yVel >= MAX_Y_VEL)
         {
            yVel = MAX_Y_VEL;
         }
         if(stateMachine.currentState == "IS_STANDING_STATE" || stateMachine.currentState == "IS_STANDING_HOLE_STATE" || stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 4) + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(stateMachine.currentState == "IS_STANDING_WATER_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 4) + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(yVel < 0)
            {
               stateMachine.performAction("NO_GROUND_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_FISHING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 4) + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            xVel = yVel = 0;
            xPos = 272;
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            _max_vel_value = 0.25;
            if(IS_ON_ICE)
            {
               _max_vel_value = 0.05;
            }
            if(Math.abs(xVel) > _max_vel_value)
            {
               ++counter1;
               if(counter2++ > 4 && counter1 < 30)
               {
                  counter2 = 0;
                  if(IS_ON_ICE)
                  {
                     level.particlesManager.groundIceParticles(this);
                  }
                  else
                  {
                     level.particlesManager.groundSmokeParticles(this);
                  }
               }
            }
            frame_speed = MAX_X_VEL * 8 / 60 + (1 - ground_friction) * 0.4;
            if(IS_IN_MUD)
            {
               frame_counter += frame_speed * 0.5;
            }
            else
            {
               frame_counter += frame_speed;
            }
            if(frame_counter > 5)
            {
               frame_counter -= 5;
            }
         }
         else if(stateMachine.currentState == "IS_RUNNING_STATE")
         {
            if(counter2++ > 2)
            {
               counter2 = -int(Math.random() * 5);
               if(IS_ON_ICE)
               {
                  level.particlesManager.groundIceParticles(this);
               }
               else
               {
                  level.particlesManager.groundSmokeParticles(this);
               }
            }
            frame_speed = 16 / 60 + (1 - ground_friction) * 0.2;
            frame_counter += frame_speed;
            if(frame_counter >= 4)
            {
               frame_counter -= 4;
            }
         }
         else if(stateMachine.currentState == "IS_GLUED_STATE")
         {
            xVel = yVel = 0;
            gravity_friction = 0;
            if(counter1 >= 5)
            {
               level.collisionsManager.destroyHoney(getMidXPos(),getMidYPos());
               SoundSystem.PlaySound("mud");
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState != "IS_FALLING_STATE")
         {
            if(stateMachine.currentState == "IS_FALLING_RUNNING_STATE")
            {
               if(Math.abs(xVel) < 1.5)
               {
                  this.same_key_counter = this.LAST_TIME_INPUT_SX = this.LAST_TIME_INPUT_DX = 0;
                  stateMachine.performAction("ZERO_X_VEL_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_ROPE_CLIMBING_STATE")
            {
               if(yVel < -0.5)
               {
                  yVel = -0.5;
               }
               ++this.rope_counter_1;
               if(this.rope_counter_1 < 10)
               {
                  yVel = 0;
               }
               else if(counter2++ > 6 && yPos > this.ropeTopY)
               {
                  counter2 = 0;
                  yPos -= 6;
                  _frame = sprite.gfxHandle().gfxHandleClip().frame;
                  if(_frame == 1)
                  {
                     this.playSound("hop");
                  }
                  if(_frame == 1)
                  {
                     _frame = 2;
                  }
                  else
                  {
                     _frame = 1;
                  }
                  sprite.gfxHandle().gfxHandleClip().gotoAndStop(_frame);
               }
               xVel = yVel = 0;
               if(this.lastRope != null)
               {
                  xPos = this.lastRope.xPos;
                  if(yPos <= this.lastRope.yPos + 8)
                  {
                     yPos = this.lastRope.yPos + 8;
                  }
               }
               if(!level.leftPressed && !level.rightPressed)
               {
                  stateMachine.performAction("KEY_RELEASE_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_CLIMBING_STATE")
            {
               climb_y_t_diff = Math.abs(this.climb_y_t - int(yPos / Utils.TILE_HEIGHT));
               if(this.isTimeToHop())
               {
                  stateMachine.performAction("HOP_ACTION");
               }
               else if(climb_y_t_diff >= this.getClimbMaxValue())
               {
                  stateMachine.performAction("END_ACTION");
               }
               else if(!level.leftPressed && !level.rightPressed && !this.IS_TAPPING_CONTINUOSLY_DX_FLAG && !this.IS_TAPPING_CONTINUOSLY_SX_FLAG)
               {
                  stateMachine.performAction("KEY_RELEASE_ACTION");
               }
               if(yVel < -2)
               {
                  yVel = -2;
               }
               xVel = 0;
            }
            else if(stateMachine.currentState == "IS_DRIFTING_STATE")
            {
               frame_speed *= 1.02;
               if(frame_speed > 0.6)
               {
                  frame_speed = 0.6;
               }
               frame_counter += frame_speed;
               if(frame_counter >= 6)
               {
                  frame_counter -= 6;
               }
               if(IS_ON_ICE)
               {
                  this.playIceSlideSound();
               }
               yVel *= 0.89;
               if(yVel >= -0.1)
               {
                  if(this.drift_counter++ > 20)
                  {
                     stateMachine.performAction("POSITIVE_Y_VEL_ACTION");
                  }
               }
               if(!level.leftPressed && !level.rightPressed)
               {
                  stateMachine.performAction("KEY_RELEASE_ACTION");
               }
               xVel = 0;
            }
            else if(stateMachine.currentState == "IS_ROPE_SLIDING_STATE")
            {
               ++this.slide_counter;
               if(counter1++ < 20)
               {
                  yVel = 0;
               }
               else
               {
                  this.playSound("brake");
               }
               xVel = 0;
               if(this.lastRope != null)
               {
                  xPos = this.lastRope.xPos;
                  if(yPos >= this.lastRope.yPos + this.lastRope.HEIGHT)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_SLIDING_STATE")
            {
               ++this.slide_counter;
               if(counter1++ < 20)
               {
                  yVel = 0;
               }
               else
               {
                  this.playSound("brake");
                  if(counter2++ > 4)
                  {
                     counter2 = -Math.random() * 3;
                     if(IS_ON_ICE)
                     {
                        level.particlesManager.wallIceParticles(this);
                     }
                     else
                     {
                        level.particlesManager.wallSmokeParticles(this);
                     }
                  }
               }
               xVel = 0;
               x_t = getTileX(WIDTH * 0.5);
               y_t = getTileY(HEIGHT * 0.5);
               if(DIRECTION == LEFT)
               {
                  tile_1 = level.levelData.getTileValueAt(x_t - 1,y_t);
               }
               else
               {
                  tile_1 = level.levelData.getTileValueAt(x_t + 1,y_t);
               }
               if(tile_1 == 0 || tile_1 == 15)
               {
                  if(!IS_ON_VER_PLATFORM)
                  {
                     stateMachine.performAction("NO_WALL_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_HOPPING_STATE" || stateMachine.currentState == "IS_WALL_JUMPING_STATE" || stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_JUMPING_WATER_STATE" || stateMachine.currentState == "IS_BOUNCING_STATE")
            {
               if(yVel > 0)
               {
                  stateMachine.performAction("POSITIVE_Y_VEL_ACTION");
               }
               if(this.IS_SUPER_WALL_JUMP)
               {
                  this.superWallJumpParticles();
               }
            }
            else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_RUNNING_STATE")
            {
               xVel *= 0.9;
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  changeDirection();
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_ROPE_TURNING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  changeDirection();
                  stateMachine.performAction("END_ACTION");
               }
               if(this.lastRope != null)
               {
                  xPos = this.lastRope.xPos;
               }
            }
            else if(stateMachine.currentState == "IS_STUN_STATE")
            {
               if(IS_IN_AIR)
               {
                  if(this.stunAirCounter++ > 60)
                  {
                     stateMachine.performAction("GROUND_COLLISION_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_BRAKING_STATE")
            {
               this.playSound("brake");
               if(counter2++ > 4)
               {
                  counter2 = 0;
                  if(IS_ON_ICE)
                  {
                     level.particlesManager.groundIceParticles(this);
                  }
                  else
                  {
                     level.particlesManager.groundSmokeParticles(this);
                  }
               }
               x_friction *= 0.95;
               if(Math.abs(xVel) < 0.25)
               {
                  changeDirection();
                  stateMachine.performAction("END_ACTION");
               }
               else if(!level.leftPressed && !level.rightPressed)
               {
                  stateMachine.performAction("KEY_RELEASE_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_HEAD_POUND_STATE")
            {
               ++this.head_pound_counter;
            }
            else if(stateMachine.currentState == "IS_STUN_WATER_STATE")
            {
               if(yPos <= Utils.SEA_LEVEL)
               {
                  yPos = Utils.SEA_LEVEL;
               }
               if(counter2++ > 60)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_LEVEL_START_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
            {
               xVel = 0;
               if(counter1 < 0)
               {
                  if(xPos + WIDTH * 0.5 < this.checkered_spot_center_x)
                  {
                     xPos += 1;
                     if(xPos + WIDTH * 0.5 >= this.checkered_spot_center_x)
                     {
                        xPos = this.checkered_spot_center_x - WIDTH * 0.5;
                        counter1 = 0;
                     }
                  }
                  else
                  {
                     --xPos;
                     if(xPos + WIDTH * 0.5 <= this.checkered_spot_center_x)
                     {
                        xPos = this.checkered_spot_center_x - WIDTH * 0.5;
                        counter1 = 0;
                     }
                  }
               }
               else
               {
                  ++counter1;
                  if(counter1 == 50)
                  {
                     if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 0 && Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
                     {
                        if(Utils.PlayerCoins >= 1)
                        {
                           if(Utils.Slot.levelSeqUnlocked[2] == true)
                           {
                              if(DoubleCoinsPanel.IsRewardAdAvailable())
                              {
                                 Utils.DoubleCoinsOn = true;
                              }
                           }
                        }
                     }
                  }
                  else if(counter1 == 60)
                  {
                     level.won();
                  }
               }
            }
            else if(stateMachine.currentState == "IS_FISHING_STATE")
            {
               xVel = yVel = 0;
            }
            else if(stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
            {
               xVel = yVel = 0;
               diff_x = this.cannonCollision.xPos - getMidXPos();
               diff_y = this.cannonCollision.yPos - getMidYPos();
               xPos += diff_x * 0.25;
               yPos += diff_y * 0.25;
            }
            else if(stateMachine.currentState == "IS_CANNON_SHOOT_STATE")
            {
               if(this.cannonCollision.cannon_frame == 0)
               {
                  xVel = 0;
                  yVel = -4;
               }
               else if(this.cannonCollision.cannon_frame == 2)
               {
                  xVel = 4;
                  yVel = 0;
               }
               else if(this.cannonCollision.cannon_frame == 4)
               {
                  xVel = 0;
                  yVel = 4;
               }
               else if(this.cannonCollision.cannon_frame == 6)
               {
                  xVel = -4;
                  yVel = 0;
               }
               this.superWallJumpParticles();
            }
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         this.updateAABB();
         level.levelPhysics.collisionDetectionMap(this);
         if(this.BUBBLE_STATE != 0)
         {
            if(this.BUBBLE_STATE == 1)
            {
               ++this.bubble_counter_1;
               if(this.bubble_counter_1 >= 3)
               {
                  this.bubble_counter_1 = 0;
                  this.bubbleSprite.alpha = this.bubbleSprite.alpha > 0.5 ? 0 : 1;
                  ++this.bubble_counter_2;
                  if(this.bubble_counter_2 == 1)
                  {
                     level.particlesManager.createBubbleParticles(getMidXPos(),getMidYPos());
                  }
                  if(this.bubble_counter_2 >= 7)
                  {
                     this.bubbleSprite.alpha = 1;
                     this.BUBBLE_STATE = 2;
                     this.bubble_counter_1 = this.bubble_counter_2 = 0;
                  }
               }
            }
            else if(this.BUBBLE_STATE == 2)
            {
               ++this.bubble_counter_1;
               if(this.bubble_counter_1 >= 300)
               {
                  this.BUBBLE_STATE = 3;
                  this.bubble_counter_1 = this.bubble_counter_2 = 0;
               }
            }
            else if(this.BUBBLE_STATE == 3)
            {
               ++this.bubble_counter_1;
               if(this.bubble_counter_1 >= 3)
               {
                  this.bubble_counter_1 = 0;
                  this.bubbleSprite.alpha = this.bubbleSprite.alpha > 0.5 ? 0 : 1;
                  ++this.bubble_counter_2;
                  if(this.bubble_counter_2 >= 14)
                  {
                     this.bubbleSprite.alpha = 0;
                     this.BUBBLE_STATE = 4;
                     this.bubble_counter_1 = this.bubble_counter_2 = 0;
                     level.particlesManager.createBubbleParticles(getMidXPos(),getMidYPos());
                  }
               }
            }
            else if(this.BUBBLE_STATE == 4)
            {
               if(this.bubble_counter_1++ >= 15)
               {
                  this.bubbleSprite.alpha = 1;
                  this.bubbleSprite.visible = false;
                  this.BUBBLE_STATE = 0;
               }
            }
         }
         if(this.BUBBLE_STATE >= 1)
         {
            if(yPos <= Utils.SEA_LEVEL + 8)
            {
               this.BUBBLE_STATE = 4;
               this.bubble_counter_1 = 30;
               level.particlesManager.pushParticle(new BubbleItemBurstParticleSprite(),getMidXPos(),getMidYPos() - 2.5,0,0,0);
            }
         }
         if(IS_GOLD)
         {
            this.gold_sin_1 += 0.1;
            if(this.gold_sin_1 >= Math.PI * 2)
            {
               this.gold_sin_1 -= Math.PI * 2;
            }
            if(this.gold_counter_1-- < 0)
            {
               this.gold_counter_1 = Math.random() * 5 + 5;
               level.particlesManager.itemSparkles("yellow",WIDTH * 0.5,HEIGHT * 0.5,-1,this);
            }
            ++this.gold_counter_2;
            if(this.gold_counter_2 >= 240)
            {
               IS_GOLD = false;
            }
            else if(this.gold_counter_2 == 90)
            {
               SoundSystem.StopMusic(true);
               level.playMusic();
            }
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_FIRE || Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_ICE_POP)
         {
            if(int(xPos) != int(oldXPos) || int(yPos) != int(oldYPos))
            {
               if(this.p_counter-- < 0)
               {
                  this.p_counter = 5;
                  if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_FIRE)
                  {
                     pSprite = new EmberParticleSprite();
                  }
                  else
                  {
                     pSprite = new FreezeParticleSprite();
                  }
                  if(Math.random() * 100 > 50)
                  {
                     pSprite.gfxHandle().gotoAndStop(1);
                  }
                  else
                  {
                     pSprite.gfxHandle().gotoAndStop(2);
                  }
                  level.particlesManager.pushBackParticle(pSprite,xPos + Math.random() * 16 - 8,yPos + Math.random() * 16 - 8,0,0.25 + Math.random() * 0.25,1);
               }
            }
         }
         if(god_mode)
         {
            if(god_mode_counter_2++ > 1)
            {
               god_mode_counter_2 = 0;
               if(sprite.alpha == 1)
               {
                  sprite.alpha = 0.2;
               }
               else
               {
                  sprite.alpha = 1;
               }
            }
            --god_mode_counter_1;
            if(god_mode_counter_1 <= 0)
            {
               god_mode = false;
               sprite.alpha = 1;
            }
         }
         DebugInputPanel.getInstance().text1.text = "" + stateMachine.currentState;
         DebugInputPanel.getInstance().text2.text = "" + "old = " + stateMachine.lastState;
      }
      
      protected function superWallJumpParticles() : void
      {
      }
      
      protected function getClimbMaxValue() : int
      {
         if(IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != LevelItems.ITEM_ICE_POP)
         {
            return 2;
         }
         return 3;
      }
      
      override protected function getIceFrictionTime() : Number
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_ICE_POP)
         {
            return 0.2;
         }
         return 0.6;
      }
      
      protected function updateAABB() : void
      {
      }
      
      public function setBackAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(19);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
      }
      
      protected function isTimeToHop(rightAfterClimb:Boolean = false) : Boolean
      {
         var y_t:int = 0;
         var tile_1:int = 0;
         var tile_2:int = 0;
         if(IS_ON_VER_PLATFORM)
         {
            if(colliding_platform != null)
            {
               if(yPos <= colliding_platform.yPos)
               {
                  return true;
               }
            }
            return false;
         }
         var x_t:int = getTileX(WIDTH * 0.5);
         if(rightAfterClimb)
         {
            y_t = getTileY(HEIGHT * 0.5);
         }
         else
         {
            y_t = getTileY(HEIGHT * 1);
         }
         tile_1 = level.levelData.getTileValueAt(x_t,y_t - 1);
         if(DIRECTION == RIGHT)
         {
            tile_2 = level.levelData.getTileValueAt(x_t + 1,y_t - 1);
         }
         else
         {
            tile_2 = level.levelData.getTileValueAt(x_t - 1,y_t - 1);
         }
         var slope_condition:Boolean = false;
         if(tile_2 == 4 || tile_2 == 5)
         {
            slope_condition = true;
         }
         if(yPos % 16 >= 8)
         {
            slope_condition = false;
         }
         else if(slope_condition)
         {
            this.IS_EXTRA_HOP_SPEED = true;
         }
         if((tile_1 == 0 || tile_1 == 15) && (tile_2 == 0 || tile_2 == 15 || slope_condition))
         {
            return true;
         }
         return false;
      }
      
      public function updateFreeze() : void
      {
         if(stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            if(counter1 == 60)
            {
               SoundSystem.PlayMusic("game_over");
            }
            else if(counter1 == 50)
            {
               Utils.GameOverOn = true;
               Utils.IsEvent = false;
            }
            if(counter1++ > 60)
            {
               sprite.visible = false;
               this.gameOverSprite.visible = true;
               this.gameOverYPos += this.gameOverYVel;
               this.gameOverYVel += 0.1;
               sprite.visible = false;
               stunHandler.updateGameOver(this.gameOverSprite,this.gameOverYPos);
               if(this.gameOverYPos >= level.camera.yPos + level.camera.HEIGHT - 64 && this.gameOverYVel > 0 && counter1 >= 180)
               {
                  level.gameOver();
               }
            }
            else
            {
               sprite.visible = true;
            }
         }
      }
      
      public function doubleCoins() : void
      {
         SoundSystem.PlayMusic("butterflies_complete");
         Utils.PlayerCoins *= 2;
      }
      
      public function revive() : void
      {
         SoundSystem.PlayMusic("butterflies_complete");
         Utils.FreezeOn = false;
         this.setGoldenCat();
         level.allowInput();
         level.soundHud.enablePause();
         if(IS_IN_WATER)
         {
            this.setInsideWater();
            stateMachine.setState("IS_FLOATING_STATE");
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var tint_level:Number = NaN;
         var bright_level:Number = NaN;
         super.updateScreenPosition(camera);
         if(stateMachine.currentState == "IS_DRIFTING_STATE" || stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_RUNNING_STATE")
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
         }
         sprite.updateScreenPosition();
         if(this.gameOverSprite != null)
         {
            this.gameOverSprite.x = sprite.x + WIDTH * 0.5;
            this.gameOverSprite.y = int(Math.floor(this.gameOverYPos - camera.yPos));
            this.gameOverSprite.updateScreenPosition();
         }
         if(IS_GOLD)
         {
            sprite.filter = new ColorMatrixFilter();
            tint_level = Math.sin(this.gold_sin_1);
            if(tint_level >= 0.5)
            {
               tint_level = 0.5;
            }
            bright_level = Math.abs(Math.sin(this.gold_sin_1));
            if(bright_level >= 0.6)
            {
               bright_level = 0.6;
            }
            ColorMatrixFilter(sprite.filter).adjustBrightness(bright_level);
            ColorMatrixFilter(sprite.filter).tint(16776960,tint_level);
         }
         else
         {
            sprite.filter = null;
         }
         this.bubbleSprite.visible = false;
         if(this.BUBBLE_STATE > 0)
         {
            this.bubbleSprite.visible = true;
            Utils.world.setChildIndex(this.bubbleSprite,Utils.world.getChildIndex(sprite) + 1);
         }
         this.bubbleSprite.x = int(Math.floor(getMidXPos() - camera.xPos));
         this.bubbleSprite.y = int(Math.floor(getMidYPos() - 2.5 - camera.yPos));
         this.bubbleSprite.updateScreenPosition();
      }
      
      public function hurt(mid_x:Number, mid_y:Number, enemy:Entity) : void
      {
         if(stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            return;
         }
         if(IS_GOLD)
         {
            return;
         }
         ++Utils.HintHurtCounter;
         if(Utils.HintHurtCounter == 2)
         {
            if(stunHandler.IS_STUNNED == false)
            {
               level.soundHud.showHint(LevelItems.ITEM_HELPER_CUPID);
            }
         }
         else if(Utils.HintHurtCounter > 4)
         {
            Utils.HintHurtCounter = 0;
         }
         if(god_mode)
         {
            return;
         }
         if(IS_IN_WATER)
         {
            level.soundHud.showHint(LevelItems.ITEM_HELPER_JELLYFISH);
         }
         this.lastEnemyHurt = enemy;
         this.lastStun = getTimer();
         Utils.PERFECT_GAME = Utils.PERFECT_ROOM = false;
         if(stunHandler.IS_STUNNED == false)
         {
            counter1 = mid_x;
            counter2 = mid_y;
            if(IS_IN_WATER)
            {
               stateMachine.setState("IS_STUN_WATER_STATE");
            }
            else
            {
               if(stateMachine.currentState == "IS_GLUED_STATE")
               {
                  level.collisionsManager.destroyHoney(getMidXPos(),getMidYPos());
               }
               stateMachine.setState("IS_STUN_STATE");
            }
            god_mode = true;
            god_mode_counter_1 = 0.5 * 60;
            god_mode_counter_2 = 0;
            SoundSystem.PlaySound("cat_hurt");
            level.particlesManager.hurtImpactParticle(this,mid_x,mid_y);
            level.freezeAction(8);
            level.camera.shake(6);
         }
         else
         {
            SoundSystem.PlaySound("cat_hurt_game_over");
            this.gameOver(mid_x,mid_y,true);
         }
      }
      
      public function isAttackingState() : Boolean
      {
         if(stateMachine.currentState == "IS_RUNNING_STATE" || stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || stateMachine.currentState == "IS_HOPPING_STATE" || stateMachine.currentState == "IS_FALLING_STATE" && this.wasOnRope())
         {
            return true;
         }
         if(stateMachine.currentState == "IS_ROPE_CLIMBING_STATE" && stateMachine.lastState == "IS_FALLING_STATE")
         {
            if(stateMachine.stateTimeCounter - getTimer() < 50)
            {
               return true;
            }
         }
         return false;
      }
      
      public function enemyDefend(mid_x:Number, mid_y:Number, enemy:Entity) : void
      {
         stateMachine.setState("IS_HEAD_POUND_STATE");
      }
      
      public function attack(mid_x:Number, mid_y:Number, enemy:Entity) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var angle:Number = NaN;
         var power:Number = NaN;
         var jump_multiplier:Number = NaN;
         var stopTeleport:Boolean = false;
         var teleportXPos:Number = xPos;
         level.freezeAction(6);
         if(!(enemy is BossLizardEnemy || enemy is BossFishEnemy))
         {
            this.playSound("cat_attack");
         }
         level.camera.shake(4);
         if(stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || (stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_HOPPING_STATE") && this.wasOnRope())
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] == 2)
            {
               SoundSystem.PlaySound("cat_super_jump");
               xPos = enemy.getMidXPos() - 8;
               yPos = enemy.getMidYPos() - 8;
               jump_multiplier = 0.75;
               jump_multiplier = 2;
               if(DIRECTION == LEFT)
               {
                  xVel = -5 * jump_multiplier;
                  this.LOCK_SPEED = 0;
               }
               else
               {
                  xVel = 5 * jump_multiplier;
                  this.LOCK_SPEED = 1;
               }
               yVel = -4 * jump_multiplier;
            }
         }
         pSprite = new ImpactParticleSprite(true);
         if(Math.random() * 100 > 50)
         {
            pSprite.scaleX = -1;
         }
         angle = Math.random() * Math.PI * 2;
         power = 6 + Math.random() * 2;
         level.topParticlesManager.pushParticle(pSprite,(enemy.getMidXPos() + getMidXPos()) * 0.5,(enemy.getMidYPos() + getMidYPos()) * 0.5,Math.sin(angle) * power,Math.cos(angle) * power,0.7);
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(this.wall_collision_after_slide_cool_off_counter > 0)
         {
            return;
         }
         if(!(Math.abs(level.camera.LEFT_MARGIN - (xPos + 8)) < 12 || Math.abs(level.camera.RIGHT_MARGIN - (xPos + 8)) < 12))
         {
            if(!(timeOutsideWater < 30 || IS_IN_WATER))
            {
               this.LOCK_SPEED = -1;
            }
            if(stateMachine.currentState == "IS_WALKING_STATE" && t_value != 11 && t_value != 12)
            {
               if(stateMachine.getCurrentStateTime() > 100)
               {
                  if(DIRECTION == LEFT && (level.leftPressed || this.IS_TAPPING_CONTINUOSLY_SX_FLAG) || DIRECTION == RIGHT && (level.rightPressed || this.IS_TAPPING_CONTINUOSLY_DX_FLAG))
                  {
                     stateMachine.performAction("CLIMB_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_RUNNING_STATE")
            {
               if(stateMachine.getCurrentStateTime() > 100 || stateMachine.lastState == "IS_FALLING_RUNNING_STATE")
               {
                  if(IS_ON_VER_PLATFORM)
                  {
                     stateMachine.performAction("CLIMB_ACTION");
                  }
                  else if((xVel < 0 && DIRECTION == LEFT && (level.leftPressed || this.IS_TAPPING_CONTINUOSLY_SX_FLAG) || xVel > 0 && DIRECTION == RIGHT && (level.rightPressed || this.IS_TAPPING_CONTINUOSLY_DX_FLAG)) && Math.abs(xVel) > 1)
                  {
                     if(t_value == 11 || t_value == 16)
                     {
                        stateMachine.performAction("WALL_COLLISION_ACTION");
                     }
                     else
                     {
                        stateMachine.performAction("CLIMB_ACTION");
                     }
                  }
               }
            }
            else if(stateMachine.currentState == "IS_CANNON_SHOOT_STATE")
            {
               stateMachine.setState("IS_HEAD_POUND_STATE");
               this.cannonCollision = null;
            }
            else if(stateMachine.currentState == "IS_HOPPING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || stateMachine.currentState == "IS_FALLING_STATE")
            {
               if(t_value != 11 && t_value != 12 && timeOutsideWater > 10)
               {
                  if(stateMachine.getTimeSinceState("IS_HOPPING_STATE") < 500)
                  {
                     if(DIRECTION == LEFT && (level.leftPressed || this.IS_TAPPING_CONTINUOSLY_SX_FLAG) || DIRECTION == RIGHT && (level.rightPressed || this.IS_TAPPING_CONTINUOSLY_DX_FLAG))
                     {
                        stateMachine.performAction("CLIMB_ACTION");
                     }
                  }
                  else
                  {
                     stateMachine.performAction("CLIMB_ACTION");
                  }
               }
            }
            else if(t_value != 11 && t_value != 12 && timeOutsideWater > 10)
            {
               stateMachine.performAction("CLIMB_ACTION");
            }
         }
         if(stateMachine.currentState != "IS_HOPPING_STATE" && stateMachine.currentState != "IS_HEAD_POUND_STATE")
         {
            if(!(timeOutsideWater < 30 || IS_IN_WATER))
            {
               xVel = 0;
            }
         }
      }
      
      override public function groundCollision() : void
      {
         var allow_sfx:Boolean = false;
         if(stateMachine.currentState == "IS_SLIDING_STATE")
         {
            if(counter1 >= 20)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
         else
         {
            allow_sfx = false;
            if(stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_FALLING_RUNNING_STATE")
            {
               if(stateMachine.getCurrentStateTime() > 50)
               {
                  allow_sfx = true;
               }
            }
            stateMachine.performAction("GROUND_COLLISION_ACTION");
            if(allow_sfx)
            {
               if(stateMachine.currentState != "IS_RUNNING_STATE")
               {
                  if(level.level_tick > 30)
                  {
                     this.playSound("falls_ground");
                  }
               }
            }
         }
      }
      
      override public function slopeCollision(t_value:int) : void
      {
         if(!IS_ON_ICE)
         {
            return;
         }
         if(IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_ICE_POP)
         {
            return;
         }
         if(t_value == 6 || t_value == 7)
         {
            xVel += 0.05;
         }
         else if(t_value == 8 || t_value == 9)
         {
            xVel -= 0.05;
         }
         else if(t_value == 4)
         {
            xVel += 0.25;
         }
         else if(t_value == 5)
         {
            xVel -= 0.25;
         }
      }
      
      override protected function playIceSlideSound() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_ICE_POP)
         {
            return;
         }
         SoundSystem.PlaySound("ice_slide");
      }
      
      override public function noGroundCollision() : void
      {
         if(!(IS_ON_PLATFORM || IS_IN_MUD))
         {
            if(stateMachine.currentState == "IS_RUNNING_STATE")
            {
               if(DIRECTION == LEFT && level.leftPressed || DIRECTION == RIGHT && level.rightPressed)
               {
                  stateMachine.performAction("JUMP_ACTION");
               }
               else
               {
                  stateMachine.performAction("NO_GROUND_ACTION");
               }
            }
            else
            {
               stateMachine.performAction("NO_GROUND_ACTION");
            }
         }
      }
      
      public function bounceCollision() : void
      {
         stateMachine.setState("IS_FALLING_STATE");
         stateMachine.performAction("BOUNCE_ACTION");
         yVel = -10;
      }
      
      public function setOnMud(mudCollision:MudAreaCollision, type:int = 0) : void
      {
         var pSprite:GameSprite = null;
         Utils.MUD_LEVEL = mudCollision.yPos + 8;
         if(type == 0)
         {
            pSprite = new MudParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(int(Math.round(Math.random() * 2)));
            level.particlesManager.pushParticle(pSprite,xPos,yPos + HEIGHT,-(Math.random() * 0.5 + 0.5),-(1 + Math.random() * 2),1,mudCollision.yPos);
            pSprite = new MudParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(int(Math.round(Math.random() * 2)));
            level.particlesManager.pushParticle(pSprite,xPos + WIDTH,yPos + HEIGHT,Math.random() * 0.5 + 0.5,-(1 + Math.random() * 2),1,mudCollision.yPos);
         }
         else if(type == 1)
         {
            level.particlesManager.snowParticlesEntity(this);
         }
         this.groundCollision();
         IS_IN_MUD = true;
         xVel = yVel = 0;
      }
      
      public function setOutsideMud() : void
      {
         IS_IN_MUD = false;
      }
      
      public function ropeCollision(_rope_collision:RopeAreaCollision, rope_mid_x:Number, rope_top_y:Number, rope_bottom_y:Number) : void
      {
         if(this.lastRope != _rope_collision)
         {
            this.lastRope = _rope_collision;
            this.ropeMidX = rope_mid_x;
            this.ropeTopY = rope_top_y + 8;
            this.ropeEndY = rope_bottom_y;
            this.playSound("cat_falls_ground");
            stateMachine.performAction("ROPE_COLLISION_ACTION");
         }
      }
      
      public function levelComplete(_checkered_spot_center_x:int, type_of_level_exit:int = 0) : void
      {
         this.checkered_spot_center_x = _checkered_spot_center_x;
         level.SECRET_EXIT = type_of_level_exit;
         if(level.SECRET_EXIT >= 1)
         {
            Utils.IS_SECRET_EXIT = true;
         }
         else
         {
            Utils.IS_SECRET_EXIT = false;
         }
         stateMachine.performAction("LEVEL_COMPLETE_ACTION");
      }
      
      public function gameOver(mid_x:Number = -1, mid_y:Number = -1, _INSTA_GAME_OVER:Boolean = false) : void
      {
         if(stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            return;
         }
         SoundSystem.PlaySound("cat_hurt_game_over");
         Utils.QUEST_HERO_GAME_OVER_FLAG = true;
         Utils.IsInstaGameOver = _INSTA_GAME_OVER;
         stateMachine.setState("IS_GAME_OVER_STATE");
         if(mid_x > 0)
         {
            level.particlesManager.hurtImpactParticle(this,mid_x,mid_y);
         }
      }
      
      override public function setInsideWater() : void
      {
         super.setInsideWater();
         if(level.level_tick > 30)
         {
            SoundSystem.PlaySound("water_splash");
         }
         stateMachine.setState("IS_FLOATING_STATE");
         xVel *= 0.25;
         yVel = 0;
         gravity_friction = 0.075;
         x_friction = 0.98;
         water_counter1 = 120;
      }
      
      override public function setInsideAir(_airCollision:AirCollision) : void
      {
         super.setInsideAir(_airCollision);
         IS_ON_ICE = false;
         SoundSystem.PlaySound("wind_breeze");
      }
      
      override public function setOutsideWater() : void
      {
         var originalYVel:Number = NaN;
         var current_tick_tock:Boolean = false;
         if(yVel < -0.4 && stateMachine.currentState != "IS_STUN_WATER_STATE")
         {
            changeDirection();
            originalYVel = yVel;
            current_tick_tock = Utils.IS_TICK;
            stateMachine.setState("IS_WALL_JUMPING_STATE");
            Utils.IS_TICK = current_tick_tock;
            yVel *= 0.85;
            SoundSystem.PlaySound("water_splash");
            super.setOutsideWater();
         }
      }
      
      protected function getMaxXVel(state:String) : Number
      {
         if(!this.IS_RUN_ALLOWED)
         {
            return 2;
         }
         if(state == "IS_RUNNING_STATE")
         {
            return 3;
         }
         return 2;
      }
      
      public function levelStartAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(13);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         level.blockInput();
         AABB_TYPE = 0;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.WAS_ON_ROPE = false;
         this.lastRope = null;
         x_friction = 0.7;
         gravity_friction = 1;
         this.LOCK_SPEED = -1;
         MAX_X_VEL = this.getMaxXVel(stateMachine.currentState);
         speed = 0.1;
         counter1 = 0;
         AABB_TYPE = 0;
      }
      
      public function standingWaterAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         counter1 = 0;
         gravity_friction = 0.075;
         x_friction = 0.98;
         AABB_TYPE = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = 0.9;
         gravity_friction = 1;
         this.same_key_counter = 0;
         counter1 = counter2 = 0;
         walking_counter = 0;
         frame_counter = 0;
         frame_speed = 0;
         MAX_X_VEL = this.getMaxXVel(stateMachine.currentState);
         speed = 0.1;
         AABB_TYPE = 0;
      }
      
      public function runningAnimation() : void
      {
         this.same_key_counter = 0;
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = 0.96;
         gravity_friction = 2;
         counter1 = counter2 = 0;
         MAX_X_VEL = this.getMaxXVel(stateMachine.currentState);
         speed = 1.5;
         if(stateMachine.lastState != "IS_BRAKING_STATE")
         {
            if(stateMachine.lastState != "IS_FALLING_STATE")
            {
               if(stateMachine.lastState != "IS_FALLING_RUNNING_STATE")
               {
                  if(level.stateMachine.currentState != "IS_CUTSCENE_STATE")
                  {
                     this.playSound("run");
                  }
               }
               ground_friction = 0;
               ground_friction_tick = 0;
               frame_counter = 0;
               frame_speed = 0;
            }
         }
         AABB_TYPE = 0;
      }
      
      public function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         gravity_friction = 1;
         AABB_TYPE = 0;
      }
      
      public function ropeTurningAnimation() : void
      {
         this.WAS_ON_ROPE = true;
         sprite.gfxHandle().gotoAndStop(21);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         AABB_TYPE = 0;
      }
      
      public function climbingAnimation() : void
      {
         if(stateMachine.lastState == "IS_BOUNCING_STATE")
         {
            IS_IN_AIR = false;
         }
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         var new_climb_y_t:int = int(yPos / Utils.TILE_HEIGHT);
         if(stateMachine.lastState == "IS_WALKING_STATE" || stateMachine.lastState == "IS_WALL_JUMPING_STATE" || stateMachine.lastState == "IS_FALLING_STATE" || stateMachine.lastState == "IS_FALLING_RUNNING_STATE" || stateMachine.lastState == "IS_JUMPING_STATE" || stateMachine.lastState == "IS_RUNNING_STATE" || stateMachine.lastState == "IS_BOUNCING_STATE" || new_climb_y_t > this.climb_y_t)
         {
            this.climb_y_t = new_climb_y_t;
         }
         this.WAS_ON_ROPE = false;
         this.lastRope = null;
         gravity_friction = 0;
         yVel = 0;
         xVel = 0;
         if(stateMachine.lastState == "IS_WALKING_STATE" || stateMachine.lastState == "IS_WALL_JUMPING_STATE" || stateMachine.lastState == "IS_FALLING_RUNNING_STATE" || stateMachine.lastState == "IS_RUNNING_STATE")
         {
            if(this.isTimeToHop(true))
            {
               stateMachine.performAction("HOP_ACTION");
               if(this.climb_y_t % Utils.TILE_HEIGHT >= 7)
               {
                  yPos = this.climb_y_t * Utils.TILE_HEIGHT;
               }
            }
         }
         AABB_TYPE = 2;
      }
      
      public function driftingAnimation() : void
      {
         var frame:int = sprite.gfxHandle().gfxHandleClip().currentFrame;
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame + 1);
         this.drift_counter = 0;
         gravity_friction = 0;
         this.lastRope = null;
         this.WAS_ON_ROPE = false;
         frame_counter = frame;
         frame_speed = 0.3333;
         AABB_TYPE = 2;
      }
      
      public function slidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         gravity_friction = 0.1;
         this.slide_counter = 0;
         this.lastRope = null;
         this.WAS_ON_ROPE = false;
         counter1 = 0;
         counter2 = 0;
         AABB_TYPE = 2;
      }
      
      public function hoppingAnimation() : void
      {
         this.playSound("hop");
         sprite.gfxHandle().gotoAndStop(10);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(DIRECTION == LEFT)
         {
            this.LOCK_SPEED = 0;
         }
         else
         {
            this.LOCK_SPEED = 1;
         }
         if(stateMachine.lastState == "IS_ROPE_CLIMBING_STATE" || stateMachine.lastState == "IS_ROPE_SLIDING_STATE")
         {
            yVel = -2;
            this.switchTickTock();
         }
         else
         {
            yVel = -2;
         }
         x_friction = 0.9;
         gravity_friction = 0.25;
         ground_friction = 1;
         if(stateMachine.lastState == "IS_ROPE_CLIMBING_STATE" || stateMachine.lastState == "IS_ROPE_SLIDING_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               xVel = 2;
            }
            else
            {
               xVel = -2;
            }
            MAX_X_VEL = 2.5;
         }
         else
         {
            speed = 0.15;
            MAX_X_VEL = 2;
         }
         AABB_TYPE = 1;
         if(this.IS_EXTRA_HOP_SPEED)
         {
            yVel *= 2.5;
            gravity_friction = 0.5;
            this.IS_EXTRA_HOP_SPEED = false;
         }
      }
      
      public function floatingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         AABB_TYPE = 1;
      }
      
      public function airFloatingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function jumpingWaterAnimation() : void
      {
         if(frame_counter >= 2)
         {
            frame_counter -= 2;
         }
         sprite.gfxHandle().gotoAndStop(15);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         AABB_TYPE = 1;
         this.switchTickTock();
      }
      
      protected function switchTickTock() : void
      {
         if(this.tick_tock_counter > 0)
         {
            return;
         }
         this.tick_tock_counter = 5;
         Utils.IS_TICK = !Utils.IS_TICK;
         if(Utils.SEA_LEVEL > 0)
         {
            if(yPos < Utils.SEA_LEVEL)
            {
               Utils.QUEST_HERO_JUMP_FLAG = true;
            }
         }
         else
         {
            Utils.QUEST_HERO_JUMP_FLAG = true;
         }
      }
      
      public function wallJumpingAnimation() : void
      {
         var sfx_to_play:int = 0;
         var jump_multiplier:Number = 1;
         this.IS_SUPER_WALL_JUMP = false;
         this.switchTickTock();
         if(stateMachine.lastState != "IS_JUMPING_WATER_STATE")
         {
            sfx_to_play = 1;
         }
         if(stateMachine.lastState == "IS_CLIMBING_STATE")
         {
            if(this.current_state_timer < 5)
            {
            }
         }
         if(sfx_to_play == 1)
         {
            this.playSound("jump");
         }
         else if(sfx_to_play == 2)
         {
            this.playSound("super_jump");
         }
         sprite.gfxHandle().gotoAndStop(10);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.IS_SUPER_WALL_JUMP)
         {
            x_friction = 0.5 + 0;
            gravity_friction = 0.25 + 0;
            MAX_X_VEL = 1.75 + 1;
            speed = 2.5 + 1;
            ground_friction = 1;
         }
         else
         {
            x_friction = 0.5;
            gravity_friction = 0.25;
            MAX_X_VEL = 1.75;
            speed = 2.5;
            ground_friction = 1;
         }
         changeDirection();
         if(DIRECTION == LEFT)
         {
            xVel = -5 * jump_multiplier;
            this.LOCK_SPEED = 0;
         }
         else
         {
            xVel = 5 * jump_multiplier;
            this.LOCK_SPEED = 1;
         }
         yVel = -4 * jump_multiplier;
         if(IS_IN_WATER == false)
         {
            level.particlesManager.createWallJumpParticle(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,DIRECTION,colliding_platform);
         }
         AABB_TYPE = 1;
         counter1 = 0;
      }
      
      public function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         IS_ON_ICE = false;
         gravity_friction = 0.25;
         this.lastRope = null;
         if(stateMachine.lastState == "IS_WALL_JUMPING_STATE")
         {
            x_friction = 0.3;
         }
         else if(stateMachine.lastState == "IS_HOPPING_STATE")
         {
            xVel *= 0.5;
         }
         else if(stateMachine.lastState != "IS_FALLING_RUNNING_STATE")
         {
            if(stateMachine.lastState == "IS_BOUNCING_STATE")
            {
               IS_IN_AIR = false;
            }
            else
            {
               x_friction = 0.9;
               if(stateMachine.lastState == "IS_RUNNING_STATE" || stateMachine.lastState == "IS_SLIDING_STATE" || stateMachine.lastState == "IS_ROPE_SLIDING_STATE")
               {
                  speed = 0.1;
               }
            }
         }
         if(stateMachine.lastState == "IS_SLIDING_STATE")
         {
            this.wall_collision_after_slide_cool_off_counter = 5;
         }
         if(DIRECTION == LEFT)
         {
            --xPos;
         }
         else
         {
            ++xPos;
         }
         AABB_TYPE = 1;
      }
      
      public function fallingRunningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(11);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         sprite.updateScreenPosition();
         sprite.gfxHandle().updateScreenPosition();
         x_friction = 0.65;
         x_friction = 0.6;
         gravity_friction = 0.31;
         AABB_TYPE = 1;
      }
      
      public function bouncingAnimation() : void
      {
         this.playSound("super_jump");
         this.WAS_ON_ROPE = false;
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = 0.65;
         gravity_friction = 0.175;
         x_friction = 0.9;
         yVel = -5;
         MAX_X_VEL = 2;
         IS_IN_AIR = true;
      }
      
      public function gluedAnimation() : void
      {
         SoundSystem.PlaySound("mud");
         xVel = yVel = 0;
         this.ropeMidX = xPos;
         this.ropeTopY = yPos;
         sprite.gfxHandle().gotoAndStop(12);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function setInsideCannon(_cannon:CannonHeroCollision) : void
      {
         if(stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
         {
            return;
         }
         if(this.cannonCollision == _cannon)
         {
            return;
         }
         this.cannonCollision = _cannon;
         stateMachine.setState("IS_CANNON_INSIDE_STATE");
      }
      
      public function setCannonShoot() : void
      {
         stateMachine.setState("IS_CANNON_SHOOT_STATE");
      }
      
      public function cannonInsideAnimation() : void
      {
         AVOID_COLLISION_DETECTION = true;
         this.cannonCollision.setHeroInside(true);
         xVel = yVel = 0;
      }
      
      public function fishingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function cannonShootAnimation() : void
      {
         this.playSound("super_jump");
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.cannonCollision.cannon_frame == 2)
         {
            DIRECTION = Entity.RIGHT;
            yPos += 4;
         }
         else if(this.cannonCollision.cannon_frame == 6)
         {
            DIRECTION = Entity.LEFT;
            yPos += 4;
         }
         AVOID_COLLISION_DETECTION = 0;
         gravity_friction = 0;
         x_friction = 1;
      }
      
      public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "jump")
         {
            SoundSystem.PlaySound("cat_jump");
         }
         else if(sfx_name == "super_jump")
         {
            SoundSystem.PlaySound("cat_super_jump");
         }
         else if(sfx_name == "falls_ground")
         {
            SoundSystem.PlaySound("cat_falls_ground");
         }
         else if(sfx_name == "hop")
         {
            SoundSystem.PlaySound("cat_grey_victory_jump");
         }
         else if(sfx_name == "cat_attack")
         {
            SoundSystem.PlaySound("enemy_hit");
         }
         else if(sfx_name == "brake")
         {
            SoundSystem.PlaySound("cat_brake");
         }
         else if(sfx_name == "run")
         {
            SoundSystem.PlaySound("cat_run");
         }
      }
      
      public function jumpingAnimation() : void
      {
         this.playSound("jump");
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         IS_ON_ICE = false;
         this.switchTickTock();
         x_friction = 0.65;
         var x_t:int = int((xPos + WIDTH * 0.5) / 8);
         if(DIRECTION == Entity.RIGHT)
         {
            xPos = x_t * 8 - WIDTH * 0.5;
         }
         else
         {
            xPos = x_t * 8;
         }
         if(DIRECTION == LEFT)
         {
            this.LOCK_SPEED = 0;
         }
         else
         {
            this.LOCK_SPEED = 1;
         }
         yVel = -3;
         AABB_TYPE = 1;
         x_friction = 0.6;
         gravity_friction = 0.31;
         jumped_at_y = getMidYPos();
      }
      
      public function brakingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(9);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter2 = 0;
         AABB_TYPE = 0;
      }
      
      public function headPoundAnimation() : void
      {
         SoundSystem.PlaySound("cat_headbutt");
         sprite.gfxHandle().gotoAndStop(12);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = 0.65;
         gravity_friction = 0.25;
         this.head_pound_counter = 0;
         yVel = -2;
         if(DIRECTION == RIGHT)
         {
            xVel = -1;
         }
         else
         {
            xVel = 1;
         }
         level.headPound();
         AABB_TYPE = 1;
      }
      
      public function stunAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(12);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(stateMachine.lastState == "IS_BOUNCING_STATE")
         {
            IS_IN_AIR = false;
         }
         if(!IS_IN_WATER)
         {
            x_friction = 0.65;
            gravity_friction = 0.25;
         }
         if(IS_IN_WATER)
         {
            if(counter2 >= yPos + HEIGHT * 0.5)
            {
               yVel = -2;
            }
         }
         else
         {
            yVel = -2;
         }
         if(counter1 > xPos + WIDTH * 0.5)
         {
            xVel = -1;
         }
         else
         {
            xVel = 1;
         }
         stun();
         Utils.QUEST_HERO_DAMAGE_FLAG = true;
         counter1 = 0;
         counter2 = 0;
         this.stunAirCounter = 0;
         AABB_TYPE = 1;
      }
      
      public function ropeClimbingAnimation() : void
      {
         this.WAS_ON_ROPE = true;
         sprite.gfxHandle().gotoAndStop(20);
         IS_ON_ICE = false;
         this.same_key_counter = 0;
         this.rope_counter_1 = this.rope_counter_2 = 0;
         gravity_friction = xVel = yVel = 0;
         if(this.lastRope != null)
         {
            xPos = this.lastRope.xPos;
         }
      }
      
      public function ropeSlidingAnimation() : void
      {
         this.WAS_ON_ROPE = true;
         this.same_key_counter = 0;
         gravity_friction = 0.075;
         this.slide_counter = 0;
         counter1 = counter2 = 0;
      }
      
      public function gameOverAnimation() : void
      {
         SoundSystem.StopMusic(true);
         level.soundHud.disablePause();
         level.blockInput();
         xVel = yVel = 0;
         x_friction = 0.7;
         gravity_friction = 1;
         this.LOCK_SPEED = -1;
         MAX_X_VEL = 2;
         speed = 0.1;
         counter1 = counter2 = counter3 = 0;
         level.camera.shake(10);
         level.freezeAction(-1);
         stunHandler.sprite.visible = true;
         this.gameOverSprite = new HeroGameOverParticleSprite();
         this.gameOverSprite.gfxHandleClip().gotoAndStop(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] + 1);
         Utils.topWorld.addChild(this.gameOverSprite);
         this.gameOverSprite.visible = false;
         this.gameOverYPos = yPos + WIDTH * 0.5;
         this.gameOverYVel = -3;
         AABB_TYPE = 0;
      }
      
      public function insideVehicleAnimation() : void
      {
      }
      
      public function levelCompleteAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(14);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         level.blockInput();
         LevelTimer.getInstance().stopTimer();
         level.soundHud.disablePause();
         SoundSystem.StopMusic();
         SoundSystem.PlayMusic("victory");
         counter1 = -1;
         xVel = 0;
         AABB_TYPE = 0;
      }
      
      public function leftPressed() : void
      {
         var diff:Number = NaN;
         this._last_time_input_sx = getTimer();
         if(stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE")
         {
            diff = getTimer() - this.LAST_TIME_INPUT_VEHICLE_SX;
            if(diff <= Utils.DOUBLE_TAP_MAX * Utils.DOUBLE_TAP_RATIO && diff >= Utils.DOUBLE_TAP_MIN * 1)
            {
               this.same_key_counter = 30;
            }
            this.LAST_TIME_INPUT_VEHICLE_SX = getTimer();
            this.LAST_TIME_INPUT_VEHICLE_DX = -1;
            return;
         }
         if(stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
         {
            if(this.cannonCollision != null)
            {
               this.cannonCollision.heroInput();
            }
         }
         else if(stateMachine.currentState == "IS_GLUED_STATE")
         {
            SoundSystem.PlaySound("unglue");
            if(this.wiggle_x_offset >= 0)
            {
               this.wiggle_x_offset = -1;
            }
            else
            {
               this.wiggle_x_offset = 1;
            }
            xPos = this.ropeMidX + this.wiggle_x_offset;
            yPos = this.ropeTopY + int(Math.random() * 2 + 1);
            ++counter1;
         }
         else if(stateMachine.currentState == "IS_FISHING_STATE")
         {
            LevelFishing(level).keyInput(true);
         }
         if(IS_IN_WATER)
         {
            if(timeInsideWater < 5 || stateMachine.currentState == "IS_STUN_WATER_STATE")
            {
               return;
            }
            if(stateMachine.currentState == "IS_JUMPING_WATER_STATE" && sprite.gfxHandle().gfxHandleClip().isComplete == false)
            {
               return;
            }
            if(DIRECTION == RIGHT)
            {
               changeDirection();
            }
            stateMachine.performAction("INPUT_ACTION");
            yVel = -1.75 * 0.75;
            xVel = -1.75 * 0.75;
            SoundSystem.PlaySound("water");
         }
         else
         {
            diff = getTimer() - this.LAST_TIME_INPUT_SX;
            if(DIRECTION == RIGHT)
            {
               stateMachine.performAction("OPPOSITE_KEY_ACTION");
            }
            if(diff <= Utils.DOUBLE_TAP_MAX * Utils.DOUBLE_TAP_RATIO && diff >= Utils.DOUBLE_TAP_MIN * 1)
            {
               ++this.DOUBLE_TAPS_SX_AMOUNT;
               this.DOUBLE_TAPS_DX_AMOUNT = 0;
               this.same_key_counter = 30;
            }
         }
      }
      
      public function rightPressed() : void
      {
         var diff:Number = NaN;
         this._last_time_input_dx = getTimer();
         if(stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE")
         {
            diff = getTimer() - this.LAST_TIME_INPUT_VEHICLE_DX;
            if(diff <= Utils.DOUBLE_TAP_MAX * Utils.DOUBLE_TAP_RATIO && diff >= Utils.DOUBLE_TAP_MIN * 1)
            {
               this.same_key_counter = 30;
            }
            this.LAST_TIME_INPUT_VEHICLE_DX = getTimer();
            this.LAST_TIME_INPUT_VEHICLE_SX = -1;
            return;
         }
         if(stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
         {
            if(this.cannonCollision != null)
            {
               this.cannonCollision.heroInput();
            }
         }
         else if(stateMachine.currentState == "IS_GLUED_STATE")
         {
            SoundSystem.PlaySound("unglue");
            if(this.wiggle_x_offset >= 0)
            {
               this.wiggle_x_offset = -1;
            }
            else
            {
               this.wiggle_x_offset = 1;
            }
            xPos = this.ropeMidX + this.wiggle_x_offset;
            yPos = this.ropeTopY + int(Math.random() * 2 + 1);
            ++counter1;
         }
         else if(stateMachine.currentState == "IS_FISHING_STATE")
         {
            LevelFishing(level).keyInput(false);
         }
         if(IS_IN_WATER)
         {
            if(timeInsideWater < 5 || stateMachine.currentState == "IS_STUN_WATER_STATE")
            {
               return;
            }
            if(stateMachine.currentState == "IS_JUMPING_WATER_STATE" && sprite.gfxHandle().gfxHandleClip().isComplete == false)
            {
               return;
            }
            if(DIRECTION == LEFT)
            {
               changeDirection();
            }
            stateMachine.performAction("INPUT_ACTION");
            yVel = -1.75 * 0.75;
            xVel = 1.75 * 0.75;
            SoundSystem.PlaySound("water");
         }
         else
         {
            diff = getTimer() - this.LAST_TIME_INPUT_DX;
            if(DIRECTION == LEFT)
            {
               stateMachine.performAction("OPPOSITE_KEY_ACTION");
            }
            if(diff <= Utils.DOUBLE_TAP_MAX * Utils.DOUBLE_TAP_RATIO && diff >= Utils.DOUBLE_TAP_MIN * 1)
            {
               ++this.DOUBLE_TAPS_DX_AMOUNT;
               this.DOUBLE_TAPS_SX_AMOUNT = 0;
               this.same_key_counter = 30;
            }
         }
      }
      
      public function setGlued() : void
      {
         stateMachine.setState("IS_GLUED_STATE");
      }
      
      protected function getHeroSprite() : GameSprite
      {
         return null;
      }
      
      override public function getAABB() : Rectangle
      {
         return new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
      }
      
      public function setInvisible() : void
      {
         sprite.visible = false;
         stunHandler.sprite.visible = false;
         this.bubbleSprite.visible = false;
      }
      
      public function refreshSprite() : void
      {
         CatSprite(sprite).refreshHat();
      }
   }
}
