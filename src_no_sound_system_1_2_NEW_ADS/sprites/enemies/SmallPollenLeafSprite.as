package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SmallPollenLeafSprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var TYPE:int;
      
      public function SmallPollenLeafSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.initStandAnim();
         addChild(this.standAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         this.standAnim.dispose();
         this.standAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallPollenLeafSpriteAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedHelperLeafSpriteAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantPollenLeafSpriteAnim_"));
         }
         this.standAnim.touchable = false;
         if(this.TYPE == 0)
         {
            this.standAnim.x = this.standAnim.y = -8;
         }
         else if(this.TYPE == 2)
         {
            this.standAnim.x = -13;
            this.standAnim.y = -8;
         }
         else
         {
            this.standAnim.x = -11;
            this.standAnim.y = -10;
         }
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
   }
}
