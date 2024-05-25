package interfaces.map.particles
{
   import game_utils.GameSlot;
   import interfaces.map.*;
   import sprites.GameSprite;
   import sprites.map.MapStarParticleSprite;
   import sprites.map.MapWoodParticleSprite;
   import sprites.map.MapYellowSparkleParticleSprite;
   import sprites.map.RainMapParticleSprite;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class MapParticlesManager
   {
       
      
      public var particles:Array;
      
      public var lastUsedParticle:int;
      
      public var particlesAmount:int;
      
      public var worldMap:WorldMap;
      
      public var container:Sprite;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      public function MapParticlesManager(_worldMap:WorldMap, _container:Sprite)
      {
         var i:int = 0;
         super();
         this.worldMap = _worldMap;
         this.container = _container;
         this.particles = new Array();
         this.particlesAmount = 256;
         this.lastUsedParticle = 0;
         this.counter1 = this.counter2 = 0;
         for(i = 0; i < this.particlesAmount; i++)
         {
            this.particles.push(new MapParticle(this.worldMap,this.container,0,0,0,0,0));
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.particles.length; i++)
         {
            this.particles[i].destroy();
            this.particles[i] = null;
         }
         this.particles = null;
         this.container = null;
         this.worldMap = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            if(this.counter1++ > 10)
            {
               this.counter1 = 0;
               this.pushParticle(new RainMapParticleSprite(),64 + Math.random() * 160,48 + Math.random() * 32,-2,4,1);
            }
         }
         for(i = 0; i < this.particlesAmount; i++)
         {
            if(this.particles[i].sprite != null)
            {
               this.particles[i].update();
               if(this.particles[i].dead)
               {
                  this.particles[i].removeSprite();
               }
            }
         }
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.particlesAmount; i++)
         {
            if(this.particles[i].sprite != null)
            {
               this.particles[i].updateScreenPosition(mapCamera);
            }
         }
      }
      
      public function pushParticle(sprite:DisplayObject, xPos:Number, yPos:Number, xVel:Number, yVel:Number, friction:Number, foo1:Number = 0, foo2:Number = 0, foo3:Number = 0, foo4:Number = 0) : MapParticle
      {
         var i:int = 0;
         do
         {
            i = this.lastUsedParticle++ % this.particlesAmount;
            if(this.lastUsedParticle >= this.particlesAmount)
            {
               this.lastUsedParticle = 0;
            }
         }
         while(false);
         
         this.particles[i].assignNewValues(sprite,xPos,yPos,xVel,yVel,friction,foo1,foo2,foo3,foo4);
         return this.particles[i];
      }
      
      public function crateExplosion(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var x_vel:Number = NaN;
         var y_vel:Number = NaN;
         for(i = 0; i < 4; i++)
         {
            pSprite = new MapWoodParticleSprite();
            if(i > 1)
            {
               pSprite.scaleX = -1;
            }
            if(i == 0)
            {
               this.pushParticle(pSprite,_xPos + 4,_yPos - 4,1,-2,0.98,30);
            }
            else if(i == 1)
            {
               this.pushParticle(pSprite,_xPos + 4,_yPos + 4,1,-1,0.98,30);
            }
            else if(i == 2)
            {
               this.pushParticle(pSprite,_xPos - 4,_yPos - 4,-1,-2,0.98,30);
            }
            else
            {
               this.pushParticle(pSprite,_xPos - 4,_yPos + 4,-1,-1,0.98,30);
            }
         }
      }
      
      public function createStars(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var amount:int = 8;
         var step:Number = Math.PI * 2 / amount;
         for(i = 0; i < amount; i++)
         {
            this.pushParticle(new MapStarParticleSprite(),_xPos,_yPos,0,0,0,step * i);
         }
      }
      
      public function itemSparkles(color:String, xPos:Number, yPos:Number, WIDTH:Number) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var step:Number = NaN;
         var speed:Number = NaN;
         var amount:int = 0;
         var index:int = 0;
         var _pSprite:GameSprite = null;
         var time:int = 0;
         var angle:Number = 0;
         var frame_offset:int = 0;
         amount = 4;
         if(WIDTH < 0)
         {
            amount = 2;
         }
         else if(WIDTH >= 24)
         {
            amount = int(WIDTH / 4);
         }
         step = Math.PI * 2 / amount;
         for(i = 0; i < amount; i++)
         {
            if(i % 2 == 0)
            {
               index = 1 + frame_offset;
               if(color == "yellow")
               {
                  _pSprite = new MapYellowSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               time = 15;
            }
            else
            {
               index = 2 + frame_offset;
               if(color == "yellow")
               {
                  _pSprite = new MapYellowSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               time = 10;
            }
            angle = i * step + Math.random() * step;
            speed = 8;
            this.pushParticle(_pSprite,xPos,yPos,Math.sin(angle) * speed,Math.cos(angle) * speed,0.7,time);
         }
      }
   }
}
