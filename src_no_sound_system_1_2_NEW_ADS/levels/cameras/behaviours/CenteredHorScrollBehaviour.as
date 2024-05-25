package levels.cameras.behaviours
{
   import entities.Entity;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CenteredHorScrollBehaviour extends CameraBehaviour
   {
       
      
      protected var x_shift:Number;
      
      protected var entity:Entity;
      
      public function CenteredHorScrollBehaviour(_level:Level, _entity:Entity = null, _x_shift:Number = 0)
      {
         super(_level);
         this.x_shift = _x_shift;
         this.entity = _entity;
      }
      
      override public function destroy() : void
      {
         this.entity = null;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         if(this.entity != null)
         {
            camera.x = this.entity.getMidXPos() - int(camera.WIDTH * 0.5) + this.x_shift;
         }
         else
         {
            camera.x = level.hero.xPos + level.hero.WIDTH * 0.5 - int(camera.WIDTH * 0.5);
         }
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
