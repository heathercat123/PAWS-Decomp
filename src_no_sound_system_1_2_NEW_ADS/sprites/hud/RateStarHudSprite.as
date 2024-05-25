package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class RateStarHudSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      public function RateStarHudSprite()
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
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("starRateHudSpriteAnim_"),12);
         this.anim1.pivotX = 16;
         this.anim1.pivotY = 16;
         this.anim1.loop = false;
         Utils.juggler.add(this.anim1);
      }
   }
}
