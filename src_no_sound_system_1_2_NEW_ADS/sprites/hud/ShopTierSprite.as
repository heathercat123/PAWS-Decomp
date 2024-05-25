package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   import starling.core.Starling;
   
   public class ShopTierSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      protected var anim2:GameMovieClip;
      
      protected var anim3:GameMovieClip;
      
      public function ShopTierSprite()
      {
         super();
         this.initAnim1();
         this.initAnim2();
         this.initAnim3();
         addChild(this.anim1);
         addChild(this.anim2);
         addChild(this.anim3);
      }
      
      override public function destroy() : void
      {
         Starling.juggler.remove(this.anim1);
         Starling.juggler.remove(this.anim2);
         Starling.juggler.remove(this.anim3);
         this.anim1.dispose();
         this.anim2.dispose();
         this.anim3.dispose();
         this.anim1 = null;
         this.anim2 = null;
         this.anim3 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("moreCoinsTierShop1Anim_"),12);
         this.anim1.touchable = false;
         this.anim1.x = -32;
         this.anim1.y = -24;
         this.anim1.loop = false;
         Starling.juggler.add(this.anim1);
      }
      
      protected function initAnim2() : void
      {
         this.anim2 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("moreCoinsTierShop2Anim_"),12);
         this.anim2.touchable = false;
         this.anim2.x = -32;
         this.anim2.y = -24;
         this.anim2.loop = false;
         Starling.juggler.add(this.anim2);
      }
      
      protected function initAnim3() : void
      {
         this.anim3 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("moreCoinsTierShop3Anim_"),12);
         this.anim3.setFrameDuration(0,0.2);
         this.anim3.setFrameDuration(1,0.2);
         this.anim3.setFrameDuration(2,0.2);
         this.anim3.setFrameDuration(3,0.2);
         this.anim3.touchable = false;
         this.anim3.x = -32;
         this.anim3.y = -24;
         this.anim3.loop = true;
         Starling.juggler.add(this.anim3);
      }
   }
}
