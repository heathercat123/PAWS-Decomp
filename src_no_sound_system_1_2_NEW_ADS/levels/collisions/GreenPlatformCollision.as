package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.GreenPlatformCollisionSprite;
   
   public class GreenPlatformCollision extends Collision
   {
       
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var TYPE:int;
      
      public function GreenPlatformCollision(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         sprite = new GreenPlatformCollisionSprite();
         Utils.world.addChild(sprite);
         sprite.gfxHandleClip().gotoAndStop(this.TYPE + 1);
         HEIGHT = 8;
         if(this.TYPE == 0)
         {
            aabb.x = 0;
            aabb.width = 64;
            WIDTH = 64;
         }
         else
         {
            aabb.x = 8;
            aabb.width = 48;
            WIDTH = 48;
         }
         aabb.y = -2;
         aabb.height = 12;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_diff:Number = NaN;
         super.update();
         if(this.entity != null)
         {
            x_diff = xPos - this.oldXPos;
            this.entity.xPos += x_diff;
         }
         this.oldXPos = xPos;
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(heroAABB.intersects(thisAABB) && level.hero.yPos + 13 < yPos && level.hero.yVel >= 0)
         {
            level.hero.setOnPlatform(this);
            level.hero.yPos = yPos - level.hero.HEIGHT;
            level.hero.yVel = 0;
            this.entity = level.hero;
            level.hero.IS_ON_ICE = false;
         }
         else if(this.entity != null)
         {
            this.entity = null;
            level.hero.IS_ON_PLATFORM = false;
            level.hero.colliding_platform = null;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
   }
}
