package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DandelionFlowerDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var type:int;
      
      public function DandelionFlowerDecorationSprite(_type:int = 0)
      {
         super();
         this.type = _type;
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
         if(this.type == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("dandelionFlowerDecorationSpriteAnim_"),12);
         }
         else if(this.type == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("dandelionDuskFlowerDecorationSpriteAnim_"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowDandelionFlowerDecorationSpriteAnim_"),12);
         }
         this.standAnimation.setFrameDuration(0,1);
         this.standAnimation.setFrameDuration(1,1);
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = 1;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
