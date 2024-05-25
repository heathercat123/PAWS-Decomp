package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class PoleLightBackgroundElement extends BackgroundElement
   {
       
      
      protected var lampImage:Image;
      
      protected var counter_1:int;
      
      protected var is_flipped:Boolean;
      
      public function PoleLightBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, _flipped:Boolean = false)
      {
         super(_level,_x,_y,_name,_container);
         this.counter_1 = 0;
         this.is_flipped = _flipped;
         this.lampImage = new Image(TextureManager.GetBackgroundTexture().getTexture("light_pole"));
         this.lampImage.touchable = false;
         if(_flipped)
         {
            this.lampImage.scaleX = -1;
         }
         image = new Image(TextureManager.GetBackgroundTexture().getTexture("light_pole_light"));
         if(_flipped)
         {
            image.scaleX = -1;
         }
         image.touchable = false;
         container.addChild(this.lampImage);
         container.addChild(image);
      }
      
      override public function update() : void
      {
         super.update();
         ++this.counter_1;
         if(this.counter_1 >= 6)
         {
            this.counter_1 = 0;
            if(image.alpha >= 0.95)
            {
               image.alpha = 0.85;
            }
            else
            {
               image.alpha = 1;
            }
         }
      }
      
      override public function destroy() : void
      {
         container.removeChild(this.lampImage);
         this.lampImage.dispose();
         this.lampImage = null;
         super.destroy();
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.lampImage.x = int(Math.floor(xPos));
         this.lampImage.y = int(Math.floor(yPos));
         if(!this.is_flipped)
         {
            image.x = this.lampImage.x - 48;
            image.y = this.lampImage.y + 6;
         }
         else
         {
            image.x = this.lampImage.x + 48;
            image.y = this.lampImage.y + 6;
         }
      }
   }
}
