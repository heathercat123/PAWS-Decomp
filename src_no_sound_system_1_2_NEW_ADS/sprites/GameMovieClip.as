package sprites
{
   import starling.display.MovieClip;
   import starling.textures.Texture;
   
   public class GameMovieClip extends MovieClip
   {
       
      
      public var frame:int;
      
      public function GameMovieClip(textures:Vector.<Texture>, fps:Number = 12)
      {
         super(textures,fps);
         this.frame = 1;
      }
      
      public function gotoAndPlay(_frame:int) : void
      {
         this.frame = _frame;
         if(this.frame < 1)
         {
            this.frame = 1;
         }
         else if(this.frame > numFrames)
         {
            this.frame = numFrames;
         }
         this.currentFrame = this.frame - 1;
         super.play();
      }
      
      public function gotoAndStop(_frame:int) : void
      {
         this.frame = _frame;
         if(this.frame < 1)
         {
            this.frame = 1;
         }
         else if(this.frame > numFrames)
         {
            this.frame = numFrames;
         }
         this.currentFrame = this.frame - 1;
         super.pause();
      }
   }
}
