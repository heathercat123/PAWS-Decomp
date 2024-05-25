package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.NightLampBackgroundSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class NightLampBackgroundElement extends BackgroundElement
   {
       
      
      protected var sprite:GameSprite;
      
      protected var counter_1:int;
      
      public function NightLampBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite)
      {
         super(_level,_x,_y,_name,_container);
         this.counter_1 = 0;
         this.sprite = new NightLampBackgroundSprite();
         image = new Image(TextureManager.GetBackgroundTexture().getTexture("mountainNightBackgroundLight"));
         image.touchable = false;
         image.alpha = 0.2;
         container.addChild(image);
         container.addChild(this.sprite);
      }
      
      override public function update() : void
      {
         super.update();
         ++this.counter_1;
         if(this.counter_1 >= 10)
         {
            this.counter_1 = 0;
            if(image.alpha == 0.2)
            {
               image.alpha = 0.17;
            }
            else
            {
               image.alpha = 0.2;
            }
         }
      }
      
      override public function destroy() : void
      {
         container.removeChild(this.sprite);
         this.sprite.destroy();
         this.sprite.dispose();
         this.sprite = null;
         super.destroy();
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.sprite.x = int(Math.floor(xPos));
         this.sprite.y = int(Math.floor(yPos));
         image.x = this.sprite.x - 28;
         image.y = this.sprite.y - 20;
         this.sprite.updateScreenPosition();
      }
   }
}
