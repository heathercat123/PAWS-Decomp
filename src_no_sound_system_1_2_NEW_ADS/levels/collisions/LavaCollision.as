package levels.collisions
{
   import entities.enemies.GiantEyeEnemy;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.particles.LavaSurfaceBubbleParticleSprite;
   import sprites.particles.SplashLavaParticleSprite;
   import sprites.tutorials.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class LavaCollision extends Collision
   {
       
      
      public var container:Sprite;
      
      public var _sprites:Array;
      
      public var _bubbleSprites:Array;
      
      public var _bottomBubbleSprites:Array;
      
      public var _bottom2BubbleSprites:Array;
      
      public var _bottom3BubbleSprites:Array;
      
      protected var last_shift_x:int;
      
      protected var shift_x:int;
      
      protected var back_tile:Image;
      
      protected var sinCounter1:Number;
      
      protected var bubbleCounter:int;
      
      public function LavaCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         var i:int = 0;
         var j:int = 0;
         var amount:int = 0;
         var wSprite:LavaCollisionSprite = null;
         var lSprite:LavaBubblesCollisionSprite = null;
         _xPos = 0;
         super(_level,_xPos,_yPos);
         sprite = null;
         this.container = new Sprite();
         Utils.IS_LAVA = true;
         this.sinCounter1 = 0;
         this.bubbleCounter = int(Math.random() * 4) * 60;
         this._sprites = new Array();
         this._bubbleSprites = new Array();
         this._bottomBubbleSprites = new Array();
         this._bottom2BubbleSprites = new Array();
         this._bottom3BubbleSprites = new Array();
         amount = Utils.WIDTH / 32 + 2;
         for(i = 0; i < amount; i++)
         {
            lSprite = new LavaBubblesCollisionSprite();
            lSprite.x = i * 32;
            lSprite.y = 8;
            this.container.addChild(lSprite);
            this._bubbleSprites.push(lSprite);
            lSprite = new LavaBubblesCollisionSprite();
            lSprite.x = i * 32;
            lSprite.y = 8 + 32;
            this.container.addChild(lSprite);
            this._bottomBubbleSprites.push(lSprite);
            lSprite = new LavaBubblesCollisionSprite();
            lSprite.x = i * 32;
            lSprite.y = 8 + 64;
            this.container.addChild(lSprite);
            this._bottom2BubbleSprites.push(lSprite);
            lSprite = new LavaBubblesCollisionSprite();
            lSprite.x = i * 32;
            lSprite.y = 8 + 96;
            this.container.addChild(lSprite);
            this._bottom3BubbleSprites.push(lSprite);
            wSprite = new LavaCollisionSprite();
            wSprite.x = i * 32;
            wSprite.y = 0;
            this.container.addChild(wSprite);
            this._sprites.push(wSprite);
         }
         Utils.topWorld.addChild(this.container);
         this.last_shift_x = this.shift_x = 0;
         this.back_tile = new Image(TextureManager.sTextureAtlas.getTexture("lava_tile_7"));
         Utils.backWorld.addChild(this.back_tile);
         Utils.SEA_LEVEL = yPos;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.backWorld.removeChild(this.back_tile);
         this.back_tile.dispose();
         this.back_tile = null;
         for(i = 0; i < this._sprites.length; i++)
         {
            this.container.removeChild(this._sprites[i]);
            this._sprites[i].destroy();
            this._sprites[i].dispose();
            this._sprites[i] = null;
         }
         for(i = 0; i < this._bottomBubbleSprites.length; i++)
         {
            this.container.removeChild(this._bottomBubbleSprites[i]);
            this.container.removeChild(this._bottom2BubbleSprites[i]);
            this.container.removeChild(this._bottom3BubbleSprites[i]);
            this._bottomBubbleSprites[i].destroy();
            this._bottom2BubbleSprites[i].destroy();
            this._bottom3BubbleSprites[i].destroy();
            this._bottomBubbleSprites[i].dispose();
            this._bottom2BubbleSprites[i].dispose();
            this._bottom3BubbleSprites[i].dispose();
            this._bottomBubbleSprites[i] = null;
            this._bottom2BubbleSprites[i] = null;
            this._bottom3BubbleSprites[i] = null;
         }
         this._bottomBubbleSprites = null;
         this._bottom2BubbleSprites = null;
         this._bottom3BubbleSprites = null;
         this._sprites = null;
         Utils.topWorld.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         this.sinCounter1 += 0.015;
         if(this.sinCounter1 >= Math.PI * 2)
         {
            this.sinCounter1 -= Math.PI * 2;
         }
         var shift:int = int(Math.floor(Math.sin(this.sinCounter1) * 8));
         Utils.SEA_X_SHIFT = shift;
         xPos = originalXPos + shift;
         if(yPos <= level.camera.yPos + level.camera.HEIGHT)
         {
            if(this.bubbleCounter-- < 0)
            {
               this.bubbleCounter = (int(Math.random() * 3) + 0.5) * 60;
               level.topParticlesManager.pushParticle(new LavaSurfaceBubbleParticleSprite(),level.camera.xPos + Math.random() * level.camera.WIDTH,Utils.SEA_LEVEL,0,0,0);
               this.setOnTop();
            }
         }
      }
      
      public function setOnTop() : void
      {
         var i:int = 0;
         var enemy:GiantEyeEnemy = null;
         Utils.topWorld.setChildIndex(this.container,Utils.topWorld.numChildren - 1);
         if(Utils.CurrentLevel == 48)
         {
            for(i = 0; i < level.enemiesManager.enemies.length; i++)
            {
               if(level.enemiesManager.enemies[i] != null)
               {
                  if(level.enemiesManager.enemies[i] is GiantEyeEnemy)
                  {
                     enemy = level.enemiesManager.enemies[i] as GiantEyeEnemy;
                     Utils.topWorld.setChildIndex(enemy.container,Utils.topWorld.numChildren - 1);
                  }
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(level.hero.IS_IN_WATER)
         {
            if(level.hero.yPos + level.hero.HEIGHT * 0.5 < yPos - 4)
            {
               level.hero.setOutsideWater();
               if(level.hero.IS_IN_WATER == false)
               {
                  level.particlesManager.pushParticle(new SplashLavaParticleSprite(),level.hero.xPos + level.hero.WIDTH * 0.5,yPos,0,0,0);
               }
            }
            else
            {
               level.hero.hurt(level.hero.xPos + level.hero.WIDTH * 0.5,level.hero.yPos + level.hero.HEIGHT,null);
            }
         }
         else if(level.hero.yPos + level.hero.HEIGHT * 0.5 > yPos + 4)
         {
            if(level.hero.stunHandler.IS_STUNNED)
            {
               level.hero.setInsideWater();
               level.particlesManager.pushParticle(new SplashLavaParticleSprite(),level.hero.xPos + level.hero.WIDTH * 0.5,yPos,0,0,0);
               level.hero.hurt(level.hero.xPos + level.hero.WIDTH * 0.5,level.hero.yPos + level.hero.HEIGHT,null);
            }
            else
            {
               level.hero.hurt(level.hero.xPos + level.hero.WIDTH * 0.5,level.hero.yPos + level.hero.HEIGHT,null);
               level.hero.setInsideWater();
               level.particlesManager.pushParticle(new SplashLavaParticleSprite(),level.hero.xPos + level.hero.WIDTH * 0.5,yPos,0,0,0);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var min_value:int = 0;
         var max_value:int = 0;
         var j:int = 0;
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
               this._bubbleSprites[min_index].x = this._sprites[min_index].x;
            }
            else
            {
               this._sprites[max_index].x = this._sprites[min_index].x - 32;
               this._bubbleSprites[max_index].x = this._sprites[min_index].x - 32;
            }
            for(j = 0; j < this._bottomBubbleSprites.length; j++)
            {
               this._bottomBubbleSprites[j].x = this._bubbleSprites[j].x;
               this._bottomBubbleSprites[j].y = this._bubbleSprites[j].y + 32;
            }
            for(j = 0; j < this._bottom2BubbleSprites.length; j++)
            {
               this._bottom2BubbleSprites[j].x = this._bubbleSprites[j].x;
               this._bottom2BubbleSprites[j].y = this._bubbleSprites[j].y + 64;
            }
            for(j = 0; j < this._bottom3BubbleSprites.length; j++)
            {
               this._bottom3BubbleSprites[j].x = this._bubbleSprites[j].x;
               this._bottom3BubbleSprites[j].y = this._bubbleSprites[j].y + 96;
            }
         }
         this.last_shift_x = this.shift_x;
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
         for(i = 0; i < this._sprites.length; i++)
         {
            this._sprites[i].updateScreenPosition();
         }
         for(i = 0; i < this._bubbleSprites.length; i++)
         {
            this._bubbleSprites[i].updateScreenPosition();
         }
         for(i = 0; i < this._bottomBubbleSprites.length; i++)
         {
            this._bottomBubbleSprites[i].updateScreenPosition();
         }
         for(i = 0; i < this._bottom2BubbleSprites.length; i++)
         {
            this._bottom2BubbleSprites[i].updateScreenPosition();
         }
         for(i = 0; i < this._bottom3BubbleSprites.length; i++)
         {
            this._bottom3BubbleSprites[i].updateScreenPosition();
         }
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
