package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CenteredVerScrollBehaviour extends CameraBehaviour
   {
       
      
      protected var y_shift:Number;
      
      protected var delay:int;
      
      public function CenteredVerScrollBehaviour(_level:Level, _y_shift:Number = 0, _delay:int = 0)
      {
         super(_level);
         this.delay = _delay;
         this.y_shift = _y_shift;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var current_y:Number = camera.y;
         var target_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - camera.HALF_HEIGHT + this.y_shift;
         var diff_y:Number = target_y - current_y;
         if(diff_y > 3)
         {
            diff_y = 3;
         }
         else if(diff_y < -3)
         {
            diff_y = -3;
         }
         if(this.delay-- <= 0)
         {
            camera.y += diff_y;
         }
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
