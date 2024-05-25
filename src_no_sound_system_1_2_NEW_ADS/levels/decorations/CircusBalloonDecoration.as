package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.decorations.CircusBalloonDecorationSprite;
   import starling.display.Image;
   
   public class CircusBalloonDecoration extends Decoration
   {
       
      
      public var has_string:Boolean;
      
      public var type:int;
      
      public var sin_counter:Number;
      
      protected var stringImage:Image;
      
      protected var anchor_y:Number;
      
      public function CircusBalloonDecoration(_level:Level, _xPos:Number, _yPos:Number, _has_string:int = 0, _type:int = 0, _anchor_y:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.has_string = _has_string == 1 ? true : false;
         this.type = _type;
         this.anchor_y = _anchor_y;
         this.sin_counter = Math.random() * Math.PI * 2;
         sprite = new CircusBalloonDecorationSprite();
         sprite.gfxHandleClip().gotoAndStop(this.type + 1);
         Utils.world.addChild(sprite);
         this.stringImage = null;
         if(this.has_string)
         {
            this.stringImage = new Image(TextureManager.sTextureAtlas.getTexture("balloon_string"));
            this.stringImage.touchable = false;
            Utils.world.addChild(this.stringImage);
         }
      }
      
      override public function destroy() : void
      {
         if(this.stringImage != null)
         {
            Utils.world.removeChild(this.stringImage);
            this.stringImage.dispose();
            this.stringImage = null;
         }
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         this.sin_counter += 0.05;
         if(this.sin_counter > Math.PI * 2)
         {
            this.sin_counter -= Math.PI * 2;
         }
         yPos = originalYPos + Math.sin(this.sin_counter) * 1;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.has_string)
         {
            this.stringImage.height = int(this.anchor_y - yPos - 15);
            this.stringImage.x = int(Math.floor(xPos + 6 - camera.xPos));
            this.stringImage.y = int(Math.floor(yPos + 17 - camera.yPos));
         }
      }
   }
}
