package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.decorations.GenericDecorationSprite;
   import starling.display.Image;
   
   public class CageDecoration extends Decoration
   {
       
      
      protected var image:Image;
      
      protected var backImage:Image;
      
      public function CageDecoration(_level:Level, _xPos:Number, _yPos:Number, _has_bar:int, _flipped:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new GenericDecorationSprite(GenericDecoration.CAGE);
         Utils.topWorld.addChild(sprite);
         if(_flipped > 0)
         {
            sprite.scaleX = -1;
         }
         this.image = new Image(TextureManager.sTextureAtlas.getTexture("cageDecorationBar"));
         this.image.touchable = false;
         Utils.topWorld.addChild(this.image);
         if(_has_bar < 1)
         {
            this.setWithBar(false);
         }
         this.backImage = new Image(TextureManager.sTextureAtlas.getTexture("cageDecorationBackBar"));
         this.backImage.touchable = false;
         Utils.backWorld.addChild(this.backImage);
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         Utils.backWorld.removeChild(this.backImage);
         this.backImage.dispose();
         this.backImage = null;
         Utils.topWorld.removeChild(this.image);
         this.image.dispose();
         this.image = null;
         super.destroy();
      }
      
      public function setWithBar(value:Boolean) : void
      {
         this.image.visible = value;
      }
      
      public function isWithBar() : Boolean
      {
         return this.image.visible;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(sprite.scaleX < 0)
         {
            this.image.x = sprite.x - 18;
         }
         else
         {
            this.image.x = sprite.x + 12;
         }
         this.image.y = sprite.y;
         this.backImage.x = this.image.x;
         this.backImage.y = this.image.y;
      }
   }
}
