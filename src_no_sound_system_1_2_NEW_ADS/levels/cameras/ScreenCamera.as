package levels.cameras
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.behaviours.CameraBehaviour;
   
   public class ScreenCamera
   {
       
      
      public var level:Level;
      
      public var x:Number;
      
      public var y:Number;
      
      public var oldXPos:Number;
      
      public var oldYPos:Number;
      
      public var originalXPos:Number;
      
      public var originalYPos:Number;
      
      public var xVel:Number;
      
      public var yVel:Number;
      
      public var WIDTH:Number;
      
      public var HEIGHT:Number;
      
      public var HALF_WIDTH:Number;
      
      public var HALF_HEIGHT:Number;
      
      public var xShift:Number;
      
      public var yShift:Number;
      
      public var wave_xShift:Number;
      
      public var wave_yShift:Number;
      
      public var LEFT_MARGIN:Number;
      
      public var RIGHT_MARGIN:Number;
      
      public var TOP_MARGIN:Number;
      
      public var BOTTOM_MARGIN:Number;
      
      public var xShake:*;
      
      public var yShake:Number;
      
      public var shakePower:Number;
      
      public var IS_SHAKING:Boolean;
      
      public var IS_HOR_SHAKE:Boolean;
      
      public var IS_VER_SHAKE:Boolean;
      
      protected var hor_shake_friction:Number;
      
      protected var hor_shake_sin_increase:Number;
      
      protected var ver_shake_friction:Number;
      
      protected var ver_shake_sin_increase:Number;
      
      public var shakeDurationCounter:int;
      
      public var shakeCounter1:*;
      
      public var shakeCounter2:Number;
      
      public var sinCounter1:Number;
      
      public var quakeTime:int;
      
      public function ScreenCamera(_level:Level)
      {
         super();
         this.level = _level;
         this.x = this.originalXPos = this.oldXPos = this.xShift = this.xVel = this.wave_xShift = 0;
         this.y = this.originalYPos = this.oldYPos = this.yShift = this.yVel = this.wave_yShift = 0;
         this.xShake = this.yShake = this.shakeCounter1 = this.shakeCounter2 = this.shakePower = this.shakeDurationCounter = this.sinCounter1 = 0;
         this.ver_shake_friction = this.hor_shake_friction = 0.85;
         this.ver_shake_sin_increase = this.hor_shake_sin_increase = 0.5;
         this.IS_SHAKING = this.IS_HOR_SHAKE = this.IS_VER_SHAKE = false;
         this.WIDTH = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE);
         this.HEIGHT = int(Utils.SCREEN_HEIGHT * Utils.GFX_INV_SCALE);
         this.HALF_WIDTH = int(this.WIDTH * 0.5);
         this.HALF_HEIGHT = int(this.HEIGHT * 0.5);
         this.LEFT_MARGIN = this.level.levelData.LEFT_MARGIN;
         this.RIGHT_MARGIN = this.level.levelData.RIGHT_MARGIN;
         this.TOP_MARGIN = this.level.levelData.TOP_MARGIN;
         this.BOTTOM_MARGIN = this.level.levelData.BOTTOM_MARGIN;
      }
      
      public function destroy() : void
      {
         this.level = null;
      }
      
      public function update() : void
      {
         this.x = this.level.hero.xPos + 8 - int(this.WIDTH * 0.5);
         this.y = 24;
      }
      
      public function shake(power:Number = 6, endless:Boolean = false, timer:int = -1) : void
      {
      }
      
      public function horShake(power:Number = 6, _hor_shake_friction:Number = 0.85, _hor_shake_sin_increase:Number = 0.5) : void
      {
      }
      
      public function verShake(power:Number = 6, _ver_shake_friction:Number = 0.85, _ver_shake_sin_increase:Number = 0.5) : void
      {
      }
      
      public function lockCameraDebug(_x:Number = 0, _y:Number = 0) : void
      {
      }
      
      public function isInsideScreen(aabb:Rectangle) : Boolean
      {
         var cameraRectangle:Rectangle = new Rectangle(this.xPos,this.yPos,this.WIDTH,this.HEIGHT);
         return cameraRectangle.intersects(aabb);
      }
      
      public function getCameraRect() : Rectangle
      {
         return new Rectangle(this.xPos,this.yPos,this.WIDTH,this.HEIGHT);
      }
      
      public function getCameraOuterRect() : Rectangle
      {
         return new Rectangle(this.xPos - Utils.TILE_WIDTH * 2,this.yPos - Utils.TILE_HEIGHT * 2,this.WIDTH + Utils.TILE_WIDTH * 4,this.HEIGHT + Utils.TILE_HEIGHT * 4);
      }
      
      public function getMaxXFocal() : Number
      {
         return Math.round(this.WIDTH * 0.1 / Utils.TILE_WIDTH) * Utils.TILE_WIDTH;
      }
      
      public function get xPos() : int
      {
         return this.x + this.xShake + this.wave_xShift;
      }
      
      public function get yPos() : int
      {
         return this.y + this.yShake + this.wave_yShift;
      }
      
      public function set xPos(value:int) : void
      {
         this.x = value;
      }
      
      public function set yPos(value:int) : void
      {
         this.y = value;
      }
      
      public function changeHorBehaviour(_newBehaviour:CameraBehaviour, _destroy:Boolean = true) : void
      {
      }
      
      public function changeVerBehaviour(_newBehaviour:CameraBehaviour, _destroy:Boolean = true) : void
      {
      }
      
      public function setVehicle(_inside:Boolean) : void
      {
      }
      
      public function getVerticalOffsetFromGroundLevel() : int
      {
         var _value:Number = Utils.HEIGHT * 0.25;
         if(Utils.IS_IPAD)
         {
            _value = Utils.HEIGHT * 0.33;
         }
         var _discrete_value:Number = Math.round(_value / 8);
         return int(_discrete_value * 8);
      }
   }
}
