package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CaneFlowerDecorationSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation1:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function CaneFlowerDecorationSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.initAnims1();
         this.initAnims2();
         addChild(this.standAnimation1);
         addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         this.standAnimation1.dispose();
         this.standAnimation1 = null;
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation2.dispose();
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caneDuskFlowerSpriteAnim_"),12);
         }
         else
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caneFlowerSpriteAnim_"),12);
         }
         this.standAnimation1.setFrameDuration(0,1);
         this.standAnimation1.setFrameDuration(1,1);
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
      
      protected function initAnims2() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caneDuskFlowerBodySpriteAnim_"),12);
         }
         else
         {
            this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caneFlowerBodySpriteAnim_"),12);
         }
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = 0;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
