package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   
   public class CarpetDecoration extends Decoration
   {
       
      
      protected var backImage:Image;
      
      protected var image:Image;
      
      protected var type:int;
      
      public function CarpetDecoration(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _type:int, _frame:int)
      {
         super(_level,_xPos,_yPos);
         this.backImage = new Image(TextureManager.sTextureAtlas.getTexture("checkeredSpotBackImage"));
         this.backImage.touchable = false;
         Utils.backWorld.addChild(this.backImage);
         this.backImage.width = _width + 2;
         if(_type == 0)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("carpetDecoration" + _frame));
         }
         else if(_type == 1)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("redCarpetDecorationSpriteAnim_" + _frame));
         }
         else if(_type == 2)
         {
            this.backImage.width -= 2;
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("carpetDecoration" + _frame));
         }
         else if(_type == 3)
         {
            this.backImage.width -= 2;
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("raidersCarpetDecorationSpriteAnim_" + _frame));
         }
         this.type = _type;
         this.image.touchable = false;
         Utils.topWorld.addChild(this.image);
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(this.backImage);
         this.backImage.dispose();
         this.backImage = null;
         Utils.topWorld.removeChild(this.image);
         this.image.dispose();
         this.image = null;
         level = null;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.type == 2 || this.type == 3)
         {
            this.backImage.x = int(Math.floor(xPos - camera.xPos));
         }
         else
         {
            this.backImage.x = int(Math.floor(xPos - 1 - camera.xPos));
         }
         this.backImage.y = int(Math.floor(yPos - 1 - camera.yPos));
         this.image.x = int(Math.floor(xPos - camera.xPos));
         this.image.y = int(Math.floor(yPos - camera.yPos));
      }
   }
}
