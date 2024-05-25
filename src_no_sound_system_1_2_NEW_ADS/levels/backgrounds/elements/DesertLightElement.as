package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.DesertLightBackgroundSprite;
   import starling.display.Sprite;
   
   public class DesertLightElement extends BackgroundElement
   {
       
      
      protected var sprite:GameSprite;
      
      public function DesertLightElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite)
      {
         super(_level,_x,_y,_name,_container);
         this.sprite = new DesertLightBackgroundSprite();
         container.addChild(this.sprite);
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
         this.sprite.updateScreenPosition();
      }
   }
}
