package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericItemSprite extends GameSprite
   {
      
      public static var GENERIC_ITEM_EGG:int = 0;
       
      
      public var INDEX:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function GenericItemSprite(_index:int)
      {
         super();
         this.INDEX = _index;
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("eggDecorationSpriteAnim_a"),12);
         this.standAnimation.touchable = false;
         if(this.INDEX == 0)
         {
            this.standAnimation.x = this.standAnimation.y = 0;
         }
         else
         {
            this.standAnimation.x = this.standAnimation.y = -8;
         }
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
