package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class HatItemSprite extends GameSprite
   {
       
      
      protected var ITEM_INDEX:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function HatItemSprite(_index:int)
      {
         super();
         this.ITEM_INDEX = _index;
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("itemHat" + this.ITEM_INDEX + "SpriteAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -16;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
