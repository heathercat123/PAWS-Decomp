package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class StaticHorBehaviour extends CameraBehaviour
   {
       
      
      public var x_locked_at:Number;
      
      public function StaticHorBehaviour(_level:Level, _xPos:Number)
      {
         super(_level);
         this.x_locked_at = _xPos;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         camera.x = this.x_locked_at;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         camera.x = this.x_locked_at;
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
