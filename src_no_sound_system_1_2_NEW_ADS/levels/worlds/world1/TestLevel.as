package levels.worlds.world1
{
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cameras.behaviours.StaticVerBehaviour;
   
   public class TestLevel extends Level
   {
       
      
      protected var scroll_counter:Number = 0;
      
      protected var delay__:int = 0;
      
      public function TestLevel()
      {
         super();
         super.init();
         camera.changeVerBehaviour(new StaticVerBehaviour(this,176 - int(camera.HEIGHT)));
         camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - int(Utils.WIDTH * 0.5)));
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      override public function getBackgroundId() : int
      {
         return BackgroundsManager.STARRY_NIGHT;
      }
   }
}
