package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.CheckeredSpotCollisionSprite;
   import starling.display.Image;
   
   public class CheckeredSpotCollision extends Collision
   {
       
      
      protected var backImage:Image;
      
      protected var IS_SECRET_EXIT:Boolean;
      
      protected var IS_FISHING_EXIT:Boolean;
      
      public function CheckeredSpotCollision(_level:Level, _xPos:Number, _yPos:Number, _id:int, is_invisible:int = 0)
      {
         super(_level,_xPos,_yPos);
         sprite = new CheckeredSpotCollisionSprite();
         Utils.topWorld.addChild(sprite);
         this.IS_SECRET_EXIT = this.IS_FISHING_EXIT = false;
         if(_id == 1)
         {
            this.IS_SECRET_EXIT = true;
            sprite.gfxHandleClip().gotoAndStop(2);
         }
         else if(_id == 2)
         {
            this.IS_FISHING_EXIT = true;
            sprite.gfxHandleClip().gotoAndStop(3);
         }
         else
         {
            sprite.gfxHandleClip().gotoAndStop(1);
         }
         this.backImage = new Image(TextureManager.sTextureAtlas.getTexture("checkeredSpotBackImage"));
         Utils.backWorld.addChild(this.backImage);
         aabb.x = 16;
         aabb.y = -16;
         aabb.width = 18;
         aabb.height = 16;
         if(is_invisible > 0)
         {
            sprite.visible = false;
            this.backImage.visible = false;
         }
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(this.backImage);
         this.backImage.dispose();
         this.backImage = null;
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function checkEntitiesCollision() : void
      {
         var aabb_1:Rectangle = level.hero.getAABB();
         var aabb_2:Rectangle = getAABB();
         if(aabb_1.intersects(aabb_2))
         {
            if(this.IS_FISHING_EXIT)
            {
               level.hero.levelComplete(xPos + 25,2);
            }
            else if(this.IS_SECRET_EXIT)
            {
               level.hero.levelComplete(xPos + 25,1);
            }
            else
            {
               level.hero.levelComplete(xPos + 25,0);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.backImage.x = sprite.x;
         this.backImage.y = sprite.y;
      }
   }
}
