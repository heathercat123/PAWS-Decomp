package entities.bullets
{
   import entities.Entity;
   import entities.enemies.*;
   import flash.geom.Rectangle;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.*;
   import sprites.*;
   import sprites.bullets.*;
   import sprites.bullets.vehicles.TankBulletSprite;
   import sprites.items.*;
   import sprites.particles.*;
   
   public class Bullet extends Entity
   {
       
      
      protected var foo1:Number;
      
      protected var foo2:Number;
      
      protected var foo3:Number;
      
      protected var foo4:Number;
      
      protected var counter4:int;
      
      protected var counter5:int;
      
      protected var IS_DISAPPEARING:Boolean;
      
      protected var disappear_counter1:int;
      
      protected var disappear_counter2:int;
      
      protected var disappear_counter3:int;
      
      public var IS_PACIFIST_BULLET:Boolean;
      
      protected var IS_ON_GROUND:Boolean;
      
      public var IS_HELPER:Boolean;
      
      public var IS_DAMAGING_ENEMIES_TOO:Boolean;
      
      public var POWER:Number;
      
      public var RADIUS:Number;
      
      public var ID:int;
      
      public var TYPE:int;
      
      public function Bullet(_level:Level, _xPos:Number, _yPos:Number, _xVel:Number, _yVel:Number)
      {
         super(_level,_xPos,_yPos,0);
         sprite = null;
         this.ID = this.TYPE = -1;
         xVel = _xVel;
         yVel = _yVel;
         AVOID_COLLISION_DETECTION = this.IS_ON_GROUND = this.IS_PACIFIST_BULLET = this.IS_DISAPPEARING = this.IS_HELPER = this.IS_DAMAGING_ENEMIES_TOO = false;
         this.POWER = 1;
         this.RADIUS = 8;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         var x_t:int = 0;
         var y_t:int = 0;
         var time_limit:int = 0;
         var dist_x:Number = NaN;
         var dist_y:Number = NaN;
         var distance:Number = NaN;
         var ___amount:int = 0;
         var speed_power:Number = NaN;
         var pSprite:FireBallBulletParticleSprite = null;
         var _type:int = 0;
         var xRef:Number = NaN;
         var yRef:Number = NaN;
         xVel *= x_friction;
         yVel *= x_friction;
         xPos += xVel;
         oldYPos = yPos;
         yPos += yVel;
         if(sprite is BaseballBulletSprite || this.ID == GenericBulletSprite.POGO_STICK || this.ID == GenericBulletSprite.PARASOL || this.ID == GenericBulletSprite.WATER_CANNON)
         {
            aabbPhysics.x = aabb.x = -3.5;
            aabbPhysics.y = aabb.y = -3.5;
            aabbPhysics.width = aabb.width = 7;
            aabbPhysics.height = aabb.height = 6.5;
            if(counter1++ > 30)
            {
               AVOID_COLLISION_DETECTION = false;
            }
            if(this.ID != GenericBulletSprite.WATER_CANNON)
            {
               yVel += 0.1;
            }
            if(this.ID == GenericBulletSprite.WATER_CANNON)
            {
               if(Math.abs(xPos - originalXPos) >= 64)
               {
                  if(xVel > 0)
                  {
                     xPos = int(originalXPos + 64);
                  }
                  else
                  {
                     xPos = int(originalXPos - 64);
                  }
                  dead = true;
                  if(this.foo1 < 1)
                  {
                     level.particlesManager.createWaterCannonImpactParticle(xPos,yPos,xVel);
                  }
               }
            }
            else
            {
               ++this.disappear_counter1;
               if(this.disappear_counter1 > 90)
               {
                  this.IS_DISAPPEARING = true;
                  ++this.disappear_counter2;
                  wait_time = 2;
                  if(sprite.visible)
                  {
                     wait_time = 4;
                  }
                  if(this.disappear_counter2 >= wait_time)
                  {
                     this.disappear_counter2 = 0;
                     ++this.disappear_counter3;
                     sprite.visible = !sprite.visible;
                     if(this.disappear_counter3 > 6)
                     {
                        dead = true;
                     }
                  }
               }
            }
            if(sprite is GenericBulletSprite)
            {
               if(this.ID == GenericBulletSprite.POGO_STICK || this.ID == GenericBulletSprite.PARASOL)
               {
                  ++counter1;
                  if(counter1 >= 15)
                  {
                     counter1 = 0;
                     if(sprite.scaleX > 0)
                     {
                        sprite.rotation -= Math.PI * 0.5;
                     }
                     else
                     {
                        sprite.rotation += Math.PI * 0.5;
                     }
                  }
               }
            }
            if(Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL)
            {
               xVel *= 0.9;
               yVel *= 0.75;
               sprite.gfxHandleClip().stop();
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
         }
         else if(this.ID == GenericBulletSprite.BEACH_BALL)
         {
            aabbPhysics.x = aabb.x = aabbPhysics.y = aabb.y = -9;
            aabbPhysics.width = aabb.width = aabbPhysics.height = aabb.height = 17;
            frame_counter += Math.abs(xVel) * 0.1;
            if(frame_counter >= 12)
            {
               frame_counter -= 12;
            }
            this.foo4 = yVel;
            yVel += 0.1;
            if(Utils.SEA_LEVEL > 0)
            {
               if(yPos + 8 >= Utils.SEA_LEVEL)
               {
                  xVel = Utils.SEA_X_SHIFT * 0.015;
                  yPos = Utils.SEA_LEVEL - 8;
                  if(yVel >= 0)
                  {
                     yVel = 0;
                  }
               }
            }
         }
         else if(sprite is PollenBulletSprite)
         {
            aabbPhysics.x = aabbPhysics.y = aabb.x = aabb.y = -3;
            aabbPhysics.width = aabbPhysics.height = aabb.width = aabb.height = 6;
            if(Math.abs(xVel) < 0.2 && Math.abs(yVel) < 0.2)
            {
               if(this.foo3 < 0)
               {
                  aabbPhysics.height = 3;
                  xVel = yVel = 0;
                  --this.foo3;
                  if(this.foo3 <= -20)
                  {
                     ++this.disappear_counter2;
                     wait_time = 2;
                     if(sprite.visible)
                     {
                        wait_time = 4;
                     }
                     if(this.disappear_counter2 >= wait_time)
                     {
                        this.disappear_counter2 = 0;
                        ++this.disappear_counter3;
                        sprite.visible = !sprite.visible;
                        if(this.disappear_counter3 > 6)
                        {
                           dead = true;
                        }
                     }
                  }
               }
               else
               {
                  yVel = 0.05;
                  yPos += 1;
                  this.foo1 += 0.2;
                  xPos = originalXPos + Math.sin(this.foo1) * 2;
               }
            }
            else
            {
               originalXPos = xPos;
            }
         }
         else if(sprite is BoneBulletSprite)
         {
            aabbPhysics.x = aabb.x = -6;
            aabbPhysics.y = aabb.y = -6;
            aabbPhysics.width = aabb.width = 12;
            aabbPhysics.height = aabb.height = 12;
            if(counter1++ > 15)
            {
               AVOID_COLLISION_DETECTION = false;
            }
            yVel += 0.1;
            ++this.disappear_counter1;
            if(this.disappear_counter1 > 90)
            {
               this.IS_DISAPPEARING = true;
               ++this.disappear_counter2;
               wait_time = 2;
               if(sprite.visible)
               {
                  wait_time = 4;
               }
               if(this.disappear_counter2 >= wait_time)
               {
                  this.disappear_counter2 = 0;
                  ++this.disappear_counter3;
                  sprite.visible = !sprite.visible;
                  if(this.disappear_counter3 > 6)
                  {
                     dead = true;
                  }
               }
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
         }
         else if(sprite is VaseBulletSprite)
         {
            aabbPhysics.x = aabb.x = -6;
            aabbPhysics.y = aabb.y = -6;
            aabbPhysics.width = aabb.width = 12;
            aabbPhysics.height = aabb.height = 12;
            yVel += 0.1;
         }
         else if(sprite is EggBulletSprite)
         {
            aabbPhysics.x = aabb.x = -5;
            aabbPhysics.y = aabb.y = -5;
            aabbPhysics.width = aabb.width = 10;
            aabbPhysics.height = aabb.height = 10;
            yVel += 0.1;
            if(Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL)
            {
               yVel *= 0.75;
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
         }
         else if(sprite is BoulderBulletSprite)
         {
            aabb.x = aabb.y = aabbPhysics.x = aabbPhysics.y = -23;
            aabb.width = aabb.height = aabbPhysics.width = aabbPhysics.height = 46;
            if(this.foo3 == 2 || this.foo3 == 3)
            {
               aabb.width = aabb.height = 0;
               counter1 = 0;
            }
            if(this.foo3 == 1)
            {
               --counter2;
               if(this.IS_ON_GROUND && yVel >= 0)
               {
                  if(this.foo4 >= 0)
                  {
                     xVel = 0.5;
                  }
                  else
                  {
                     xVel = -0.5;
                  }
               }
            }
            else if(this.foo3 == 2)
            {
               this.foo3 = 3;
               x_t = getTileX(0);
               y_t = getTileY(0);
               level.levelData.setTileValueAt(x_t,y_t,1);
               level.levelData.setTileValueAt(x_t - 1,y_t,1);
               level.levelData.setTileValueAt(x_t + 1,y_t,1);
               level.levelData.setTileValueAt(x_t,y_t + 1,1);
               level.levelData.setTileValueAt(x_t - 1,y_t + 1,1);
               level.levelData.setTileValueAt(x_t + 1,y_t + 1,1);
               level.levelData.setTileValueAt(x_t,y_t - 1,1);
               level.levelData.setTileValueAt(x_t - 1,y_t - 1,5);
               level.levelData.setTileValueAt(x_t + 1,y_t - 1,4);
               AVOID_COLLISION_DETECTION = true;
               xVel = yVel = 0;
               xPos = int(x_t * Utils.TILE_WIDTH + 8);
               yPos = int(y_t * Utils.TILE_HEIGHT + 8);
            }
            else if(this.foo3 == 3)
            {
               AVOID_COLLISION_DETECTION = true;
               xVel = yVel = 0;
               gravity_friction = 0;
            }
            if(counter1++ > (AVOID_COLLISION_DETECTION ? this.foo2 * 0.25 : this.foo2))
            {
               counter1 = 0;
               if(this.foo1 < 0.5 || this.foo4 >= 0.5)
               {
                  sprite.rotation += Math.PI * 0.5;
               }
               else
               {
                  sprite.rotation -= Math.PI * 0.5;
               }
            }
            if(this.foo3 == 0 || this.foo3 == 1)
            {
               yVel += 0.1;
            }
            if(yVel >= 4)
            {
               yVel = 4;
            }
            if(yPos >= level.camera.yPos + level.camera.HEIGHT + 32)
            {
               dead = true;
            }
         }
         else if(sprite is CometBulletSprite)
         {
            if(this.foo1 == 1)
            {
               AVOID_COLLISION_DETECTION = true;
               if(yPos >= 368)
               {
                  AVOID_COLLISION_DETECTION = false;
                  this.foo1 = 0;
               }
            }
            else if(this.foo1 == 2)
            {
               AVOID_COLLISION_DETECTION = true;
            }
            if(sprite.gfxHandleClip().frame == 1)
            {
               aabb.x = aabb.y = -12;
               aabb.width = aabb.height = 24;
               aabbPhysics.x = aabbPhysics.y = -12;
               aabbPhysics.width = aabbPhysics.height = 24;
            }
            else
            {
               aabb.x = aabb.y = -8;
               aabb.width = aabb.height = 16;
               aabbPhysics.x = aabbPhysics.y = -12;
               aabbPhysics.width = aabbPhysics.height = 24;
            }
            if(yPos >= Utils.SEA_LEVEL && this.foo4 == 0)
            {
               this.foo4 = 1;
               yVel = 0;
               SoundSystem.PlaySound("water_splash");
               if(sprite.gfxHandleClip().frame == 1)
               {
                  level.topParticlesManager.pushParticle(new SplashBigLavaParticleSprite(),xPos,yPos,0,0,0);
               }
               else
               {
                  level.topParticlesManager.pushParticle(new SplashLavaParticleSprite(),xPos,yPos,0,0,0);
               }
               level.collisionsManager.setLavaOnTop();
            }
            if(yPos >= level.camera.yPos + level.camera.HEIGHT + 64)
            {
               dead = true;
            }
            if(this.foo4 == 1)
            {
               if(counter1++ > 2)
               {
                  yVel += 0.02;
                  if(yVel > 1)
                  {
                     yVel = 1;
                  }
               }
            }
            else if(this.foo3-- < 0)
            {
               yVel += 0.1;
            }
            if(yVel >= 4)
            {
               yVel = 4;
            }
            if(counter2 == 1)
            {
               this.IS_DISAPPEARING = true;
               ++this.disappear_counter2;
               wait_time = 2;
               if(sprite.visible)
               {
                  wait_time = 4;
               }
               if(this.disappear_counter2 >= wait_time)
               {
                  this.disappear_counter2 = 0;
                  ++this.disappear_counter3;
                  sprite.visible = !sprite.visible;
                  if(this.disappear_counter3 > 6)
                  {
                     dead = true;
                  }
               }
            }
         }
         else if(sprite is FirePlantBulletSprite)
         {
            aabb.x = -3.5;
            aabb.y = -3.5;
            aabb.width = 7;
            aabb.height = 6.5;
            aabbPhysics.x = -1;
            aabbPhysics.y = -1;
            aabbPhysics.width = 2;
            aabbPhysics.height = 2;
            this.RADIUS = 4.5;
            if(this.foo4 != 1)
            {
               if(this.foo1++ > 10)
               {
                  yVel += 0.1;
               }
            }
            if(xPos < level.camera.xPos - Utils.TILE_WIDTH)
            {
               dead = true;
            }
            else if(xPos > level.camera.xPos + level.camera.WIDTH + Utils.TILE_WIDTH)
            {
               dead = true;
            }
            else if(yPos >= Utils.SEA_LEVEL && Utils.SEA_LEVEL > 0 && this.foo4 != 1)
            {
               dead = true;
            }
            time_limit = 3;
            if(this.foo4 == 1)
            {
               time_limit = 5;
            }
            ++this.foo2;
            if(this.foo2 > time_limit)
            {
               this.foo2 = 0;
               if(this.foo4 == 1)
               {
                  level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(5),xPos,yPos,0,0,0);
               }
               else
               {
                  level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(0),xPos,yPos,0,0,0);
               }
               Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            }
         }
         else if(sprite is FireFlameBulletSprite)
         {
            AVOID_COLLISION_DETECTION = true;
            aabb.x = aabb.y = -3;
            aabb.width = aabb.height = 6;
            ++this.foo2;
            if(this.foo2 < 15)
            {
               this.IS_DISAPPEARING = true;
            }
            else
            {
               this.IS_DISAPPEARING = false;
            }
            ++this.disappear_counter1;
            if(this.disappear_counter1 > 120)
            {
               this.IS_DISAPPEARING = true;
               ++this.disappear_counter2;
               wait_time = 2;
               if(sprite.visible)
               {
                  wait_time = 4;
               }
               if(this.disappear_counter2 >= wait_time)
               {
                  this.disappear_counter2 = 0;
                  ++this.disappear_counter3;
                  sprite.visible = !sprite.visible;
                  if(this.disappear_counter3 > 6)
                  {
                     dead = true;
                  }
               }
            }
         }
         else if(sprite is SnowballFloatingBulletSprite)
         {
            aabbPhysics.x = aabb.x = -6;
            aabbPhysics.y = aabb.y = -6;
            aabbPhysics.width = aabb.width = 12;
            aabbPhysics.height = aabb.height = 12;
            if(counter1++ > 30)
            {
               AVOID_COLLISION_DETECTION = false;
            }
            if(counter2 > 1)
            {
               dead = true;
               this.blow();
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
         }
         else if(sprite is SnowballBulletSprite)
         {
            aabbPhysics.x = aabb.x = -8;
            aabbPhysics.y = aabb.y = -8;
            aabbPhysics.width = aabb.width = 16;
            aabbPhysics.height = aabb.height = 15;
            if(counter1++ > 30)
            {
               AVOID_COLLISION_DETECTION = false;
            }
            yVel += 0.1;
            if(counter2 > 1)
            {
               dead = true;
               this.blow();
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
         }
         else if(sprite is BubbleHelperBulletSprite)
         {
            aabbPhysics.x = -1;
            aabb.x = -4;
            aabbPhysics.y = -1;
            aabb.y = -4;
            aabbPhysics.width = 2;
            aabb.width = 8;
            aabbPhysics.height = 2;
            aabb.height = 8;
            if(this.foo1 == 0)
            {
               if(Utils.SEA_LEVEL > 0)
               {
                  if(yPos > Utils.SEA_LEVEL)
                  {
                     dead = true;
                  }
               }
               dist_x = xPos - originalXPos;
               dist_y = yPos - originalYPos;
               distance = Math.sqrt(dist_x * dist_x + dist_y * dist_y);
               if(distance > 56)
               {
                  dead = true;
               }
            }
            else if(yPos <= Utils.SEA_LEVEL)
            {
               dead = true;
            }
         }
         else if(sprite is ThunderHelperBulletSprite)
         {
            aabbPhysics.x = aabb.x = -4;
            aabbPhysics.y = aabb.y = -7;
            aabbPhysics.width = aabb.width = 8;
            aabbPhysics.height = aabb.height = 9;
            if(this.foo2 == 1)
            {
               aabbPhysics.width = aabbPhysics.height = 0;
               aabb.x = aabb.y = -16;
               aabb.width = aabb.height = 32;
               sprite.visible = false;
               ++this.foo3;
               if(this.foo3 >= 72)
               {
                  dead = true;
               }
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
            if(this.foo3 < 0.5)
            {
               if(Utils.SEA_LEVEL != 0)
               {
                  if(yPos >= Utils.SEA_LEVEL && this.foo2 == 0)
                  {
                     this.groundCollision();
                  }
               }
            }
            else if(Math.abs(yPos - originalYPos) >= 32)
            {
               dead = true;
            }
         }
         else if(sprite is FireFloatingBulletSprite)
         {
            this.RADIUS = 4.5;
            aabbPhysics.x = aabb.x = -3;
            aabbPhysics.y = aabb.y = -3;
            aabbPhysics.width = aabb.width = 6;
            aabbPhysics.height = aabb.height = 5;
            if(!this.isInsideScreen())
            {
               dead = true;
            }
            ++this.foo2;
            ___amount = 6;
            if(this.foo2 > ___amount)
            {
               this.foo2 = 0;
               level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(4),xPos,yPos,0,0,0);
               Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            }
         }
         else if(this.ID == GenericBulletSprite.ARROW_HELPER)
         {
            aabbPhysics.width = aabbPhysics.height = 0;
            if(xVel > 0)
            {
               DIRECTION = RIGHT;
            }
            else
            {
               DIRECTION = LEFT;
            }
         }
         else if(sprite is SeedHelperBulletSprite || this.ID == GenericBulletSprite.ROCK || this.ID == GenericBulletSprite.ROCK_NO_DAMAGE)
         {
            aabbPhysics.x = aabb.x = -3;
            aabbPhysics.y = aabb.y = -3;
            aabbPhysics.width = aabb.width = 6;
            aabbPhysics.height = aabb.height = 5;
            if(!this.isInsideScreen())
            {
               dead = true;
            }
            speed_power = Math.sqrt(xVel * xVel + yVel * yVel);
            frame_counter += speed_power * 0.1;
            if(frame_counter >= 4)
            {
               frame_counter -= 4;
            }
            if(xVel > 0)
            {
               DIRECTION = RIGHT;
            }
            else
            {
               DIRECTION = LEFT;
            }
            if(Utils.SEA_LEVEL != 0)
            {
               if(Utils.IS_LAVA)
               {
                  if(yPos >= Utils.SEA_LEVEL - 4)
                  {
                     dead = true;
                     this.fireBulletImpact();
                  }
               }
               else if(yPos >= Utils.SEA_LEVEL - 4)
               {
                  this.groundCollision();
                  yVel = 0;
               }
            }
            yVel += 0.2;
            if(yVel >= 8)
            {
               yVel = 8;
            }
            if(Math.abs(xVel) < 0.01)
            {
               ++this.disappear_counter1;
            }
            if(this.disappear_counter1 >= 1)
            {
               if(sprite is SeedHelperBulletSprite && (this.TYPE == 0 || this.TYPE == 2))
               {
                  if(this.disappear_counter1 >= 240)
                  {
                     dead = true;
                  }
               }
               else
               {
                  if(this.disappear_counter1 >= 30)
                  {
                     dead = true;
                  }
                  if(this.disappear_counter1 >= 25)
                  {
                     aabb.width = 0;
                  }
               }
            }
            else if(this.ID != GenericBulletSprite.ROCK_NO_DAMAGE)
            {
               ++this.foo2;
               ___amount = 6;
               if(sprite is SeedHelperBulletSprite)
               {
                  ___amount = 3;
               }
               if(this.foo2 > ___amount && Math.abs(xVel) > 0.1)
               {
                  this.foo2 = 0;
                  if(sprite is SeedHelperBulletSprite)
                  {
                     if(this.TYPE == 1)
                     {
                        level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(1),xPos,yPos,0,0,0);
                     }
                  }
                  else if(this.ID == GenericBulletSprite.ROCK)
                  {
                     level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(3),xPos,yPos,0,0,0);
                  }
                  else
                  {
                     level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(2),xPos,yPos,0,0,0);
                  }
                  Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
               }
            }
         }
         else if(this.ID == GenericBulletSprite.INK)
         {
            aabb.x = -3.5;
            aabb.y = -3.5;
            aabb.width = 7;
            aabb.height = 6.5;
            aabbPhysics.x = -1;
            aabbPhysics.y = -1;
            aabbPhysics.width = 2;
            aabbPhysics.height = 2;
            if(this.foo3 >= 0)
            {
               if(this.foo1++ > 10)
               {
                  yVel += 0.1;
               }
            }
            ++counter1;
            if(counter1 > 6)
            {
               counter1 = 0;
               level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(2),xPos,yPos,0,0,0);
               Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            }
            if(Utils.SEA_LEVEL > 0)
            {
               if(yPos >= Utils.SEA_LEVEL)
               {
                  dead = true;
               }
            }
         }
         else if(sprite is SpikedBulletSprite)
         {
            yVel += 0.1;
            if(this.foo2 >= 2)
            {
               if(yVel >= 4)
               {
                  yVel = 4;
               }
            }
            else if(yVel >= 2)
            {
               yVel = 2;
            }
            aabbPhysics.x = aabb.x = -6;
            aabbPhysics.y = aabb.y = -6;
            aabbPhysics.width = aabb.width = 12;
            aabbPhysics.height = aabb.height = 12;
            if(!this.isInsideScreen())
            {
               dead = true;
            }
         }
         else if(sprite is FireballBlueGeneralBulletSprite)
         {
            aabbPhysics.x = aabb.x = -6;
            aabbPhysics.y = aabb.y = -6;
            aabbPhysics.width = aabb.width = 12;
            aabbPhysics.height = aabb.height = 12;
            if(!this.isInsideScreen())
            {
               dead = true;
            }
            ++counter1;
            if(counter1 > 10)
            {
               counter1 = 0;
               pSprite = new FireBallBulletParticleSprite();
               pSprite.gfxHandleClip().setFrameDuration(0,0.1);
               pSprite.gfxHandleClip().setFrameDuration(1,0.1);
               pSprite.gfxHandleClip().setFrameDuration(2,0.1);
               level.particlesManager.pushParticle(pSprite,xPos,yPos,0,0,0);
               Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            }
         }
         else if(sprite is FireballBulletSprite)
         {
            _type = int(FireballBulletSprite(sprite).TYPE);
            aabbPhysics.x = aabb.x = -6;
            aabbPhysics.y = aabb.y = -6;
            aabbPhysics.width = aabb.width = 12;
            aabbPhysics.height = aabb.height = 12;
            this.RADIUS = 8;
            if(counter1++ > 30)
            {
               AVOID_COLLISION_DETECTION = false;
            }
            if(_type == 0)
            {
               if(this.foo2 <= 0)
               {
                  if(this.foo1 == 0)
                  {
                     yVel += 0.1;
                  }
               }
               else if(this.foo2++ > 11)
               {
                  yVel += 0.1;
               }
               if(counter2 > 1)
               {
                  dead = true;
                  this.blow();
               }
               if(!this.isInsideScreen())
               {
                  dead = true;
               }
               if(this.foo1 == 0)
               {
                  ++counter1;
                  if(counter1 > 3)
                  {
                     counter1 = 0;
                     level.particlesManager.pushParticle(new FireBallBulletParticleSprite(),xPos,yPos,0,0,0);
                     Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
                  }
               }
               else
               {
                  ++counter1;
                  if(counter1 > 10)
                  {
                     counter1 = 0;
                     pSprite = new FireBallBulletParticleSprite();
                     pSprite.gfxHandleClip().setFrameDuration(0,0.1);
                     pSprite.gfxHandleClip().setFrameDuration(1,0.1);
                     pSprite.gfxHandleClip().setFrameDuration(2,0.1);
                     level.particlesManager.pushParticle(pSprite,xPos,yPos,0,0,0);
                     Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
                  }
               }
            }
            else if(_type == 1)
            {
               ++counter1;
               if(counter1 > 15)
               {
                  counter1 = 0;
                  level.particlesManager.pushParticle(new FirePlantBulletParticleSprite(2),xPos,yPos,0,0,0);
                  Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
               }
            }
         }
         else if(sprite is TankBulletSprite)
         {
            aabbPhysics.x = aabb.x = -12;
            aabbPhysics.y = aabb.y = -12;
            aabbPhysics.width = aabb.width = 24;
            aabbPhysics.height = aabb.height = 24;
            AVOID_COLLISION_DETECTION = true;
            if(!this.isInsideScreen())
            {
               dead = true;
            }
            ++this.foo2;
            if(this.foo2 > 2)
            {
               this.foo2 = 0;
               level.particlesManager.pushBackParticle(new FireBallBigBulletParticleSprite(),xPos,yPos,0,0,0);
            }
            if(counter3 > -1)
            {
               ++counter3;
               if(counter3 > 2)
               {
                  dead = true;
               }
            }
         }
         else if(sprite is FireballBigBulletSprite)
         {
            aabbPhysics.x = aabb.x = -12;
            aabbPhysics.y = aabb.y = -12;
            aabbPhysics.width = aabb.width = 24;
            aabbPhysics.height = aabb.height = 24;
            if(counter1++ > 20)
            {
               AVOID_COLLISION_DETECTION = false;
            }
            yVel += 0.1;
            if(counter2 > 1)
            {
               dead = true;
               this.blow();
            }
            if(!this.isInsideScreen())
            {
               dead = true;
            }
            ++this.foo2;
            if(this.foo2 > 2)
            {
               this.foo2 = 0;
               level.particlesManager.pushParticle(new FireBallBigBulletParticleSprite(),xPos,yPos,0,0,0);
               Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            }
         }
         else if(sprite is SnowballBigBulletSprite)
         {
            aabbPhysics.x = aabb.x = -12;
            aabbPhysics.y = aabb.y = -12;
            aabbPhysics.width = aabb.width = 24;
            aabbPhysics.height = aabb.height = 24;
            xRef = 2400;
            yRef = 48;
            ++this.foo2;
            ++this.foo3;
            if(xVel < 0)
            {
               if(xPos - 12 < xRef)
               {
                  xPos = xRef + 12;
                  xVel = Math.abs(xVel);
                  sprite.gfxHandleClip().gotoAndPlay(1);
                  SoundSystem.PlaySound("giant_bullet_impact");
                  if(this.foo2 > 60)
                  {
                     ++this.foo1;
                     this.foo2 = 0;
                  }
               }
            }
            else if(xPos + 12 > xRef + 224)
            {
               xPos = xRef + 224 - 12;
               xVel = -Math.abs(xVel);
               sprite.gfxHandleClip().gotoAndPlay(1);
               SoundSystem.PlaySound("giant_bullet_impact");
               if(this.foo2 > 60)
               {
                  ++this.foo1;
                  this.foo2 = 0;
               }
            }
            if(yVel < 0)
            {
               if(yPos - 12 < yRef)
               {
                  yPos = yRef + 12;
                  yVel = Math.abs(yVel);
                  sprite.gfxHandleClip().gotoAndPlay(1);
                  SoundSystem.PlaySound("giant_bullet_impact");
                  if(this.foo2 > 60)
                  {
                     ++this.foo1;
                     this.foo2 = 0;
                  }
               }
            }
            else if(yPos + 12 >= level.camera.yPos + level.camera.HEIGHT)
            {
               SoundSystem.PlaySound("giant_bullet_impact");
               yVel = -Math.abs(yVel);
               yPos = level.camera.yPos + level.camera.HEIGHT - 12;
               sprite.gfxHandleClip().gotoAndPlay(1);
               if(this.foo2 > 60)
               {
                  ++this.foo1;
                  this.foo2 = 0;
               }
            }
            if(this.foo1 >= 2)
            {
               dead = true;
               this.blowBig();
            }
         }
         if(!AVOID_COLLISION_DETECTION)
         {
            level.levelPhysics.collisionDetectionMap(this);
         }
      }
      
      protected function destroyEgg() : void
      {
         if(Utils.SEA_LEVEL > 0)
         {
            if(yPos < Utils.SEA_LEVEL)
            {
               SoundSystem.PlaySound("egg_impact");
            }
         }
         else
         {
            SoundSystem.PlaySound("egg_impact");
         }
         level.particlesManager.eggExplosion(xPos,yPos);
      }
      
      public function checkCollisionsCollision() : void
      {
         var i:int = 0;
         if(dead || this.IS_DISAPPEARING)
         {
            return;
         }
         if(this.IS_HELPER || sprite is FireFloatingBulletSprite)
         {
            for(i = 0; i < level.collisionsManager.collisions.length; i++)
            {
               if(level.collisionsManager.collisions[i] != null)
               {
                  if(level.collisionsManager.collisions[i].isBulletCollision(this))
                  {
                     this.setDead();
                     level.collisionsManager.collisions[i].bulletCollision(this);
                  }
               }
            }
         }
      }
      
      public function setDead(value:Boolean = true) : void
      {
         if(sprite is TankBulletSprite)
         {
            if(value)
            {
               counter3 = 0;
            }
            else
            {
               counter3 = -1;
            }
         }
         else if(!(sprite is BoulderBulletSprite))
         {
            dead = true;
         }
      }
      
      public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         var enemyAABB:Rectangle = null;
         var hero_x_vel:Number = NaN;
         var this_x_vel:Number = NaN;
         if(dead || this.IS_DISAPPEARING || this.IS_PACIFIST_BULLET)
         {
            return;
         }
         if(sprite is CometBulletSprite && counter2 == 1)
         {
            return;
         }
         var heroAABB:Rectangle = level.hero.getAABB();
         var thisAABB:Rectangle = this.getAABB();
         if(this.IS_HELPER || this.IS_DAMAGING_ENEMIES_TOO)
         {
            for(i = 0; i < level.enemiesManager.enemies.length; i++)
            {
               if(level.enemiesManager.enemies[i] != null && !dead)
               {
                  if(level.enemiesManager.enemies[i].active)
                  {
                     enemyAABB = level.enemiesManager.enemies[i].getAABB();
                     if(enemyAABB.intersects(thisAABB))
                     {
                        if(level.enemiesManager.enemies[i].energy > 0)
                        {
                           if(sprite is TankBulletSprite)
                           {
                              level.camera.shake(8);
                           }
                        }
                        if(this.ID != GenericBulletSprite.BEACH_BALL)
                        {
                           level.enemiesManager.enemies[i].bulletImpact(this);
                        }
                        if(sprite is TankBulletSprite)
                        {
                           if(level.enemiesManager.enemies[i] is GiantEnemy)
                           {
                              dead = true;
                           }
                        }
                        else if(this.ID == GenericBulletSprite.BEACH_BALL)
                        {
                           if(level.enemiesManager.enemies[i].getMidXPos() < xPos)
                           {
                              xVel = 1;
                              yVel = -1;
                           }
                           else
                           {
                              xVel = -1;
                              yVel = -1;
                           }
                        }
                        else if(!(sprite is BoulderBulletSprite))
                        {
                           if(sprite is ThunderHelperBulletSprite)
                           {
                              if(this.foo2 == 0)
                              {
                                 dead = true;
                              }
                           }
                           else
                           {
                              dead = true;
                           }
                        }
                     }
                  }
               }
            }
         }
         if(!this.IS_HELPER || this.IS_DAMAGING_ENEMIES_TOO)
         {
            if(heroAABB.intersects(thisAABB))
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_SHIELD_ && this.isHeroFacingBullet(thisAABB))
               {
                  level.particlesManager.shieldItemParticle(level.hero,xPos,yPos);
               }
               else if(this.ID != GenericBulletSprite.BEACH_BALL)
               {
                  level.hero.hurt(xPos,yPos,this);
               }
               if(sprite is BaseballBulletSprite || sprite is BoneBulletSprite)
               {
                  this.disappear_counter1 = 90;
                  xVel *= -1;
               }
               else if(this.ID == GenericBulletSprite.BEACH_BALL)
               {
                  if(this.counter4 == 1)
                  {
                     if(this.counter5 == 0)
                     {
                        this.counter5 = 1;
                     }
                     else
                     {
                        this.counter4 = 0;
                        ++Utils.BEACH_BALL_BOUNCES;
                     }
                  }
                  SoundSystem.PlaySound("wiggle");
                  hero_x_vel = Math.abs(level.hero.xVel);
                  this_x_vel = xVel;
                  if(hero_x_vel < 0.1)
                  {
                     hero_x_vel = Math.abs(Math.random() * 0.2 + 0.1);
                  }
                  if(level.hero.getMidXPos() < xPos)
                  {
                     xVel = hero_x_vel;
                     if(level.hero.stateMachine.currentState == "IS_RUNNING_STATE")
                     {
                        yVel = -3;
                     }
                     else
                     {
                        yVel = -(2 + hero_x_vel * 0.1);
                     }
                  }
                  else
                  {
                     xVel = -hero_x_vel;
                     if(level.hero.stateMachine.currentState == "IS_RUNNING_STATE")
                     {
                        yVel = -3;
                     }
                     else
                     {
                        yVel = -(2 + hero_x_vel * 0.1);
                     }
                  }
               }
               else if(sprite is VaseBulletSprite || sprite is SpikedBulletSprite)
               {
                  level.particlesManager.pushParticle(new EnemyHurtParticleSprite(),xPos,yPos,0,0,0);
                  dead = true;
               }
               else if(sprite is EggBulletSprite)
               {
                  this.destroyEgg();
                  dead = true;
               }
               else if(sprite is SnowballBigBulletSprite)
               {
                  xVel *= -1;
                  this.blowBig();
                  dead = true;
               }
               else if(sprite is FireFlameBulletSprite || sprite is SeedHelperBulletSprite || sprite is PollenBulletSprite || this.ID == GenericBulletSprite.ROCK || sprite is FireFloatingBulletSprite || this.ID == GenericBulletSprite.INK || this.ID == GenericBulletSprite.WATER_CANNON)
               {
                  dead = true;
               }
               else if(sprite is FirePlantBulletSprite || sprite is FireballBulletSprite || sprite is FireballBigBulletSprite || sprite is FireballBlueGeneralBulletSprite)
               {
                  dead = true;
                  if(sprite is FireballBulletSprite)
                  {
                     if(FireballBulletSprite(sprite).TYPE == 0)
                     {
                        this.fireBulletImpact();
                     }
                  }
                  else
                  {
                     this.fireBulletImpact();
                  }
               }
               else if(!(sprite is CometBulletSprite || sprite is BoulderBulletSprite))
               {
                  xVel *= -1;
                  this.blow();
                  dead = true;
               }
            }
            else if(this.ID == GenericBulletSprite.BEACH_BALL)
            {
               this.counter4 = 1;
            }
            if(sprite is SnowballBigBulletSprite && !dead && this.foo3 > 60)
            {
               for(i = 0; i < level.enemiesManager.enemies.length; i++)
               {
                  if(level.enemiesManager.enemies[i] != null)
                  {
                     if(level.enemiesManager.enemies[i] is GiantDragonEnemy)
                     {
                        enemyAABB = level.enemiesManager.enemies[i].getAABB();
                        if(enemyAABB.intersects(thisAABB))
                        {
                           this.blowBig();
                           dead = true;
                           level.enemiesManager.enemies[i].stateMachine.performAction("HIT_ACTION");
                        }
                     }
                  }
               }
            }
         }
      }
      
      protected function isHeroFacingBullet(aabb:Rectangle) : Boolean
      {
         if(level.hero.DIRECTION == Entity.LEFT)
         {
            if(xPos > level.hero.getMidXPos())
            {
               return false;
            }
            return true;
         }
         if(xPos < level.hero.getMidXPos())
         {
            return false;
         }
         return true;
      }
      
      override public function ceilCollision() : void
      {
         if(sprite is BubbleHelperBulletSprite || sprite is FireFloatingBulletSprite)
         {
            dead = true;
         }
         else if(sprite is FirePlantBulletSprite)
         {
            if(this.foo4 == 1)
            {
               dead = true;
            }
         }
         else if(this.ID == GenericBulletSprite.BEACH_BALL)
         {
            yVel *= -1;
         }
      }
      
      override public function allowPlatformCollision(collision:Collision) : Boolean
      {
         if(yVel < 0)
         {
            return false;
         }
         return true;
      }
      
      override public function noGroundCollision() : void
      {
         if(sprite is BoulderBulletSprite)
         {
            if(this.foo3 == 1)
            {
               this.IS_ON_GROUND = false;
            }
         }
      }
      
      override public function groundCollision() : void
      {
         var pSprite:GameSprite = null;
         if(sprite is BaseballBulletSprite)
         {
            SoundSystem.PlaySound("ground_impact");
            ++counter2;
            yVel = -3 + counter2 * 0.5;
            xVel *= 0.75;
         }
         else if(this.ID == GenericBulletSprite.POGO_STICK || this.ID == GenericBulletSprite.PARASOL)
         {
            SoundSystem.PlaySound("ground_impact");
            ++counter2;
            yVel = -3 + counter2 * 0.5;
            xVel *= 0.75;
         }
         else if(this.ID == GenericBulletSprite.BEACH_BALL)
         {
            this.counter5 = 0;
            yVel = -y_vel_at_ground_collision * 0.8;
            xVel *= 0.9;
            if(Math.abs(yVel) < 0.75)
            {
               xVel = yVel = 0;
            }
            if(collision_tile_value == 6 || collision_tile_value == 7)
            {
               xVel += 1;
            }
            else if(collision_tile_value == 8 || collision_tile_value == 9)
            {
               --xVel;
            }
            else if(collision_tile_value == 4)
            {
               xVel += 2;
            }
            else if(collision_tile_value == 5)
            {
               xVel -= 2;
            }
         }
         else if(sprite is BoneBulletSprite)
         {
            SoundSystem.PlaySound("seed_impact");
            ++counter2;
            yVel = -3;
            xVel *= 0.75;
         }
         else if(sprite is FireballBlueGeneralBulletSprite)
         {
            yVel = -1;
         }
         else if(sprite is SpikedBulletSprite)
         {
            ++this.foo1;
            yVel = -3;
            SoundSystem.PlaySound("ground_stomp");
            level.camera.shake(2);
         }
         else if(sprite is VaseBulletSprite)
         {
            SoundSystem.PlaySound("coconut_bullet_impact");
            dead = true;
            level.particlesManager.pushParticle(new EnemyHurtParticleSprite(),xPos,yPos,0,0,0);
         }
         else if(sprite is EggBulletSprite)
         {
            this.destroyEgg();
            dead = true;
         }
         else if(sprite is BoulderBulletSprite)
         {
            if(this.foo3 == 0)
            {
               yVel = -2;
               AVOID_COLLISION_DETECTION = true;
               if(this.isInsideScreen())
               {
                  SoundSystem.PlaySound("rock_stomp");
                  level.camera.shake(4);
                  level.backgroundsManager.shake();
               }
               level.topParticlesManager.createDust(xPos + 16,yPos + 24,Entity.LEFT);
               level.topParticlesManager.createDust(xPos - 16,yPos + 24,Entity.RIGHT);
            }
            else if(this.foo3 == 1)
            {
               if(!this.IS_ON_GROUND && counter2 < 5)
               {
                  SoundSystem.PlaySound("rock_stomp");
                  yVel = -2;
                  counter2 = 120;
                  level.camera.shake(2);
                  level.backgroundsManager.shake();
                  level.topParticlesManager.createDust(xPos + 16,yPos + 24,Entity.LEFT);
                  level.topParticlesManager.createDust(xPos - 16,yPos + 24,Entity.RIGHT);
               }
               this.IS_ON_GROUND = true;
            }
         }
         else if(sprite is CometBulletSprite)
         {
            if(yPos <= 352)
            {
               this.foo1 = 1;
            }
            else
            {
               this.foo1 = 2;
            }
            yVel = -2;
            if(sprite.gfxHandleClip().frame == 1)
            {
               SoundSystem.PlaySound("ground_stomp");
               this.foo3 = 5;
               level.camera.shake(4);
               level.topParticlesManager.createDust(xPos + 8,yPos + 16,Entity.LEFT);
               level.topParticlesManager.createDust(xPos - 8,yPos + 16,Entity.RIGHT);
            }
            else
            {
               SoundSystem.PlaySound("ground_stomp");
               this.foo3 = 3;
               level.camera.shake(2);
               level.topParticlesManager.createDust(xPos + 4,yPos + 11,Entity.LEFT);
               level.topParticlesManager.createDust(xPos - 4,yPos + 11,Entity.RIGHT);
            }
         }
         else if(sprite is ThunderHelperBulletSprite)
         {
            dead = true;
            pSprite = new ElectroParticleSprite();
            pSprite.scaleY = -1;
            level.particlesManager.pushParticle(pSprite,xPos + 2,yPos,2,-1,0.8);
            pSprite = new ElectroParticleSprite();
            pSprite.scaleX = pSprite.scaleY = -1;
            level.particlesManager.pushParticle(pSprite,xPos - 2,yPos,-2,-1,0.8);
         }
         else if(sprite is SeedHelperBulletSprite || this.ID == GenericBulletSprite.ROCK || this.ID == GenericBulletSprite.ROCK_NO_DAMAGE)
         {
            ++counter2;
            if(this.ID == GenericBulletSprite.ROCK || this.ID == GenericBulletSprite.ROCK_NO_DAMAGE)
            {
               yVel -= 2;
               if(counter2 >= 3)
               {
                  yVel = 0;
                  xVel = 0;
               }
            }
            else
            {
               yVel = -3 + counter2 * 0.5;
               xVel *= 0.75;
               if(counter2 >= 2)
               {
                  yVel = 0;
                  xVel = 0;
               }
            }
            if(yVel > 0)
            {
               yVel = 0;
            }
            else if(counter2 < 3)
            {
               SoundSystem.PlaySound("seed_impact");
            }
         }
         else if(sprite is SnowballBulletSprite)
         {
            SoundSystem.PlaySound("snow_bullet_impact");
            ++counter2;
            yVel = -3.5 + counter2 * 0.5;
            xVel *= 0.75;
         }
         else if(sprite is FireballBulletSprite)
         {
            if(FireballBulletSprite(sprite).TYPE == 1)
            {
               dead = true;
            }
            else
            {
               if(this.isInsideScreen())
               {
                  SoundSystem.PlaySound("fire_bullet");
               }
               if(this.foo3 >= 0)
               {
                  level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos,yPos,-1.5,-2,1);
                  level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos,yPos,1.5,-2,1);
               }
               dead = true;
            }
         }
         else if(sprite is FireballBigBulletSprite)
         {
            if(this.isInsideScreen())
            {
               SoundSystem.PlaySound("fire_dragon_shoot");
            }
            level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos,yPos,-1.5,-2,1,2,1);
            level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos,yPos,1.5,-2,1,2,1);
            dead = true;
         }
         else if(sprite is FirePlantBulletSprite || sprite is FireFloatingBulletSprite)
         {
            dead = true;
            this.fireBulletImpact();
         }
         else if(sprite is PollenBulletSprite)
         {
            if(this.foo3 >= 0)
            {
               this.foo3 = -1;
            }
         }
         else if(sprite is BubbleHelperBulletSprite || this.ID == GenericBulletSprite.INK)
         {
            dead = true;
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(sprite is FireballBulletSprite || sprite is FireFloatingBulletSprite)
         {
            dead = true;
            if(sprite is FireballBulletSprite)
            {
               if(FireballBulletSprite(sprite).TYPE != 1)
               {
                  this.fireBulletImpact();
               }
            }
            else
            {
               this.fireBulletImpact();
            }
         }
         else if(this.ID == GenericBulletSprite.ARROW_HELPER)
         {
            dead = true;
         }
         else if(sprite is FireballBlueGeneralBulletSprite)
         {
            if(xPos >= 1472)
            {
               if(xVel > 0)
               {
                  xVel *= -1;
               }
            }
            else if(xVel < 0)
            {
               xVel *= -1;
            }
         }
         else if(sprite is SpikedBulletSprite)
         {
            ++this.foo2;
            xVel *= -1;
            if(this.foo2 >= 2)
            {
               xVel = 0;
               AVOID_COLLISION_DETECTION = true;
               yVel += 2;
            }
         }
         else if(sprite is BubbleHelperBulletSprite)
         {
            dead = true;
         }
         else if(sprite is SnowballFloatingBulletSprite)
         {
            dead = true;
            SoundSystem.PlaySound("snow_bullet_impact");
            this.blow(true);
         }
         else if(sprite is GenericBulletSprite)
         {
            xVel *= -1;
            if(this.ID == GenericBulletSprite.POGO_STICK || this.ID == GenericBulletSprite.PARASOL)
            {
               sprite.scaleX *= -1;
            }
            else if(this.ID == GenericBulletSprite.BEACH_BALL)
            {
               this.counter5 = 0;
            }
            else if(this.ID == GenericBulletSprite.WATER_CANNON)
            {
               xVel = 0;
               dead = true;
            }
         }
         else if(sprite is BoulderBulletSprite)
         {
            xVel *= -1;
            if(level.levelData.getTileValueAt(getTileX(0) - 2,getTileY(0) + 1) == 1 && level.levelData.getTileValueAt(getTileX(0) + 2,getTileY(0) + 1) == 1)
            {
               xVel = 0;
               this.foo3 = 2;
            }
         }
         else
         {
            xVel *= -1;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         if(sprite != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.scaleX = 1;
            }
            else
            {
               sprite.scaleX = -1;
            }
         }
         if(sprite is SeedHelperBulletSprite || this.ID == GenericBulletSprite.ROCK || this.ID == GenericBulletSprite.BEACH_BALL)
         {
            sprite.gfxHandleClip().gotoAndStop(frame_counter + 1);
         }
         sprite.updateScreenPosition();
      }
      
      public function assignNewValues(_sprite:GameSprite, _xPos:Number, _yPos:Number, _xVel:Number, _yVel:Number, _friction:Number, _foo1:Number = 0, _foo2:Number = 0, _foo3:Number = 0, _foo4:Number = 0) : void
      {
         this.removeSprite();
         this.ID = -1;
         sprite = _sprite;
         if(sprite is GenericBulletSprite)
         {
            this.ID = GenericBulletSprite(sprite).ID;
         }
         if(sprite is CometBulletSprite || sprite is BoulderBulletSprite)
         {
            Utils.topWorld.addChild(sprite);
         }
         else
         {
            Utils.world.addChild(sprite);
         }
         counter1 = counter2 = counter3 = this.counter4 = this.counter5 = this.disappear_counter1 = this.disappear_counter2 = this.disappear_counter3 = 0;
         AVOID_COLLISION_DETECTION = this.IS_DISAPPEARING = this.IS_PACIFIST_BULLET = this.IS_ON_GROUND = false;
         if(sprite is BaseballBulletSprite)
         {
            if(_foo1 < 0.5)
            {
               AVOID_COLLISION_DETECTION = true;
            }
         }
         else if(sprite is BoneBulletSprite)
         {
            AVOID_COLLISION_DETECTION = true;
         }
         if(sprite is ThunderHelperBulletSprite)
         {
            this.IS_HELPER = true;
            if(_foo1 == 1)
            {
               this.POWER = 0.5;
            }
            else if(_foo1 == 2)
            {
               this.POWER = 1;
            }
            else
            {
               this.POWER = 2;
            }
            if(_foo2 == 1)
            {
               this.POWER = 0.05;
            }
         }
         else if(sprite is SeedHelperBulletSprite)
         {
            this.TYPE = SeedHelperBulletSprite(sprite).TYPE;
            if(this.TYPE == 0)
            {
               this.IS_HELPER = true;
               if(_foo1 == 1)
               {
                  this.POWER = 0.5;
               }
               else if(_foo1 == 2)
               {
                  this.POWER = 0.5;
               }
               else
               {
                  this.POWER = 1;
               }
            }
            else if(this.TYPE == 2)
            {
               this.IS_HELPER = true;
               this.POWER = 1;
            }
         }
         else if(sprite is BubbleHelperBulletSprite)
         {
            this.IS_HELPER = true;
            if(_foo2 == 1)
            {
               this.POWER = 0.25;
            }
            else if(_foo2 == 2)
            {
               this.POWER = 0.5;
            }
            else
            {
               this.POWER = 1;
            }
         }
         else if(sprite is TankBulletSprite)
         {
            this.IS_HELPER = true;
            this.POWER = 20;
            counter3 = -1;
         }
         else if(sprite is GenericBulletSprite)
         {
            if(this.ID == GenericBulletSprite.POGO_STICK || this.ID == GenericBulletSprite.PARASOL || this.ID == GenericBulletSprite.ROCK_NO_DAMAGE)
            {
               this.IS_PACIFIST_BULLET = true;
            }
            else if(this.ID == GenericBulletSprite.BEACH_BALL)
            {
               this.IS_DAMAGING_ENEMIES_TOO = true;
            }
            else if(this.ID == GenericBulletSprite.ARROW_HELPER)
            {
               this.IS_HELPER = true;
               this.POWER = 1;
               aabbPhysics.height = aabbPhysics.width = 0;
            }
         }
         else if(sprite is BoulderBulletSprite)
         {
            this.IS_DAMAGING_ENEMIES_TOO = true;
         }
         else
         {
            this.IS_HELPER = false;
         }
         this.foo1 = _foo1;
         this.foo2 = _foo2;
         this.foo3 = _foo3;
         this.foo4 = _foo4;
         xPos = originalXPos = _xPos;
         yPos = originalYPos = _yPos;
         xVel = _xVel;
         yVel = _yVel;
         x_friction = y_friction = _friction;
         dead = false;
      }
      
      public function removeSprite() : void
      {
         if(sprite != null)
         {
            if(sprite is CometBulletSprite || sprite is BoulderBulletSprite)
            {
               Utils.topWorld.removeChild(sprite);
            }
            else
            {
               Utils.world.removeChild(sprite);
            }
            sprite.destroy();
            sprite.dispose();
            sprite = null;
         }
      }
      
      override public function isInsideScreen() : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos - Utils.TILE_HEIGHT,level.camera.yPos - Utils.TILE_HEIGHT * 2,level.camera.WIDTH + Utils.TILE_HEIGHT * 2,level.camera.HEIGHT + Utils.TILE_HEIGHT * 4);
         var area:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      protected function blow(_isWall:Boolean = false) : void
      {
         var pSprite:SnowParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         var vel:Number = NaN;
         var _vel:Number = 1;
         if(xVel < 0)
         {
            _vel = -1;
         }
         if(_isWall)
         {
            _vel *= -1;
         }
         var max:int = 5;
         if(Math.random() * 100 > 80)
         {
            max = 6;
         }
         for(i = 0; i < max; i++)
         {
            pSprite = new SnowParticleSprite();
            angle = Math.random() * Math.PI * 2;
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            vel = _vel * (i * 0.5 + 1 + Math.random() * 1);
            level.particlesManager.pushParticle(pSprite,xPos + (Math.random() * 16 - 8),yPos + (Math.random() * 16 - 8),vel,-(2 + Math.random() * 1),0.98,(int(Math.random() * 2) + (i + 1)) * 0.1);
         }
      }
      
      protected function blowBig() : void
      {
         var pSprite:SnowBigParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         var vel:Number = NaN;
         var _vel:Number = 1;
         if(xVel < 0)
         {
            _vel = -1;
         }
         var max:int = 5;
         if(Math.random() * 100 > 80)
         {
            max = 6;
         }
         for(i = 0; i < max; i++)
         {
            pSprite = new SnowBigParticleSprite();
            angle = Math.random() * Math.PI * 2;
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            vel = _vel * (i * 0.5 + 1 + Math.random() * 1);
            level.particlesManager.pushParticle(pSprite,xPos + (Math.random() * 12 - 6),yPos + (Math.random() * 12 - 6),vel * 0.5,-(2 + Math.random() * 1),0.98,(int(Math.random() * 2) + (i + 1)) * 0.1);
         }
         for(i = 0; i < max; i++)
         {
            pSprite = new SnowBigParticleSprite();
            angle = Math.random() * Math.PI * 2;
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            vel = _vel * (i * 0.5 + 1 + Math.random() * 1);
            level.particlesManager.pushParticle(pSprite,xPos + (Math.random() * 12 - 6),yPos + (Math.random() * 12 - 6),-vel * 0.5,-(2 + Math.random() * 1),0.98,(int(Math.random() * 2) + (i + 1)) * 0.1);
         }
      }
      
      public function fireBulletImpact() : void
      {
         if(Math.random() * 100 > 25)
         {
            level.particlesManager.pushBackParticle(new FireSparkleParticleSprite(),xPos,yPos,-(Math.random() * 1),-(1 + Math.random() * 1),1);
         }
         if(Math.random() * 100 > 25)
         {
            level.particlesManager.pushBackParticle(new FireSparkleParticleSprite(),xPos,yPos,Math.random() * 1,-(1 + Math.random() * 1),1);
         }
      }
   }
}
