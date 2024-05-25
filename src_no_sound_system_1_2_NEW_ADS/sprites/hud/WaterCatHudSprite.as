package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WaterCatHudSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      protected var anim3:GameMovieClip;
      
      protected var anim4:GameMovieClip;
      
      public function WaterCatHudSprite()
      {
         super();
         this.initAnim1();
         this.initAnim3();
         this.initAnim4();
         addChild(this.anim1);
         addChild(this.anim3);
         addChild(this.anim4);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.anim1);
         Utils.juggler.remove(this.anim3);
         Utils.juggler.remove(this.anim4);
         this.anim1.dispose();
         this.anim1 = null;
         this.anim3.dispose();
         this.anim3 = null;
         this.anim4.dispose();
         this.anim4 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("waterCatItemHudSpriteHiddenAnim_a"),12);
         this.anim1.touchable = false;
         this.anim1.x = this.anim1.y = -16;
         this.anim1.loop = false;
         Utils.juggler.add(this.anim1);
      }
      
      protected function initAnim3() : void
      {
         this.anim3 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("waterCatItemHudSpriteGetAnim_"),12);
         this.anim3.touchable = false;
         this.anim3.x = this.anim3.y = -16;
         this.anim3.loop = false;
         Utils.juggler.add(this.anim3);
      }
      
      protected function initAnim4() : void
      {
         this.anim4 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("waterCatItemHudSpriteVisibleAnim_a"),12);
         this.anim4.touchable = false;
         this.anim4.x = this.anim4.y = -16;
         this.anim4.loop = false;
         Utils.juggler.add(this.anim4);
      }
   }
}
