package levels.backgrounds
{
   import starling.display.Sprite;
   
   public class MenuBackgroundPortable extends Sprite
   {
       
      
      protected var backgroundContainer:Sprite;
      
      protected var sin_counter:Number;
      
      public function MenuBackgroundPortable()
      {
         super();
         this.backgroundContainer = new Sprite();
         this.backgroundContainer.x = this.backgroundContainer.y = 0;
         this.backgroundContainer.scaleX = this.backgroundContainer.scaleY = Utils.GFX_SCALE;
         addChild(this.backgroundContainer);
         this.sin_counter = 0;
      }
      
      public function destroy() : void
      {
         removeChild(this.backgroundContainer);
         this.backgroundContainer.dispose();
         this.backgroundContainer = null;
      }
      
      public function update() : void
      {
         this.sin_counter += 0.01;
         if(this.sin_counter > Math.PI * 2)
         {
            this.sin_counter -= Math.PI * 2;
         }
      }
   }
}
