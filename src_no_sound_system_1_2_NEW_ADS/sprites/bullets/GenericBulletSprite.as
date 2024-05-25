package sprites.bullets
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericBulletSprite extends GameSprite
   {
      
      public static var POGO_STICK:int = 0;
      
      public static var ROCK:int = 1;
      
      public static var PARASOL:int = 2;
      
      public static var INK:int = 3;
      
      public static var BEACH_BALL:int = 4;
      
      public static var WATER_CANNON:int = 5;
      
      public static var ARROW_HELPER:int = 6;
      
      public static var ROCK_NO_DAMAGE:int = 7;
       
      
      public var ID:int;
      
      protected var pogoAnimation:GameMovieClip;
      
      public function GenericBulletSprite(_id:int)
      {
         super();
         this.ID = _id;
         this.initAnims();
         addChild(this.pogoAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.pogoAnimation);
         this.pogoAnimation.dispose();
         this.pogoAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.ID == GenericBulletSprite.POGO_STICK)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pogoBulletSpriteAnim_a"));
            this.pogoAnimation.x = this.pogoAnimation.y = -12;
         }
         else if(this.ID == GenericBulletSprite.PARASOL)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("parasolBulletSpriteAnim_a"));
            this.pogoAnimation.x = this.pogoAnimation.y = -12;
         }
         else if(this.ID == GenericBulletSprite.INK)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("inkBulletSpriteAnim_"));
            this.pogoAnimation.x = this.pogoAnimation.y = -6;
         }
         else if(this.ID == GenericBulletSprite.BEACH_BALL)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beachBallBulletSpriteAnim_"));
            this.pogoAnimation.x = this.pogoAnimation.y = -12;
         }
         else if(this.ID == GenericBulletSprite.WATER_CANNON)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterBulletSpriteAnim_a"));
            this.pogoAnimation.x = this.pogoAnimation.y = -6;
         }
         else if(this.ID == GenericBulletSprite.ARROW_HELPER)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("arrowHelperBulletSpriteAnim_a"));
            this.pogoAnimation.x = -8;
            this.pogoAnimation.y = -4;
         }
         else if(this.ID == GenericBulletSprite.ROCK_NO_DAMAGE)
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallRockBulletSpriteAnim_"));
            this.pogoAnimation.x = this.pogoAnimation.y = -4;
         }
         else
         {
            this.pogoAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockBulletSpriteAnim_"));
            this.pogoAnimation.x = this.pogoAnimation.y = -8;
         }
         this.pogoAnimation.touchable = false;
         this.pogoAnimation.loop = true;
         Utils.juggler.add(this.pogoAnimation);
      }
   }
}
