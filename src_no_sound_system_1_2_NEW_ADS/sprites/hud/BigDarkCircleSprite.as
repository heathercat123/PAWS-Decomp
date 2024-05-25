package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BigDarkCircleSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      public function BigDarkCircleSprite()
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
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("bigDarkCircleSpriteAnim_"),12);
         this.anim1.setFrameDuration(0,0.1);
         this.anim1.touchable = false;
         this.anim1.x = this.anim1.y = 0;
         this.anim1.loop = false;
         Utils.juggler.add(this.anim1);
      }
   }
}
