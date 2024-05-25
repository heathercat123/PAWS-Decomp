package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class TunnelVelShiftVerScrollBehaviour extends CameraBehaviour
   {
       
      
      public var y_focal:Number;
      
      public var MAX_Y_FOCAL:Number;
      
      public var y_limit:Number;
      
      public var hero_max_y:Number;
      
      public var old_hero_y:Number;
      
      public var yVel:Number;
      
      public var top_y:Number;
      
      protected var IS_GOING_DOWN:Boolean;
      
      protected var fall_counter:int;
      
      public function TunnelVelShiftVerScrollBehaviour(_level:Level)
      {
         super(_level);
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.y_focal = 0;
         this.y_limit = 0;
         this.yVel = 0;
         this.fall_counter = 0;
         this.MAX_Y_FOCAL = Math.round(camera.HEIGHT * 0.15 / Utils.TILE_HEIGHT) * Utils.TILE_HEIGHT;
         this.old_hero_y = level.hero.yPos + level.hero.HEIGHT * 0.5;
         this.top_y = camera.y;
         this.IS_GOING_DOWN = false;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var hero_y_diff:Number = NaN;
         var new_hero_y:Number = NaN;
         new_hero_y = level.hero.yPos + level.hero.HEIGHT * 0.5;
         hero_y_diff = new_hero_y - this.old_hero_y;
         this.old_hero_y = new_hero_y;
         if(level.hero.yPos + level.hero.HEIGHT * 0.5 > camera.y + camera.HEIGHT - Utils.TILE_WIDTH * 2)
         {
            this.IS_GOING_DOWN = true;
         }
         if(hero_y_diff < 0)
         {
            this.IS_GOING_DOWN = false;
         }
         if(hero_y_diff < 0 || this.IS_GOING_DOWN)
         {
            if(this.isStateAllowed())
            {
               this.y_focal += hero_y_diff * 0.75;
            }
         }
         if(this.y_focal < -this.MAX_Y_FOCAL)
         {
            this.y_focal = -this.MAX_Y_FOCAL;
         }
         else if(this.y_focal > this.MAX_Y_FOCAL)
         {
            this.y_focal = this.MAX_Y_FOCAL;
         }
         var current_y:Number = camera.y;
         var target_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - int(camera.HEIGHT * 0.5) + this.y_focal;
         var vel_mult:Number = Math.abs(level.hero.yVel);
         if(level.hero.stateMachine.currentState == "IS_ROPE_CLIMBING_STATE")
         {
            vel_mult = 1;
         }
         var diff_y:Number = target_y - current_y;
         if(diff_y > 2 * vel_mult)
         {
            diff_y = 2 * vel_mult;
         }
         else if(diff_y < -2 * vel_mult)
         {
            diff_y = -2 * vel_mult;
         }
         if(this.isStateAllowed())
         {
            camera.y += diff_y;
         }
         if(!this.IS_GOING_DOWN)
         {
            if(camera.y > this.top_y)
            {
               camera.y = this.top_y;
            }
            else if(camera.y <= this.top_y)
            {
               this.top_y = camera.y;
            }
         }
         else
         {
            this.top_y = camera.y;
         }
         if(level.hero.stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || level.hero.stateMachine.currentState == "IS_ROPE_SLIDING_STATE")
         {
            ++this.fall_counter;
         }
         else
         {
            this.fall_counter = 0;
         }
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
      
      protected function isStateAllowed() : Boolean
      {
         var _state:String = level.hero.stateMachine.currentState;
         if(_state == "IS_JUMPING_STATE")
         {
            return false;
         }
         if(_state == "IS_FALLING_RUNNING_STATE" && this.fall_counter < 20)
         {
            return false;
         }
         return true;
      }
   }
}
