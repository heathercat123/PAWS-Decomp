package entities.helpers
{
   import entities.Entity;
   import entities.enemies.Enemy;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.WaterCollision;
   import sprites.GameSprite;
   import sprites.particles.ItemExplosionParticleSprite;
   import sprites.particles.SplashParticleSprite;
   
   public class Helper extends Entity
   {
       
      
      protected var OLD_LEVEL:int;
      
      public var LEVEL:int;
      
      public var ITEM_ID:int;
      
      protected var float_y:Number;
      
      public var offset_y:Number;
      
      protected var target:Enemy;
      
      protected var ACTION_RADIUS:Number;
      
      protected var RADIUS_MAX_DISTANCE_FROM_HERO:Number;
      
      protected var topSprite:GameSprite;
      
      protected var attackCooldownCounter:int;
      
      protected var WATER_TYPE:int;
      
      public function Helper(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ID:int)
      {
         super(_level,_xPos,_yPos,_direction);
         this.ITEM_ID = _ID;
         this.OLD_LEVEL = this.LEVEL = Utils.Slot.playerInventory[this.ITEM_ID];
         this.attackCooldownCounter = 0;
         this.float_y = 0;
         this.target = null;
         this.ACTION_RADIUS = 160;
         this.RADIUS_MAX_DISTANCE_FROM_HERO = 160;
         this.WATER_TYPE = -1;
      }
      
      protected function checkWater() : void
      {
         if(Utils.SEA_LEVEL != 0)
         {
            if(!IS_IN_WATER)
            {
               if(!level.hero.IS_IN_WATER)
               {
                  if(yPos >= Utils.SEA_LEVEL - 8)
                  {
                     yVel = 0;
                     yPos = Utils.SEA_LEVEL - 8;
                  }
               }
               else if(yPos >= Utils.SEA_LEVEL + 8)
               {
                  IS_IN_WATER = true;
                  this.setParams();
                  SoundSystem.PlaySound("water_splash");
                  if(this.WATER_TYPE < 0)
                  {
                     this.getWaterType();
                  }
                  level.particlesManager.pushParticle(new SplashParticleSprite(this.WATER_TYPE),xPos,Utils.SEA_LEVEL,0,0,0);
               }
            }
            else if(level.hero.IS_IN_WATER)
            {
               if(yPos <= Utils.SEA_LEVEL + 8)
               {
                  yVel = 0;
                  yPos = Utils.SEA_LEVEL + 8;
               }
            }
            else if(yPos <= Utils.SEA_LEVEL - 8)
            {
               IS_IN_WATER = false;
               this.setParams();
               SoundSystem.PlaySound("water_splash");
               if(this.WATER_TYPE < 0)
               {
                  this.getWaterType();
               }
               level.particlesManager.pushParticle(new SplashParticleSprite(this.WATER_TYPE),xPos,Utils.SEA_LEVEL,0,0,0);
            }
         }
      }
      
      protected function followHero() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         if(level.hero.DIRECTION == RIGHT)
         {
            dest_x = level.hero.xPos - Utils.TILE_WIDTH;
         }
         else
         {
            dest_x = level.hero.xPos + level.hero.WIDTH + Utils.TILE_WIDTH;
         }
         dest_y = level.hero.yPos - Utils.TILE_HEIGHT;
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         if(dist_perc <= 0.1)
         {
            dist_perc = 0;
         }
         angle = this.getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function targetEnemy() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         dest_x = this.target.getMidXPos();
         dest_y = this.target.getMidYPos() - (this.target.HEIGHT * 0.5 + Utils.TILE_HEIGHT * 1.5);
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         angle = this.getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function canTargetEnemy() : Boolean
      {
         var i:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         diff_x = level.hero.getMidXPos() - xPos;
         diff_y = level.hero.getMidYPos() - yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > 144)
         {
            return false;
         }
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               if(level.enemiesManager.enemies[i].isTargetable())
               {
                  diff_x = level.enemiesManager.enemies[i].getMidXPos() - xPos;
                  diff_y = level.enemiesManager.enemies[i].getMidYPos() - yPos;
                  distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                  if(distance <= this.ACTION_RADIUS)
                  {
                     diff_x = level.enemiesManager.enemies[i].getMidXPos() - level.hero.getMidXPos();
                     diff_y = level.enemiesManager.enemies[i].getMidYPos() - level.hero.getMidYPos();
                     distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                     if(distance <= 128)
                     {
                        if(this.canBeAttacked(level.enemiesManager.enemies[i]))
                        {
                           if(level.enemiesManager.enemies[i].getMidYPos() - Utils.TILE_HEIGHT * 3 > level.camera.yPos)
                           {
                              this.target = level.enemiesManager.enemies[i];
                              return true;
                           }
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      protected function isTargetTooDistantFromHero() : Boolean
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         if(this.target == null)
         {
            return true;
         }
         diff_x = level.hero.getMidXPos() - this.target.getMidXPos();
         diff_y = level.hero.getMidYPos() - this.target.getMidYPos();
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > this.RADIUS_MAX_DISTANCE_FROM_HERO + 32)
         {
            return true;
         }
         return false;
      }
      
      protected function isDistantFromHero() : Boolean
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         diff_x = level.hero.getMidXPos() - xPos;
         diff_y = level.hero.getMidYPos() - yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > 144)
         {
            return true;
         }
         return false;
      }
      
      protected function canBeAttacked(enemy:Enemy) : Boolean
      {
         var i:int = 0;
         var mid_x_t:Number = enemy.getMidXPos() / Utils.TILE_WIDTH;
         var mid_y_t:Number = enemy.getMidYPos() / Utils.TILE_HEIGHT;
         for(i = 0; i < 2; i++)
         {
            if(level.levelData.getTileValueAt(mid_x_t,mid_y_t - i) != 0)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function initSprites() : void
      {
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(this.topSprite);
         this.topSprite.destroy();
         this.topSprite.dispose();
         this.topSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         this.float_y += 0.05;
         if(this.float_y >= Math.PI * 2)
         {
            this.float_y -= Math.PI * 2;
         }
         this.offset_y = Math.sin(this.float_y) * 4;
      }
      
      public function setActive() : void
      {
         this.LEVEL = Utils.Slot.playerInventory[this.ITEM_ID];
         if(this.LEVEL != this.OLD_LEVEL)
         {
            this.OLD_LEVEL = this.LEVEL;
            this.initSprites();
         }
         stateMachine.setState("IS_TARGETING_HERO_STATE");
         this.setParams();
         this.setVisible();
      }
      
      protected function setParams() : void
      {
      }
      
      protected function getWaterType() : void
      {
         var i:int = 0;
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is WaterCollision)
               {
                  this.WATER_TYPE = WaterCollision(level.collisionsManager.collisions[i]).type;
                  return;
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos + this.offset_y - camera.yPos));
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               sprite.gfxHandle().scaleX = -1;
            }
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
         var isInsideObstacle:Boolean = false;
         this.topSprite.visible = true;
         this.topSprite.alpha = 0.25;
         this.topSprite.gfxHandle().gotoAndStop(sprite.gfxHandle().frame);
         this.topSprite.gfxHandle().gfxHandleClip().gotoAndStop(sprite.gfxHandle().gfxHandleClip().currentFrame + 1);
         this.topSprite.x = sprite.x;
         this.topSprite.y = sprite.y;
         this.topSprite.gfxHandle().scaleX = sprite.gfxHandle().scaleX;
         this.topSprite.updateScreenPosition();
      }
      
      public function shake() : void
      {
      }
      
      public function setVisible() : void
      {
         sprite.visible = true;
         this.topSprite.visible = true;
      }
      
      public function setInvisible() : void
      {
         sprite.visible = false;
         this.topSprite.visible = false;
      }
      
      protected function flyAway() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         if(level.hero.DIRECTION == RIGHT)
         {
            dest_x = level.hero.xPos + 8 + Utils.TILE_WIDTH * 3;
         }
         else
         {
            dest_x = level.hero.xPos - 8 + Utils.TILE_WIDTH * 3;
         }
         dest_y = level.hero.yPos - Utils.HEIGHT;
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         if(dist_perc <= 0.1)
         {
            dist_perc = 0;
         }
         angle = this.getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function getAngle(x1:Number, y1:Number, x2:Number, y2:Number) : Number
      {
         var dx:Number = x2 - x1;
         var dy:Number = y2 - y1;
         return Math.atan2(dy,dx);
      }
      
      public function setDisappear() : void
      {
         SoundSystem.PlaySound("item_pop");
         level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos,yPos,0,0,0);
         this.setInvisible();
      }
   }
}
