package levels.collisions
{
   import entities.bullets.Bullet;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import interfaces.dialogs.*;
   import levels.Level;
   import levels.cameras.*;
   import levels.items.CoinItem;
   import sprites.bullets.*;
   import sprites.collisions.*;
   import sprites.particles.*;
   import sprites.tutorials.*;
   
   public class SmallIceBlockCollision extends Collision
   {
       
      
      public function SmallIceBlockCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = new SmallIceBlockCollisionSprite();
         Utils.topWorld.addChild(sprite);
         aabb.x = -2;
         aabb.y = -2;
         aabb.width = 20;
         aabb.height = 20;
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         level.levelData.setTileValueAt(x_t,y_t,13);
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function getMidXPos() : Number
      {
         return xPos + 8;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos + 8;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         var pSprite:VaporParticleSprite = null;
         var x_t:int = 0;
         var y_t:int = 0;
         var i:int = 0;
         if(IS_MELTING)
         {
            if(counter3-- < 0)
            {
               counter3 = Math.random() * 10 + 15;
               pSprite = new VaporParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.topParticlesManager.pushBackParticle(pSprite,xPos + Math.random() * 16,yPos + Math.random() * 16,0,0,1,Math.random() * (Math.PI * 2));
            }
            ++counter1;
            wait_time = 2;
            if(sprite.visible)
            {
               wait_time = 4;
            }
            if(counter1 >= wait_time)
            {
               counter1 = 0;
               ++counter2;
               sprite.visible = !sprite.visible;
               if(counter2 > 12)
               {
                  dead = true;
                  x_t = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
                  y_t = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
                  level.levelData.setTileValueAt(x_t,y_t,0);
                  for(i = 0; i < level.itemsManager.items.length; i++)
                  {
                     if(level.itemsManager.items[i] != null)
                     {
                        if(level.itemsManager.items[i] is CoinItem)
                        {
                           if(level.itemsManager.items[i].getAABB().intersects(getAABB()))
                           {
                              CoinItem(level.itemsManager.items[i]).unfreeze();
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         var bullet:Bullet = null;
         var aabb:Rectangle = getAABB();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_FIRE)
         {
            if(aabb.intersects(level.hero.getAABB()))
            {
               this.melt();
            }
         }
         for(i = 0; i < level.bulletsManager.bullets.length; i++)
         {
            if(level.bulletsManager.bullets[i] != null)
            {
               if(level.bulletsManager.bullets[i].sprite != null)
               {
                  if(level.bulletsManager.bullets[i].sprite is FireballBulletSprite || level.bulletsManager.bullets[i].sprite is FirePlantBulletSprite || level.bulletsManager.bullets[i].sprite is FireFloatingBulletSprite)
                  {
                     bullet = level.bulletsManager.bullets[i] as Bullet;
                     if(Utils.CircleRectHitTest(bullet.xPos,bullet.yPos,bullet.RADIUS,aabb.x,aabb.y,aabb.x + aabb.width,aabb.y + aabb.height))
                     {
                        this.melt();
                     }
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         var x_t:int = int(sprite.x % 16 / 2);
         while(x_t < 0)
         {
            x_t += 8;
         }
         sprite.gfxHandleClip().gotoAndStop(x_t + 1);
      }
      
      public function melt() : void
      {
         if(!IS_MELTING)
         {
            IS_MELTING = true;
            SoundSystem.PlaySound("ice_melt");
         }
      }
      
      public function explode(_isBigCat:Boolean = false) : void
      {
         SoundSystem.PlaySound("brick_destroyed");
         dead = true;
         level.camera.shake(3);
         this.clearTileValue();
         level.topParticlesManager.createSmallBrickExplosion(xPos + 8,yPos + 8,_isBigCat);
      }
      
      public function clearTileValue() : void
      {
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         level.levelData.setTileValueAt(x_t,y_t,0);
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var area:Rectangle = new Rectangle(xPos,yPos,16,16);
         var camera:Rectangle = new Rectangle(level.camera.xPos + 16,level.camera.yPos + 16,level.camera.WIDTH - 32,level.camera.HEIGHT - 32);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
   }
}
