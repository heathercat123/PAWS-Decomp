package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MinecartDecorationSprite extends GameSprite
   {
       
      
      protected var index:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var glowAnim1:GameMovieClip;
      
      protected var glowAnim2:GameMovieClip;
      
      protected var glowAnim3:GameMovieClip;
      
      public function MinecartDecorationSprite(_index:int = 0)
      {
         super();
         this.index = _index;
         this.initAnims();
         this.initGlowAnim1();
         this.initGlowAnim2();
         this.initGlowAnim3();
         addChild(this.standAnimation);
         addChild(this.glowAnim1);
         addChild(this.glowAnim2);
         addChild(this.glowAnim3);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.glowAnim1);
         Utils.juggler.remove(this.glowAnim2);
         Utils.juggler.remove(this.glowAnim3);
         this.standAnimation.dispose();
         this.glowAnim1.dispose();
         this.glowAnim2.dispose();
         this.glowAnim3.dispose();
         this.standAnimation = this.glowAnim1 = this.glowAnim2 = this.glowAnim3 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.index == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartDecorationSpriteStandAnim_a"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartBlueDecorationSpriteStandAnim_a"),12);
         }
         this.standAnimation.setFrameDuration(0,0.2);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initGlowAnim1() : void
      {
         if(this.index == 0)
         {
            this.glowAnim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartDecorationSpriteGlow1Anim_"),12);
         }
         else
         {
            this.glowAnim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartBlueDecorationSpriteGlow1Anim_"),12);
         }
         this.glowAnim1.setFrameDuration(0,0.1);
         this.glowAnim1.setFrameDuration(0,0.1);
         this.glowAnim1.setFrameDuration(0,0.1);
         this.glowAnim1.touchable = false;
         this.glowAnim1.x = this.glowAnim1.y = 0;
         this.glowAnim1.loop = false;
         Utils.juggler.add(this.glowAnim1);
      }
      
      protected function initGlowAnim2() : void
      {
         if(this.index == 0)
         {
            this.glowAnim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartDecorationSpriteGlow2Anim_"),12);
         }
         else
         {
            this.glowAnim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartBlueDecorationSpriteGlow2Anim_"),12);
         }
         this.glowAnim2.setFrameDuration(0,0.1);
         this.glowAnim2.setFrameDuration(0,0.1);
         this.glowAnim2.setFrameDuration(0,0.1);
         this.glowAnim2.touchable = false;
         this.glowAnim2.x = this.glowAnim2.y = 0;
         this.glowAnim2.loop = false;
         Utils.juggler.add(this.glowAnim2);
      }
      
      protected function initGlowAnim3() : void
      {
         if(this.index == 0)
         {
            this.glowAnim3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartDecorationSpriteGlow3Anim_"),12);
         }
         else
         {
            this.glowAnim3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("minecartBlueDecorationSpriteGlow3Anim_"),12);
         }
         this.glowAnim3.setFrameDuration(0,0.1);
         this.glowAnim3.setFrameDuration(0,0.1);
         this.glowAnim3.setFrameDuration(0,0.1);
         this.glowAnim3.touchable = false;
         this.glowAnim3.x = this.glowAnim3.y = 0;
         this.glowAnim3.loop = false;
         Utils.juggler.add(this.glowAnim3);
      }
   }
}
