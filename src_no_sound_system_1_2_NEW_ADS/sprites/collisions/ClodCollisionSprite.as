package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ClodCollisionSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var seedAnimation:GameMovieClip;
      
      protected var growAnimation:GameMovieClip;
      
      protected var plantGrowAnimation:GameMovieClip;
      
      public function ClodCollisionSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.initAnims();
         this.initBounceAnims();
         this.initGrowAnims();
         this.initPlantGrowAnims();
         addChild(this.standAnimation);
         addChild(this.seedAnimation);
         addChild(this.growAnimation);
         addChild(this.plantGrowAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.seedAnimation);
         Utils.juggler.remove(this.growAnimation);
         Utils.juggler.remove(this.plantGrowAnimation);
         this.standAnimation.dispose();
         this.seedAnimation.dispose();
         this.growAnimation.dispose();
         this.plantGrowAnimation.dispose();
         this.standAnimation = null;
         this.seedAnimation = null;
         this.growAnimation = null;
         this.plantGrowAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("clodCollisionStandAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = -4;
         this.standAnimation.y = -16;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initBounceAnims() : void
      {
         if(this.TYPE == 1)
         {
            this.seedAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("clodCollisionSeedBAnim_"),12);
         }
         else
         {
            this.seedAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("clodCollisionSeedAnim_"),12);
         }
         this.seedAnimation.setFrameDuration(0,0.1);
         this.seedAnimation.setFrameDuration(1,1);
         this.seedAnimation.setFrameDuration(2,0.1);
         this.seedAnimation.setFrameDuration(3,0.1);
         this.seedAnimation.touchable = false;
         this.seedAnimation.x = -4;
         this.seedAnimation.y = -16;
         this.seedAnimation.loop = false;
         Utils.juggler.add(this.seedAnimation);
      }
      
      protected function initGrowAnims() : void
      {
         this.growAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("clodCollisionGrowAnim_"),12);
         this.growAnimation.setFrameDuration(0,0.1);
         this.growAnimation.setFrameDuration(1,0.1);
         this.growAnimation.touchable = false;
         this.growAnimation.x = -4;
         this.growAnimation.y = -16;
         this.growAnimation.loop = true;
         Utils.juggler.add(this.growAnimation);
      }
      
      protected function initPlantGrowAnims() : void
      {
         this.plantGrowAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("clodPlantCollisionSpriteAnim_"),12);
         this.plantGrowAnimation.touchable = false;
         this.plantGrowAnimation.loop = false;
         Utils.juggler.add(this.plantGrowAnimation);
      }
   }
}
