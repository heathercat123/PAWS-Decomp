package levels.cameras
{
   import levels.Level;
   import levels.cameras.behaviours.CameraBehaviour;
   import levels.cameras.behaviours.CenteredVerScrollBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   
   public class GameCamera extends ScreenCamera
   {
       
      
      public var horBehaviour:CameraBehaviour;
      
      public var verBehaviour:CameraBehaviour;
      
      protected var x_lock:Number;
      
      protected var y_lock:Number;
      
      protected var lock_camera:Boolean;
      
      public function GameCamera(_level:Level)
      {
         super(_level);
         this.horBehaviour = null;
         this.verBehaviour = null;
         x = level.hero.getMidXPos() - WIDTH * 0.5;
         this.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
         this.changeVerBehaviour(new CenteredVerScrollBehaviour(level));
      }
      
      override public function destroy() : void
      {
         if(this.horBehaviour)
         {
            this.horBehaviour.destroy();
            this.horBehaviour = null;
         }
         if(this.verBehaviour)
         {
            this.verBehaviour.destroy();
            this.verBehaviour = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.horBehaviour)
         {
            this.horBehaviour.updateBehaviour(this);
         }
         if(this.verBehaviour)
         {
            this.verBehaviour.updateBehaviour(this);
         }
         this.boundariesCheck();
      }
      
      public function boundariesCheck() : void
      {
         var mid_x:int = 0;
         var angle:Number = NaN;
         if(x < LEFT_MARGIN)
         {
            x = LEFT_MARGIN;
         }
         else if(x + WIDTH > RIGHT_MARGIN)
         {
            x = RIGHT_MARGIN - WIDTH;
         }
         if(y < TOP_MARGIN)
         {
            y = TOP_MARGIN;
         }
         else if(y + HEIGHT > BOTTOM_MARGIN)
         {
            y = BOTTOM_MARGIN - HEIGHT;
         }
         if(RIGHT_MARGIN - LEFT_MARGIN < Utils.WIDTH)
         {
            mid_x = LEFT_MARGIN + (RIGHT_MARGIN - LEFT_MARGIN) * 0.5;
            LEFT_MARGIN = mid_x - Utils.WIDTH * 0.5;
            RIGHT_MARGIN = mid_x + Utils.WIDTH * 0.5;
         }
         if(IS_SHAKING)
         {
            if(IS_HOR_SHAKE)
            {
               sinCounter1 += hor_shake_sin_increase;
               xShake = Math.sin(sinCounter1) * shakePower;
               shakePower *= hor_shake_friction;
               if(Math.abs(shakePower) < 1)
               {
                  IS_SHAKING = IS_HOR_SHAKE = false;
                  shakePower = xShake = yShake = 0;
               }
            }
            else if(IS_VER_SHAKE)
            {
               sinCounter1 += ver_shake_sin_increase;
               yShake = Math.sin(sinCounter1) * shakePower;
               shakePower *= ver_shake_friction;
               if(Math.abs(shakePower) < 1)
               {
                  IS_SHAKING = IS_VER_SHAKE = false;
                  shakePower = xShake = yShake = 0;
               }
            }
            else if(shakeCounter1++ > 0)
            {
               shakeCounter1 = 0;
               angle = Math.random() * Math.PI * 2;
               xShake = Math.sin(angle) * shakePower;
               yShake = Math.cos(angle) * shakePower;
               if(quakeTime-- < 0)
               {
                  shakePower *= 0.85;
               }
               if(Math.abs(shakePower) < 1)
               {
                  IS_SHAKING = false;
                  shakePower = xShake = yShake = 0;
               }
            }
         }
         if(this.lock_camera)
         {
            x = this.x_lock;
            y = this.y_lock;
         }
      }
      
      override public function lockCameraDebug(_x:Number = 0, _y:Number = 0) : void
      {
         this.lock_camera = !this.lock_camera;
         this.x_lock = _x;
         this.y_lock = _y;
      }
      
      override public function changeHorBehaviour(_newBehaviour:CameraBehaviour, _destroy:Boolean = true) : void
      {
         if(this.horBehaviour)
         {
            this.horBehaviour.exitBehaviour(this);
            if(_destroy)
            {
               this.horBehaviour.destroy();
               this.horBehaviour = null;
            }
         }
         this.horBehaviour = _newBehaviour;
         this.horBehaviour.enterBehaviour(this);
      }
      
      override public function changeVerBehaviour(_newBehaviour:CameraBehaviour, _destroy:Boolean = true) : void
      {
         if(this.verBehaviour)
         {
            this.verBehaviour.exitBehaviour(this);
            if(_destroy)
            {
               this.verBehaviour.destroy();
               this.verBehaviour = null;
            }
         }
         this.verBehaviour = _newBehaviour;
         this.verBehaviour.enterBehaviour(this);
      }
      
      override public function shake(power:Number = 6, endless:Boolean = false, time:int = 2) : void
      {
         if(IS_SHAKING)
         {
            if(shakePower > power)
            {
               return;
            }
         }
         IS_SHAKING = true;
         IS_HOR_SHAKE = IS_VER_SHAKE = false;
         shakePower = power;
         if(!endless)
         {
            shakeCounter1 = 0;
         }
         quakeTime = time;
      }
      
      override public function horShake(power:Number = 6, _hor_shake_friction:Number = 0.85, _hor_shake_sin_increase:Number = 0.5) : void
      {
         IS_SHAKING = true;
         IS_HOR_SHAKE = true;
         IS_VER_SHAKE = false;
         shakePower = power;
         hor_shake_friction = _hor_shake_friction;
         hor_shake_sin_increase = _hor_shake_sin_increase;
         shakeCounter1 = 0;
         sinCounter1 = 0;
      }
      
      override public function verShake(power:Number = 6, _ver_shake_friction:Number = 0.85, _ver_shake_sin_increase:Number = 0.5) : void
      {
         IS_SHAKING = true;
         IS_VER_SHAKE = true;
         IS_HOR_SHAKE = false;
         shakePower = power;
         ver_shake_friction = _ver_shake_friction;
         ver_shake_sin_increase = _ver_shake_sin_increase;
         shakeCounter1 = 0;
         sinCounter1 = 0;
      }
   }
}
