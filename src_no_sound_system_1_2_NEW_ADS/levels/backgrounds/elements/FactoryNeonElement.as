package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.FactoryNeonBackgroundSprite;
   import starling.display.Sprite;
   
   public class FactoryNeonElement extends BackgroundElement
   {
       
      
      protected var sprite:GameSprite;
      
      protected var TYPE:int;
      
      protected var counter_1:int;
      
      public function FactoryNeonElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, _type:int = 0)
      {
         super(_level,_x,_y,_name,_container);
         this.TYPE = _type;
         this.sprite = new FactoryNeonBackgroundSprite(this.TYPE);
         this.counter_1 = 0;
         this.sprite.gfxHandleClip().gotoAndStop(1);
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
      
      override public function update() : void
      {
         ++this.counter_1;
         this.sprite.gfxHandleClip().gotoAndStop(1);
         if(this.TYPE == 0)
         {
            if(this.counter_1 < 25)
            {
               this.sprite.gfxHandleClip().gotoAndStop(2);
            }
         }
         else if(this.TYPE == 1)
         {
            if(this.counter_1 >= 25 && this.counter_1 < 50)
            {
               this.sprite.gfxHandleClip().gotoAndStop(2);
            }
         }
         else if(this.counter_1 >= 50)
         {
            this.sprite.gfxHandleClip().gotoAndStop(3);
         }
         if(this.counter_1 > 75)
         {
            this.counter_1 = 0;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.sprite.x = int(Math.floor(xPos));
         this.sprite.y = int(Math.floor(yPos));
         this.sprite.updateScreenPosition();
      }
   }
}
