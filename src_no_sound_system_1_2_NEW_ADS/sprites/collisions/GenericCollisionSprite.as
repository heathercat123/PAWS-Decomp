package sprites.collisions
{
   import levels.collisions.GenericCollision;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericCollisionSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function GenericCollisionSprite(_TYPE:int)
      {
         super();
         this.TYPE = _TYPE;
         this.standAnimation2 = null;
         this.initAnims();
         if(this.TYPE == GenericCollision.PUMPKIN)
         {
            this.initAnims2();
         }
         addChild(this.standAnimation);
         if(this.standAnimation2 != null)
         {
            addChild(this.standAnimation2);
         }
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         if(this.standAnimation2 != null)
         {
            Utils.juggler.remove(this.standAnimation2);
            this.standAnimation2.dispose();
            this.standAnimation2 = null;
         }
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spinningSpikesCollisionAnim_"),1);
         }
         else if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spinningSpikesBlockCollisionAnim_"),1);
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spinningSingleSpikesCollisionAnim_"),1);
         }
         else if(this.TYPE == 3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderCollisionSpriteAnim_1"),1);
         }
         else if(this.TYPE == 4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("arcadeCabinetCollisionSpriteAnim_a"),1);
         }
         else if(this.TYPE == 5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("arcadeCabinetCollisionSpriteAnim_b"),1);
         }
         else if(this.TYPE == 6)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("arcadeCabinetCollisionSpriteAnim_c"),1);
         }
         else if(this.TYPE == 7)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("giantFishMouthCollisionSpriteAnim_"),1);
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
         }
         else if(this.TYPE == 8)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("gachaCollisionSpriteAnim_a"),1);
         }
         else if(this.TYPE == 100)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("foreground_lift"),1);
         }
         else if(this.TYPE == 101)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pumpkinCollisionSpriteOffAnim_a"),1);
         }
         this.standAnimation.touchable = false;
         if(this.TYPE == 3)
         {
            this.standAnimation.x = this.standAnimation.y = -24;
         }
         else if(this.TYPE == 7)
         {
            this.standAnimation.x = this.standAnimation.y = -16;
         }
         else
         {
            this.standAnimation.x = this.standAnimation.y = 0;
         }
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims2() : void
      {
         if(this.TYPE == 101)
         {
            this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pumpkinCollisionSpriteOnAnim_"),1);
         }
         this.standAnimation2.setFrameDuration(0,1);
         this.standAnimation2.setFrameDuration(1,1);
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
