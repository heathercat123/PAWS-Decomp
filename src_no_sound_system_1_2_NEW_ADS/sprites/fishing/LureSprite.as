package sprites.fishing
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class LureSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var bigStandAnimation:GameMovieClip;
      
      public function LureSprite(_type:int)
      {
         super();
         this.TYPE = _type;
         this.standAnimation = null;
         this.bigStandAnimation = null;
         if(this.TYPE == 0)
         {
            this.initAnims();
            this.initBigAnims();
            addChild(this.standAnimation);
            addChild(this.bigStandAnimation);
         }
         else if(this.TYPE == 1)
         {
            this.initAnims();
            addChild(this.standAnimation);
         }
      }
      
      override public function destroy() : void
      {
         if(this.standAnimation != null)
         {
            Utils.juggler.remove(this.standAnimation);
            this.standAnimation.dispose();
            this.standAnimation = null;
         }
         if(this.bigStandAnimation != null)
         {
            Utils.juggler.remove(this.bigStandAnimation);
            this.bigStandAnimation.dispose();
            this.bigStandAnimation = null;
         }
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lureStandAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.33);
            this.standAnimation.setFrameDuration(1,0.33);
            this.standAnimation.setFrameDuration(2,0.33);
            this.standAnimation.touchable = false;
            this.standAnimation.x = this.standAnimation.y = -8;
            this.standAnimation.loop = true;
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lureFightArrowStandAnim_"),12);
            this.standAnimation.touchable = false;
            this.standAnimation.x = this.standAnimation.y = -6;
         }
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initBigAnims() : void
      {
         this.bigStandAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lureStandAnim_"),12);
         this.bigStandAnimation.textureSmoothing = Utils.getSmoothing();
         this.bigStandAnimation.touchable = false;
         this.bigStandAnimation.x = this.bigStandAnimation.y = -8;
         this.bigStandAnimation.loop = false;
         Utils.juggler.add(this.bigStandAnimation);
      }
   }
}
