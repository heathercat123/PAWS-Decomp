package levels.backgrounds.elements
{
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MoonBackgroundElement extends BackgroundElement
   {
       
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var sin_counter1:Number;
      
      public function MoonBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level,_x,_y,_name,_container,isFlipped);
         this.counter1 = this.counter2 = 0;
         this.sin_counter1 = 0;
      }
      
      override public function update() : void
      {
         super.update();
         this.sin_counter1 += 0.025;
         if(this.sin_counter1 > Math.PI * 2)
         {
            this.sin_counter1 -= Math.PI * 2;
         }
         xPos = level.camera.WIDTH * 0.5 - 45;
         yPos = -45;
         if(level.getBackgroundId() == BackgroundsManager.GRAVEYARD)
         {
            yPos = 32;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
   }
}
