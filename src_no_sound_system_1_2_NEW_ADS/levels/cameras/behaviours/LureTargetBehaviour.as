package levels.cameras.behaviours
{
   import entities.Entity;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class LureTargetBehaviour extends CameraBehaviour
   {
       
      
      protected var lure:Entity;
      
      protected var IS_HOR:Boolean;
      
      protected var diff_y:Number;
      
      protected var delay:Number;
      
      public function LureTargetBehaviour(_level:Level, _lure:Entity, _isHor:Boolean = true)
      {
         this.lure = _lure;
         this.delay = 0;
         super(_level);
         this.IS_HOR = _isHor;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         if(this.IS_HOR)
         {
            camera.x = this.lure.xPos - Utils.WIDTH * 0.5;
         }
         else
         {
            this.diff_y = camera.y - this.lure.yPos;
            this.delay = 0;
         }
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         var camera_desired_position:Number = NaN;
         var camera_diff_y:Number = NaN;
         if(this.IS_HOR)
         {
            camera.x = this.lure.xPos - Utils.WIDTH * 0.5;
         }
         else
         {
            camera_desired_position = this.lure.yPos - camera.HEIGHT * 0.5;
            camera_diff_y = camera_desired_position - camera.y;
            this.delay += 0.002;
            if(this.delay >= 1)
            {
               this.delay = 1;
            }
            camera.y += camera_diff_y * this.delay;
         }
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
