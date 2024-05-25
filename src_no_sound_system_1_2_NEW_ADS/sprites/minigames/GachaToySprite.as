package sprites.minigames
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   import starling.core.Starling;
   
   public class GachaToySprite extends GameSprite
   {
       
      
      public var INDEX:int;
      
      protected var anim1:GameMovieClip;
      
      public function GachaToySprite(_index:int)
      {
         super();
         this.INDEX = _index;
         this.initAnim1();
         addChild(this.anim1);
      }
      
      override public function destroy() : void
      {
         Starling.juggler.remove(this.anim1);
         this.anim1.dispose();
         this.anim1 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         if(this.INDEX == 5 || this.INDEX == 6 || this.INDEX == 7 || this.INDEX == 8 || this.INDEX == 11)
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha3TextureAtlas.getTextures("gacha_" + this.INDEX + "_"),24);
         }
         else if(this.INDEX == 9 || this.INDEX == 10 || this.INDEX == 12 || this.INDEX == 13 || this.INDEX == 14)
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha4TextureAtlas.getTextures("gacha_" + this.INDEX + "_"),24);
         }
         else if(this.INDEX == 15 || this.INDEX == 16 || this.INDEX == 17 || this.INDEX == 18 || this.INDEX == 19)
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha5TextureAtlas.getTextures("gacha_" + this.INDEX + "_"),24);
         }
         else
         {
            this.anim1 = new GameMovieClip(TextureManager.gacha2TextureAtlas.getTextures("gacha_" + this.INDEX + "_"),24);
         }
         this.anim1.touchable = false;
         this.anim1.x = -64;
         this.anim1.y = -64;
         this.anim1.loop = true;
         Starling.juggler.add(this.anim1);
      }
   }
}
