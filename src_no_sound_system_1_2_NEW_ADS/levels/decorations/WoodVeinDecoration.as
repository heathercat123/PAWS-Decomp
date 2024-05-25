package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   
   public class WoodVeinDecoration extends Decoration
   {
       
      
      protected var image:Image;
      
      protected var IS_BACK:Boolean;
      
      public function WoodVeinDecoration(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _frame:int, _flipped:int, _flipped_ver:int)
      {
         super(_level,_xPos,_yPos);
         this.IS_BACK = false;
         if(_frame == 0)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_a"));
         }
         else if(_frame == 1)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_b"));
         }
         else if(_frame == 2)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinNightDecorationSpriteAnim_a"));
         }
         else if(_frame == 3)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinNightDecorationSpriteAnim_b"));
         }
         else if(_frame == 4)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_c"));
         }
         else if(_frame == 5)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_d"));
         }
         else if(_frame == 6)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_e"));
         }
         else if(_frame == 7)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_f"));
         }
         else if(_frame == 8)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_g"));
         }
         else if(_frame == 9)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_h"));
         }
         else if(_frame == 10)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_i"));
            this.IS_BACK = true;
         }
         else if(_frame == 11)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_j"));
            this.IS_BACK = true;
         }
         else if(_frame == 12)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_k"));
         }
         else if(_frame == 13)
         {
            this.image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_l"));
         }
         this.image.touchable = false;
         this.image.scaleX = _flipped > 0 ? -1 : 1;
         this.image.width = _width * this.image.scaleX;
         this.image.scaleY = _flipped_ver > 0 ? -1 : 1;
         this.image.height = _height * this.image.scaleY;
         if(this.IS_BACK)
         {
            Utils.backWorld.addChild(this.image);
         }
         else
         {
            Utils.topWorld.addChild(this.image);
         }
      }
      
      override public function destroy() : void
      {
         if(this.IS_BACK)
         {
            Utils.backWorld.removeChild(this.image);
         }
         else
         {
            Utils.topWorld.removeChild(this.image);
         }
         this.image.dispose();
         this.image = null;
         level = null;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.image.x = int(Math.floor(xPos - camera.xPos));
         this.image.y = int(Math.floor(yPos - camera.yPos));
      }
   }
}
