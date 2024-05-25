package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class FullAreaCollision extends Collision
   {
       
      
      protected var TYPE:int;
      
      public var ENABLED:Boolean;
      
      public function FullAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _type:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         WIDTH = _width;
         HEIGHT = _height;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.ENABLED = true;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
      
      override public function checkPostUpdateEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = null;
         var intersection:Rectangle = null;
         var center_x:Number = NaN;
         var center_y:Number = NaN;
         var hero_center_x:Number = NaN;
         var hero_center_y:Number = NaN;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         if(!this.ENABLED)
         {
            return;
         }
         aabb.x = xPos;
         aabb.y = yPos;
         if(this.TYPE == 0)
         {
            hero_aabb = level.hero.getAABBPhysics();
            intersection = hero_aabb.intersection(aabb);
            if(intersection.width > 0 || intersection.height > 0)
            {
               if(intersection.width > intersection.height)
               {
                  if(hero_aabb.y > yPos + HEIGHT * 0.5)
                  {
                     level.hero.yPos = yPos + HEIGHT - level.hero.aabbPhysics.y;
                     if(level.hero.IS_IN_WATER == false)
                     {
                        level.hero.yVel = 0;
                     }
                  }
                  else
                  {
                     level.hero.yPos = yPos - (level.hero.aabbPhysics.y + level.hero.aabbPhysics.height);
                     if(level.hero.IS_IN_WATER == false)
                     {
                        level.hero.yVel = 0;
                     }
                  }
               }
               else if(hero_aabb.x < xPos + WIDTH * 0.5)
               {
                  level.hero.xPos = xPos - (level.hero.aabbPhysics.x + level.hero.aabbPhysics.width);
               }
               else
               {
                  level.hero.xPos = xPos + WIDTH - level.hero.aabbPhysics.x;
               }
            }
         }
         else
         {
            center_y = yPos;
            if(this.TYPE == 2)
            {
               center_x = xPos;
            }
            else
            {
               center_x = xPos + 16;
            }
            hero_center_x = level.hero.getMidXPos();
            hero_center_y = level.hero.getMidYPos();
            if(hero_center_y < center_y)
            {
               return;
            }
            diff_x = hero_center_x - center_x;
            diff_y = hero_center_y - center_y;
            distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
            if(distance <= 26)
            {
               diff_x /= distance;
               diff_y /= distance;
               if(level.hero.IS_IN_WATER)
               {
                  level.hero.xPos = center_x + diff_x * 26 - 8;
               }
               level.hero.yPos = center_y + diff_y * 26 - 8;
               if(!level.hero.IS_IN_WATER)
               {
                  level.hero.yVel *= 0.98;
               }
            }
         }
      }
   }
}
