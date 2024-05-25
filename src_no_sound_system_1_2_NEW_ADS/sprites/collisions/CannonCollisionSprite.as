package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CannonCollisionSprite extends GameSprite
   {
       
      
      protected var standSxAnimation:GameMovieClip;
      
      protected var standDxAnimation:GameMovieClip;
      
      protected var turnDxAnimation:GameMovieClip;
      
      protected var turnSxAnimation:GameMovieClip;
      
      protected var shootSxAnimation:GameMovieClip;
      
      protected var shootDxAnimation:GameMovieClip;
      
      public function CannonCollisionSprite()
      {
         super();
         this.initAnims();
         this.initTurnAnims();
         this.initShootAnims();
         addChild(this.standSxAnimation);
         addChild(this.standDxAnimation);
         addChild(this.turnDxAnimation);
         addChild(this.turnSxAnimation);
         addChild(this.shootSxAnimation);
         addChild(this.shootDxAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standSxAnimation);
         Utils.juggler.remove(this.standDxAnimation);
         Utils.juggler.remove(this.turnDxAnimation);
         Utils.juggler.remove(this.turnSxAnimation);
         Utils.juggler.remove(this.shootSxAnimation);
         Utils.juggler.remove(this.shootDxAnimation);
         this.standSxAnimation.dispose();
         this.standDxAnimation.dispose();
         this.turnDxAnimation.dispose();
         this.turnSxAnimation.dispose();
         this.shootSxAnimation.dispose();
         this.shootDxAnimation.dispose();
         this.standSxAnimation = null;
         this.standDxAnimation = null;
         this.turnDxAnimation = null;
         this.turnSxAnimation = null;
         this.shootSxAnimation = null;
         this.shootDxAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standSxAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonCollisionStandSxAnim_"),12);
         this.standSxAnimation.touchable = false;
         this.standSxAnimation.x = -16;
         this.standSxAnimation.y = -8;
         this.standSxAnimation.loop = true;
         Utils.juggler.add(this.standSxAnimation);
         this.standDxAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonCollisionStandDxAnim_"),12);
         this.standDxAnimation.touchable = false;
         this.standDxAnimation.x = -16;
         this.standDxAnimation.y = -8;
         this.standDxAnimation.loop = true;
         Utils.juggler.add(this.standDxAnimation);
      }
      
      protected function initTurnAnims() : void
      {
         this.turnDxAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonCollisionTurnDxAnim_"),12);
         this.turnDxAnimation.setFrameDuration(0,0.1);
         this.turnDxAnimation.setFrameDuration(1,0.1);
         this.turnDxAnimation.setFrameDuration(2,0.1);
         this.turnDxAnimation.touchable = false;
         this.turnDxAnimation.x = -16;
         this.turnDxAnimation.y = -8;
         this.turnDxAnimation.loop = false;
         Utils.juggler.add(this.turnDxAnimation);
         this.turnSxAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonCollisionTurnSxAnim_"),12);
         this.turnSxAnimation.setFrameDuration(0,0.1);
         this.turnSxAnimation.setFrameDuration(1,0.1);
         this.turnSxAnimation.setFrameDuration(2,0.1);
         this.turnSxAnimation.touchable = false;
         this.turnSxAnimation.x = -16;
         this.turnSxAnimation.y = -8;
         this.turnSxAnimation.loop = false;
         Utils.juggler.add(this.turnSxAnimation);
      }
      
      protected function initShootAnims() : void
      {
         this.shootSxAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonCollisionShootSxAnim_"),12);
         this.shootSxAnimation.setFrameDuration(0,0.075);
         this.shootSxAnimation.setFrameDuration(1,0.075);
         this.shootSxAnimation.setFrameDuration(2,0.075);
         this.shootSxAnimation.setFrameDuration(3,0.5);
         this.shootSxAnimation.touchable = false;
         this.shootSxAnimation.x = -16;
         this.shootSxAnimation.y = -8;
         this.shootSxAnimation.loop = false;
         Utils.juggler.add(this.shootSxAnimation);
         this.shootDxAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cannonCollisionShootDxAnim_"),12);
         this.shootDxAnimation.setFrameDuration(0,0.075);
         this.shootDxAnimation.setFrameDuration(1,0.075);
         this.shootDxAnimation.setFrameDuration(2,0.075);
         this.shootDxAnimation.setFrameDuration(3,0.5);
         this.shootDxAnimation.touchable = false;
         this.shootDxAnimation.x = -16;
         this.shootDxAnimation.y = -8;
         this.shootDxAnimation.loop = false;
         Utils.juggler.add(this.shootDxAnimation);
      }
   }
}
