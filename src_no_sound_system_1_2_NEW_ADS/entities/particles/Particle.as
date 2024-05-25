package entities.particles
{
   import entities.Entity;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.*;
   import levels.collisions.Collision;
   import sprites.*;
   import sprites.background.*;
   import sprites.collisions.*;
   import sprites.enemies.FoxBossEnemySprite;
   import sprites.enemies.MonkeyEnemySprite;
   import sprites.items.*;
   import sprites.particles.*;
   import sprites.particles.vehicles.*;
   import starling.display.Sprite;
   
   public class Particle
   {
       
      
      protected var ID:int;
      
      public var level:Level;
      
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
      
      public var collision:Collision;
      
      public var dead:Boolean;
      
      public var foo1:Number;
      
      public var foo2:Number;
      
      public var foo3:Number;
      
      public var foo4:Number;
      
      public var counter1:Number;
      
      public var counter2:Number;
      
      public var counter3:Number;
      
      public var DO_NOT_UPDATE:Boolean;
      
      protected var sound_counter:int;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      public function Particle(_level:Level, _container:Sprite, _xPos:Number, _yPos:Number, _xVel:Number, _yVel:Number, _friction:Number)
      {
         super();
         this.ID = -1;
         this.level = _level;
         this.container = _container;
         this.DO_NOT_UPDATE = false;
         this.sound_counter = 0;
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.xVel = _xVel;
         this.yVel = _yVel;
         this.foo1 = this.foo2 = this.foo3 = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.sprite = null;
         this.collision = null;
      }
      
      public function destroy() : void
      {
         this.removeSprite();
         this.container = null;
         this.entity = null;
         this.level = null;
         this.collision = null;
      }
      
      public function setTweenValues(_t_start:Number, _t_diff:Number, _t_time:Number, _t_tick:Number = 0) : void
      {
         this.t_start = _t_start;
         this.t_diff = _t_diff;
         this.t_time = _t_time;
         this.t_tick = _t_tick;
      }
      
      public function update() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         var mudParticle:MudParticleSprite = null;
         var x_distance:Number = NaN;
         var wait_time:int = 0;
         if(!this.DO_NOT_UPDATE)
         {
            this.xVel *= this.friction;
            this.yVel *= this.friction;
            this.xPos += this.xVel;
            this.yPos += this.yVel;
         }
         if(this.sprite is PollenParticleSprite || this.sprite is CandleSmokeParticleSprite || this.sprite is BlueSparkleParticleSprite)
         {
            this.foo3 += this.foo1;
            this.originalYPos += this.yVel * 0.25;
            this.yPos = this.originalYPos + Math.sin(this.foo3) * this.foo4;
            this.foo4 += 0.1;
            if(this.foo4 > this.foo2)
            {
               this.foo4 = this.foo2;
            }
            ++this.counter1;
            if(this.counter1 > 60)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.ID == GenericParticleSprite.HONEY_DISSOLVE || this.ID == GenericParticleSprite.DARK_PORTAL_APPEAR || this.ID == GenericParticleSprite.RED_ORB || this.ID == GenericParticleSprite.WATER_CANNON_IMPACT)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.ID == GenericParticleSprite.LOVE)
         {
            this.foo1 += 0.1;
            this.yPos -= 0.5;
            this.xPos = Math.sin(this.foo1) * 4;
            ++this.counter1;
            if(this.counter1 > 30)
            {
               ++this.counter2;
               if(this.counter2 >= 2)
               {
                  this.counter2 = 0;
                  ++this.counter3;
                  this.sprite.visible = !this.sprite.visible;
                  if(this.counter3 >= 10)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is EnergyParticleSprite)
         {
            diff_x = this.foo1 - this.xPos;
            diff_y = this.foo2 - this.yPos;
            distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
            this.foo3 *= 1.2;
            if(this.foo3 >= 1)
            {
               this.foo3 = 1;
            }
            if(distance <= 2)
            {
               distance = 0.1;
               this.dead = true;
            }
            if(distance < 8)
            {
               this.sprite.gotoAndStop(2);
            }
            diff_x /= distance;
            diff_y /= distance;
            this.xPos += diff_x * this.foo3;
            this.yPos += diff_y * this.foo3;
         }
         else if(this.sprite is BigEnergyParticleSprite)
         {
            diff_x = this.level.camera.x + this.entity.sprite.x + 40 - this.xPos;
            diff_y = this.level.camera.y + this.entity.sprite.y + 72 - this.yPos;
            distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
            this.foo3 *= 1.2;
            if(this.foo3 >= 3)
            {
               this.foo3 = 3;
            }
            if(distance <= 6)
            {
               distance = 0.1;
               this.dead = true;
            }
            if(distance < 12)
            {
               this.sprite.gotoAndStop(2);
            }
            diff_x /= distance;
            diff_y /= distance;
            this.xPos += diff_x * this.foo3;
            this.yPos += diff_y * this.foo3;
         }
         else if(this.sprite is LunaCatSparkleParticleSprite)
         {
            this.foo3 += this.foo1;
            this.originalYPos += this.yVel * 0.25;
            this.yPos = this.originalYPos + Math.sin(this.foo3) * this.foo4;
            this.foo4 += 0.1;
            if(this.foo4 > this.foo2)
            {
               this.foo4 = this.foo2;
            }
            ++this.counter1;
            if(this.counter1 > 0)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is QuestionMarkParticleSprite)
         {
            ++this.counter1;
            if(this.counter1 < 8)
            {
               --this.yPos;
            }
            if(this.counter1 > 40)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is MonkeyEnemySprite)
         {
            if(this.counter1 > 5)
            {
               this.yVel += 0.1;
            }
            if(this.counter1++ > 20)
            {
               this.dead = true;
               this.level.particlesManager.pushParticle(new EnemyHurtParticleSprite(),this.xPos + 8,this.yPos + 8,0,0,0);
            }
         }
         else if(this.sprite is SnowSmallParticleSprite)
         {
            this.foo1 += 0.1;
            this.yPos = this.originalYPos + Math.sin(this.foo1) * this.foo2;
            ++this.counter1;
            if(this.counter1 > 40)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is GlassParticleSprite)
         {
            this.yVel += 0.1;
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.sprite.gfxHandleClip().setFrameDuration(0,Math.random() * 0.5);
               this.sprite.gfxHandleClip().gotoAndPlay(1);
               if(this.xVel > 0)
               {
                  this.sprite.rotation += Math.PI * 0.5;
               }
               else
               {
                  this.sprite.rotation -= Math.PI * 0.5;
               }
            }
            if(this.yVel > 0)
            {
               x_t = int(this.xPos / Utils.TILE_WIDTH);
               y_t = int((this.yPos + 8) / Utils.TILE_HEIGHT);
               if(this.level.levelData.getTileValueAt(x_t,y_t) != 0)
               {
                  this.yVel *= -0.8;
               }
            }
            ++this.counter1;
            if(this.counter1 > 60)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is ItemHeroParticleSprite)
         {
            if(this.sprite.gfxHandleClip().frame == 1)
            {
               --this.yPos;
               if(this.yPos <= -24)
               {
                  this.yPos = -24;
                  ++this.counter1;
                  ++this.counter2;
                  if(this.counter2 >= 3)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                     if(this.counter3 >= 7)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
            if(this.sprite.gfxHandleClip().frame == 3)
            {
               --this.yPos;
               if(this.yPos <= -24)
               {
                  this.yPos = -24;
                  ++this.counter1;
                  ++this.counter2;
                  if(this.counter2 >= 3)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                     if(this.counter3 >= 7)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
            else
            {
               ++this.counter1;
               if(this.counter1 > 15)
               {
                  ++this.counter2;
                  if(this.counter2 >= 2)
                  {
                     this.counter2 = 0;
                     ++this.counter3;
                     this.sprite.visible = !this.sprite.visible;
                     if(this.counter3 >= 10)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
         }
         else if(this.sprite is WorriedParticleSprite)
         {
            ++this.yPos;
            if(this.yPos >= this.originalYPos + 8)
            {
               this.yPos = this.originalYPos + 8;
            }
            if(this.counter1++ >= 60)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is GreySmokeParticleSprite)
         {
            this.foo1 += 0.05;
            this.yPos -= this.foo4;
            this.foo2 += 0.05;
            if(this.foo2 >= 8)
            {
               this.foo2 = 8;
            }
            this.xPos = int(this.originalXPos + Math.sin(this.foo1) * this.foo2);
            --this.foo3;
            if(this.foo3 < 60)
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
         else if(this.sprite is EggParticleSprite)
         {
            this.yVel += 0.1;
            ++this.foo1;
            if(this.foo1 > 5)
            {
               this.foo1 = 0;
               if(this.xVel < 0)
               {
                  this.sprite.rotation -= Math.PI * 0.5;
               }
               else
               {
                  this.sprite.rotation += Math.PI * 0.5;
               }
            }
            ++this.counter1;
            if(this.counter1 > 20)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is EmberParticleSprite || this.sprite is FreezeParticleSprite)
         {
            ++this.counter1;
            if(this.counter1 > 20)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is SlowGreySmokeParticleSprite)
         {
            this.foo1 += 0.02;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 8;
            if(this.foo2-- < 0)
            {
               ++this.counter1;
               if(this.counter1 >= 2)
               {
                  this.counter1 = 0;
                  ++this.counter2;
                  this.sprite.visible = !this.sprite.visible;
                  if(this.counter2 > 4)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is DirtyDustParticleSprite)
         {
            this.foo1 += 0.05;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 8;
            this.yVel += this.foo2 * 0.5;
            ++this.counter1;
            if(this.counter1 > 60)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is VaporParticleSprite)
         {
            this.yVel -= 0.05;
            if(this.yVel <= -4)
            {
               this.yVel = -4;
            }
            this.foo1 += 0.1;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 4;
            if(this.yPos < this.level.camera.yPos - 16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is LavaSurfaceBubbleParticleSprite)
         {
            if(this.foo1 == 0)
            {
               if(this.sprite.gfxHandleClip().currentFrame == 4)
               {
                  this.foo1 = 1;
                  this.level.topParticlesManager.pushParticle(new FireSparkleParticleSprite(),this.xPos - 4,this.yPos,-(Math.random() * 0.5 + 0.5),-(1 + Math.random() * 1),1,Utils.SEA_LEVEL);
                  this.level.topParticlesManager.pushParticle(new FireSparkleParticleSprite(),this.xPos + 4,this.yPos,Math.random() * 0.5 + 0.5,-(1 + Math.random() * 1),1,Utils.SEA_LEVEL);
                  this.level.collisionsManager.setLavaOnTop();
               }
            }
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is EnemyHurtParticleSprite || this.sprite is EnemyBigHurtParticleSprite)
         {
            if(this.sprite.gfxHandleClip().currentFrame == 0 && this.counter1 == 0)
            {
               this.counter1 = 1;
               this.level.particlesManager.createEnemyHurtStars(this.xPos,this.yPos,this.sprite is EnemyBigHurtParticleSprite ? true : false);
            }
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is EnemyHurtStarParticleSprite)
         {
            --this.foo2;
            if(this.foo2 == 0)
            {
               this.DO_NOT_UPDATE = false;
               this.sprite.visible = true;
            }
            else if(this.foo2 < 0)
            {
               --this.foo1;
               if(this.foo1 < 0)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is ElectroParticleSprite || this.sprite is EnemyHurtStarParticleSprite)
         {
            ++this.counter1;
            if(this.counter1 >= 3)
            {
               this.counter1 = 0;
               this.sprite.visible = !this.sprite.visible;
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is MudSurfaceBubbleParticleSprite)
         {
            if(this.foo2 == 0)
            {
               if(this.sprite.gfxHandleClip().currentFrame == 3)
               {
                  mudParticle = new MudParticleSprite();
                  mudParticle.gfxHandleClip().gotoAndStop(int(Math.round(Math.random() * 2)));
                  this.level.particlesManager.pushParticle(mudParticle,this.xPos - 4,this.yPos,-(Math.random() * 0.5 + 0.5),-(1 + Math.random() * 2),1,this.foo1);
                  mudParticle = new MudParticleSprite();
                  mudParticle.gfxHandleClip().gotoAndStop(int(Math.round(Math.random() * 2)));
                  this.level.particlesManager.pushParticle(mudParticle,this.xPos + 4,this.yPos,Math.random() * 0.5 + 0.5,-(1 + Math.random() * 2),1,this.foo1);
                  this.foo2 = 1;
               }
            }
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is AshParticleSprite)
         {
            this.foo3 += this.foo1;
            this.originalYPos += this.yVel * 0.25;
            this.yPos = this.originalYPos + Math.sin(this.foo3) * this.foo4;
            this.foo4 += 0.1;
            if(this.foo4 > this.foo2)
            {
               this.foo4 = this.foo2;
            }
            ++this.counter1;
            if(this.counter1 > 30)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is WhitePointParticleSprite)
         {
            ++this.counter1;
            if(this.counter1 > 30)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is FirePlantBulletParticleSprite || this.sprite is FireBallBulletParticleSprite || this.sprite is FireBallBigBulletParticleSprite || this.sprite is TankShootExplosionParticleSprite || this.sprite is FireExplosionParticleSprite || this.sprite is FireSmallExplosionParticleSprite || this.sprite is GenieParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is GoldenCatItemSprite || this.sprite is FoxBossEnemySprite)
         {
            if(this.counter1++ > 3)
            {
               this.counter1 = 0;
               this.sprite.alpha -= 0.3;
               if(this.sprite.alpha <= 0)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is ExclamationMarkParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
            else
            {
               this.foo1 += 0.5;
            }
         }
         else if(this.sprite is FireSparkleParticleSprite || this.sprite is DirtParticleSprite)
         {
            this.yVel += 0.2;
            if(this.yVel > 0)
            {
               x_t = int(this.xPos / Utils.TILE_WIDTH);
               y_t = int(this.yPos / Utils.TILE_HEIGHT);
               if(this.sprite is FireSparkleParticleSprite)
               {
                  if(this.foo1 > 0)
                  {
                     if(this.yPos >= this.foo1)
                     {
                        this.dead = true;
                     }
                  }
               }
               if(this.level.levelData.getTileValueAt(x_t,y_t) != 0 && this.foo1 == 0)
               {
                  this.dead = true;
               }
            }
            if(this.sprite is FireSparkleParticleSprite)
            {
               if(this.yPos >= Utils.SEA_LEVEL)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is MudParticleSprite)
         {
            this.yVel += 0.2;
            if(this.yVel > 0)
            {
               if(this.yPos >= this.foo1)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is FireAmberBackgroundParticleSprite)
         {
            this.foo1 += 0.05;
            if(this.foo1 >= Math.PI * 2)
            {
               this.foo1 -= Math.PI * 2;
            }
            this.xVel = Math.sin(this.foo1);
            --this.yPos;
            if(this.sprite.gfxHandleClip().isComplete)
            {
               ++this.foo2;
               if(this.foo2 >= 10)
               {
                  if(Math.random() * 100 > 95)
                  {
                     this.sprite.gfxHandleClip().gotoAndPlay(1);
                  }
               }
            }
            if(this.xPos > this.level.camera.xPos + this.level.camera.WIDTH * 2 || this.xPos < this.level.camera.xPos - this.level.camera.WIDTH)
            {
               this.dead = true;
            }
            if(this.yPos < this.level.camera.yPos - 16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is FireAmberIntroBackgroundParticleSprite)
         {
            this.foo1 += 0.05 * this.sprite.alpha;
            if(this.foo1 >= Math.PI * 2)
            {
               this.foo1 -= Math.PI * 2;
            }
            this.xVel = Math.sin(this.foo1) * this.sprite.alpha;
            this.xPos -= 1 - this.sprite.alpha;
            this.yPos -= 1 * this.sprite.alpha;
            if(this.sprite.gfxHandleClip().isComplete)
            {
               ++this.foo2;
               if(this.foo2 >= 10)
               {
                  if(Math.random() * 100 > 95)
                  {
                     this.sprite.gfxHandleClip().gotoAndPlay(1);
                  }
               }
            }
            if(this.yPos < -16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is MetalNutParticleSprite || this.sprite is MetalBoltParticleSprite || this.sprite is WoodCrateParticleSprite || this.sprite is MetalBigNutParticleSprite)
         {
            this.yVel += 0.1;
            if(this.counter3 > 0)
            {
               ++this.counter1;
               if(this.counter1 > this.foo1)
               {
                  ++this.counter2;
                  if(this.counter2 >= 3)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                     if(this.counter3 >= 7)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
            if(this.yVel > 0)
            {
               x_t = int(this.xPos / Utils.TILE_WIDTH);
               y_t = int(this.yPos / Utils.TILE_HEIGHT);
               if(this.level.levelData.getTileValueAt(x_t,y_t) != 0)
               {
                  this.yVel *= -0.8;
                  ++this.counter3;
               }
            }
         }
         else if(this.sprite is BoneParticleSprite || this.sprite is MetalRodParticleSprite || this.sprite is CoconutParticleSprite)
         {
            this.yVel += 0.1;
            ++this.counter1;
            if(this.counter1 > 30)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
            if(this.yVel > 0)
            {
               x_t = int(this.xPos / Utils.TILE_WIDTH);
               y_t = int((this.yPos + 8) / Utils.TILE_HEIGHT);
               if(this.level.levelData.getTileValueAt(x_t,y_t) != 0)
               {
                  this.yVel *= -0.8;
               }
            }
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.sprite.rotation += Math.PI * 0.5;
               this.sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(this.sprite is BubbleItemBurstParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is CoconutParticleSprite)
         {
            this.yVel += 0.1;
            ++this.counter1;
            if(this.counter1 > 30)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
            if(this.yVel > 0)
            {
               x_t = int(this.xPos / Utils.TILE_WIDTH);
               y_t = int(this.yPos / Utils.TILE_HEIGHT);
               if(this.level.levelData.getTileValueAt(x_t,y_t) != 0)
               {
                  this.yVel *= -0.95;
               }
            }
         }
         else if(this.sprite is SandParticleSprite || this.sprite is IceParticleSprite || this.sprite is RockParticleSprite)
         {
            this.yVel += 0.2;
            ++this.counter1;
            if(this.counter1 > 60)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
            if(this.yPos >= Utils.SEA_LEVEL)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is SnowBigParticleSprite)
         {
            this.yVel += 0.2;
            x_t = int(this.xPos / Utils.TILE_WIDTH);
            y_t = int(this.yPos / Utils.TILE_HEIGHT);
            if(this.level.levelData.getTileValueAt(x_t,y_t) != 0 && this.yVel > 0)
            {
               this.level.particlesManager.createSnowParticles(this.xPos,this.yPos);
               this.dead = true;
            }
            ++this.counter1;
            if(this.counter1 > 60)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is NumberParticleSprite)
         {
            --this.yPos;
            ++this.counter1;
            if(this.counter1 >= 30)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is FiftyCoinsParticleSprite)
         {
            --this.yPos;
            ++this.counter1;
            if(this.counter1 >= 30)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
            if(this.counter1 == 20)
            {
               SoundSystem.PlaySound("item_appear");
            }
         }
         else if(this.sprite is ChimneySmokeParticleSprite || this.sprite is DarkGreySmokeParticleSprite)
         {
            this.foo1 += 0.05;
            this.yPos -= 0.25;
            this.foo2 += 0.05;
            if(this.foo2 >= 8)
            {
               this.foo2 = 8;
            }
            this.originalXPos -= this.xVel;
            this.xPos = int(this.originalXPos + Math.sin(this.foo1) * this.foo2);
            --this.foo3;
            if(this.foo3 < 0)
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
         else if(this.sprite is SnowBackgroundParticleSprite)
         {
            this.yPos += 0.75 + this.foo2 * 0.5;
            this.foo1 += 0.025;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 16;
            x_distance = this.level.camera.xPos + this.level.camera.HALF_WIDTH;
            if(Math.abs(x_distance - this.xPos) > this.level.camera.WIDTH * 1.5)
            {
               this.dead = true;
            }
            if(this.yPos > this.level.camera.yPos + this.level.camera.HEIGHT + 16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is CityNightSnowBackgroundParticleSprite)
         {
            this.yPos += 0.75 + this.foo2 * 0.5;
            this.foo1 += 0.025;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 16;
            x_distance = this.level.camera.xPos + this.level.camera.HALF_WIDTH;
            if(Math.abs(x_distance - this.xPos) > this.level.camera.WIDTH * 1.5)
            {
               this.dead = true;
            }
            if(this.yPos > this.level.camera.yPos + this.level.camera.HEIGHT + 16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is FrozenSnowBackgroundParticleSprite)
         {
            this.yPos += 1 + this.foo2 * 0.5;
            this.foo1 += 0.05;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 16;
            x_distance = this.level.camera.xPos + this.level.camera.HALF_WIDTH;
            if(Math.abs(x_distance - this.xPos) > this.level.camera.WIDTH * 1.5)
            {
               this.dead = true;
            }
            if(this.yPos > this.level.camera.yPos + this.level.camera.HEIGHT + 16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is NightSnowBackgroundParticleSprite)
         {
            this.yPos += 1.75 + this.foo2 * 0.5;
            this.foo1 += 0.025;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 16;
            this.originalXPos += Utils.WIND_X_VEL;
            x_distance = this.level.camera.xPos + this.level.camera.HALF_WIDTH;
            if(Math.abs(x_distance - this.xPos) > this.level.camera.WIDTH * 1.5)
            {
               this.dead = true;
            }
            if(this.yPos > this.level.camera.yPos + this.level.camera.HEIGHT + 16)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is GreenLeafBackgroundParticleSprite || this.ID == GenericParticleSprite.SAND_BEACH)
         {
            if(this.level.getBackgroundId() == BackgroundsManager.MOUNTAIN || this.level.getBackgroundId() == BackgroundsManager.MOUNTAIN_TRAIN)
            {
               this.foo3 += 0.01 * ParticlesManager.GLOBAL_VARIABLE_1;
               this.yPos = this.originalYPos + Math.sin(this.foo3) * 32;
               this.originalYPos -= 0.25 * ParticlesManager.GLOBAL_VARIABLE_1 * 0.5;
               this.foo1 += 0.01 + this.foo2 * 0.01 * ParticlesManager.GLOBAL_VARIABLE_1;
               this.xPos = this.originalXPos + Math.sin(this.foo1) * 32;
               this.originalXPos -= 0.5 * ParticlesManager.GLOBAL_VARIABLE_1;
               if(this.yPos < this.level.camera.yPos - Utils.TILE_HEIGHT || this.xPos < this.level.camera.xPos - 32)
               {
                  this.dead = true;
               }
            }
            else
            {
               this.yPos += 0.5 + this.foo2;
               this.foo1 += 0.01 + this.foo2 * 0.01;
               if(this.foo4 > 0)
               {
                  this.xPos = this.originalXPos + Math.sin(this.foo1) * this.foo4;
               }
               else
               {
                  this.xPos = this.originalXPos + Math.sin(this.foo1) * 32;
               }
               if(this.yPos > this.level.camera.yPos + this.level.camera.HEIGHT + 16)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is WindDustIntroParticleSprite)
         {
            this.foo3 += 0.01;
            this.yPos = this.originalYPos + Math.sin(this.foo3) * 32;
            this.originalYPos -= 0.25 * ParticlesManager.GLOBAL_VARIABLE_1 * 0.5;
            this.foo1 += 0.01 * 1 + this.foo2 * (0.01 * 1);
            this.xPos = this.originalXPos + Math.sin(this.foo1) * (32 * 2);
            this.originalXPos -= 0.5 * ParticlesManager.GLOBAL_VARIABLE_1;
            if(this.yPos < -Utils.TILE_HEIGHT || this.xPos < -32)
            {
               this.dead = true;
            }
            this.container.setChildIndex(this.sprite,0);
         }
         else if(this.sprite is PollenIntroBackgroundParticleSprite)
         {
            this.foo3 += 0.01;
            this.yPos = this.originalYPos + Math.sin(this.foo3) * 32;
            this.originalYPos -= 0.25 * ParticlesManager.GLOBAL_VARIABLE_1 * 0.5;
            this.foo1 += 0.01 * 1 + this.foo2 * (0.01 * 1);
            this.xPos = this.originalXPos + Math.sin(this.foo1) * (32 * 2);
            this.originalXPos -= 0.5 * ParticlesManager.GLOBAL_VARIABLE_1;
            if(this.yPos < -Utils.TILE_HEIGHT || this.xPos < -32)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is PollenBackgroundParticleSprite)
         {
            if(this.foo4 == 0)
            {
               this.foo3 += 0.01;
               this.yPos = this.originalYPos + Math.sin(this.foo3) * 32;
               this.originalYPos -= 0.25 * ParticlesManager.GLOBAL_VARIABLE_1;
               this.foo1 += 0.01 + this.foo2 * 0.01;
               this.xPos = this.originalXPos + Math.sin(this.foo1) * 32;
               this.originalXPos -= 0.5 * ParticlesManager.GLOBAL_VARIABLE_1;
               if(this.yPos < this.level.camera.yPos - Utils.TILE_HEIGHT || this.xPos < this.level.camera.xPos - 32)
               {
                  this.dead = true;
               }
            }
            else if(this.foo4 == 1)
            {
               this.foo3 += 0.01;
               this.yPos = this.originalYPos + Math.sin(this.foo3) * 32;
               this.originalYPos += 0.25 * ParticlesManager.GLOBAL_VARIABLE_1;
               this.foo1 += 0.01 + this.foo2 * 0.01;
               this.xPos = this.originalXPos + Math.sin(this.foo1) * 32;
               if(this.yPos > this.level.camera.yPos + Utils.HEIGHT + 16)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is SandBackgroundParticleSprite)
         {
            this.foo3 += 0.01;
            this.yPos = this.originalYPos + Math.sin(this.foo3) * 32;
            this.originalYPos -= 0.125 * ParticlesManager.GLOBAL_VARIABLE_1;
            this.foo1 += 0.01 + this.foo2 * 0.01;
            this.xPos -= 0.5 * ParticlesManager.GLOBAL_VARIABLE_2;
            if(this.yPos < this.level.camera.yPos - Utils.TILE_HEIGHT || this.xPos < this.level.camera.xPos - 32)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is YellowSparkleParticleSprite || this.sprite is RedSparkleParticleSprite || this.ID == GenericParticleSprite.SAND_WIND)
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
            if(this.ID == GenericParticleSprite.SAND_WIND)
            {
               this.foo3 += 0.5;
               this.foo2 += 0.1;
               this.yPos = this.originalYPos + Math.sin(this.foo2) * this.foo3;
            }
         }
         else if(this.sprite is HurtImpactParticleSprite)
         {
            ++this.counter1;
            if(this.counter1 > 5)
            {
               ++this.counter2;
               if(this.counter2 >= 2)
               {
                  this.counter2 = 0;
                  ++this.counter3;
                  this.sprite.visible = !this.sprite.visible;
                  if(this.counter3 >= 10)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is WallJumpParticleSprite || this.sprite is SplashBigLavaParticleSprite || this.sprite is SplashParticleSprite || this.sprite is GlimpseParticleSprite || this.sprite is SplashLavaParticleSprite)
         {
            if(this.sprite is GlimpseParticleSprite)
            {
               if(this.sprite.gfxHandleClip().currentFrame == 1 || this.sprite.gfxHandleClip().currentFrame == 3)
               {
                  if(this.sound_counter == 0)
                  {
                     SoundSystem.PlaySound("cat_blink");
                     this.sound_counter = 1;
                  }
               }
               else
               {
                  this.sound_counter = 0;
               }
            }
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is ZSleepParticleSprite)
         {
            this.foo1 += 0.15;
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 1;
            if(this.foo3 == 0)
            {
               this.originalXPos += 0.1;
            }
            else
            {
               this.originalXPos -= 0.1;
            }
            this.yPos -= 0.2;
            ++this.foo2;
            if(this.foo2 > 40)
            {
               ++this.counter1;
               if(this.counter1 > 5)
               {
                  ++this.counter2;
                  if(this.counter2 >= 2)
                  {
                     this.counter2 = 0;
                     ++this.counter3;
                     this.sprite.visible = !this.sprite.visible;
                     if(this.counter3 >= 10)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
         }
         else if(this.sprite is SmokeParticleSprite || this.sprite is IceWallSlideParticleSprite)
         {
            if(this.foo3 == 0)
            {
               if(this.sprite.gfxHandleClip().isComplete)
               {
                  if(this.foo1++ > 0)
                  {
                     this.foo1 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.foo2;
                  }
                  if(this.foo2 > 6)
                  {
                     this.dead = true;
                  }
               }
            }
            else if(this.foo3 == 1)
            {
               this.foo1 += 0.2;
               this.xPos = this.originalXPos + Math.sin(this.foo1) * 6;
               this.yVel -= 0.25;
               ++this.foo2;
               if(this.foo2 > 6)
               {
                  if(this.counter2++ > 0)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                  }
                  if(this.counter3 > 6)
                  {
                     this.dead = true;
                  }
               }
            }
            else if(this.foo3 == 2)
            {
               ++this.foo2;
               if(this.foo2 > 6)
               {
                  if(this.counter2++ > 0)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                  }
                  if(this.counter3 > 6)
                  {
                     this.dead = true;
                  }
               }
            }
            else if(this.foo3 == 3 || this.foo3 == 4)
            {
               this.foo1 += 0.2;
               this.yPos = this.originalYPos + Math.sin(this.foo1) * this.foo4;
               this.foo4 += 0.4;
               if(this.foo4 >= 24)
               {
                  this.foo4 = 24;
               }
               if(this.foo3 == 3)
               {
                  this.xVel -= 0.75;
               }
               else
               {
                  this.xVel += 0.75;
               }
               ++this.foo2;
               if(this.foo2 > 20)
               {
                  if(this.counter2++ > 0)
                  {
                     this.counter2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.counter3;
                  }
                  if(this.counter3 > 6)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is RainStormBackgroundParticleSprite)
         {
            this.yPos += 8;
            this.xPos -= 4;
            if(this.yPos > this.level.camera.yPos + this.level.camera.HEIGHT + 32)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is DewParticleSprite || this.sprite is WaterDropParticleSprite || this.sprite is RedGooDropParticleSprite || this.sprite is SnowParticleSprite || this.sprite is IceGroundParticleSprite)
         {
            this.yVel += 0.25;
            if(this.yVel >= 5)
            {
               this.yVel = 5;
            }
            x_t = int(this.xPos / Utils.TILE_WIDTH);
            y_t = int(this.yPos / Utils.TILE_HEIGHT);
            if(this.sprite is WaterDropParticleSprite && this.foo4 > 0)
            {
               if(this.yPos >= this.foo4)
               {
                  this.dead = true;
               }
            }
            else if(this.level.levelData.getTileValueAt(x_t,y_t) != 0 && this.yVel > 0 || Utils.SEA_LEVEL > 0 && this.yPos >= Utils.SEA_LEVEL)
            {
               if(this.sprite is DewParticleSprite)
               {
                  if(DewParticleSprite(this.sprite).ID == 0)
                  {
                     this.level.particlesManager.createDewDroplets(this.xPos,this.yPos);
                  }
                  else
                  {
                     this.level.collisionsManager.createHoneyCollision(this.xPos - 8,y_t * Utils.TILE_HEIGHT);
                  }
               }
               this.dead = true;
            }
         }
         else if(this.sprite is ItemExplosionParticleSprite || this.sprite is SmallWhiteExplosionParticleSprite || this.sprite is DarkExplosionParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               if(this.foo1++ > 0)
               {
                  this.foo1 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.foo2;
               }
               if(this.foo2 > 6)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is KeyItemSprite || this.sprite is BellItemSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               ++this.counter1;
               wait_time = 3;
               if(this.sprite.visible)
               {
                  wait_time = 5;
               }
               if(this.counter1 >= wait_time)
               {
                  this.counter1 = 0;
                  ++this.counter2;
                  this.sprite.visible = !this.sprite.visible;
                  if(this.counter2 > 8)
                  {
                     this.dead = true;
                  }
               }
            }
         }
         else if(this.sprite is CoinItemSprite)
         {
            if(this.yPos <= this.originalYPos - 16)
            {
               this.yPos = this.originalYPos - 16;
               this.yVel = 0;
               if(this.foo3 == 100)
               {
                  if(++this.counter3 > this.foo1)
                  {
                     this.dead = true;
                     this.level.particlesManager.itemSparkles("yellow",this.xPos + 8,this.yPos + 8,-1,null);
                  }
               }
               else if(++this.counter3 > 5)
               {
                  ++this.counter1;
                  wait_time = 3;
                  if(this.sprite.visible)
                  {
                     wait_time = 5;
                  }
                  if(this.counter1 >= wait_time)
                  {
                     this.counter1 = 0;
                     ++this.counter2;
                     this.sprite.visible = !this.sprite.visible;
                     if(this.counter2 > 8)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
         }
         else if(this.sprite is SteamParticleSprite)
         {
            this.counter1 += 0.3;
            if(this.counter1 > Math.PI * 2)
            {
               this.counter1 -= Math.PI * 2;
            }
            this.xPos = this.originalXPos + Math.sin(this.counter1) * 2;
            this.originalXPos += Utils.WIND_X_VEL;
            if(this.yPos < this.level.camera.yPos - 32)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is SmallSteamParticleSprite)
         {
            this.counter1 += 0.1;
            if(this.counter1 > Math.PI * 2)
            {
               this.counter1 -= Math.PI * 2;
            }
            this.xPos = this.originalXPos + Math.sin(this.counter1) * 1;
            if(this.counter2++ > 60)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is SpiritSmokeParticleSprite)
         {
            this.foo1 += 0.1;
            if(this.foo1 > Math.PI * 2)
            {
               this.foo1 -= Math.PI * 2;
            }
            this.xPos = this.originalXPos + Math.sin(this.foo1) * 2;
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is StreamBubbleParticleSprite || this.sprite is StreamAirParticleSprite)
         {
            this.counter1 += 0.3;
            if(this.counter1 > Math.PI * 2)
            {
               this.counter1 -= Math.PI * 2;
            }
            if(this.foo2 < 0)
            {
               this.xPos = this.originalXPos + Math.sin(this.counter1) * 2;
               if(this.yVel > 0)
               {
                  this.yVel += 0.05;
                  if(this.yVel > 3)
                  {
                     this.yVel = 3;
                  }
                  if(this.yPos > this.foo1)
                  {
                     if(this.counter2++ > 0)
                     {
                        this.counter2 = 0;
                        this.sprite.visible = !this.sprite.visible;
                        ++this.counter3;
                     }
                     if(this.counter3 > 6)
                     {
                        this.dead = true;
                     }
                  }
               }
               else
               {
                  this.yVel -= 0.05;
                  if(this.yVel < -3)
                  {
                     this.yVel = -3;
                  }
                  if(this.yPos < this.foo1)
                  {
                     if(this.counter2++ > 0)
                     {
                        this.counter2 = 0;
                        this.sprite.visible = !this.sprite.visible;
                        ++this.counter3;
                     }
                     if(this.counter3 > 6)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
            else
            {
               this.yPos = this.originalYPos + Math.sin(this.counter1) * 2;
               if(this.xVel > 0)
               {
                  this.xVel += 0.05;
                  if(this.xVel > 3)
                  {
                     this.xVel = 3;
                  }
                  if(this.xPos > this.foo1)
                  {
                     if(this.counter2++ > 0)
                     {
                        this.counter2 = 0;
                        this.sprite.visible = !this.sprite.visible;
                        ++this.counter3;
                     }
                     if(this.counter3 > 6)
                     {
                        this.dead = true;
                     }
                  }
               }
               else
               {
                  this.xVel -= 0.05;
                  if(this.xVel < -3)
                  {
                     this.xVel = -3;
                  }
                  if(this.xPos < this.foo1)
                  {
                     if(this.counter2++ > 0)
                     {
                        this.counter2 = 0;
                        this.sprite.visible = !this.sprite.visible;
                        ++this.counter3;
                     }
                     if(this.counter3 > 6)
                     {
                        this.dead = true;
                     }
                  }
               }
            }
            diff_x = this.xPos - (this.level.camera.xPos + this.level.camera.HALF_WIDTH);
            if(diff_x > this.level.camera.WIDTH)
            {
               this.dead = true;
            }
            if(this.sprite is StreamBubbleParticleSprite)
            {
               if(this.yPos <= Utils.SEA_LEVEL)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is RockBackgroundParticleSprite)
         {
            if(this.foo2-- > 0)
            {
               this.sprite.visible = false;
               this.yPos = this.originalYPos;
            }
            else
            {
               this.sprite.visible = true;
               this.yVel = 5 + this.foo3;
               if(this.yPos >= this.level.camera.yPos + this.level.camera.HEIGHT + 8)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is GeiserBubbleParticleSprite)
         {
            if(this.foo2-- > 0)
            {
               this.sprite.visible = false;
               this.yPos = this.originalYPos;
            }
            else
            {
               this.yVel *= 1.05;
               if(this.yVel <= -2 * this.foo3)
               {
                  this.yVel = -2 * this.foo3;
               }
               else if(this.yVel > -0.2 * this.foo3)
               {
                  this.yVel = -0.2 * this.foo3;
               }
               this.sprite.visible = true;
               if(this.sprite.gfxHandleClip().currentFrame == 1)
               {
                  this.xPos = this.originalXPos + int(Math.floor(Math.sin(this.foo1) * 4));
                  this.foo1 += 0.125;
               }
               else
               {
                  this.xPos = this.originalXPos + int(Math.floor(Math.sin(this.foo1) * 2));
                  this.foo1 += 0.25;
               }
               if(this.collision != null)
               {
                  if(this.yPos <= this.collision.yValue)
                  {
                     this.dead = true;
                  }
               }
               else
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is WaterBubbleParticleSprite || this.sprite is WaterBigBubbleParticleSprite || this.sprite is LavaBubbleParticleSprite)
         {
            if(this.foo2-- > 0)
            {
               this.sprite.visible = false;
               this.yPos = this.originalYPos;
            }
            else
            {
               this.yVel *= 1.05;
               if(this.yVel <= -2 * this.foo3)
               {
                  this.yVel = -2 * this.foo3;
               }
               else if(this.yVel > -0.2 * this.foo3)
               {
                  this.yVel = -0.2 * this.foo3;
               }
               this.sprite.visible = true;
               if(this.sprite.gfxHandleClip().currentFrame == 1)
               {
                  this.xPos = this.originalXPos + int(Math.floor(Math.sin(this.foo1) * 4));
                  this.foo1 += 0.125;
               }
               else
               {
                  this.xPos = this.originalXPos + int(Math.floor(Math.sin(this.foo1) * 2));
                  this.foo1 += 0.25;
               }
               if(this.yPos <= Utils.SEA_LEVEL || this.yPos >= this.level.camera.yPos + this.level.camera.HEIGHT * 1.5)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is ExplosionParticleSprite || this.sprite is ImpactParticleSprite || this.sprite is DustParticleSprite || this.ID == GenericParticleSprite.BIG_EXPLOSION)
         {
            --this.foo1;
            if(this.foo1 > 0)
            {
               this.sprite.visible = false;
            }
            else if(this.foo1 == 0)
            {
               this.DO_NOT_UPDATE = false;
               this.sprite.visible = true;
               this.sprite.gfxHandleClip().play();
            }
            else if(this.foo1 < 0)
            {
               if(this.sprite.gfxHandleClip().isComplete)
               {
                  if(this.sprite is ExplosionParticleSprite)
                  {
                     this.dead = true;
                  }
                  if(this.foo2++ > 0)
                  {
                     this.foo2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                     ++this.foo3;
                  }
                  if(this.foo3 > 6)
                  {
                     this.dead = true;
                  }
               }
            }
         }
      }
      
      public function updateFreeze() : void
      {
         if(this.sprite is FireExplosionParticleSprite || this.sprite is FireSmallExplosionParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               this.dead = true;
            }
         }
         else if(this.sprite is ItemExplosionParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               if(this.foo1++ > 0)
               {
                  this.foo1 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.foo2;
               }
               if(this.foo2 > 6)
               {
                  this.dead = true;
               }
            }
         }
         else if(this.sprite is BubbleItemBurstParticleSprite)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               ++this.counter2;
               if(this.counter2 >= 3)
               {
                  this.counter2 = 0;
                  this.sprite.visible = !this.sprite.visible;
                  ++this.counter3;
                  if(this.counter3 >= 7)
                  {
                     this.dead = true;
                  }
               }
            }
         }
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.entity != null)
         {
            if(this.sprite is BigEnergyParticleSprite)
            {
               this.sprite.x = int(Math.floor(this.xPos - camera.xPos));
               this.sprite.y = int(Math.floor(this.yPos - camera.yPos));
            }
            else
            {
               this.sprite.x = int(Math.floor(this.entity.xPos + this.originalXPos + this.xPos - camera.xPos));
               this.sprite.y = int(Math.floor(this.entity.yPos + this.originalYPos + this.yPos - camera.yPos));
            }
         }
         else
         {
            this.sprite.x = int(Math.floor(this.xPos - camera.xPos));
            this.sprite.y = int(Math.floor(this.yPos - camera.yPos));
         }
         this.sprite.updateScreenPosition();
      }
      
      public function updatePostScreenPosition(camera:ScreenCamera) : void
      {
         if(this.sprite is FiftyCoinsParticleSprite)
         {
            Utils.gameMovie.setChildIndex(this.sprite,Utils.gameMovie.numChildren - 1);
         }
      }
      
      public function assignNewValues(_sprite:GameSprite, _xPos:Number, _yPos:Number, _xVel:Number, _yVel:Number, _friction:Number, _foo1:Number = 0, _foo2:Number = 0, _foo3:Number = 0, _foo4:Number = 0) : void
      {
         this.ID = -1;
         this.removeSprite();
         this.sprite = _sprite;
         if(this.sprite is GenericParticleSprite)
         {
            this.ID = GenericParticleSprite(this.sprite).TYPE;
         }
         if(this.sprite is FiftyCoinsParticleSprite)
         {
            Utils.gameMovie.addChild(this.sprite);
         }
         else
         {
            this.container.addChild(this.sprite);
         }
         this.sound_counter = 0;
         this.foo1 = _foo1;
         this.foo2 = _foo2;
         this.foo3 = _foo3;
         this.foo4 = _foo4;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.DO_NOT_UPDATE = false;
         this.xPos = this.originalXPos = _xPos;
         this.yPos = this.originalYPos = _yPos;
         this.xVel = _xVel;
         this.yVel = _yVel;
         this.friction = _friction;
         this.dead = false;
         this.entity = null;
         this.collision = null;
      }
      
      public function removeSprite() : void
      {
         if(this.sprite != null)
         {
            if(this.sprite is FiftyCoinsParticleSprite)
            {
               Utils.gameMovie.removeChild(this.sprite);
            }
            else
            {
               this.container.removeChild(this.sprite);
            }
            this.sprite.destroy();
            this.sprite.dispose();
            this.sprite = null;
         }
      }
      
      public function setEntity(_entity:Entity = null) : void
      {
         if(_entity != null)
         {
            this.entity = _entity;
            this.xPos = this.yPos = 0;
         }
      }
   }
}
