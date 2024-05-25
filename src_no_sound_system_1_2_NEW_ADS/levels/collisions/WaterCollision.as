package levels.collisions
{
   import entities.bullets.Bullet;
   import entities.enemies.Enemy;
   import flash.geom.*;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.particles.*;
   import sprites.tutorials.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class WaterCollision extends Collision
   {
       
      
      public var container:Sprite;
      
      public var _sprites:Array;
      
      protected var last_shift_x:int;
      
      protected var shift_x:int;
      
      protected var back_tile:Image;
      
      protected var sinCounter1:Number;
      
      protected var bubbleCounter:int;
      
      protected var post_init_update:int;
      
      public var scrollValue:Number;
      
      public var type:int;
      
      public function WaterCollision(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0)
      {
         var i:int = 0;
         var amount:int = 0;
         var wSprite:WaterCollisionSprite = null;
         _xPos = 0;
         super(_level,_xPos,_yPos);
         this.type = _type;
         this.post_init_update = 0;
         sprite = null;
         this.container = new Sprite();
         this.scrollValue = 0;
         this.sinCounter1 = 0;
         this.bubbleCounter = int(Math.random() * 4) * 60;
         this._sprites = new Array();
         amount = int(Math.ceil(Utils.WIDTH / 32)) + 3;
         for(i = 0; i < amount; i++)
         {
            wSprite = new WaterCollisionSprite();
            wSprite.x = i * 32;
            wSprite.y = 0;
            this.container.addChild(wSprite);
            this._sprites.push(wSprite);
         }
         Utils.topWorld.addChild(this.container);
         this.last_shift_x = this.shift_x = 0;
         if(level.getBackgroundId() == BackgroundsManager.UNDERWATER)
         {
            this.back_tile = null;
         }
         else
         {
            if(this.type == 0)
            {
               this.back_tile = new Image(TextureManager.sTextureAtlas.getTexture("water_tile_5"));
            }
            else
            {
               this.back_tile = new Image(TextureManager.sTextureAtlas.getTexture("water_tile_35"));
            }
            Utils.backWorld.addChild(this.back_tile);
         }
         Utils.SEA_LEVEL = yPos;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.back_tile != null)
         {
            Utils.backWorld.removeChild(this.back_tile);
            this.back_tile.dispose();
            this.back_tile = null;
         }
         for(i = 0; i < this._sprites.length; i++)
         {
            this.container.removeChild(this._sprites[i]);
            this._sprites[i].destroy();
            this._sprites[i].dispose();
            this._sprites[i] = null;
         }
         this._sprites = null;
         Utils.topWorld.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         if(this.post_init_update > -1)
         {
            ++this.post_init_update;
            if(this.post_init_update == 3)
            {
               this.post_init_update = -1;
               xPos = originalXPos = level.camera.xPos - 64;
            }
         }
         this.sinCounter1 += 0.015;
         if(this.sinCounter1 >= Math.PI * 2)
         {
            this.sinCounter1 -= Math.PI * 2;
         }
         var shift:int = int(Math.floor(Math.sin(this.sinCounter1) * 16));
         Utils.SEA_X_SHIFT = shift;
         xPos = originalXPos + shift + this.scrollValue;
         if(yPos <= level.camera.yPos + level.camera.HEIGHT)
         {
            if(this.bubbleCounter-- < 0)
            {
               this.bubbleCounter = (int(Math.random() * 3) + 0.5) * 60;
               level.topParticlesManager.createClusterBubbles(level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.y + level.camera.HEIGHT + 4);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         var bullet:Bullet = null;
         var enemy:Enemy = null;
         if(level.hero.IS_IN_WATER)
         {
            if(level.hero.yPos + level.hero.HEIGHT * 0.5 < yPos - 4)
            {
               level.hero.setOutsideWater();
               if(level.hero.IS_IN_WATER == false)
               {
                  level.particlesManager.pushParticle(new SplashParticleSprite(this.type),level.hero.xPos + level.hero.WIDTH * 0.5,yPos,0,0,0);
               }
            }
         }
         else if(level.hero.yPos + level.hero.HEIGHT * 0.5 > yPos + 4)
         {
            level.hero.setInsideWater();
            level.particlesManager.pushParticle(new SplashParticleSprite(this.type),level.hero.xPos + level.hero.WIDTH * 0.5,yPos,0,0,0);
         }
         for(i = 0; i < level.bulletsManager.bullets.length; i++)
         {
            if(level.bulletsManager.bullets[i].sprite != null)
            {
               bullet = level.bulletsManager.bullets[i];
               if(Math.abs(bullet.oldYPos - bullet.yPos) < 16)
               {
                  if(int(bullet.oldYPos + bullet.HEIGHT * 0.5) < yPos && int(bullet.yPos + bullet.HEIGHT * 0.5) >= yPos)
                  {
                     SoundSystem.PlaySound("water_splash");
                     level.particlesManager.pushParticle(new SplashParticleSprite(this.type),bullet.xPos,yPos,0,0,0);
                  }
                  else if(int(bullet.oldYPos - bullet.HEIGHT * 0.5) >= yPos && int(bullet.yPos - bullet.HEIGHT * 0.5) < yPos)
                  {
                     SoundSystem.PlaySound("water_splash");
                     level.particlesManager.pushParticle(new SplashParticleSprite(this.type),bullet.xPos,yPos,0,0,0);
                  }
               }
            }
         }
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               enemy = level.enemiesManager.enemies[i];
               if(Math.abs(enemy.oldYPos - enemy.yPos) < 16 && enemy.isWaterAllowed())
               {
                  if(enemy.oldYPos + enemy.HEIGHT < yPos && enemy.yPos + enemy.HEIGHT >= yPos)
                  {
                     if(enemy.WIDTH < 32)
                     {
                        level.particlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos(),yPos,0,0,0);
                        if(enemy.isInsideInnerScreen())
                        {
                           SoundSystem.PlaySound("water_splash");
                        }
                     }
                     else
                     {
                        level.topParticlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos() + 24,yPos,0,0,0);
                        level.topParticlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos(),yPos,0,0,0);
                        level.topParticlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos() - 24,yPos,0,0,0);
                        if(enemy.isInsideInnerScreen())
                        {
                           SoundSystem.PlaySound("water_splash_low");
                        }
                     }
                  }
                  else if(enemy.oldYPos >= yPos && enemy.yPos < yPos)
                  {
                     if(enemy.WIDTH < 32)
                     {
                        if(enemy.isInsideInnerScreen())
                        {
                           SoundSystem.PlaySound("water_splash");
                        }
                        level.particlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos(),yPos,0,0,0);
                     }
                     else
                     {
                        level.topParticlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos() + 24,yPos,0,0,0);
                        level.topParticlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos(),yPos,0,0,0);
                        level.topParticlesManager.pushParticle(new SplashParticleSprite(this.type),enemy.getMidXPos() - 24,yPos,0,0,0);
                        if(enemy.isInsideInnerScreen())
                        {
                           SoundSystem.PlaySound("water_splash_low");
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var min_value:int = 0;
         var max_value:int = 0;
         var min_index:int = 0;
         var max_index:int = 0;
         this.shift_x = int((xPos - camera.xPos) / 32);
         if(this.shift_x != this.last_shift_x)
         {
            min_value = 9999 * 9999;
            max_value = -9999 * 9999;
            for(i = 0; i < this._sprites.length; i++)
            {
               if(this._sprites[i].x < min_value)
               {
                  min_index = i;
                  min_value = int(this._sprites[i].x);
               }
               if(this._sprites[i].x > max_value)
               {
                  max_index = i;
                  max_value = int(this._sprites[i].x);
               }
            }
            if(this.shift_x < this.last_shift_x)
            {
               this._sprites[min_index].x = this._sprites[max_index].x + 32;
            }
            else
            {
               this._sprites[max_index].x = this._sprites[min_index].x - 32;
            }
         }
         this.last_shift_x = this.shift_x;
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
         Utils.topWorld.setChildIndex(this.container,Utils.topWorld.numChildren - 1);
         for(i = 0; i < this._sprites.length; i++)
         {
            this._sprites[i].updateScreenPosition();
         }
         if(this.back_tile != null)
         {
            this.back_tile.x = 0;
            this.back_tile.y = int(Math.floor(yPos - camera.yPos));
            this.back_tile.width = level.camera.WIDTH + 1;
            if(level.camera.HEIGHT - (this.back_tile.y - camera.yPos) < 0)
            {
               this.back_tile.height = 1;
               this.back_tile.visible = false;
            }
            else
            {
               this.back_tile.height = level.camera.HEIGHT - (this.back_tile.y - camera.yPos) + 8;
               this.back_tile.visible = true;
            }
            Utils.backWorld.setChildIndex(this.back_tile,0);
         }
      }
   }
}
