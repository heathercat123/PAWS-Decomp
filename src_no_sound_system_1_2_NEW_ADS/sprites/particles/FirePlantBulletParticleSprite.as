package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FirePlantBulletParticleSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function FirePlantBulletParticleSprite(_type:int = 0)
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
         if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantBulletParticleSpriteAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("webBulletParticleSpriteAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("dirtBulletParticleSpriteAnim_"));
         }
         else if(this.TYPE == 4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireBulletParticleSpriteAnim_"));
         }
         else if(this.TYPE == 5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantBulletParticleSpriteAnim_"));
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantBulletParticleSpriteAnim_"));
         }
         if(this.TYPE == 2 || this.TYPE == 3 || this.TYPE == 4)
         {
            this.standAnimation.setFrameDuration(0,0.1);
         }
         else
         {
            this.standAnimation.setFrameDuration(0,0.05);
         }
         this.standAnimation.setFrameDuration(1,0.05);
         this.standAnimation.setFrameDuration(2,0.05);
         if(this.TYPE == 5)
         {
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -6;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
