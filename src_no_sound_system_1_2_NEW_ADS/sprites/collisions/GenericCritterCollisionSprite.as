package sprites.collisions
{
   import levels.collisions.CritterCollision;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericCritterCollisionSprite extends GameSprite
   {
       
      
      public var ID:int;
      
      protected var anim1:GameMovieClip;
      
      protected var anim2:GameMovieClip;
      
      protected var anim3:GameMovieClip;
      
      public function GenericCritterCollisionSprite(_ID:int)
      {
         var sprite:GameSprite = null;
         super();
         this.ID = _ID;
         this.initAnim1();
         this.initAnim2();
         this.initAnim3();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         if(this.ID == CritterCollision.MOUSE_1)
         {
            sprite.pivotX = 12;
            sprite.x = 0;
            sprite.y = -8;
         }
         else if(this.ID == CritterCollision.HERMIT_1)
         {
            sprite.pivotX = 8;
         }
         else
         {
            sprite.pivotX = sprite.pivotY = 5;
            sprite.x = sprite.y = 0;
         }
         sprite.addChild(this.anim1);
         sprite.addChild(this.anim2);
         sprite.addChild(this.anim3);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.anim1);
         Utils.juggler.remove(this.anim2);
         Utils.juggler.remove(this.anim3);
         this.anim1.dispose();
         this.anim2.dispose();
         this.anim3.dispose();
         this.anim1 = null;
         this.anim2 = null;
         this.anim3 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         if(this.ID == CritterCollision.MOUSE_1)
         {
            this.anim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mouseCollisionSpriteAStandAnim_"),12);
            this.anim1.setFrameDuration(0,Math.random() * 3 + 1);
            this.anim1.setFrameDuration(1,0.15);
            this.anim1.setFrameDuration(2,0.15);
            this.anim1.setFrameDuration(3,0.15);
            this.anim1.loop = false;
         }
         else if(this.ID == CritterCollision.HERMIT_1)
         {
            this.anim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("critterHermitCollisionSpriteStandAnim_a"),12);
         }
         else
         {
            this.anim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("critterFishCollisionSpriteStandAnim_"),12);
            this.anim1.setFrameDuration(0,Math.random() * 2 + 0.25);
            this.anim1.setFrameDuration(1,0.1);
            this.anim1.setFrameDuration(2,0.1);
            this.anim1.loop = true;
         }
         this.anim1.touchable = false;
         this.anim1.x = this.anim1.y = 0;
         Utils.juggler.add(this.anim1);
      }
      
      protected function initAnim2() : void
      {
         if(this.ID == CritterCollision.MOUSE_1)
         {
            this.anim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mouseCollisionSpriteAWalkAnim_"),16);
            this.anim2.loop = true;
         }
         else if(this.ID == CritterCollision.HERMIT_1)
         {
            this.anim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("critterHermitCollisionSpriteStandAnim_"),12);
            this.anim2.setFrameDuration(0,0.5);
            this.anim2.setFrameDuration(1,0.5);
            this.anim2.loop = true;
         }
         else
         {
            this.anim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("critterFishCollisionSpriteStandAnim_"),16);
            this.anim2.loop = false;
         }
         this.anim2.touchable = false;
         this.anim2.x = this.anim2.y = 0;
         Utils.juggler.add(this.anim2);
      }
      
      protected function initAnim3() : void
      {
         if(this.ID == CritterCollision.MOUSE_1)
         {
            this.anim3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mouseCollisionSpriteARaiseAnim_"),16);
            this.anim3.setFrameDuration(0,0.075);
            this.anim3.setFrameDuration(1,0);
            this.anim3.setFrameDuration(2,0.075);
         }
         else if(this.ID == CritterCollision.HERMIT_1)
         {
            this.anim3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("critterHermitCollisionSpriteStandAnim_a"),12);
         }
         else
         {
            this.anim3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mouseCollisionSpriteAWalkAnim_"),16);
         }
         this.anim3.touchable = false;
         this.anim3.x = this.anim3.y = 0;
         this.anim3.loop = false;
         Utils.juggler.add(this.anim3);
      }
   }
}
