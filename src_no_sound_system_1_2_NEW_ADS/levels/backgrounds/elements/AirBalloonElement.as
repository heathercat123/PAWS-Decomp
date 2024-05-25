package levels.backgrounds.elements
{
   import interfaces.texts.GameText;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class AirBalloonElement extends BackgroundElement
   {
       
      
      protected var index:int;
      
      protected var spriteContainer:Sprite;
      
      protected var image1:Image;
      
      protected var image2:Image;
      
      protected var image3:Image;
      
      protected var promo_text:GameText;
      
      public function AirBalloonElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, _index:int)
      {
         super(_level,_x,_y,_name,_container);
         this.spriteContainer = new Sprite();
         container.addChild(this.spriteContainer);
         this.promo_text = new GameText(Utils.AIR_MESSAGE,GameText.TYPE_SMALL_DARK);
         this.promo_text.alpha = 0.75;
         this.image1 = new Image(TextureManager.GetBackgroundTexture().getTexture("air_balloon_1"));
         this.image1.touchable = false;
         this.spriteContainer.addChild(this.image1);
         this.image2 = new Image(TextureManager.GetBackgroundTexture().getTexture("air_balloon_2"));
         this.image2.touchable = false;
         this.image2.width = this.promo_text.WIDTH;
         this.spriteContainer.addChild(this.image2);
         this.image2.x = this.image1.width;
         this.image2.y = 6;
         this.image3 = new Image(TextureManager.GetBackgroundTexture().getTexture("air_balloon_3"));
         this.image3.touchable = false;
         this.spriteContainer.addChild(this.image3);
         this.image3.x = this.image2.x + this.image2.width;
         this.image3.y = 6;
         this.spriteContainer.addChild(this.promo_text);
         this.promo_text.x = this.image2.x;
         this.promo_text.y = this.image2.y + 2;
      }
      
      override public function destroy() : void
      {
         this.spriteContainer.removeChild(this.promo_text);
         this.promo_text.destroy();
         this.promo_text.dispose();
         this.promo_text = null;
         this.spriteContainer.removeChild(this.image3);
         this.image3.dispose();
         this.image3 = null;
         this.spriteContainer.removeChild(this.image2);
         this.image2.dispose();
         this.image2 = null;
         this.spriteContainer.removeChild(this.image1);
         this.image1.dispose();
         this.image1 = null;
         container.removeChild(this.spriteContainer);
         this.spriteContainer.dispose();
         this.spriteContainer = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         xPos -= 0.5;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.spriteContainer.x = int(Math.floor(xPos));
         this.spriteContainer.y = int(Math.floor(yPos));
      }
   }
}
