package sprites.hud
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class LetterFirstCHudSprite extends GameSprite
   {
      
      public static var speed:Number = 0.075;
       
      
      protected var anim1:GameMovieClip;
      
      public function LetterFirstCHudSprite()
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
         this.anim1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("firstCLetterSpriteAnim_"),12);
         this.anim1.setFrameDuration(0,LetterFirstCHudSprite.speed);
         this.anim1.setFrameDuration(1,LetterFirstCHudSprite.speed);
         this.anim1.setFrameDuration(2,LetterFirstCHudSprite.speed);
         this.anim1.setFrameDuration(3,LetterFirstCHudSprite.speed);
         this.anim1.setFrameDuration(4,LetterFirstCHudSprite.speed);
         this.anim1.touchable = false;
         this.anim1.x = 0;
         this.anim1.y = 0;
         this.anim1.loop = false;
         Utils.juggler.add(this.anim1);
      }
   }
}
