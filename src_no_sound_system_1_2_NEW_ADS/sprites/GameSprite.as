package sprites
{
   import starling.display.Sprite;
   
   public class GameSprite extends Sprite
   {
       
      
      public var frame:int;
      
      public function GameSprite()
      {
         super();
         this.frame = 1;
      }
      
      public function destroy() : void
      {
         this.dispose();
      }
      
      public function gfxHandle() : GameSprite
      {
         return GameSprite(getChildAt(this.frame - 1));
      }
      
      public function gfxHandleClip() : GameMovieClip
      {
         return GameMovieClip(getChildAt(this.frame - 1));
      }
      
      public function updateScreenPosition() : void
      {
         var i:int = 0;
         for(i = 0; i < numChildren; i++)
         {
            getChildAt(i).visible = false;
            if(i == this.frame - 1)
            {
               getChildAt(i).visible = true;
               if(getChildAt(i) is GameSprite)
               {
                  GameSprite(getChildAt(i)).updateScreenPosition();
               }
            }
         }
      }
      
      public function gotoAndStop(_frame:int) : void
      {
         this.frame = _frame;
         if(this.frame > numChildren)
         {
            this.frame = numChildren;
         }
         else if(this.frame < 1)
         {
            this.frame = 1;
         }
      }
   }
}
