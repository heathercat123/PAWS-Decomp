package levels.collisions
{
   import entities.Easings;
   import entities.bullets.Bullet;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import levels.items.CoinItem;
   import sprites.bullets.*;
   import sprites.collisions.*;
   import sprites.particles.VaporParticleSprite;
   import sprites.tutorials.*;
   
   public class BigIceBlockCollision extends Collision
   {
       
      
      public var TYPE:int;
      
      protected var STATE:int;
      
      protected var ORIGINAL_MOVE_DIRECTION:int;
      
      protected var MOVE_DIRECTION:int;
      
      protected var IS_CLOCKWISE:Boolean;
      
      public var DO_NOT_MOVE:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      public function BigIceBlockCollision(_level:Level, _xPos:Number, _yPos:Number, _param:int = 0, _type:int = 0, _clockwise:int = 0)
      {
         var x_t:int = 0;
         var y_t:int = 0;
         super(_level,_xPos,_yPos);
         this.STATE = 0;
         this.TYPE = _type;
         this.ORIGINAL_MOVE_DIRECTION = this.MOVE_DIRECTION = _param;
         sprite = new BigIceBlockCollisionSprite(this.TYPE);
         this.DO_NOT_MOVE = false;
         this.IS_CLOCKWISE = false;
         if(_clockwise > 0)
         {
            this.IS_CLOCKWISE = true;
         }
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         if(this.TYPE == 0)
         {
            Utils.topWorld.addChild(sprite);
            aabb.x = -2;
            aabb.y = -2;
            aabb.width = 36;
            aabb.height = 36;
            x_t = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
            y_t = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               level.levelData.setTileValueAt(x_t,y_t,13);
            }
            if(level.levelData.getTileValueAt(x_t + 1,y_t) == 0)
            {
               level.levelData.setTileValueAt(x_t + 1,y_t,13);
            }
            if(level.levelData.getTileValueAt(x_t,y_t + 1) == 0)
            {
               level.levelData.setTileValueAt(x_t,y_t + 1,13);
            }
            if(level.levelData.getTileValueAt(x_t + 1,y_t + 1) == 0)
            {
               level.levelData.setTileValueAt(x_t + 1,y_t + 1,13);
            }
         }
         else if(this.TYPE == 1)
         {
            Utils.world.addChild(sprite);
            aabb.x = -16;
            aabb.y = -16;
            aabb.width = 32;
            aabb.height = 32;
            WIDTH = HEIGHT = 32;
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this.TYPE == 1)
         {
            this.MOVE_DIRECTION = this.ORIGINAL_MOVE_DIRECTION;
            this.STATE = 0;
            counter1 = 0;
         }
      }
      
      override public function destroy() : void
      {
         if(this.TYPE == 0)
         {
            Utils.topWorld.removeChild(sprite);
         }
         else
         {
            Utils.world.removeChild(sprite);
         }
         super.destroy();
      }
      
      override public function getMidXPos() : Number
      {
         if(this.TYPE == 0)
         {
            return xPos + 16;
         }
         return xPos;
      }
      
      override public function getMidYPos() : Number
      {
         if(this.TYPE == 0)
         {
            return yPos + 16;
         }
         return yPos;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         var pSprite:VaporParticleSprite = null;
         var x_t:int = 0;
         var y_t:int = 0;
         var i:int = 0;
         var _aabb:Rectangle = null;
         if(this.TYPE == 1)
         {
            if(this.STATE == 0)
            {
               if(!this.DO_NOT_MOVE)
               {
                  ++counter1;
                  if(counter1 >= 60)
                  {
                     this.evaluateMove();
                     this.STATE = 1;
                  }
               }
            }
            else if(this.STATE == 1)
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
               }
               if(this.MOVE_DIRECTION == 0 || this.MOVE_DIRECTION == 2)
               {
                  yPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
               }
               else
               {
                  xPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
               }
               if(this.t_tick >= this.t_time)
               {
                  this.STATE = 0;
                  counter1 = 0;
                  if(this.isInsideInnerScreen(-32))
                  {
                     level.camera.shake(4);
                     SoundSystem.PlaySound("big_impact");
                  }
                  if(this.IS_CLOCKWISE)
                  {
                     --this.MOVE_DIRECTION;
                     if(this.MOVE_DIRECTION < 0)
                     {
                        this.MOVE_DIRECTION = 3;
                     }
                  }
                  else
                  {
                     ++this.MOVE_DIRECTION;
                     if(this.MOVE_DIRECTION > 3)
                     {
                        this.MOVE_DIRECTION = 0;
                     }
                  }
               }
            }
         }
         else if(IS_MELTING)
         {
            if(counter3-- < 0)
            {
               counter3 = Math.random() * 10 + 10;
               pSprite = new VaporParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.topParticlesManager.pushBackParticle(pSprite,xPos + Math.random() * 32,yPos + Math.random() * 32,0,0,1,Math.random() * (Math.PI * 2));
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
                  level.levelData.setTileValueAt(x_t + 1,y_t,0);
                  level.levelData.setTileValueAt(x_t,y_t + 1,0);
                  level.levelData.setTileValueAt(x_t + 1,y_t + 1,0);
                  _aabb = new Rectangle(xPos,yPos,32,32);
                  for(i = 0; i < level.itemsManager.items.length; i++)
                  {
                     if(level.itemsManager.items[i] != null)
                     {
                        if(level.itemsManager.items[i] is CoinItem)
                        {
                           if(level.itemsManager.items[i].getAABB().intersects(_aabb))
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
      
      protected function evaluateMove() : void
      {
         var found:Boolean = false;
         var mid_x_t:int = int(this.getMidXPos() / Utils.TILE_WIDTH);
         var mid_y_t:int = int(this.getMidYPos() / Utils.TILE_HEIGHT);
         var mid_sx_x_t:int = int((this.getMidXPos() - 8) / Utils.TILE_WIDTH);
         var mid_dx_x_t:int = int((this.getMidXPos() + 8) / Utils.TILE_WIDTH);
         var mid_top_y_t:int = int((this.getMidYPos() - 8) / Utils.TILE_HEIGHT);
         var mid_bottom_y_t:int = int((this.getMidYPos() + 8) / Utils.TILE_HEIGHT);
         var dest_x_t:int = mid_x_t;
         var dest_y_t:int = mid_y_t;
         while(!found)
         {
            if(this.MOVE_DIRECTION == 0)
            {
               dest_y_t--;
            }
            else if(this.MOVE_DIRECTION == 1)
            {
               dest_x_t--;
            }
            else if(this.MOVE_DIRECTION == 2)
            {
               dest_y_t++;
            }
            else
            {
               dest_x_t++;
            }
            if(this.MOVE_DIRECTION == 0 || this.MOVE_DIRECTION == 2)
            {
               if(level.levelData.getTileValueAt(mid_sx_x_t,dest_y_t) != 0 || level.levelData.getTileValueAt(mid_dx_x_t,dest_y_t) != 0)
               {
                  found = true;
               }
            }
            else if(level.levelData.getTileValueAt(dest_x_t,mid_bottom_y_t) != 0 || level.levelData.getTileValueAt(dest_x_t,mid_top_y_t) != 0)
            {
               found = true;
            }
            if(dest_x_t <= 0 || dest_y_t <= 0 || dest_x_t >= level.levelData.T_WIDTH || dest_y_t >= level.levelData.T_HEIGHT)
            {
               found = true;
            }
         }
         this.t_tick = 0;
         if(this.MOVE_DIRECTION == 0)
         {
            this.t_start = yPos;
            this.t_diff = (dest_y_t + 2) * Utils.TILE_HEIGHT - yPos;
         }
         else if(this.MOVE_DIRECTION == 1)
         {
            this.t_start = xPos;
            this.t_diff = (dest_x_t + 2) * Utils.TILE_WIDTH - xPos;
         }
         else if(this.MOVE_DIRECTION == 2)
         {
            this.t_start = yPos;
            this.t_diff = (dest_y_t - 1) * Utils.TILE_HEIGHT - yPos;
         }
         else if(this.MOVE_DIRECTION == 3)
         {
            this.t_start = xPos;
            this.t_diff = (dest_x_t - 1) * Utils.TILE_WIDTH - xPos;
         }
         this.t_time = Math.abs(this.t_diff / 256);
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         var bullet:Bullet = null;
         var aabb:Rectangle = null;
         var heroAABB:Rectangle = null;
         var thisAABB:Rectangle = null;
         if(this.TYPE == 0)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_FIRE)
            {
               if(getAABB().intersects(level.hero.getAABB()))
               {
                  this.melt();
               }
            }
            aabb = getAABB();
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
         else
         {
            heroAABB = level.hero.getAABB();
            thisAABB = new Rectangle(xPos - 16,yPos - 16,32,32);
            if(heroAABB.intersects(thisAABB))
            {
               level.hero.hurt(thisAABB.x + 16,thisAABB.y + 16,null);
            }
            for(i = 0; i < level.enemiesManager.enemies.length; i++)
            {
               if(level.enemiesManager.enemies[i] != null)
               {
                  heroAABB = level.enemiesManager.enemies[i].getAABB();
                  if(heroAABB.intersects(thisAABB))
                  {
                     level.enemiesManager.enemies[i].hit(xPos,yPos,false);
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var x_t:int = 0;
         super.updateScreenPosition(camera);
         if(this.TYPE == 0)
         {
            x_t = int(sprite.x % 32 / 4);
            while(x_t < 0)
            {
               x_t += 8;
            }
            sprite.gfxHandleClip().gotoAndStop(x_t + 1);
         }
      }
      
      public function melt() : void
      {
         if(!IS_MELTING)
         {
            IS_MELTING = true;
            SoundSystem.PlaySound("ice_melt");
         }
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var area:Rectangle = null;
         if(this.TYPE == 0)
         {
            area = new Rectangle(xPos,yPos,32,32);
         }
         else
         {
            area = new Rectangle(xPos - 16,yPos - 16,32,32);
         }
         var camera:Rectangle = new Rectangle(level.camera.xPos + _offset,level.camera.yPos + _offset,level.camera.WIDTH - _offset * 2,level.camera.HEIGHT - _offset * 2);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
   }
}
