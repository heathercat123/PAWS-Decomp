package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.background.WaterfallBackgroundSprite;
   import starling.display.Sprite;
   
   public class WaterfallBackgroundElement extends BackgroundElement
   {
       
      
      protected var sprite:WaterfallBackgroundSprite;
      
      protected var TYPE:int;
      
      protected var offset_y:int;
      
      public function WaterfallBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false, isFlippedVer:Boolean = false, _type:int = 0)
      {
         this.TYPE = _type;
         super(_level,_x,_y,_name,_container,isFlipped,isFlippedVer);
         this.sprite = new WaterfallBackgroundSprite(this.TYPE);
         if(isFlipped)
         {
            this.sprite.scaleX = -1;
         }
         if(isFlippedVer)
         {
            this.sprite.scaleY = -1;
         }
         container.addChild(this.sprite);
      }
      
      override public function update() : void
      {
         if(this.TYPE == 1)
         {
            this.offset_y += 1;
            if(this.offset_y >= 32)
            {
               this.offset_y = 0;
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
         this.sprite.y = int(Math.floor(yPos + this.offset_y));
      }
   }
}
