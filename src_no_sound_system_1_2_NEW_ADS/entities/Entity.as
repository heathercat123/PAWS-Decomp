package entities
{
   import entities.particles.*;
   import flash.geom.Rectangle;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.*;
   import sprites.GameSprite;
   import sprites.particles.*;
   
   public class Entity
   {
      
      public static var LEFT:int = 0;
      
      public static var RIGHT:int = 1;
      
      public static const EMOTION_SHOCKED:int = 0;
      
      public static const EMOTION_WORRIED:int = 1;
      
      public static const EMOTION_LOVE:int = 2;
      
      public static const EMOTION_QUESTION:int = 3;
       
      
      public var level:Level;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var originalXPos:Number;
      
      public var originalYPos:Number;
      
      public var oldXPos:Number;
      
      public var oldYPos:Number;
      
      public var xVel:Number;
      
      public var yVel:Number;
      
      public var speed:Number;
      
      public var mass:Number;
      
      public var waterfall_counter:Number;
      
      public var MAX_X_VEL:Number;
      
      public var MAX_Y_VEL:Number;
      
      public var MIN_X_VEL:Number;
      
      public var IS_ON_PLATFORM:Boolean;
      
      public var IS_ON_VER_PLATFORM:Boolean;
      
      public var colliding_platform:Collision;
      
      public var DIRECTION:int;
      
      public var IS_IN_WATER:Boolean;
      
      public var timeOutsideWater:int;
      
      public var timeInsideWater:int;
      
      public var water_counter1:int;
      
      public var IS_ON_ICE:Boolean;
      
      public var IS_IN_AIR:Boolean;
      
      public var IS_GOLD:Boolean;
      
      public var airCollision:AirCollision;
      
      public var wasOnCloudTile:Boolean;
      
      public var wasOnSlopeTile:Boolean;
      
      public var restitution:Number;
      
      public var x_friction:Number;
      
      public var y_friction:Number;
      
      public var water_friction:Number;
      
      public var gravity_friction:Number;
      
      public var jumped_at_y:Number;
      
      public var y_vel_at_ground_collision:Number;
      
      public var collision_tile_value:int;
      
      protected var frame_counter:Number;
      
      protected var frame_speed:Number;
      
      protected var counter1:Number;
      
      protected var counter2:Number;
      
      protected var counter3:Number;
      
      protected var walking_counter:int;
      
      protected var AABB_TYPE:int;
      
      protected var god_mode:Boolean;
      
      protected var god_mode_counter_1:int;
      
      protected var god_mode_counter_2:int;
      
      protected var ground_friction:Number;
      
      protected var ground_friction_tick:Number;
      
      protected var ground_friction_time:Number;
      
      public var dead:Boolean;
      
      public var active:Boolean;
      
      public var aabb:Rectangle;
      
      public var aabbPhysics:Rectangle;
      
      public var aabbSpike:Rectangle;
      
      public var AVOID_COLLISION_DETECTION:Boolean;
      
      public var AVOID_CEIL_COLLISION_DETECTION:Boolean;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var IS_IN_MUD:Boolean;
      
      protected var IS_BACK_WORLD:Boolean;
      
      public var stateMachine:StateMachine;
      
      public var sprite:GameSprite;
      
      public var stunHandler:StunHandler;
      
      protected var worried_offset_x:int = 0;
      
      protected var worried_offset_y:int = 0;
      
      protected var shocked_offset_x:int = 0;
      
      protected var shocked_offset_y:int = 0;
      
      public function Entity(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super();
         this.level = _level;
         this.xPos = this.originalXPos = this.oldXPos = _xPos;
         this.yPos = this.originalYPos = this.oldYPos = _yPos;
         this.xVel = this.yVel = 0;
         this.waterfall_counter = 0;
         this.y_vel_at_ground_collision = this.collision_tile_value = 0;
         this.jumped_at_y = 0;
         this.IS_BACK_WORLD = false;
         this.DIRECTION = _direction;
         this.AVOID_COLLISION_DETECTION = false;
         this.AVOID_CEIL_COLLISION_DETECTION = false;
         this.colliding_platform = null;
         this.aabb = new Rectangle(0,4,16,12);
         this.aabbPhysics = new Rectangle(0,4,16,12);
         this.aabbSpike = new Rectangle(0,0,0,0);
         this.AABB_TYPE = 0;
         this.sprite = null;
         this.MAX_X_VEL = 4;
         this.MIN_X_VEL = 0.15;
         this.MAX_Y_VEL = 4;
         this.IS_ON_PLATFORM = this.IS_ON_VER_PLATFORM = false;
         this.x_friction = 1;
         this.y_friction = 1;
         this.gravity_friction = 1;
         this.water_friction = 1;
         this.restitution = 0;
         this.mass = 1;
         this.water_counter1 = 0;
         this.frame_counter = 0;
         this.frame_speed = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.walking_counter = 0;
         this.wasOnCloudTile = true;
         this.wasOnSlopeTile = false;
         this.dead = false;
         this.active = true;
         this.IS_IN_WATER = false;
         this.timeOutsideWater = this.timeInsideWater = 0;
         this.airCollision = null;
         this.IS_ON_ICE = false;
         this.IS_IN_AIR = false;
         this.IS_GOLD = false;
         this.ground_friction = 0;
         this.ground_friction_tick = 0;
         this.ground_friction_time = 0.2;
         this.stateMachine = null;
         this.stunHandler = null;
      }
      
      public function destroy() : void
      {
         if(this.stateMachine != null)
         {
            this.stateMachine.destroy();
            this.stateMachine = null;
         }
         if(this.stunHandler != null)
         {
            this.stunHandler.destroy();
            this.stunHandler = null;
         }
         if(this.sprite != null)
         {
            if(this.IS_BACK_WORLD)
            {
               Utils.backWorld.removeChild(this.sprite);
            }
            else
            {
               Utils.world.removeChild(this.sprite);
            }
            this.sprite.destroy();
            this.sprite.dispose();
            this.sprite = null;
         }
         this.colliding_platform = null;
         this.airCollision = null;
         this.aabb = this.aabbPhysics = this.aabbSpike = null;
         this.level = null;
      }
      
      public function update() : void
      {
         if(this.stunHandler)
         {
            this.stunHandler.update();
         }
         if(!this.IS_IN_WATER)
         {
            ++this.timeOutsideWater;
            if(this.timeOutsideWater > 100)
            {
               this.timeOutsideWater = 100;
            }
         }
         else
         {
            ++this.timeInsideWater;
            if(this.timeInsideWater > 100)
            {
               this.timeInsideWater = 100;
            }
         }
         if(this.stateMachine != null)
         {
            if(this.stateMachine.currentState == "IS_WALKING_STATE" || this.stateMachine.currentState == "IS_WALKING_HOLE_STATE")
            {
               ++this.walking_counter;
            }
            else
            {
               --this.walking_counter;
            }
            if(this.walking_counter >= 60)
            {
               this.walking_counter = 60;
            }
            else if(this.walking_counter < 0)
            {
               this.walking_counter = 0;
            }
         }
         if(this.IS_ON_ICE)
         {
            this.ground_friction_time = this.getIceFrictionTime();
         }
         else if(this.IS_IN_MUD)
         {
            this.ground_friction_time = 0.6;
         }
         else
         {
            this.ground_friction_time = this.getGroundFrictionTime();
         }
      }
      
      protected function getIceFrictionTime() : Number
      {
         return 0.6;
      }
      
      protected function getGroundFrictionTime() : Number
      {
         return 0.2;
      }
      
      public function setInIce(value:Boolean) : void
      {
         this.IS_ON_ICE = value;
      }
      
      public function allowPlatformCollision(collision:Collision) : Boolean
      {
         var mid_x:Number = NaN;
         var this_mid_x:Number = NaN;
         if(collision is YellowVerticalPlatformCollision)
         {
            if(this.yPos <= collision.yPos)
            {
               return false;
            }
            if(this.yPos >= collision.yPos + collision.HEIGHT)
            {
               return false;
            }
         }
         else if(this.yVel < 0)
         {
            return false;
         }
         if(this.stateMachine != null)
         {
            if(this.stateMachine.currentState == "IS_HURT_STATE" || this.stateMachine.currentState == "IS_GAME_OVER_STATE" || this.stateMachine.currentState == "IS_HIT_STATE")
            {
               return false;
            }
         }
         if(collision is WaterfallCollision || collision is FloatingLogCollision || collision is SandfallCollision)
         {
            if(this.yPos + 6 >= collision.yPos)
            {
               return false;
            }
         }
         else
         {
            if(collision is YellowVerticalPlatformCollision)
            {
               mid_x = collision.getMidXPos();
               this_mid_x = this.getMidXPos();
               if(this_mid_x < mid_x)
               {
                  if(this.DIRECTION == Entity.LEFT || this.xVel < 0)
                  {
                     return false;
                  }
               }
               else if(this.DIRECTION == Entity.RIGHT || this.xVel > 0)
               {
                  return false;
               }
               return true;
            }
            if(this.yPos + this.aabbPhysics.y + this.aabbPhysics.height - 3 >= collision.yPos)
            {
               return false;
            }
         }
         return true;
      }
      
      public function resetGroundFriction() : void
      {
         this.ground_friction = 0;
         this.ground_friction_tick = 0;
      }
      
      public function setOnWallPlatform(platformCollision:Collision) : void
      {
         this.IS_ON_VER_PLATFORM = true;
         this.wallCollision();
         this.colliding_platform = platformCollision;
      }
      
      public function setOnPlatform(platformCollision:Collision) : void
      {
         this.groundCollision();
         this.colliding_platform = platformCollision;
         this.IS_ON_PLATFORM = true;
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.sprite.x = int(Math.floor(this.xPos - camera.xPos));
         this.sprite.y = int(Math.floor(this.yPos - camera.yPos));
         if(this.sprite.gfxHandle() != null)
         {
            if(this.DIRECTION == LEFT)
            {
               this.sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               this.sprite.gfxHandle().scaleX = -1;
            }
         }
         if(this.stunHandler)
         {
            this.stunHandler.updateScreenPosition(camera);
         }
         this.sprite.updateScreenPosition();
      }
      
      public function onTop() : void
      {
         Utils.world.setChildIndex(this.sprite,Utils.world.numChildren - 1);
      }
      
      public function getAABB() : Rectangle
      {
         return new Rectangle(this.xPos + this.aabb.x,this.yPos + this.aabb.y,this.aabb.width,this.aabb.height);
      }
      
      public function getAABBPhysics() : Rectangle
      {
         return new Rectangle(this.xPos + this.aabbPhysics.x,this.yPos + this.aabbPhysics.y,this.aabbPhysics.width,this.aabbPhysics.height);
      }
      
      public function getAABBSpike() : Rectangle
      {
         return new Rectangle(this.xPos + this.aabbSpike.x,this.yPos + this.aabbSpike.y,this.aabbSpike.width,this.aabbSpike.height);
      }
      
      public function getMidXPos() : Number
      {
         return this.xPos + this.WIDTH * 0.5;
      }
      
      public function getMidYPos() : Number
      {
         return this.yPos + this.HEIGHT * 0.5;
      }
      
      public function getBottomYPos() : Number
      {
         return this.yPos + this.HEIGHT - 8;
      }
      
      public function getTileX(offset_x:Number) : int
      {
         return int((this.xPos + offset_x) / Utils.TILE_WIDTH);
      }
      
      public function getTileY(offset_y:Number) : int
      {
         return int((this.yPos + offset_y) / Utils.TILE_HEIGHT);
      }
      
      public function getBalloonXOffset() : int
      {
         return 8;
      }
      
      public function getBalloonYOffset() : int
      {
         return -20;
      }
      
      public function wallCollision(t_value:int = 1) : void
      {
      }
      
      public function groundCollision() : void
      {
      }
      
      public function slopeCollision(t_value:int) : void
      {
      }
      
      public function ceilCollision() : void
      {
      }
      
      public function noGroundCollision() : void
      {
      }
      
      public function setZeroVelocity() : void
      {
         this.xVel = this.yVel = 0;
      }
      
      public function setInsideWater() : void
      {
         this.IS_IN_WATER = true;
         this.water_friction = 0.5;
         this.timeInsideWater = 0;
      }
      
      public function setOutsideWater() : void
      {
         this.IS_IN_WATER = false;
         this.water_friction = 1;
         this.timeOutsideWater = 0;
      }
      
      public function setInsideAir(_airCollision:AirCollision) : void
      {
         this.IS_IN_AIR = true;
         this.airCollision = _airCollision;
      }
      
      public function setOutsideAir() : void
      {
         this.IS_IN_AIR = false;
         this.airCollision = null;
      }
      
      public function changeDirection() : void
      {
         if(this.DIRECTION == Entity.RIGHT)
         {
            this.DIRECTION = Entity.LEFT;
         }
         else
         {
            this.DIRECTION = Entity.RIGHT;
         }
      }
      
      public function isInsideVehicle() : Boolean
      {
         return false;
      }
      
      public function stun() : void
      {
         if(this.stunHandler != null)
         {
            this.stunHandler.stun();
         }
      }
      
      public function unstun() : void
      {
      }
      
      public function setEmotionParticle(emotion_id:int) : void
      {
         var pSprite:GameSprite = null;
         var particle:Particle = null;
         if(emotion_id == Entity.EMOTION_WORRIED)
         {
            pSprite = new WorriedParticleSprite();
            if(this.DIRECTION == Entity.LEFT)
            {
               particle = this.level.particlesManager.pushParticle(pSprite,8 - this.worried_offset_x,-4 + this.worried_offset_y,0,0,1);
            }
            else
            {
               particle = this.level.particlesManager.pushParticle(pSprite,1 + this.worried_offset_x,-4 + this.worried_offset_y,0,0,1);
            }
            particle.entity = this;
         }
         else if(emotion_id == Entity.EMOTION_SHOCKED)
         {
            pSprite = new GlimpseParticleSprite();
            if(this.DIRECTION == Entity.LEFT)
            {
               particle = this.level.particlesManager.pushParticle(pSprite,1 - this.shocked_offset_x,2 + this.shocked_offset_y,0,0,1);
            }
            else
            {
               pSprite.scaleX = -1;
               particle = this.level.particlesManager.pushParticle(pSprite,15 + this.shocked_offset_x,2 + this.shocked_offset_y,0,0,1);
            }
            particle.setEntity(this);
         }
         else if(emotion_id == Entity.EMOTION_QUESTION)
         {
            SoundSystem.PlaySound("blink");
            pSprite = new QuestionMarkParticleSprite();
            particle = this.level.particlesManager.pushParticle(pSprite,5,-5,0,0,1);
            particle.entity = this;
         }
         else if(emotion_id == Entity.EMOTION_LOVE)
         {
            pSprite = new GenericParticleSprite(GenericParticleSprite.LOVE);
            particle = this.level.particlesManager.pushParticle(pSprite,this.WIDTH * 0.5,-5,0,0,1);
            particle.entity = this;
         }
      }
      
      protected function removeGroundFriction() : void
      {
         this.ground_friction_tick += 1 / 60;
         if(this.stateMachine.currentState == "IS_RUNNING_STATE" || this.stateMachine.currentState == "IS_TURNING_RUNNING_STATE")
         {
            if(this.ground_friction_tick >= this.ground_friction_time)
            {
               this.ground_friction_tick = this.ground_friction_time;
            }
            else if(this.IS_ON_ICE)
            {
               if(Utils.ICE_TYPE == 1)
               {
                  SoundSystem.PlaySound("mud_slide");
               }
               else if(!this.IS_IN_AIR)
               {
                  this.playIceSlideSound();
               }
            }
            this.ground_friction = Easings.easeInQuart(this.ground_friction_tick,0,1,this.ground_friction_time);
         }
         else
         {
            if(this.ground_friction_tick >= this.ground_friction_time)
            {
               this.ground_friction_tick = this.ground_friction_time;
            }
            else if(this.IS_ON_ICE)
            {
               if(Utils.ICE_TYPE == 1)
               {
                  SoundSystem.PlaySound("mud_slide");
               }
               else if(!this.IS_IN_AIR)
               {
                  this.playIceSlideSound();
               }
            }
            this.ground_friction = Easings.easeInQuart(this.ground_friction_tick,0,1,this.ground_friction_time);
            if(!this.IS_ON_ICE && !this.IS_IN_MUD)
            {
               this.ground_friction = 1;
            }
            if(this.IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_ICE_POP)
            {
               this.ground_friction = 1;
            }
         }
      }
      
      protected function playIceSlideSound() : void
      {
         SoundSystem.PlaySound("ice_slide");
      }
      
      protected function addGroundFriction() : void
      {
         this.ground_friction_tick -= 1 / 60;
         if(this.stateMachine.currentState == "IS_RUNNING_STATE" || this.stateMachine.currentState == "IS_TURNING_RUNNING_STATE")
         {
            if(this.ground_friction_tick <= 0)
            {
               this.ground_friction_tick = 0;
            }
            this.ground_friction = Easings.easeInQuart(this.ground_friction_tick,1,-1,this.ground_friction_time);
         }
         else
         {
            if(this.ground_friction_tick <= 0)
            {
               this.ground_friction_tick = 0;
            }
            this.ground_friction = Easings.easeInQuart(this.ground_friction_tick,1,-1,this.ground_friction_time);
         }
      }
      
      public function activate() : void
      {
         this.active = true;
         if(this.sprite != null)
         {
            this.sprite.visible = true;
         }
      }
      
      public function deactivate() : void
      {
         this.active = false;
         if(this.sprite != null)
         {
            this.sprite.visible = false;
         }
      }
      
      public function isInsideScreen() : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(this.level.camera.xPos - 48,this.level.camera.yPos - 48,this.level.camera.WIDTH + 96,this.level.camera.HEIGHT + 96);
         var area:Rectangle = new Rectangle(this.xPos + this.aabbPhysics.x,this.yPos + this.aabbPhysics.y,this.aabbPhysics.width,this.aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(this.level.camera.xPos + _offset,this.level.camera.yPos + _offset,this.level.camera.WIDTH - _offset * 2,this.level.camera.HEIGHT - _offset * 2);
         var area:Rectangle = new Rectangle(this.xPos + this.aabbPhysics.x,this.yPos + this.aabbPhysics.y,this.aabbPhysics.width,this.aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
