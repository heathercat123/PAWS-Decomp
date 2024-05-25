package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.DawnDesertStarBackgroundSprite;
   import starling.display.Sprite;
   
   public class DawnDesertStarElement extends BackgroundElement
   {
       
      
      protected var index:int;
      
      protected var sprite:GameSprite;
      
      public function DawnDesertStarElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, _index:int)
      {
         super(_level,_x,_y,_name,_container);
         this.index = _index + 1;
         this.sprite = new DawnDesertStarBackgroundSprite();
         this.sprite.gotoAndStop(this.index);
         if(this.index == 1 || this.index == 3)
         {
            this.sprite.gfxHandleClip().gotoAndPlay(int(Math.random() * 4) + 1);
         }
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
         if(this.sprite.gfxHandleClip().isComplete)
         {
            if(this.index == 2 || this.index == 4)
            {
               this.sprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               this.sprite.gfxHandleClip().gotoAndPlay(1);
            }
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
