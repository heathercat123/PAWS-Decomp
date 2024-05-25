package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SandfallWaveCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      public function SandfallWaveCollisionSprite()
      {
         super();
         this.initAnims1();
         addChild(this.standAnimation1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         this.standAnimation1.dispose();
         this.standAnimation1 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         var i:int = 0;
         this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandfallLargeWaveCollisionSpriteAnim_"),12);
         for(i = 0; i < this.standAnimation1.numFrames; i++)
         {
            this.standAnimation1.setFrameDuration(i,0.2);
         }
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
