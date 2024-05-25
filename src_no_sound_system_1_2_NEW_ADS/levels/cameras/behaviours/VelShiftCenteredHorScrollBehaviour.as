package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class VelShiftCenteredHorScrollBehaviour extends CameraBehaviour
   {
       
      
      public var x_focal:Number;
      
      public var MAX_X_FOCAL:Number;
      
      public var x_limit:Number;
      
      public var hero_max_x:Number;
      
      public var old_hero_x:Number;
      
      public var xVel:Number;
      
      public var updateCheckFlag:Boolean;
      
      public var updateFlag:Boolean;
      
      protected var delay:int;
      
      protected var friction:Number;
      
      protected var input_pressed:Boolean;
      
      public function VelShiftCenteredHorScrollBehaviour(_level:Level)
      {
         super(_level);
         this.updateCheckFlag = false;
         this.updateFlag = false;
         this.delay = 0;
         this.friction = 0.1;
         this.input_pressed = false;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.x_focal = 0;
         this.x_limit = 0;
         this.xVel = 0;
         this.MAX_X_FOCAL = camera.getMaxXFocal();
         this.old_hero_x = level.hero.xPos + level.hero.WIDTH * 0.5;
         camera.x = camera.xPos = int(level.hero.getMidXPos() - Utils.WIDTH * 0.5);
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var hero_x_diff:Number = NaN;
         var _state:String = null;
         var current_x:Number = NaN;
         var target_x:Number = NaN;
         var diff_x:Number = NaN;
         var vel:Number = NaN;
         if((camera.level.leftPressed || camera.level.rightPressed) && !this.input_pressed)
         {
            if(camera.level.rightPressed)
            {
               this.x_focal = this.MAX_X_FOCAL;
            }
            else
            {
               this.x_focal = -this.MAX_X_FOCAL;
            }
            this.input_pressed = true;
         }
         if(this.delay++ > 30 && this.input_pressed || this.input_pressed)
         {
            this.delay = 31;
            hero_x_diff = level.hero.xPos + level.hero.WIDTH * 0.5 - this.old_hero_x;
            this.old_hero_x = level.hero.xPos + level.hero.WIDTH * 0.5;
            _state = camera.level.hero.stateMachine.currentState;
            if(_state != "IS_HEAD_POUND_STATE" && _state != "IS_HURT_STATE")
            {
               this.x_focal += hero_x_diff * 0.75;
            }
            if(this.x_focal < -this.MAX_X_FOCAL)
            {
               this.x_focal = -this.MAX_X_FOCAL;
            }
            else if(this.x_focal > this.MAX_X_FOCAL)
            {
               this.x_focal = this.MAX_X_FOCAL;
            }
            current_x = camera.x;
            target_x = level.hero.xPos + level.hero.WIDTH * 0.5 - int(camera.WIDTH * 0.5) + this.x_focal;
            diff_x = target_x - current_x;
            vel = Math.abs(level.hero.xVel);
            if(vel < 1)
            {
               vel = 1;
            }
            if(diff_x > 2 * vel)
            {
               diff_x = 2 * vel;
            }
            else if(diff_x < -2 * vel)
            {
               diff_x = -2 * vel;
            }
            camera.x += diff_x * this.friction;
            this.friction *= 1.1;
            if(this.friction >= 1)
            {
               this.friction = 1;
            }
         }
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
