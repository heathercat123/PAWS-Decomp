package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CannonHeroBaseCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      protected var standAnimation3:GameMovieClip;
      
      public function CannonHeroBaseCollisionSprite()
      {
         super();
         this.initAnims();
         this.initAnims2();
         this.initAnims3();
         addChild(this.standAnimation);
         addChild(this.standAnimation2);
         addChild(this.standAnimation3);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.standAnimation2);
         Utils.juggler.remove(this.standAnimation3);
         this.standAnimation.dispose();
         this.standAnimation2.dispose();
         this.standAnimation3.dispose();
         this.standAnimation = null;
         this.standAnimation2 = null;
         this.standAnimation3 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonHeroBaseCollisionStandAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -20;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonHeroBaseCollisionBiggerAnim_"),12);
         this.standAnimation2.setFrameDuration(0,0.1);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = -20;
         this.standAnimation2.loop = false;
         Utils.juggler.add(this.standAnimation2);
      }
      
      protected function initAnims3() : void
      {
         this.standAnimation3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonHeroBaseCollisionShootAnim_"),12);
         this.standAnimation3.setFrameDuration(0,0.1);
         this.standAnimation3.touchable = false;
         this.standAnimation3.x = this.standAnimation3.y = -20;
         this.standAnimation3.loop = false;
         Utils.juggler.add(this.standAnimation3);
      }
   }
}
