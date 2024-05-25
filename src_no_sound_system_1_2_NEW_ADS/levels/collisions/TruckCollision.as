package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.tutorials.*;
   import starling.display.*;
   import states.LevelState;
   
   public class TruckCollision extends Collision
   {
      
      public static var TRUCK_TYPE_BLUE:int = 0;
      
      public static var TRUCK_TYPE_RED:int = 1;
       
      
      public var DIRECTION:int;
      
      public var TYPE:int;
      
      public var IS_ON:Boolean;
      
      public var is_on_offset_y:int;
      
      protected var is_on_counter_1:int;
      
      public var xVel:Number;
      
      public var yVel:Number;
      
      public var x_friction:Number;
      
      public var y_friction:Number;
      
      public var MAX_X_VEL:Number;
      
      public var MAX_Y_VEL:Number;
      
      public var oldXPos:Number;
      
      protected var container:Sprite;
      
      protected var backWheelsImage:Image;
      
      protected var backWheelsImage2:Image;
      
      protected var bodyImage:Image;
      
      public var driversContainer:Sprite;
      
      protected var headImage:Image;
      
      protected var bottomImage:Image;
      
      protected var sxWheelImage:Image;
      
      protected var dxWheelImage:Image;
      
      protected var lightImage:Image;
      
      protected var satelliteImage:Image;
      
      protected var tireImage1:Image;
      
      protected var tireImage2:Image;
      
      protected var signalParticle:MovieClip;
      
      protected var engineSpringForce:Number;
      
      protected var light_counter_1:int;
      
      protected var light_counter_2:int;
      
      protected var gear_frame_speed:Number;
      
      protected var gear_frame_anim:Number;
      
      protected var TIRES_ON:Boolean;
      
      protected var tire_counter:int;
      
      protected var SIGNAL_ON:Boolean;
      
      protected var signal_counter_1:int;
      
      protected var signal_counter_2:int;
      
      protected var SKID_ON:Boolean;
      
      protected var skid_counter_1:int;
      
      protected var skidImage1:Image;
      
      protected var skidImage2:Image;
      
      public var IS_SLOW_DOWN:Boolean;
      
      public function TruckCollision(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int = 0, _is_on:Boolean = true)
      {
         if(_direction == Entity.LEFT)
         {
            _xPos -= 104;
         }
         this.IS_SLOW_DOWN = false;
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         WIDTH = 112;
         this.oldXPos = xPos;
         this.DIRECTION = _direction;
         this.xVel = this.yVel = 0;
         this.x_friction = this.y_friction = 0.8;
         this.MAX_X_VEL = this.MAX_Y_VEL = 4;
         this.engineSpringForce = 0;
         if(_is_on == false)
         {
            this.IS_ON = false;
         }
         else
         {
            this.IS_ON = true;
         }
         this.TIRES_ON = false;
         this.is_on_offset_y = this.is_on_counter_1 = 0;
         this.light_counter_1 = this.light_counter_2 = 0;
         this.gear_frame_anim = this.gear_frame_speed = 0;
         this.tire_counter = 0;
         this.SIGNAL_ON = false;
         this.signal_counter_1 = 0;
         this.signal_counter_2 = 0;
         this.SKID_ON = false;
         this.skid_counter_1 = 0;
         this.initImages();
      }
      
      protected function initImages() : void
      {
         this.container = new Sprite();
         this.container.touchable = false;
         Utils.world.addChild(this.container);
         if(this.TYPE == TruckCollision.TRUCK_TYPE_RED)
         {
            sprite = null;
            this.backWheelsImage2 = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart0"));
            this.backWheelsImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart0"));
            this.backWheelsImage.touchable = this.backWheelsImage2.touchable = false;
            this.container.addChild(this.backWheelsImage);
            this.container.addChild(this.backWheelsImage2);
            this.backWheelsImage.x = 37;
            this.backWheelsImage2.x = 80;
            this.backWheelsImage.y = this.backWheelsImage2.y = 38;
            this.bottomImage = null;
            this.satelliteImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart4"));
            this.satelliteImage.touchable = false;
            this.container.addChild(this.satelliteImage);
            this.bodyImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart1"));
            this.bodyImage.touchable = false;
            this.container.addChild(this.bodyImage);
            this.bodyImage.x = 0;
            this.bodyImage.y = 0;
            this.driversContainer = new Sprite();
            this.driversContainer.touchable = false;
            this.container.addChild(this.driversContainer);
            this.headImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart2"));
            this.headImage.touchable = false;
            this.container.addChild(this.headImage);
            this.headImage.x = 53;
            this.headImage.y = 2;
            this.sxWheelImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart3"));
            this.sxWheelImage.touchable = false;
            this.container.addChild(this.sxWheelImage);
            this.sxWheelImage.x = 2 + 2;
            this.sxWheelImage.y = 43 - 5;
            this.dxWheelImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart3"));
            this.dxWheelImage.touchable = false;
            this.container.addChild(this.dxWheelImage);
            this.dxWheelImage.x = 45 + 2;
            this.dxWheelImage.y = 43 - 5;
            this.tireImage1 = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart6"));
            this.tireImage1.touchable = false;
            this.container.addChild(this.tireImage1);
            this.tireImage2 = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart6"));
            this.tireImage2.touchable = false;
            this.container.addChild(this.tireImage2);
            this.tireImage1.x = 27;
            this.tireImage2.x = 70;
            this.tireImage1.y = 47;
            this.tireImage2.y = 47;
            this.lightImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleRedTruckPart5"));
            this.lightImage.touchable = false;
            this.container.addChild(this.lightImage);
            this.lightImage.x = 73;
            this.lightImage.y = 39;
            this.signalParticle = new MovieClip(TextureManager.sTextureAtlas.getTextures("signalParticleSpriteAnim_"),12);
            Utils.juggler.add(this.signalParticle);
            this.signalParticle.touchable = false;
            this.signalParticle.loop = false;
            this.signalParticle.play();
            this.signalParticle.visible = false;
            this.container.addChild(this.signalParticle);
            this.skidImage1 = new Image(TextureManager.sTextureAtlas.getTexture("vehicleSkid"));
            this.skidImage2 = new Image(TextureManager.sTextureAtlas.getTexture("vehicleSkid"));
            this.skidImage1.touchable = false;
            this.skidImage2.touchable = false;
            this.container.addChild(this.skidImage1);
            this.container.addChild(this.skidImage2);
            this.skidImage1.visible = false;
            this.skidImage2.visible = false;
         }
         else
         {
            this.tireImage1 = null;
            this.tireImage2 = null;
            this.skidImage1 = null;
            this.skidImage2 = null;
            this.backWheelsImage2 = null;
            this.backWheelsImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart0"));
            this.backWheelsImage.touchable = false;
            this.container.addChild(this.backWheelsImage);
            this.backWheelsImage.x = 37;
            this.backWheelsImage.y = 48;
            this.bottomImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart3"));
            this.bottomImage.touchable = false;
            this.container.addChild(this.bottomImage);
            this.bottomImage.x = 1;
            this.bottomImage.y = 39;
            this.bodyImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart1"));
            this.bodyImage.touchable = false;
            this.container.addChild(this.bodyImage);
            this.bodyImage.x = 0;
            this.bodyImage.y = 0;
            this.sxWheelImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart4"));
            this.sxWheelImage.touchable = false;
            this.container.addChild(this.sxWheelImage);
            this.sxWheelImage.x = 2;
            this.sxWheelImage.y = 43;
            this.dxWheelImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart4"));
            this.dxWheelImage.touchable = false;
            this.container.addChild(this.dxWheelImage);
            this.dxWheelImage.x = this.dxWheelImage.y = 43;
            this.driversContainer = new Sprite();
            this.driversContainer.touchable = false;
            this.container.addChild(this.driversContainer);
            this.headImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart2"));
            this.headImage.touchable = false;
            this.container.addChild(this.headImage);
            this.headImage.x = 48;
            this.headImage.y = 1;
            this.lightImage = new Image(TextureManager.sTextureAtlas.getTexture("vehicleTruckPart5"));
            this.lightImage.touchable = false;
            this.container.addChild(this.lightImage);
            this.lightImage.x = 73;
            this.lightImage.y = 39;
            this.signalParticle = null;
         }
         this.container.pivotX = int(WIDTH * 0.5);
      }
      
      override public function update() : void
      {
         this.x_friction = 0.8;
         this.xVel *= this.x_friction;
         xPos += this.xVel;
         yPos += this.yVel;
         var wait_time:int = 2;
         var deltaDistance:Number = xPos - this.oldXPos;
         this.engineSpringForce += deltaDistance * 0.05;
         this.engineSpringForce *= 0.7;
         this.oldXPos += this.engineSpringForce;
         if(this.IS_ON)
         {
            ++this.is_on_counter_1;
            if(this.IS_SLOW_DOWN)
            {
               wait_time = 4;
            }
            if(this.is_on_counter_1 > wait_time)
            {
               this.is_on_counter_1 = 0;
               if(this.is_on_offset_y == 0)
               {
                  this.is_on_offset_y = 1;
               }
               else
               {
                  this.is_on_offset_y = 0;
               }
            }
         }
         if(this.SIGNAL_ON)
         {
            if(this.signalParticle.visible)
            {
               if(this.signalParticle.isComplete)
               {
                  this.signalParticle.visible = false;
                  this.signal_counter_1 = 0;
                  ++this.signal_counter_2;
                  if(this.signal_counter_2 >= 4)
                  {
                     this.SIGNAL_ON = false;
                  }
               }
            }
            else if(this.signal_counter_1++ > 15)
            {
               this.signalParticle.visible = true;
               this.signalParticle.currentFrame = 0;
               this.signalParticle.play();
            }
         }
         if(this.SKID_ON)
         {
            if(this.skid_counter_1++ > 0)
            {
               this.skidImage1.visible = !this.skidImage1.visible;
               this.skidImage2.visible = this.skidImage1.visible;
               this.skid_counter_1 = 0;
            }
         }
         if(this.TIRES_ON)
         {
            if(this.TYPE == TruckCollision.TRUCK_TYPE_RED)
            {
               ++this.tire_counter;
               if(this.tire_counter > 2)
               {
                  this.tire_counter = 0;
                  this.tireImage1.visible = !this.tireImage1.visible;
                  this.tireImage2.visible = this.tireImage1.visible;
               }
            }
         }
         else if(this.TYPE == TruckCollision.TRUCK_TYPE_RED)
         {
            this.tireImage1.visible = this.tireImage2.visible = false;
         }
         if(this.lightImage != null)
         {
            ++this.light_counter_1;
            if(this.light_counter_1 > 1)
            {
               this.light_counter_1 = 0;
               if(this.light_counter_2 == 0)
               {
                  this.light_counter_2 = 1;
                  this.lightImage.alpha = 0.2;
               }
               else
               {
                  this.light_counter_2 = 0;
                  this.lightImage.alpha = 0.3;
               }
            }
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_7)
            {
               this.lightImage.visible = false;
            }
         }
         this.gear_frame_speed += Math.abs(this.xVel * 0.00125);
         this.gear_frame_speed *= 0.98;
         this.gear_frame_anim += this.gear_frame_speed;
         if(this.gear_frame_anim >= 4)
         {
            this.gear_frame_anim -= 4;
         }
         else if(this.gear_frame_anim < 0)
         {
            this.gear_frame_anim += 4;
         }
      }
      
      public function addForce(_force:Number) : void
      {
         this.engineSpringForce += _force;
      }
      
      public function turnOn(value:Boolean) : void
      {
         this.IS_ON = value;
         this.is_on_offset_y = this.is_on_counter_1 = 0;
      }
      
      public function setSkidOn(value:Boolean) : void
      {
         if(this.TYPE == TruckCollision.TRUCK_TYPE_BLUE)
         {
            return;
         }
         this.SKID_ON = value;
         this.skid_counter_1 = 0;
         if(this.SKID_ON == false)
         {
            this.skidImage1.visible = this.skidImage2.visible = false;
         }
      }
      
      public function setSignalOn(value:Boolean) : void
      {
         if(this.TYPE == TruckCollision.TRUCK_TYPE_BLUE)
         {
            return;
         }
         this.SIGNAL_ON = value;
         this.signal_counter_1 = 0;
         this.signal_counter_2 = 0;
         this.signalParticle.visible = value;
      }
      
      public function setTiresOn(value:Boolean) : void
      {
         this.TIRES_ON = value;
         this.tire_counter = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
         if(this.DIRECTION == Entity.LEFT)
         {
            this.container.scaleX = -1;
         }
         else
         {
            this.container.scaleX = 1;
         }
         var offset_y:int = 0;
         var y_diff:Number = xPos - this.oldXPos;
         if(y_diff > 1.5)
         {
            y_diff = 1.5;
         }
         else if(y_diff < -1.5)
         {
            y_diff = -1.5;
         }
         if(this.TYPE == TruckCollision.TRUCK_TYPE_RED)
         {
            offset_y = 1;
            this.lightImage.x = 86;
            this.lightImage.y = 39 + this.is_on_offset_y;
            this.skidImage1.x = -4;
            this.skidImage2.x = 39;
            this.skidImage1.y = this.skidImage2.y = 50;
         }
         if(this.signalParticle != null)
         {
            this.signalParticle.x = int(4);
            this.signalParticle.y = int(-27 + this.is_on_offset_y);
         }
         this.bodyImage.y = int(Math.floor(this.is_on_offset_y + y_diff));
         this.headImage.y = int(Math.floor(10 + this.is_on_offset_y - y_diff)) + offset_y;
         this.driversContainer.x = 0;
         this.driversContainer.y = this.headImage.y;
         if(this.TYPE == TruckCollision.TRUCK_TYPE_RED)
         {
            this.satelliteImage.x = 13;
            this.satelliteImage.y = this.bodyImage.y - 19;
         }
         else
         {
            sprite.x = -20;
            sprite.y = this.bodyImage.y;
            sprite.gfxHandleClip().gotoAndStop(this.gear_frame_anim + 1);
         }
      }
      
      override public function destroy() : void
      {
         this.container.removeChild(this.backWheelsImage);
         if(this.bottomImage != null)
         {
            this.container.removeChild(this.bottomImage);
         }
         if(this.signalParticle != null)
         {
            Utils.juggler.remove(this.signalParticle);
            this.container.removeChild(this.signalParticle);
            this.signalParticle.dispose();
            this.signalParticle = null;
         }
         if(this.skidImage1 != null)
         {
            this.container.removeChild(this.skidImage1);
            this.skidImage1.dispose();
            this.skidImage1 = null;
            this.container.removeChild(this.skidImage2);
            this.skidImage2.dispose();
            this.skidImage2 = null;
         }
         this.container.removeChild(this.bodyImage);
         this.container.removeChild(this.sxWheelImage);
         this.container.removeChild(this.dxWheelImage);
         this.container.removeChild(this.driversContainer);
         this.container.removeChild(this.headImage);
         this.container.removeChild(this.lightImage);
         this.backWheelsImage.dispose();
         if(this.bottomImage != null)
         {
            this.bottomImage.dispose();
         }
         this.bodyImage.dispose();
         this.sxWheelImage.dispose();
         this.dxWheelImage.dispose();
         this.driversContainer.dispose();
         this.headImage.dispose();
         this.lightImage.dispose();
         this.backWheelsImage = null;
         this.bottomImage = null;
         this.bodyImage = null;
         this.sxWheelImage = null;
         this.dxWheelImage = null;
         this.driversContainer = null;
         this.headImage = null;
         this.lightImage = null;
         if(this.tireImage1 != null)
         {
            this.container.removeChild(this.tireImage1);
            this.tireImage1.dispose();
            this.tireImage1 = null;
         }
         if(this.tireImage2 != null)
         {
            this.container.removeChild(this.tireImage2);
            this.tireImage2.dispose();
            this.tireImage2 = null;
         }
         if(sprite != null)
         {
            this.container.removeChild(sprite);
            sprite.destroy();
            sprite.dispose();
            sprite = null;
         }
         if(this.satelliteImage != null)
         {
            this.container.removeChild(this.satelliteImage);
            this.satelliteImage.dispose();
            this.satelliteImage = null;
         }
         Utils.world.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         super.destroy();
      }
   }
}
