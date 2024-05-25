package levels.collisions
{
   import entities.Entity;
   import entities.bullets.Bullet;
   import entities.enemies.Enemy;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import levels.items.BellItem;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class PlatformCollisionArea extends Collision
   {
       
      
      protected var entity:Entity;
      
      public function PlatformCollisionArea(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         aabb.x = -4;
         aabb.y = -2;
         aabb.width = WIDTH + 8;
         aabb.height = 12 + 4;
      }
      
      override public function destroy() : void
      {
         this.entity = null;
         super.destroy();
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         var enemy:Enemy = null;
         var item:BellItem = null;
         var bullet:Bullet = null;
         var entityAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(entityAABB.intersects(thisAABB) && level.hero.yPos + 13 < yPos && level.hero.yVel >= 0)
         {
            level.hero.setOnPlatform(this);
            level.hero.yPos = yPos - level.hero.HEIGHT;
            level.hero.yVel = 0;
            this.entity = level.hero;
         }
         else if(this.entity != null)
         {
            this.entity = null;
            level.hero.IS_ON_PLATFORM = false;
         }
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               enemy = level.enemiesManager.enemies[i] as Enemy;
               entityAABB.x = enemy.xPos + enemy.aabbPhysics.x;
               entityAABB.y = enemy.yPos + enemy.aabbPhysics.y;
               entityAABB.width = enemy.aabbPhysics.width;
               entityAABB.height = enemy.aabbPhysics.height;
               if(entityAABB.intersects(thisAABB) && enemy.yVel >= 0)
               {
                  enemy.yPos = yPos - (enemy.aabbPhysics.height + enemy.aabbPhysics.y);
                  enemy.yVel = 0;
                  enemy.groundCollision();
               }
            }
         }
         for(i = 0; i < level.itemsManager.items.length; i++)
         {
            if(level.itemsManager.items[i] != null)
            {
               if(level.itemsManager.items[i] is BellItem)
               {
                  item = level.itemsManager.items[i] as BellItem;
                  entityAABB.x = item.xPos + item.aabbPhysics.x;
                  entityAABB.y = item.yPos + item.aabbPhysics.y;
                  entityAABB.width = item.aabbPhysics.width;
                  entityAABB.height = item.aabbPhysics.height;
                  if(entityAABB.intersects(thisAABB) && item.yVel >= 0)
                  {
                     item.yPos = yPos - (item.aabbPhysics.height + item.aabbPhysics.y);
                     item.yVel = 0;
                     item.groundCollision();
                  }
               }
            }
         }
         for(i = 0; i < level.bulletsManager.bullets.length; i++)
         {
            if(level.bulletsManager.bullets[i] != null)
            {
               if(level.bulletsManager.bullets[i].sprite != null)
               {
                  bullet = level.bulletsManager.bullets[i];
                  entityAABB.x = bullet.xPos + bullet.aabbPhysics.x;
                  entityAABB.y = bullet.yPos + bullet.aabbPhysics.y;
                  entityAABB.width = bullet.aabbPhysics.width;
                  entityAABB.height = bullet.aabbPhysics.height;
                  if(entityAABB.intersects(thisAABB) && bullet.yVel >= 0)
                  {
                     bullet.yPos = yPos - (bullet.aabbPhysics.height + bullet.aabbPhysics.y);
                     bullet.yVel = 0;
                     bullet.groundCollision();
                  }
               }
            }
         }
      }
   }
}
