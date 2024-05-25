package levels.cameras.behaviours
{
   import entities.Entity;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class VelShiftHorScrollBehaviour extends CameraBehaviour
   {
       
      
      public var x_focal:Number;
      
      public var MAX_X_FOCAL:Number;
      
      public var x_limit:Number;
      
      public var hero_max_x:Number;
      
      public var old_hero_x:Number;
      
      public var xVel:Number;
      
      public var updateCheckFlag:Boolean;
      
      public var updateFlag:Boolean;
      
      public function VelShiftHorScrollBehaviour(_level:Level)
      {
         super(_level);
         this.updateCheckFlag = false;
         this.updateFlag = false;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.x_focal = 0;
         this.x_limit = 0;
         this.xVel = 0;
         this.MAX_X_FOCAL = camera.getMaxXFocal();
         this.old_hero_x = level.hero.xPos + level.hero.WIDTH * 0.5;
         if(level.hero.DIRECTION == Entity.RIGHT)
         {
            this.x_focal = this.MAX_X_FOCAL;
         }
         else
         {
            this.x_focal = -this.MAX_X_FOCAL;
         }
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var hero_x_diff:Number = NaN;
         hero_x_diff = level.hero.xPos + level.hero.WIDTH * 0.5 - this.old_hero_x;
         this.old_hero_x = level.hero.xPos + level.hero.WIDTH * 0.5;
         var _state:String = camera.level.hero.stateMachine.currentState;
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
         var current_x:Number = camera.x;
         var target_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5 - int(camera.WIDTH * 0.5) + this.x_focal;
         var diff_x:Number = target_x - current_x;
         var vel:Number = Math.abs(level.hero.xVel);
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
         camera.x += diff_x;
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
