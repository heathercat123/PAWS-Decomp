package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.GenericBackgroundSprite;
   import starling.display.Sprite;
   
   public class GenericBackgroundElement extends BackgroundElement
   {
      
      public static var CANYON_GLITTER_1:int = 0;
      
      public static var CANYON_GLITTER_2:int = 1;
      
      public static var CASTLE_TORCH:int = 2;
      
      public static var LIGHTHOUSE:int = 3;
       
      
      public var TYPE:int;
      
      protected var sprite:GameSprite;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      public function GenericBackgroundElement(_level:Level, _type:int, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false, isFlippedVer:Boolean = false)
      {
         super(_level,_x,_y,_name,_container,isFlipped,isFlippedVer);
         this.counter_1 = this.counter_2 = 0;
         this.TYPE = _type;
         this.sprite = new GenericBackgroundSprite(this.TYPE);
         if(this.TYPE == GenericBackgroundElement.CANYON_GLITTER_1 || this.TYPE == GenericBackgroundElement.CANYON_GLITTER_2)
         {
            if(Math.random() * 100 > 80)
            {
               this.sprite.visible = true;
               this.sprite.gfxHandleClip().gotoAndPlay(1);
            }
            else
            {
               this.sprite.visible = false;
               this.counter_1 = (1 + Math.random() * 8) * 60;
            }
         }
         container.addChild(this.sprite);
         if(isFlipped)
         {
            this.sprite.scaleX = -1;
         }
         if(isFlippedVer)
         {
            this.sprite.scaleY = -1;
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
      
      override public function update() : void
      {
         if(this.TYPE == GenericBackgroundElement.CANYON_GLITTER_1 || this.TYPE == GenericBackgroundElement.CANYON_GLITTER_2)
         {
            if(this.sprite.visible)
            {
               if(this.sprite.gfxHandleClip().isComplete)
               {
                  this.sprite.visible = false;
                  this.counter_1 = (1 + Math.random() * 8) * 60;
               }
            }
            else if(this.counter_1-- < 0)
            {
               this.sprite.visible = true;
               this.sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.sprite.x = int(Math.floor(xPos));
         this.sprite.y = int(Math.floor(yPos));
         this.sprite.updateScreenPosition();
      }
   }
}
