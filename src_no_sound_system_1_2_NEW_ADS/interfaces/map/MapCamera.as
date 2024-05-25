package interfaces.map
{
   import flash.geom.Point;
   import game_utils.GameSlot;
   import starling.display.Button;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class MapCamera
   {
       
      
      public var worldMap:WorldMap;
      
      public var x:*;
      
      public var y:Number;
      
      public var x_key:Number;
      
      public var x_new:Number;
      
      public var x_friction:Number;
      
      public var x_diff:Number;
      
      public var x_freeze:Number;
      
      public var MAX_VEL:Number;
      
      protected var IS_MOVING_RIGHT:Boolean;
      
      public var WIDTH:int;
      
      public var IS_PRESSED:Boolean;
      
      public var LEFT_MARGIN:Number;
      
      public var RIGHT_MARGIN:Number;
      
      public var xShake:*;
      
      public var yShake:Number;
      
      public var shakePower:Number;
      
      public var IS_SHAKING:Boolean;
      
      public var IS_HOR_SHAKE:Boolean;
      
      public var shakeDurationCounter:int;
      
      public var shakeCounter1:*;
      
      public var shakeCounter2:Number;
      
      public var sinCounter1:Number;
      
      public function MapCamera(_worldMap:WorldMap)
      {
         super();
         this.worldMap = _worldMap;
         this.x = this.y = 0;
         this.xShake = this.yShake = this.shakeCounter1 = this.shakeCounter2 = this.shakePower = this.shakeDurationCounter = this.sinCounter1 = 0;
         this.IS_SHAKING = this.IS_HOR_SHAKE = false;
         this.x_key = this.x_new = this.x_diff = 0;
         this.x_friction = 0.8;
         this.x_freeze = 1;
         this.MAX_VEL = 8;
         this.IS_PRESSED = false;
         this.IS_MOVING_RIGHT = false;
         this.WIDTH = int(Utils.WIDTH) + 1;
         this.LEFT_MARGIN = 48;
         this.RIGHT_MARGIN = _worldMap.mapLoader.mapEndX;
         this.xPos = Utils.Slot.gameVariables[GameSlot.VARIABLE_MAP];
         if(this.xPos < 48)
         {
            this.xPos = 48;
         }
         else if(this.xPos > this.RIGHT_MARGIN)
         {
            this.xPos = this.RIGHT_MARGIN;
         }
         this.yPos = 168 - int(Utils.HEIGHT * 0.5);
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
      }
      
      public function destroy() : void
      {
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         this.worldMap = null;
      }
      
      public function onClick(event:TouchEvent) : void
      {
         var touches:Vector.<Touch> = null;
         var previousPosition:Point = null;
         var position:Point = null;
         if(this.worldMap.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            return;
         }
         if(event.target is Button)
         {
            return;
         }
         try
         {
            touches = event.getTouches(Utils.rootStage);
            previousPosition = touches[touches.length - 1].getPreviousLocation(Utils.rootStage);
            position = touches[touches.length - 1].getLocation(Utils.rootStage);
            if(touches[touches.length - 1].phase == "began")
            {
               this.worldMap.mapCoins.processInput(this.xPos + position.x * Utils.GFX_INV_SCALE,this.yPos + position.y * Utils.GFX_INV_SCALE);
               this.x_key = this.x_new = position.x * Utils.GFX_INV_SCALE;
               this.IS_PRESSED = true;
            }
            else if(touches[touches.length - 1].phase == "moved")
            {
               if(position.x * Utils.GFX_INV_SCALE < this.x_new)
               {
                  this.IS_MOVING_RIGHT = false;
               }
               else
               {
                  this.IS_MOVING_RIGHT = true;
               }
               this.x_new = position.x * Utils.GFX_INV_SCALE;
            }
            else if(touches[touches.length - 1].phase == "ended")
            {
               this.IS_PRESSED = false;
               this.x_diff *= 0.75;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function update() : void
      {
         var angle:Number = NaN;
         if(this.IS_PRESSED)
         {
            this.x_diff = (this.x_new - this.x_key) * this.x_freeze;
            this.x_key += this.x_diff * 0.5;
            this.x -= this.x_diff * 0.5;
         }
         else
         {
            this.x -= this.x_diff;
            this.x_diff *= 0.9;
            if(this.x < this.LEFT_MARGIN)
            {
               this.x += (this.LEFT_MARGIN - this.x) * 0.25;
            }
            else if(this.x + this.WIDTH > this.RIGHT_MARGIN)
            {
               this.x -= (this.x + this.WIDTH - this.RIGHT_MARGIN) * 0.25;
            }
         }
         if(this.x < this.LEFT_MARGIN)
         {
            this.x_freeze = 1 - (this.LEFT_MARGIN - this.x) / 48;
            if(!this.IS_MOVING_RIGHT)
            {
               this.x_freeze = 1;
            }
            if(this.x < 0)
            {
               this.x = 0;
            }
         }
         else if(this.x + this.WIDTH > this.RIGHT_MARGIN)
         {
            this.x_freeze = 1 - (this.x + this.WIDTH - this.RIGHT_MARGIN) / 48;
            if(this.IS_MOVING_RIGHT)
            {
               this.x_freeze = 1;
            }
            if(this.x + this.WIDTH > this.RIGHT_MARGIN + 48)
            {
               this.x = this.RIGHT_MARGIN + 48 - this.WIDTH;
            }
         }
         if(this.x_freeze < 0)
         {
            this.x_freeze = 0;
         }
         else if(this.x_freeze > 1)
         {
            this.x_freeze = 1;
         }
         if(this.IS_SHAKING)
         {
            if(this.IS_HOR_SHAKE)
            {
               this.sinCounter1 += 0.5;
               this.xShake = Math.abs(Math.sin(this.sinCounter1)) * this.shakePower;
               this.shakePower *= 0.85;
               if(Math.abs(this.shakePower) < 1)
               {
                  this.IS_SHAKING = this.IS_HOR_SHAKE = false;
                  this.shakePower = this.xShake = this.yShake = 0;
               }
            }
            else if(this.shakeCounter1++ > 0)
            {
               this.shakeCounter1 = 0;
               angle = Math.random() * Math.PI * 2;
               this.xShake = Math.sin(angle) * this.shakePower;
               this.yShake = Math.cos(angle) * this.shakePower;
               this.shakePower *= 0.85;
               if(Math.abs(this.shakePower) < 1)
               {
                  this.IS_SHAKING = false;
                  this.shakePower = this.xShake = this.yShake = 0;
               }
            }
         }
      }
      
      public function shake(power:Number = 6, endless:Boolean = false) : void
      {
         this.IS_SHAKING = true;
         this.IS_HOR_SHAKE = false;
         this.shakePower = power;
         if(!endless)
         {
            this.shakeCounter1 = 0;
         }
      }
      
      public function get xPos() : int
      {
         return this.x + this.xShake;
      }
      
      public function get yPos() : int
      {
         return this.y + this.yShake;
      }
      
      public function set xPos(value:int) : void
      {
         this.x = value;
      }
      
      public function set yPos(value:int) : void
      {
         this.y = value;
      }
   }
}
