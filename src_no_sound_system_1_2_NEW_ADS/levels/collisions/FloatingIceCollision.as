package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.BigIceBlockCollisionSprite;
   
   public class FloatingIceCollision extends Collision
   {
       
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var sinCounter1:Number;
      
      protected var oldShift:Number;
      
      protected var lighter_y_diff:Number;
      
      protected var x_friction:Number;
      
      protected var xVel:Number;
      
      protected var yVel:Number;
      
      protected var __xPos:Number;
      
      protected var __yPos:Number;
      
      public function FloatingIceCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = new BigIceBlockCollisionSprite(0);
         Utils.world.addChild(sprite);
         WIDTH = 64;
         HEIGHT = 8;
         aabb.x = 0;
         aabb.y = -1;
         aabb.width = 32;
         aabb.height = 34;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.sinCounter1 = Utils.random.nextMax(6);
         this.oldShift = Utils.SEA_X_SHIFT;
         this.lighter_y_diff = 0;
         this.x_friction = 0.95;
         this.xVel = this.yVel = 0;
         this.__xPos = _xPos;
         this.__yPos = _yPos;
         this.lighter_y_diff = -12;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         this.entity = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_diff:Number = NaN;
         super.update();
         this.sinCounter1 += 0.05;
         if(this.sinCounter1 >= Math.PI * 2)
         {
            this.sinCounter1 -= Math.PI * 2;
         }
         this.__yPos = Utils.SEA_LEVEL - HEIGHT + Math.sin(this.sinCounter1) * 1.5 + this.lighter_y_diff;
         this.xVel += (Utils.SEA_X_SHIFT - this.oldShift) * 0.02;
         this.oldShift = Utils.SEA_X_SHIFT;
         if(this.entity != null)
         {
            x_diff = xPos - this.oldXPos;
            this.entity.xPos += x_diff;
         }
         this.oldXPos = xPos;
         this.xVel *= this.x_friction;
         this.__xPos += this.xVel;
         this.__yPos += this.yVel;
         xPos = int(this.__xPos);
         yPos = int(this.__yPos);
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(heroAABB.intersects(thisAABB) && level.hero.yPos + 8 < yPos && level.hero.yVel >= 0)
         {
            level.hero.setOnPlatform(this);
            level.hero.IS_ON_ICE = true;
            level.hero.yPos = yPos - level.hero.HEIGHT;
            level.hero.yVel = 0;
            this.entity = level.hero;
            this.lighter_y_diff += 0.2;
            if(this.lighter_y_diff >= -4)
            {
               this.lighter_y_diff = -4;
            }
         }
         else
         {
            if(this.entity != null)
            {
               this.entity = null;
               level.hero.IS_ON_PLATFORM = false;
               level.hero.IS_ON_ICE = false;
            }
            this.lighter_y_diff -= 0.2;
            if(this.lighter_y_diff <= -12)
            {
               this.lighter_y_diff = -12;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
   }
}
