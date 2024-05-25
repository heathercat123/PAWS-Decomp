package entities.particles
{
   import entities.Entity;
   import entities.Hero;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.Collision;
   import sprites.*;
   import sprites.items.BellItemSprite;
   import sprites.items.CoinItemSprite;
   import sprites.items.KeyItemSprite;
   import sprites.particles.*;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ParticlesManager
   {
      
      public static var GLOBAL_VARIABLE_1:Number;
      
      public static var GLOBAL_VARIABLE_2:Number;
      
      public static var GLOBAL_VARIABLE_3:Number;
       
      
      public var particles:Array;
      
      public var lastUsedParticle:int;
      
      public var particlesAmount:int;
      
      public var level:Level;
      
      public var container:Sprite;
      
      protected var brick_explosion_dir:Boolean;
      
      public function ParticlesManager(_level:Level, _container:Sprite)
      {
         var i:int = 0;
         super();
         this.level = _level;
         this.container = _container;
         this.brick_explosion_dir = true;
         this.particles = new Array();
         this.particlesAmount = 256;
         this.lastUsedParticle = 0;
         GLOBAL_VARIABLE_1 = GLOBAL_VARIABLE_2 = GLOBAL_VARIABLE_3 = 1;
         for(i = 0; i < this.particlesAmount; i++)
         {
            this.particles.push(new Particle(this.level,this.container,0,0,0,0,0));
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.particlesAmount; i++)
         {
            if(this.particles[i] != null)
            {
               this.particles[i].destroy();
               this.particles[i] = null;
            }
         }
         this.particles = null;
         this.container = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
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
      
      public function updateFreeze() : void
      {
         var i:int = 0;
         for(i = 0; i < this.particlesAmount; i++)
         {
            if(this.particles[i].sprite != null)
            {
               this.particles[i].updateFreeze();
               if(this.particles[i].dead)
               {
                  this.particles[i].removeSprite();
               }
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.particlesAmount; i++)
         {
            if(this.particles[i].sprite != null)
            {
               this.particles[i].updateScreenPosition(camera);
            }
         }
      }
      
      public function updatePostScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.particlesAmount; i++)
         {
            if(this.particles[i].sprite != null)
            {
               Particle(this.particles[i]).updatePostScreenPosition(camera);
            }
         }
      }
      
      public function pushParticle(sprite:DisplayObject, xPos:Number, yPos:Number, xVel:Number, yVel:Number, friction:Number, foo1:Number = 0, foo2:Number = 0, foo3:Number = 0, foo4:Number = 0) : Particle
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
      
      public function pushBackParticle(sprite:DisplayObject, xPos:Number, yPos:Number, xVel:Number, yVel:Number, friction:Number, foo1:Number = 0, foo2:Number = 0, foo3:Number = 0, foo4:Number = 0) : Particle
      {
         var particle:Particle = this.pushParticle(sprite,xPos,yPos,xVel,yVel,friction,foo1,foo2,foo3,foo4);
         if(particle != null)
         {
            this.container.setChildIndex(particle.sprite,0);
         }
         return particle;
      }
      
      public function screwsParticles(xPos:Number, yPos:Number, amount:int) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var angle:Number = NaN;
         var power:Number = NaN;
         for(i = 0; i < amount; i++)
         {
            if(i % 2 == 0)
            {
               pSprite = new MetalNutParticleSprite();
            }
            else
            {
               pSprite = new MetalBoltParticleSprite();
            }
            pSprite.gfxHandleClip().gotoAndPlay(int(Math.random() * pSprite.gfxHandleClip().numFrames));
            angle = Math.random() * Math.PI * 2;
            power = Math.random() + 1;
            if(Math.sin(angle) < 0)
            {
               pSprite.scaleX = -1;
            }
            this.level.particlesManager.pushParticle(pSprite,xPos + Math.sin(angle) * power,yPos + Math.cos(angle) * power,Math.sin(angle) * power,Math.cos(angle) * power,0.98,int(5 + Math.random() * 15));
         }
      }
      
      public function createBubbleParticles(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var radius:int = 0;
         var start_angle:Number = Math.random() * Math.PI * 2;
         var step_angle:Number = Math.PI * 2 / 3;
         for(i = 0; i < 3; i++)
         {
            radius = 16 + int(Math.random() * 3) * 4;
            this.createClusterBubbles(_xPos + Math.sin(start_angle + step_angle * i) * radius,_yPos + Math.cos(start_angle + step_angle * i) * radius);
         }
      }
      
      public function createWaterCannonImpactParticle(xPos:Number, yPos:Number, _xVel:Number) : void
      {
         var pSprite:GenericParticleSprite = new GenericParticleSprite(GenericParticleSprite.WATER_CANNON_IMPACT);
         if(_xVel > 0)
         {
            pSprite.scaleX = -1;
         }
         this.pushParticle(pSprite,xPos,yPos,0,0,0);
      }
      
      public function createSnowParticles(xPos:Number, yPos:Number) : void
      {
         var pSprite:SnowParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         var vel:Number = NaN;
         var power:Number = NaN;
         var _vel:Number = 1.25;
         if(this.level.hero.xVel < 0)
         {
            _vel = -1.25;
         }
         var max:int = 3;
         if(Math.random() * 100 > 80)
         {
            max = 4;
         }
         for(i = 0; i < max; i++)
         {
            pSprite = new SnowParticleSprite();
            angle = Math.PI * 0.5 + Math.random() * Math.PI;
            power = 2 + Math.random() * 2;
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            vel = -Math.random() * 2 + 4;
            this.level.particlesManager.pushParticle(pSprite,xPos,yPos,Math.sin(angle) * power,Math.cos(angle) * power,0.98 + Math.random() * 0.02,(int(Math.random() * 2) + (i + 1)) * 0.1);
         }
      }
      
      public function snowParticlesEntity(entity:Entity) : void
      {
         var pSprite:GameSprite = new SnowParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         this.level.particlesManager.pushParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos + entity.HEIGHT,0.5 + Math.random() * 2,-(2 + Math.random() * 1),0.98,0.5);
         pSprite = new SnowParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         this.level.particlesManager.pushParticle(pSprite,entity.xPos,entity.yPos + entity.HEIGHT,-(0.5 + Math.random() * 2),-(2 + Math.random() * 1),0.98,0.5);
      }
      
      public function createEnemyHurtStars(xPos:Number, yPos:Number, isGiantEnemy:Boolean = false) : void
      {
         var i:int = 0;
         var amount:int = 0;
         var delay:int = 0;
         var life:int = 0;
         var start_angle:Number = NaN;
         var step:Number = NaN;
         var force:Number = NaN;
         var radius:Number = NaN;
         var pSprite:EnemyHurtStarParticleSprite = null;
         var pParticle:Particle = null;
         if(Math.random() * 100 > 50)
         {
            amount = 3;
         }
         else
         {
            amount = 2;
         }
         start_angle = Math.random() * Math.PI * 2;
         step = Math.PI * 2 / amount;
         for(i = 0; i < amount; i++)
         {
            force = 2 + Math.random() * 2;
            delay = 1 + int(Math.random() * 4) * 6;
            life = int(Math.random() * 10 + 5);
            pSprite = new EnemyHurtStarParticleSprite();
            pSprite.visible = false;
            radius = 8 + Math.random() * 8;
            if(isGiantEnemy)
            {
               pParticle = this.pushBackParticle(pSprite,xPos + Math.sin(start_angle + step * i) * radius,yPos + Math.cos(start_angle + step * i) * radius,Math.sin(start_angle + step * i) * force,Math.cos(start_angle + step * i) * force,0.8,life,delay);
            }
            else
            {
               pParticle = this.pushBackParticle(pSprite,xPos,yPos,Math.sin(start_angle + step * i) * force,Math.cos(start_angle + step * i) * force,0.8,life,delay);
            }
            pParticle.DO_NOT_UPDATE = true;
         }
      }
      
      public function itemSparkles(color:String, xPos:Number, yPos:Number, WIDTH:Number, entity:Entity = null, _xOffset:Number = 0, _yOffset:Number = 0) : void
      {
         var i:int = 0;
         var pSprite:Image = null;
         var step:Number = NaN;
         var speed:Number = NaN;
         var amount:int = 0;
         var index:int = 0;
         var pParticle:Particle = null;
         var _pSprite:GameSprite = null;
         var time:int = 0;
         var angle:Number = 0;
         var frame_offset:int = 0;
         amount = 4;
         if(WIDTH < 0)
         {
            amount = 2;
         }
         step = Math.PI * 2 / amount;
         for(i = 0; i < amount; i++)
         {
            if(i % 2 == 0)
            {
               index = 1 + frame_offset;
               if(color == "yellow")
               {
                  _pSprite = new YellowSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               else if(color == "blue")
               {
                  _pSprite = new BlueSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               else
               {
                  _pSprite = new RedSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               time = 15;
            }
            else
            {
               index = 2 + frame_offset;
               if(color == "yellow")
               {
                  _pSprite = new YellowSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               else if(color == "blue")
               {
                  _pSprite = new BlueSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               else
               {
                  _pSprite = new RedSparkleParticleSprite();
                  _pSprite.gfxHandleClip().gotoAndStop(index);
               }
               time = 10;
            }
            angle = i * step + Math.random() * step;
            speed = 8;
            if(entity is Hero)
            {
               pParticle = this.pushBackParticle(_pSprite,xPos,yPos,Math.sin(angle) * speed,Math.cos(angle) * speed,0.7,time);
            }
            else
            {
               pParticle = this.pushParticle(_pSprite,xPos,yPos,Math.sin(angle) * speed,Math.cos(angle) * speed,0.7,time);
            }
            pParticle.originalXPos += _xOffset;
            pParticle.originalYPos += _yOffset;
            pParticle.setEntity(entity);
         }
      }
      
      public function hurtImpactParticle(entity:Entity, enemy_mid_x:Number, enemy_mid_y:Number) : void
      {
         var entity_mid_x:Number = entity.xPos + entity.WIDTH * 0.5;
         var entity_mid_y:Number = entity.yPos + entity.HEIGHT * 0.5;
         var radius:Number = (entity.WIDTH + entity.HEIGHT) * 0.25;
         var x_diff:Number = enemy_mid_x - entity_mid_x;
         var y_diff:Number = enemy_mid_y - entity_mid_y;
         var distance:Number = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
         x_diff /= distance;
         y_diff /= distance;
         this.pushParticle(new HurtImpactParticleSprite(),entity_mid_x + x_diff * radius,entity_mid_y + y_diff * radius,0,0,0);
      }
      
      public function shieldItemParticle(entity:Entity, enemy_mid_x:Number, enemy_mid_y:Number) : void
      {
         var particle:Particle = null;
         var entity_mid_x:Number = entity.xPos + entity.WIDTH * 0.5;
         var entity_mid_y:Number = entity.yPos + entity.HEIGHT * 0.5;
         var radius:Number = (entity.WIDTH + entity.HEIGHT) * 0.25;
         var x_diff:Number = enemy_mid_x - entity_mid_x;
         var y_diff:Number = enemy_mid_y - entity_mid_y;
         var distance:Number = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
         x_diff /= distance;
         y_diff /= distance;
         var pSprite:GameSprite = new ItemHeroParticleSprite();
         pSprite.gfxHandleClip().gotoAndStop(2);
         this.level.camera.shake(2);
         particle = this.pushParticle(pSprite,entity.WIDTH * 0.5 + x_diff * radius,entity.HEIGHT * 0.5 + y_diff * radius,0,0,0);
         particle.setEntity(entity);
      }
      
      public function airParticles(xPos:Number, yPos:Number, WIDTH:Number, DIRECTION:int = -1) : void
      {
         var pSprite:SmokeParticleSprite = new SmokeParticleSprite();
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(3);
         }
         if(DIRECTION == -1)
         {
            this.pushBackParticle(pSprite,xPos + WIDTH * 0.5,yPos,0,0,0.8,Math.random() * Math.PI * 2,-(Math.random() * 10 + 5),1);
         }
         else if(DIRECTION == Entity.LEFT)
         {
            this.pushParticle(pSprite,xPos - 4,yPos,0,0,0.8,Math.random() * Math.PI * 2,-(Math.random() * 10 + 5),3);
         }
         else
         {
            this.pushParticle(pSprite,xPos + 4,yPos,0,0,0.8,Math.random() * Math.PI * 2,-(Math.random() * 10 + 5),4);
         }
      }
      
      public function groundRedGooParticles(entity:Entity, _ENTITY_SIZE:int = 16, _SIDE:int = 0) : void
      {
         var angle:Number = NaN;
         var pSprite:RedGooDropParticleSprite = new RedGooDropParticleSprite();
         var x_vel_mult:Number = 1;
         var power:Number = 2.5;
         var dir:int = 0;
         if(_ENTITY_SIZE > 16)
         {
            power = 3;
         }
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndPlay(2);
         }
         if(entity.stateMachine.currentState == "IS_BRAKING_STATE")
         {
            x_vel_mult = 1.5;
            if(entity.DIRECTION == Entity.RIGHT)
            {
               dir = Entity.LEFT;
            }
            else
            {
               dir = Entity.RIGHT;
            }
         }
         else
         {
            dir = entity.DIRECTION;
         }
         if(dir == Entity.RIGHT)
         {
            angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,1);
         }
         else
         {
            angle = Math.PI * 0.5 + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,1);
         }
      }
      
      public function groundIceParticles(entity:Entity, _ENTITY_SIZE:int = 16, _SIDE:int = 0) : void
      {
         var angle:Number = NaN;
         var pSprite:IceGroundParticleSprite = new IceGroundParticleSprite();
         var x_vel_mult:Number = 1;
         var power:Number = 2.5;
         var dir:int = 0;
         if(_ENTITY_SIZE > 16)
         {
            power = 3;
         }
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndPlay(2);
         }
         if(entity.stateMachine.currentState == "IS_BRAKING_STATE")
         {
            x_vel_mult = 1.5;
            if(entity.DIRECTION == Entity.RIGHT)
            {
               dir = Entity.LEFT;
            }
            else
            {
               dir = Entity.RIGHT;
            }
         }
         else
         {
            dir = entity.DIRECTION;
         }
         if(dir == Entity.RIGHT)
         {
            angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,1);
         }
         else
         {
            angle = Math.PI * 0.5 + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,1);
         }
      }
      
      public function groundSmokeParticles(entity:Entity, _ENTITY_SIZE:int = 16, _SIDE:int = 0) : void
      {
         var angle:Number = NaN;
         var x_t:int = 0;
         var y_t:int = 0;
         var bottom_t_value:int = 0;
         var additionalYVel:Number = NaN;
         if(entity.IS_ON_ICE)
         {
            if(Utils.ICE_TYPE != 0)
            {
               if(Utils.ICE_TYPE == 1)
               {
                  this.groundRedGooParticles(entity,_ENTITY_SIZE,_SIDE);
               }
               else if(Utils.ICE_TYPE == 2)
               {
                  this.groundIceParticles(entity,_ENTITY_SIZE,_SIDE);
               }
            }
            return;
         }
         var pSprite:SmokeParticleSprite = new SmokeParticleSprite();
         var x_vel_mult:Number = 1;
         var power:Number = 2;
         if(_ENTITY_SIZE > 16)
         {
            power = 3;
         }
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndPlay(2);
         }
         var dir:int = 0;
         if(entity.stateMachine.currentState == "IS_BRAKING_STATE")
         {
            x_vel_mult = 1.5;
            if(entity.DIRECTION == Entity.RIGHT)
            {
               dir = Entity.LEFT;
            }
            else
            {
               dir = Entity.RIGHT;
            }
         }
         else
         {
            dir = entity.DIRECTION;
         }
         if(_SIDE == 0)
         {
            x_t = int((entity.xPos + entity.aabbPhysics.x + entity.aabbPhysics.width * 0.5) / Utils.TILE_HEIGHT);
            y_t = int((entity.yPos + entity.aabbPhysics.y + entity.aabbPhysics.height + 1) / Utils.TILE_HEIGHT);
            bottom_t_value = this.level.levelData.getTileValueAt(x_t,y_t);
            additionalYVel = 0;
            if(bottom_t_value == 4 && entity.DIRECTION == Entity.RIGHT)
            {
               additionalYVel = -6;
            }
            else if(bottom_t_value == 5 && entity.DIRECTION == Entity.LEFT)
            {
               additionalYVel = -6;
            }
            else if(bottom_t_value >= 6 && bottom_t_value <= 7 && entity.DIRECTION == Entity.RIGHT)
            {
               additionalYVel = -3;
            }
            else if(bottom_t_value >= 8 && bottom_t_value <= 9 && entity.DIRECTION == Entity.LEFT)
            {
               additionalYVel = -3;
            }
            if(dir == Entity.RIGHT)
            {
               angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.25);
               this.pushBackParticle(pSprite,entity.xPos,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power + additionalYVel,0.8);
            }
            else
            {
               angle = Math.PI * 0.5 + Math.random() * (Math.PI * 0.25);
               this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power + additionalYVel,0.8);
            }
         }
         else if(_SIDE == 1)
         {
            if(dir == Entity.RIGHT)
            {
               angle = Math.PI * 2 - Math.random() * (Math.PI * 0.25);
               this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,0.8);
            }
            else
            {
               angle = Math.PI + Math.PI * 0.25 - Math.random() * (Math.PI * 0.25);
               this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,0.8);
            }
         }
         else if(_SIDE == 2)
         {
            if(dir == Entity.RIGHT)
            {
               angle = Math.PI * 0.5 - Math.random() * (Math.PI * 0.25);
               this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,0.8);
            }
            else
            {
               angle = Math.PI * 1.5 + Math.random() * (Math.PI * 0.25);
               this.pushBackParticle(pSprite,entity.xPos,entity.yPos,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,0.8);
            }
         }
         else if(dir == Entity.RIGHT)
         {
            angle = Math.PI - Math.random() * (Math.PI * 0.25);
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,0.8);
         }
         else
         {
            angle = Math.random() * (Math.PI * 0.25);
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,0.8);
         }
      }
      
      public function groundSnowParticles(entity:Entity, _ENTITY_SIZE:int = 16, _SIDE:int = 0) : void
      {
         var angle:Number = NaN;
         var pSprite:SnowParticleSprite = new SnowParticleSprite();
         var x_vel_mult:Number = 1;
         var power:Number = 2.5;
         var dir:int = 0;
         if(_ENTITY_SIZE > 16)
         {
            power = 3;
         }
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndPlay(2);
         }
         if(entity.stateMachine.currentState == "IS_BRAKING_STATE")
         {
            x_vel_mult = 1.5;
            if(entity.DIRECTION == Entity.RIGHT)
            {
               dir = Entity.LEFT;
            }
            else
            {
               dir = Entity.RIGHT;
            }
         }
         else
         {
            dir = entity.DIRECTION;
         }
         if(dir == Entity.RIGHT)
         {
            angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,1);
         }
         else
         {
            angle = Math.PI * 0.5 + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos + entity.HEIGHT,Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power,1);
         }
      }
      
      public function wallSmokeParticles(entity:Entity) : void
      {
         var angle:Number = NaN;
         var pSprite:SmokeParticleSprite = new SmokeParticleSprite();
         var x_vel_mult:Number = 1;
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndPlay(2);
         }
         var dir:int = entity.DIRECTION;
         if(dir == Entity.RIGHT)
         {
            angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.25);
            this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos,Math.sin(angle) * 2 * x_vel_mult,Math.cos(angle) * 2,0.8);
         }
         else
         {
            angle = Math.PI - Math.PI * 0.2 - Math.random() * (Math.PI * 0.25);
            pSprite.scaleX = -1;
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos,Math.sin(angle) * 2 * x_vel_mult,Math.cos(angle) * 2,0.8);
         }
      }
      
      public function wallIceParticles(entity:Entity) : void
      {
         var angle:Number = NaN;
         var pSprite:IceWallSlideParticleSprite = new IceWallSlideParticleSprite();
         var x_vel_mult:Number = 1;
         if(Math.random() * 100 > 80)
         {
            pSprite.gfxHandleClip().gotoAndPlay(2);
         }
         var dir:int = entity.DIRECTION;
         if(dir == Entity.RIGHT)
         {
            angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.25);
            this.pushBackParticle(pSprite,entity.xPos + entity.WIDTH,entity.yPos,Math.sin(angle) * 2 * x_vel_mult,Math.cos(angle) * 2,0.8);
         }
         else
         {
            angle = Math.PI - Math.PI * 0.2 - Math.random() * (Math.PI * 0.25);
            pSprite.scaleX = -1;
            this.pushBackParticle(pSprite,entity.xPos,entity.yPos,Math.sin(angle) * 2 * x_vel_mult,Math.cos(angle) * 2,0.8);
         }
      }
      
      public function createDewDroplets(_xPos:Number, _yPos:Number, _type:int = 0) : void
      {
         var i:int = 0;
         var angle:Number = NaN;
         var power:Number = NaN;
         var pSprite:GameSprite = null;
         for(i = 0; i < 2; i++)
         {
            pSprite = new WaterDropParticleSprite(_type);
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            if(i == 0)
            {
               angle = this.getRandomRangeAngle(Math.PI * 2 - Math.PI * 0.25,Math.PI * 0.25);
            }
            else
            {
               angle = this.getRandomRangeAngle(0,Math.PI * 0.5);
            }
            power = 2 + Math.random() * 1;
            this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * 2,-Math.cos(angle) * power,1);
         }
      }
      
      public function createSandParticles(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var angle:Number = NaN;
         var power:Number = NaN;
         var pSprite:GameSprite = null;
         for(i = 0; i < 2; i++)
         {
            pSprite = new SandParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            if(i == 0)
            {
               angle = this.getRandomRangeAngle(Math.PI * 2 - Math.PI * 0.25,Math.PI * 0.25);
            }
            else
            {
               angle = this.getRandomRangeAngle(0,Math.PI * 0.5);
            }
            power = 1.5 + Math.random() * 1;
            this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * 2,-Math.cos(angle) * power,0.95);
         }
      }
      
      public function createWallJumpParticle(_xPos:Number, _yPos:Number, DIRECTION:int, verticalPlatform:Collision = null) : void
      {
         var pSprite:WallJumpParticleSprite = new WallJumpParticleSprite();
         var x_t:int = int(_xPos / Utils.TILE_WIDTH);
         var y_t:int = int(_yPos / Utils.TILE_HEIGHT);
         var max_amount:int = 0;
         if(verticalPlatform != null)
         {
            if(Math.abs(verticalPlatform.xPos - _xPos) >= 24)
            {
               verticalPlatform = null;
            }
         }
         if(DIRECTION == Entity.LEFT)
         {
            pSprite.scaleX = -1;
            if(verticalPlatform == null)
            {
               max_amount = 0;
               while(this.level.levelData.getTileValueAt(x_t,y_t) == 0 && max_amount++ <= 5)
               {
                  x_t++;
               }
               if(max_amount <= 2)
               {
                  this.pushParticle(pSprite,x_t * Utils.TILE_WIDTH,_yPos,0,0,0);
               }
            }
            else
            {
               this.pushParticle(pSprite,verticalPlatform.xPos,_yPos,0,0,0);
            }
         }
         else if(verticalPlatform == null)
         {
            max_amount = 0;
            while(this.level.levelData.getTileValueAt(x_t,y_t) == 0 && max_amount++ <= 5)
            {
               x_t--;
            }
            if(max_amount <= 2)
            {
               this.pushParticle(pSprite,(x_t + 1) * Utils.TILE_WIDTH,_yPos,0,0,0);
            }
         }
         else
         {
            this.pushParticle(pSprite,verticalPlatform.xPos + verticalPlatform.WIDTH,_yPos,0,0,0);
         }
      }
      
      public function createWoodCrateExplosion(xPos:Number, yPos:Number, WIDTH:Number, HEIGHT:Number) : void
      {
         var bSprite:GameSprite = null;
         var _xVel:Number = 0.5;
         bSprite = new WoodCrateParticleSprite();
         bSprite.gfxHandleClip().gotoAndPlay(int(Math.random() * 4 + 1));
         this.pushParticle(bSprite,xPos,yPos + Math.random() * HEIGHT,-Math.random() * _xVel,-(0.5 + Math.random()),1);
         bSprite = new WoodCrateParticleSprite();
         bSprite.scaleX = -1;
         bSprite.gfxHandleClip().gotoAndPlay(int(Math.random() * 4 + 1));
         this.pushParticle(bSprite,xPos + WIDTH,yPos + Math.random() * HEIGHT,Math.random() * _xVel,-(0.5 + Math.random()),1);
         bSprite = new WoodCrateParticleSprite();
         bSprite.gfxHandleClip().gotoAndPlay(int(Math.random() * 4 + 1));
         if(Math.random() * 100 > 50)
         {
            this.pushParticle(bSprite,xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,Math.random() * _xVel,-(0.5 + Math.random()),1,Math.random() * 120);
         }
         else
         {
            bSprite.scaleX = -1;
            this.pushParticle(bSprite,xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,Math.random() * _xVel,-(0.5 + Math.random()),1,Math.random() * 120);
         }
      }
      
      public function createMediumBrickExplosion(_xPos:Number, _yPos:Number) : void
      {
         var pSprite:GameSprite = null;
         var angle:Number = NaN;
         var power:Number = NaN;
         var rand:int = 0;
         var particle:Particle = null;
         pSprite = new GenericParticleSprite(GenericParticleSprite.BIG_EXPLOSION);
         pSprite.gfxHandleClip().gotoAndStop(1);
         particle = this.pushParticle(pSprite,_xPos,_yPos,0,0,0.75,1);
         pSprite = new ImpactParticleSprite();
         pSprite.gfxHandleClip().gotoAndStop(1);
         power = 6;
         if(this.brick_explosion_dir)
         {
            angle = Math.PI * 0.25;
            if(Math.random() * 100 > 50)
            {
               angle += Math.PI;
            }
            if(this.brick_explosion_dir)
            {
               pSprite.scaleY = -1;
            }
         }
         else
         {
            angle = Math.PI * 0.25 + Math.PI * 0.5;
            if(Math.random() * 100 > 50)
            {
               angle += Math.PI;
            }
         }
         this.brick_explosion_dir = !this.brick_explosion_dir;
         particle = this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * power,Math.cos(angle) * power,0.7,10);
         particle.DO_NOT_UPDATE = true;
      }
      
      public function createSmallBrickExplosion(_xPos:Number, _yPos:Number, _bigCat:Boolean = false, LEVEL:int = 1) : void
      {
         var pSprite:GameSprite = null;
         var angle:Number = NaN;
         var power:Number = NaN;
         var rand:int = 0;
         var particle:Particle = null;
         pSprite = new ExplosionParticleSprite();
         pSprite.gfxHandleClip().gotoAndStop(1);
         particle = this.pushParticle(pSprite,_xPos,_yPos,0,0,0.75,1);
         pSprite = new ImpactParticleSprite();
         if(!_bigCat)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         power = 6;
         if(this.brick_explosion_dir)
         {
            angle = Math.PI * 0.25;
            if(Math.random() * 100 > 50)
            {
               angle += Math.PI;
            }
            if(this.brick_explosion_dir)
            {
               pSprite.scaleY = -1;
            }
         }
         else
         {
            angle = Math.PI * 0.25 + Math.PI * 0.5;
            if(Math.random() * 100 > 50)
            {
               angle += Math.PI;
            }
         }
         this.brick_explosion_dir = !this.brick_explosion_dir;
         if(!_bigCat)
         {
            particle = this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * power,Math.cos(angle) * power,0.7,10);
            particle.DO_NOT_UPDATE = true;
         }
         else
         {
            particle = this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * power,Math.cos(angle) * power,0.7,0);
            particle.DO_NOT_UPDATE = false;
         }
      }
      
      public function createUseItemParticles(item_id:int) : void
      {
         var pSprite:GameSprite = null;
         if(item_id == LevelItems.ITEM_BELL)
         {
            pSprite = new BellItemSprite();
         }
         else
         {
            pSprite = new KeyItemSprite(0);
         }
         pSprite.gotoAndStop(5);
         pSprite.gfxHandleClip().gotoAndPlay(1);
         var particle:Particle = this.pushParticle(pSprite,0,-32,0,0,1);
         particle.setEntity(this.level.hero);
      }
      
      public function createItemParticlesAt(item_id:int, mid_x_pos:int, top_y_pos:int) : void
      {
         var pSprite:GameSprite = null;
         var pParticle:Particle = null;
         if(item_id == LevelItems.ITEM_COIN)
         {
            pSprite = new CoinItemSprite();
         }
         else
         {
            pSprite = new CoinItemSprite();
         }
         pSprite.gotoAndStop(1);
         pSprite.gfxHandleClip().gotoAndStop(1);
         pParticle = this.pushParticle(pSprite,mid_x_pos - 8,top_y_pos - 8,0,-2,1);
         this.itemSparkles("yellow",mid_x_pos,top_y_pos - 16,16);
      }
      
      public function createClusterBubbles(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var delay:int = 0;
         var shift_x:int = 0;
         var amount:int = 2 + int(Math.random() * 2);
         var multiplier:Number = 0.8 + int(Math.random() * 5) * 0.1;
         for(i = 0; i < amount; i++)
         {
            pSprite = new WaterBubbleParticleSprite();
            if(i == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            if(i == 0)
            {
               shift_x = delay = 0;
            }
            else
            {
               delay = i * 6 + Math.random() * 4;
               shift_x = (Math.random() * 4 - 2) * 4;
            }
            this.pushParticle(pSprite,_xPos + shift_x,_yPos,0,-0.01,1,Math.random() * Math.PI * 2,delay,multiplier);
         }
      }
      
      public function createSplashParticle(_xPos:Number, _type:int = 0) : void
      {
         this.pushParticle(new SplashParticleSprite(_type),_xPos,Utils.SEA_LEVEL,0,0,0);
      }
      
      public function createClusterLavaBubbles(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var delay:int = 0;
         var shift_x:int = 0;
         var amount:int = 2 + int(Math.random() * 2);
         var multiplier:Number = 0.8 + int(Math.random() * 5) * 0.1;
         for(i = 0; i < amount; i++)
         {
            pSprite = new LavaBubbleParticleSprite();
            if(i == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            if(i == 0)
            {
               shift_x = delay = 0;
            }
            else
            {
               delay = i * 6 + Math.random() * 4;
               shift_x = (Math.random() * 4 - 2) * 4;
            }
            this.pushParticle(pSprite,_xPos + shift_x,_yPos,0,-0.01,1,Math.random() * Math.PI * 2,delay,multiplier);
         }
      }
      
      public function createClusterRocks(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var delay:int = 0;
         var shift_x:int = 0;
         var amount:int = 2 + int(Math.random() * 2);
         var multiplier:Number = int(Math.random() * 5) * 0.5;
         for(i = 0; i < amount; i++)
         {
            pSprite = new RockBackgroundParticleSprite();
            if(i == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            if(i == 0)
            {
               shift_x = delay = 0;
            }
            else
            {
               delay = i * 4 + Math.random() * 2;
               shift_x = (Math.random() * 4 - 2) * 4;
            }
            this.pushParticle(pSprite,_xPos + shift_x,_yPos,0,-0.01,1,Math.random() * Math.PI * 2,delay,multiplier);
         }
      }
      
      public function createBreatheWaterBubble(_xPos:Number, _yPos:Number) : void
      {
         var pSprite:WaterBubbleParticleSprite = new WaterBubbleParticleSprite();
         pSprite.gfxHandleClip().gotoAndStop(1);
         this.pushParticle(pSprite,_xPos,_yPos,0,-0.01,1,Math.random() * Math.PI * 2,0,1);
      }
      
      public function createBubble(_xPos:Number, _yPos:Number) : void
      {
         var pSprite:WaterBubbleParticleSprite = new WaterBubbleParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         this.pushParticle(pSprite,_xPos,_yPos,0,-0.01,1,Math.random() * Math.PI * 2,0,1);
      }
      
      public function createDust(_xPos:Number, _yPos:Number, _direction:int, _onTop:Boolean = false) : void
      {
         var i:int = 0;
         var amount:int = 0;
         var angle:Number = NaN;
         var pSprite:DustParticleSprite = null;
         var particle:Particle = null;
         if(Math.random() * 100 > 50)
         {
            amount = 2;
         }
         else
         {
            amount = 1;
         }
         for(i = 0; i < amount; i++)
         {
            pSprite = new DustParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(1);
            if(_direction == Entity.LEFT)
            {
               angle = Math.PI + Math.PI * 0.125 + Math.PI * 0.25 + Math.random() * (Math.PI * 0.125);
            }
            else
            {
               angle = Math.PI * 0.5 + Math.random() * (Math.PI * 0.125);
            }
            if(_onTop)
            {
               if(i == 1)
               {
                  particle = this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * 1,Math.cos(angle) * 1,0.8,int(Math.random() * 10 + 10));
               }
               else
               {
                  particle = this.pushParticle(pSprite,_xPos,_yPos,Math.sin(angle) * 4,Math.cos(angle) * 4,0.8,int(1));
               }
            }
            else if(i == 1)
            {
               particle = this.pushBackParticle(pSprite,_xPos,_yPos,Math.sin(angle) * 1,Math.cos(angle) * 1,0.8,int(Math.random() * 10 + 10));
            }
            else
            {
               particle = this.pushBackParticle(pSprite,_xPos,_yPos,Math.sin(angle) * 4,Math.cos(angle) * 4,0.8,int(1));
            }
            if(i == 1)
            {
               particle.DO_NOT_UPDATE = true;
            }
         }
      }
      
      public function eggExplosion(_xPos:Number, _yPos:Number) : void
      {
         var eggParticleSprite:EggParticleSprite = null;
         eggParticleSprite = new EggParticleSprite();
         eggParticleSprite.gfxHandleClip().gotoAndStop(1);
         this.pushParticle(eggParticleSprite,_xPos,_yPos,-1,-2,1);
         eggParticleSprite = new EggParticleSprite();
         eggParticleSprite.gfxHandleClip().gotoAndStop(2);
         this.pushParticle(eggParticleSprite,_xPos,_yPos,1,-2,1);
      }
      
      protected function getRandomAngle(isLeftSide:Boolean) : Number
      {
         return isLeftSide ? Math.random() * Math.PI + Math.PI * 0.5 : Math.random() * Math.PI + Math.PI * 1.5;
      }
      
      protected function getRandomRangeAngle(_start:Number, _range:Number) : Number
      {
         return Math.random() * _range + _start;
      }
   }
}
