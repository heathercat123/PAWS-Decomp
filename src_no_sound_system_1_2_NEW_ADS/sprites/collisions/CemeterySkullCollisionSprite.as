package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CemeterySkullCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var attackAnimation:GameMovieClip;
      
      protected var postAttackAnimation:GameMovieClip;
      
      public function CemeterySkullCollisionSprite()
      {
         super();
         this.initAnims();
         this.initBounceAnims();
         this.initPostAttackAnimation();
         addChild(this.standAnimation);
         addChild(this.attackAnimation);
         addChild(this.postAttackAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.attackAnimation);
         Utils.juggler.remove(this.postAttackAnimation);
         this.standAnimation.dispose();
         this.attackAnimation.dispose();
         this.postAttackAnimation.dispose();
         this.standAnimation = null;
         this.attackAnimation = null;
         this.postAttackAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cemeterySkullCollisionAttackAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = -6;
         this.standAnimation.y = -4;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initBounceAnims() : void
      {
         this.attackAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cemeterySkullCollisionAttackAnim_"),12);
         this.attackAnimation.setFrameDuration(0,0.1);
         this.attackAnimation.setFrameDuration(1,0.1);
         this.attackAnimation.setFrameDuration(2,0.1);
         this.attackAnimation.setFrameDuration(3,0.1);
         this.attackAnimation.touchable = false;
         this.attackAnimation.x = -6;
         this.attackAnimation.y = -4;
         this.attackAnimation.loop = false;
         Utils.juggler.add(this.attackAnimation);
      }
      
      protected function initPostAttackAnimation() : void
      {
         this.postAttackAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cemeterySkullCollisionRestoreAnim_"),12);
         this.postAttackAnimation.setFrameDuration(0,0.1);
         this.postAttackAnimation.setFrameDuration(1,0.1);
         this.postAttackAnimation.setFrameDuration(2,0.1);
         this.postAttackAnimation.touchable = false;
         this.postAttackAnimation.x = -6;
         this.postAttackAnimation.y = -4;
         this.postAttackAnimation.loop = false;
         Utils.juggler.add(this.postAttackAnimation);
      }
   }
}
