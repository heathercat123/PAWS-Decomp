package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class StaticVerBehaviour extends CameraBehaviour
   {
       
      
      public var yLockCoordinate:Number;
      
      public function StaticVerBehaviour(_level:Level, _yLockCoordinate:Number)
      {
         super(_level);
         this.yLockCoordinate = _yLockCoordinate;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         camera.y = this.yLockCoordinate;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         camera.y = this.yLockCoordinate;
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
