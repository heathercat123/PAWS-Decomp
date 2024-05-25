package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CenteredProgressiveVerScrollBehaviour extends CameraBehaviour
   {
       
      
      protected var multiplier:Number;
      
      public var y_shift:Number;
      
      protected var delay:int;
      
      protected var mult_amount:Number;
      
      public function CenteredProgressiveVerScrollBehaviour(_level:Level, _y_shift:Number = 0, _delay:int = 0, _mult:* = 0.005)
      {
         super(_level);
         this.delay = _delay;
         this.y_shift = _y_shift;
         this.mult_amount = _mult;
         this.multiplier = 0;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.multiplier = 0;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var start_y:Number = camera.y;
         var dest_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - int(camera.HEIGHT * 0.5) + this.y_shift;
         var diff_y:Number = (dest_y - start_y) * this.multiplier;
         if(this.delay > 0)
         {
            --this.delay;
            return;
         }
         this.multiplier += this.mult_amount;
         if(this.multiplier > 1)
         {
            this.multiplier = 1;
         }
         camera.y += int(diff_y);
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
