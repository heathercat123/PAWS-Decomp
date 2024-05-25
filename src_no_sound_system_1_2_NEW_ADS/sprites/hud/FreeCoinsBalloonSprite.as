package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FreeCoinsBalloonSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      public function FreeCoinsBalloonSprite()
      {
         super();
         this.initAnim1();
         addChild(this.anim1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.anim1);
         this.anim1.dispose();
         this.anim1 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("freeCoinsBalloonSpriteAnim_"),12);
         this.anim1.setFrameDuration(0,0.1);
         this.anim1.setFrameDuration(1,0.1);
         this.anim1.setFrameDuration(2,0.1);
         this.anim1.setFrameDuration(3,0.1);
         this.anim1.touchable = false;
         this.anim1.x = 0;
         this.anim1.y = 0;
         this.anim1.loop = true;
         Utils.juggler.add(this.anim1);
      }
   }
}
