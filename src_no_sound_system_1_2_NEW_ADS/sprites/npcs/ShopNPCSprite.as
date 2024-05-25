package sprites.npcs
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ShopNPCSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      public function ShopNPCSprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         this.initTurnAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 16;
         sprite.x = 8;
         sprite.y = -15;
         if(this.TYPE == 2)
         {
            sprite.y = -22;
         }
         else if(this.TYPE == 3 || this.TYPE == 4)
         {
            sprite.y = -24;
         }
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("vendor1NpcStandAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatIceCreamNpcStandAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bunnyShopNpcStandAnim_"));
         }
         else if(this.TYPE == 4)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fishShopNpcStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redShopTomoNpcStandAnim_"));
         }
         if(this.TYPE != 1)
         {
            this.standAnim.setFrameDuration(0,1);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.1);
            this.standAnim.setFrameDuration(3,0.1);
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("vendor1NpcTurnAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatIceCreamNpcTurnAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bunnyShopNpcTurnAnim_"));
         }
         else if(this.TYPE == 4)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fishShopNpcStandAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redShopTomoNpcTurnAnim_"));
         }
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
   }
}
