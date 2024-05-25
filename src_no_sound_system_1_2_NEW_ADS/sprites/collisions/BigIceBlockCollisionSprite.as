package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BigIceBlockCollisionSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function BigIceBlockCollisionSprite(_type:int)
      {
         super();
         this.TYPE = _type;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceBigBlockCollisionSpriteAnim_"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spikedRockCollisionSpriteAnim_"),12);
         }
         this.standAnimation.touchable = false;
         if(this.TYPE == 0)
         {
            this.standAnimation.x = this.standAnimation.y = 0;
         }
         else
         {
            this.standAnimation.x = this.standAnimation.y = -20;
         }
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
