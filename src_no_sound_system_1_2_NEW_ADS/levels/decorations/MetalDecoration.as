package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   
   public class MetalDecoration extends Decoration
   {
       
      
      protected var image:Image;
      
      public function MetalDecoration(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _frame:int, _flipped:int, _flipped_ver:int)
      {
         super(_level,_xPos,_yPos);
         this.image = new Image(TextureManager.sTextureAtlas.getTexture("metal_decoration_" + _frame));
         this.image.touchable = false;
         this.image.scaleX = _flipped > 0 ? -1 : 1;
         this.image.scaleY = _flipped_ver > 0 ? -1 : 1;
         Utils.topWorld.addChild(this.image);
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(this.image);
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
