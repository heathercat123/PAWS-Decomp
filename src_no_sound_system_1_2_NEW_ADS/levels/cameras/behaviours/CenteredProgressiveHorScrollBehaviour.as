package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CenteredProgressiveHorScrollBehaviour extends CameraBehaviour
   {
       
      
      protected var multiplier:Number;
      
      protected var x_shift:Number;
      
      public function CenteredProgressiveHorScrollBehaviour(_level:Level, _x_shift:Number = 0)
      {
         super(_level);
         this.x_shift = _x_shift;
         this.multiplier = 0;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.multiplier = 0;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var dest_x:Number = NaN;
         var start_x:Number = camera.xPos;
         dest_x = level.hero.xPos + level.hero.WIDTH * 0.5 - int(camera.WIDTH * 0.5) + this.x_shift;
         var diff_x:Number = (dest_x - start_x) * this.multiplier;
         this.multiplier += 0.005;
         if(this.multiplier > 1)
         {
            this.multiplier = 1;
         }
         camera.x += int(diff_x);
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
