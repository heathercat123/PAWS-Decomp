package sprites.intro
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericIntroSprite extends GameSprite
   {
       
      
      protected var INDEX:int;
      
      protected var anim1:GameMovieClip;
      
      public function GenericIntroSprite(_id:int = 0)
      {
         super();
         this.INDEX = _id;
         this.initAnim1();
         addChild(this.anim1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.anim1);
         this.anim1.dispose();
         this.anim1 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         if(this.INDEX == 1)
         {
            this.anim1 = new GameMovieClip(TextureManager.intro2TextureAtlas.getTextures("seaReflectionSpriteAnim_"),12);
            this.anim1.setFrameDuration(0,0.2);
            this.anim1.setFrameDuration(1,0.2);
         }
         else if(this.INDEX == 2)
         {
            this.anim1 = new GameMovieClip(TextureManager.intro2TextureAtlas.getTextures("dustIntroSpriteAnim_"),12);
            this.anim1.setFrameDuration(0,0.1);
            this.anim1.setFrameDuration(1,0.1);
            this.anim1.setFrameDuration(2,0.1);
         }
         else
         {
            this.anim1 = new GameMovieClip(TextureManager.intro2TextureAtlas.getTextures("pascalIntroSpriteAnim_"),12);
            this.anim1.setFrameDuration(0,0.1);
            this.anim1.setFrameDuration(1,0.1);
            this.anim1.setFrameDuration(2,0.1);
            this.anim1.setFrameDuration(3,0.1);
         }
         this.anim1.touchable = false;
         if(this.INDEX == 2)
         {
            this.anim1.loop = false;
         }
         else
         {
            this.anim1.loop = true;
         }
         Utils.juggler.add(this.anim1);
      }
   }
}
