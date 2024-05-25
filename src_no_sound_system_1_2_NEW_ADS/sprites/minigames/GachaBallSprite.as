package sprites.minigames
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GachaBallSprite extends GameSprite
   {
       
      
      public var COLOR_INDEX:int;
      
      protected var anim1:GameMovieClip;
      
      public function GachaBallSprite(_index:int)
      {
         super();
         this.COLOR_INDEX = _index;
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
         if(this.COLOR_INDEX == 0)
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha1TextureAtlas.getTextures("gatchaRedBallAnim_"),24);
         }
         else if(this.COLOR_INDEX == 1)
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha1TextureAtlas.getTextures("gatchaYellowBallAnim_"),24);
         }
         else if(this.COLOR_INDEX == 2)
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha1TextureAtlas.getTextures("gatchaGreenBallAnim_"),24);
         }
         else
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha1TextureAtlas.getTextures("gatchaBlueBallAnim_"),24);
         }
         this.anim1.touchable = false;
         this.anim1.x = -120;
         this.anim1.y = -152;
         this.anim1.loop = false;
         Utils.freeze_juggler.add(this.anim1);
      }
   }
}
