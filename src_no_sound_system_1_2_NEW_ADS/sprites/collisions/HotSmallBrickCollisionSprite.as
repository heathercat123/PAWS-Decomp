package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class HotSmallBrickCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var turnOnAnimation:GameMovieClip;
      
      protected var glowAnimation:GameMovieClip;
      
      protected var turnOffAnimation:GameMovieClip;
      
      protected var meltAnimation:GameMovieClip;
      
      public function HotSmallBrickCollisionSprite()
      {
         super();
         this.initAnims();
         this.initTurnOnAnims();
         this.initGlowAnims();
         this.initTurnOffAnims();
         this.initMeltAnims();
         addChild(this.standAnimation);
         addChild(this.turnOnAnimation);
         addChild(this.glowAnimation);
         addChild(this.turnOffAnimation);
         addChild(this.meltAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.turnOnAnimation);
         Utils.juggler.remove(this.glowAnimation);
         Utils.juggler.remove(this.turnOffAnimation);
         Utils.juggler.remove(this.meltAnimation);
         this.standAnimation.dispose();
         this.turnOnAnimation.dispose();
         this.glowAnimation.dispose();
         this.turnOffAnimation.dispose();
         this.meltAnimation.dispose();
         this.standAnimation = null;
         this.turnOnAnimation = null;
         this.glowAnimation = null;
         this.turnOffAnimation = null;
         this.meltAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hotSmallBrickNormalAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initTurnOnAnims() : void
      {
         this.turnOnAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hotSmallBrickTurnOnAnim_"),12);
         this.turnOnAnimation.setFrameDuration(0,0.05);
         this.turnOnAnimation.setFrameDuration(1,0.05);
         this.turnOnAnimation.setFrameDuration(2,0.05);
         this.turnOnAnimation.touchable = false;
         this.turnOnAnimation.x = this.turnOnAnimation.y = 0;
         this.turnOnAnimation.loop = false;
         Utils.juggler.add(this.turnOnAnimation);
      }
      
      protected function initGlowAnims() : void
      {
         this.glowAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hotSmallBrickGlowingAnim_"),12);
         this.glowAnimation.setFrameDuration(0,0.05);
         this.glowAnimation.setFrameDuration(1,0.05);
         this.glowAnimation.setFrameDuration(2,0.05);
         this.glowAnimation.setFrameDuration(3,0.05);
         this.glowAnimation.touchable = false;
         this.glowAnimation.x = this.glowAnimation.y = 0;
         this.glowAnimation.loop = true;
         Utils.juggler.add(this.glowAnimation);
      }
      
      protected function initTurnOffAnims() : void
      {
         this.turnOffAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hotSmallBrickTurnOffAnim_"),12);
         this.turnOffAnimation.setFrameDuration(0,0.05);
         this.turnOffAnimation.setFrameDuration(1,0.05);
         this.turnOffAnimation.touchable = false;
         this.turnOffAnimation.x = this.turnOffAnimation.y = 0;
         this.turnOffAnimation.loop = false;
         Utils.juggler.add(this.turnOffAnimation);
      }
      
      protected function initMeltAnims() : void
      {
         this.meltAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hotSmallBrickMeltAnim_"),12);
         this.meltAnimation.setFrameDuration(0,0.1);
         this.meltAnimation.setFrameDuration(1,0.1);
         this.meltAnimation.setFrameDuration(2,0.1);
         this.meltAnimation.setFrameDuration(3,0.1);
         this.meltAnimation.touchable = false;
         this.meltAnimation.x = this.meltAnimation.y = 0;
         this.meltAnimation.loop = false;
         Utils.juggler.add(this.meltAnimation);
      }
   }
}
