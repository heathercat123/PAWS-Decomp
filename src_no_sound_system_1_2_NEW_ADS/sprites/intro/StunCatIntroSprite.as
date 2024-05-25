package sprites.intro
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   import starling.core.Starling;
   
   public class StunCatIntroSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      public function StunCatIntroSprite()
      {
         super();
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
         this.anim1 = new GameMovieClip(TextureManager.introTextureAtlas.getTextures("stunnedCatIntroSpriteAnim_"),12);
         this.anim1.setFrameDuration(0,0.25);
         this.anim1.setFrameDuration(1,0.25);
         this.anim1.setFrameDuration(2,0.25);
         this.anim1.setFrameDuration(3,0.25);
         this.anim1.touchable = false;
         this.anim1.loop = true;
         Starling.juggler.add(this.anim1);
      }
   }
}
