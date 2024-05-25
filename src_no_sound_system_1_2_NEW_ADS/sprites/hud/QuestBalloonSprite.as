package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class QuestBalloonSprite extends GameSprite
   {
       
      
      protected var anim1:GameMovieClip;
      
      public function QuestBalloonSprite()
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
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("questBalloonSpriteAnim_"),12);
         this.anim1.touchable = false;
         this.anim1.x = -32;
         this.anim1.y = -40;
         this.anim1.loop = false;
         Utils.juggler.add(this.anim1);
      }
   }
}
