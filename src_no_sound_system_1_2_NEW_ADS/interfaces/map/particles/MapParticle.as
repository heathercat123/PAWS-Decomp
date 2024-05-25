package interfaces.map.particles
{
   import entities.Entity;
   import interfaces.map.MapCamera;
   import interfaces.map.WorldMap;
   import sprites.GameSprite;
   import sprites.map.LavaWaveMapParticleSprite;
   import sprites.map.MapButtonAppearingParticleSprite;
   import sprites.map.MapExplosionParticleSprite;
   import sprites.map.MapSandParticleSprite;
   import sprites.map.MapSmallWhiteExplosionParticleSprite;
   import sprites.map.MapStarParticleSprite;
   import sprites.map.MapWoodParticleSprite;
   import sprites.map.MapYellowSparkleParticleSprite;
   import sprites.map.RainMapParticleSprite;
   import sprites.map.SmokeMapParticleSprite;
   import sprites.map.WaveMapParticleSprite;
   import starling.display.Sprite;
   
   public class MapParticle
   {
      
      public static var RAIN:int = 0;
       
      
      public var worldMap:WorldMap;
      
      public var container:Sprite;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var originalXPos:Number;
      
      public var originalYPos:Number;
      
      public var xVel:Number;
      
      public var yVel:Number;
      
      public var friction:Number;
      
      public var sprite:GameSprite;
      
      public var entity:Entity;
      
      public var dead:Boolean;
      
      public var foo1:*;
      
      public var foo2:*;
      
      public var foo3:*;
      
      public var foo4:Number;
      
      public var counter1:*;
      
      public var counter2:*;
      
      public var counter3:int;
      
      public function MapParticle(_worldMap:WorldMap, _container:Sprite, _xPos:Number, _yPos:Number, _xVel:Number, _yVel:Number, _friction:Number)
      {
         super();
         this.worldMap = _worldMap;
         this.container = _container;
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.xVel = _xVel;
         this.yVel = _yVel;
         this.foo1 = this.foo2 = this.foo3 = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.sprite = null;
      }
      
      public function destroy() : void
      {
         this.removeSprite();
         this.container = null;
         this.worldMap = null;
         this.entity = null;
      }
      
      public function update() : void
      {
         this.xVel *= this.friction;
         this.yVel *= this.friction;
         this.xPos += this.xVel;
         this.yPos += this.yVel;
         if(this.sprite is SmokeMapParticleSprite)
         {
            if(this.foo1 == 1)
            {
               this.foo2 += 0.075;
               this.originalXPos += this.xVel;
               this.yPos += this.yVel;
               this.xPos = this.originalXPos + Math.sin(this.foo2) * 4;
               if(this.counter1++ > 30)
               {
                  if(this.counter2++ > 2)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                     if(this.counter3 > 10)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
            else if(this.counter1++ > 2)
            {
               this.sprite.visible = !this.sprite.visible;
               ++this.counter2;
               if(this.counter2 > 10)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is RainMapParticleSprite)
         {
            if(this.yPos >= 160)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is MapExplosionParticleSprite || this.sprite is MapButtonAppearingParticleSprite || this.sprite is WaveMapParticleSprite || this.sprite is LavaWaveMapParticleSprite || this.sprite is MapSmallWhiteExplosionParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is MapStarParticleSprite)
         {
            this.foo1 -= 0.1;
            this.foo2 += 2;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * this.foo2;
            this.yPos = this.originalYPos + Math.cos(this.foo1) * this.foo2;
         }
         else if(this.sprite is MapYellowSparkleParticleSprite)
         {
            --this.foo1;
            if(this.foo1 <= 0)
            {
               ++this.counter1;
               if(this.counter1 >= 3)
               {
                  this.counter1 = 0;
                  ++this.counter2;
                  this.sprite.visible = !this.sprite.visible;
                  if(this.counter2 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is MapWoodParticleSprite)
         {
            if(this.counter3++ > 15)
            {
               this.yVel += 0.1;
            }
            --this.foo1;
            if(this.foo1 <= 0)
            {
               ++this.counter1;
               if(this.counter1 >= 3)
               {
                  this.counter1 = 0;
                  ++this.counter2;
                  this.sprite.visible = !this.sprite.visible;
                  if(this.counter2 >= 3)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is MapSandParticleSprite)
         {
            this.foo1 += 0.1;
            this.yPos = this.originalYPos + Math.sin(this.foo1) * 4;
            if(this.xPos < 700)
            {
               --this.foo2;
               if(this.foo2 < 0)
               {
                  ++this.counter1;
                  if(this.counter1 >= 3)
                  {
                     this.counter1 = 0;
                     ++this.counter2;
                     this.sprite.visible = !this.sprite.visible;
                     if(this.counter2 >= 3)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
         }
      }
      
      public function updateScreenPosition(camera:MapCamera) : void
      {
         this.sprite.x = int(Math.floor(this.xPos - camera.xPos));
         this.sprite.y = int(Math.floor(this.yPos - camera.yPos));
         this.sprite.updateScreenPosition();
      }
      
      public function assignNewValues(_sprite:GameSprite, _xPos:Number, _yPos:Number, _xVel:Number, _yVel:Number, _friction:Number, _foo1:Number = 0, _foo2:Number = 0, _foo3:Number = 0, _foo4:Number = 0) : void
      {
         this.removeSprite();
         this.sprite = _sprite;
         this.container.addChild(this.sprite);
         this.foo1 = _foo1;
         this.foo2 = _foo2;
         this.foo3 = _foo3;
         this.foo4 = _foo4;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.xPos = this.originalXPos = _xPos;
         this.yPos = this.originalYPos = _yPos;
         this.xVel = _xVel;
         this.yVel = _yVel;
         this.friction = _friction;
         this.dead = false;
         this.entity = null;
      }
      
      public function removeSprite() : void
      {
         if(this.sprite != null)
         {
            this.container.removeChild(this.sprite);
            this.sprite.destroy();
            this.sprite.dispose();
            this.sprite = null;
         }
      }
   }
}
