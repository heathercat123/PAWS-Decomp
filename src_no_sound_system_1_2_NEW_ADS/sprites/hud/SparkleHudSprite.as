package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SparkleHudSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      protected var anim2:GameMovieClip;
      
      public function SparkleHudSprite()
      {
         super();
         this.initAnim1();
         this.initAnim2();
         addChild(this.anim1);
         addChild(this.anim2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.anim1);
         Utils.juggler.remove(this.anim2);
         this.anim1.dispose();
         this.anim1 = null;
         this.anim2.dispose();
         this.anim2 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("sparkleHudSpriteAnim_"),12);
         this.anim1.setFrameDuration(0,0.2);
         this.anim1.setFrameDuration(1,0.2);
         this.anim1.touchable = false;
         this.anim1.x = this.anim1.y = -6;
         this.anim1.loop = true;
         Utils.juggler.add(this.anim1);
      }
      
      protected function initAnim2() : void
      {
         this.anim2 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("sparkleBigHudSpriteAnim_"),12);
         this.anim2.setFrameDuration(0,0.2);
         this.anim2.setFrameDuration(1,0.2);
         this.anim2.touchable = false;
         this.anim2.x = this.anim2.y = -12;
         this.anim2.loop = true;
         Utils.juggler.add(this.anim2);
      }
   }
}
