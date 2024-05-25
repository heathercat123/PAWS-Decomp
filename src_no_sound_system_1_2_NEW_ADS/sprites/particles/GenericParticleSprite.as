package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericParticleSprite extends GameSprite
   {
      
      public static var HONEY_DISSOLVE:int = 0;
      
      public static var DARK_PORTAL_APPEAR:int = 1;
      
      public static var RED_ORB:int = 2;
      
      public static var SAND_BEACH:int = 3;
      
      public static var LOVE:int = 4;
      
      public static var SAND_WIND:int = 5;
      
      public static var WATER_CANNON_IMPACT:int = 6;
      
      public static var BIG_EXPLOSION:int = 7;
       
      
      public var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function GenericParticleSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("honeyDissolveParticleSpriteAnim_"));
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.x = this.standAnimation.y = 0;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkPortalParticleSpriteOpenAnim_"));
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
            this.standAnimation.x = this.standAnimation.y = -12;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redOrbParticleSpriteAnim_"));
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.x = this.standAnimation.y = -5;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == 3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("sandBeachBackgroundSpriteAnim_"),12);
            this.standAnimation.x = this.standAnimation.y = -4;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == GenericParticleSprite.LOVE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("loveParticleSpriteAnim_"),12);
            this.standAnimation.x = this.standAnimation.y = -6;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == 5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("sandWindBeachBackgroundSpriteAnim_"),12);
            this.standAnimation.x = this.standAnimation.y = -4;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == GenericParticleSprite.WATER_CANNON_IMPACT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterCannonImpactParticleSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.075);
            this.standAnimation.setFrameDuration(1,0.075);
            this.standAnimation.x = this.standAnimation.y = -12;
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == GenericParticleSprite.BIG_EXPLOSION)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("explosionBigParticleSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.05);
            this.standAnimation.setFrameDuration(1,0.05);
            this.standAnimation.setFrameDuration(2,0.05);
            this.standAnimation.setFrameDuration(3,0.05);
            this.standAnimation.x = this.standAnimation.y = -20;
            this.standAnimation.loop = false;
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
