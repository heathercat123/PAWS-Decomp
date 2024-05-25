package levels.cameras.behaviours
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CameraBehaviour
   {
       
      
      public var level:Level;
      
      public function CameraBehaviour(_level:Level)
      {
         super();
         this.level = _level;
      }
      
      public function destroy() : void
      {
         this.level = null;
      }
      
      public function enterBehaviour(camera:ScreenCamera) : void
      {
      }
      
      public function updateBehaviour(camera:ScreenCamera) : void
      {
      }
      
      public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
