package entities.enemies
{
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.PollenBulletSprite;
   import sprites.enemies.GiantPollenEnemySprite;
   import sprites.enemies.SmallPollenEnemySprite;
   import sprites.enemies.SmallPollenLeafSprite;
   import sprites.particles.PollenParticleSprite;
   import sprites.particles.ZSleepParticleSprite;
   
   public class SmallPollenEnemy extends Enemy
   {
       
      
      protected var leafSprite:SmallPollenLeafSprite;
      
      protected var x_leaf_shift:int;
      
      protected var y_leaf_shift:int;
      
      protected var leaf_frame:Number;
      
      protected var leaf_speed:Number;
      
      protected var leaf_friction:Number;
      
      protected var go_up:Boolean;
      
      protected var z_counter:int;
      
      protected var WAS_HERO_SX_WHEN_HIT:Boolean;
      
      protected var IS_BIG_POLLEN:Boolean;
      
      protected var bullet_counter:int;
      
      protected var param_1:int;
      
      public function SmallPollenEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int, _param_1:int = 0)
      {
         this.IS_BIG_POLLEN = false;
         if(_ai_index == 2)
         {
            this.IS_BIG_POLLEN = true;
            ai_index = 1;
         }
         this.param_1 = _param_1;
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         this.leaf_frame = this.leaf_speed = 0;
         this.go_up = false;
         this.z_counter = -Utils.random.nextMax(120);
         this.bullet_counter = 0;
         if(this.param_1 > 0)
         {
            this.bullet_counter = 60;
         }
         MAX_Y_VEL = 0.5;
         this.WAS_HERO_SX_WHEN_HIT = false;
         if(this.IS_BIG_POLLEN)
         {
            this.leafSprite = new SmallPollenLeafSprite(1);
            Utils.world.addChild(this.leafSprite);
            sprite = new GiantPollenEnemySprite(0);
            Utils.world.addChild(sprite);
         }
         else
         {
            this.leafSprite = new SmallPollenLeafSprite();
            Utils.world.addChild(this.leafSprite);
            sprite = new SmallPollenEnemySprite();
            Utils.world.addChild(sprite);
         }
         aabb.y = aabbPhysics.y = 3;
         aabb.height = aabbPhysics.height = 10;
         if(this.IS_BIG_POLLEN)
         {
            aabb.x = -5;
            aabb.y = 4;
            aabb.width = 26;
            aabb.height = 22;
            aabbPhysics.x = 2;
            aabbPhysics.y = 10;
            aabbPhysics.width = 26;
            aabbPhysics.height = 17;
         }
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_SLEEPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setRule("IS_FLOATING_STATE","END_ACTION","IS_SLEEPING_STATE");
         stateMachine.setRule("IS_FLOATING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_FLOATING_STATE",this.floatAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 0)
         {
            stateMachine.setState("IS_SLEEPING_STATE");
         }
         else
         {
            stateMachine.setState("IS_FLOATING_STATE");
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         this.bullet_counter = 0;
         if(this.param_1 > 0)
         {
            this.bullet_counter = 60;
         }
         if(ai_index == 0)
         {
            stateMachine.setState("IS_SLEEPING_STATE");
         }
         else
         {
            stateMachine.setState("IS_FLOATING_STATE");
         }
      }
      
      override public function getMidXPos() : Number
      {
         return xPos + 8;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos + 8;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.leafSprite);
         this.leafSprite.destroy();
         this.leafSprite.dispose();
         this.leafSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:PollenBulletSprite = null;
         super.update();
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 3 + 2) * 0.5);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            yVel += 0.2;
            if(this.z_counter++ > 120)
            {
               this.z_counter = 0;
               if(DIRECTION == LEFT)
               {
                  level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos + WIDTH,yPos,0,0,0,0,0,0);
               }
               else
               {
                  level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos,yPos,0,0,0,0,0,1);
               }
            }
         }
         else if(stateMachine.currentState == "IS_FLOATING_STATE")
         {
            if(this.go_up)
            {
               yVel -= 0.01;
            }
            else
            {
               yVel += 0.01;
            }
            if(yVel <= -MAX_Y_VEL)
            {
               yVel = -MAX_Y_VEL;
            }
            else if(yVel >= MAX_Y_VEL)
            {
               yVel = MAX_Y_VEL;
            }
            if(yPos <= path_start_y)
            {
               this.go_up = false;
               this.leaf_friction = 1;
            }
            else if(yPos >= path_end_y)
            {
               this.go_up = true;
               this.leaf_friction = 1;
            }
            if(this.IS_BIG_POLLEN)
            {
               if(this.bullet_counter-- < 0)
               {
                  this.bullet_counter = 120;
                  pSprite = new PollenBulletSprite();
                  level.bulletsManager.pushBackBullet(pSprite,xPos + 8,yPos + 32,0,0,0.9 + Math.random() * 0.05,Math.random() * Math.PI * 2);
               }
            }
            sinCounter1 += 0.04;
            xPos = originalXPos + Math.sin(sinCounter1) * 6;
            if(this.go_up == false)
            {
               if(yVel > -0.5)
               {
                  this.leaf_speed += (MAX_Y_VEL - Math.abs(yVel)) * 0.25;
                  if(yVel <= 0.4 && yVel > -0.25)
                  {
                     counter1 += this.leaf_speed * 0.5;
                     if(counter1 > 0)
                     {
                        counter1 = -3;
                        level.particlesManager.airParticles(xPos,yPos - 4,WIDTH);
                     }
                  }
               }
            }
            this.leaf_speed *= 0.98;
            if(this.leaf_speed < 0.1)
            {
               this.leaf_speed = 0.1;
            }
            else if(this.leaf_speed > 0.5)
            {
               this.leaf_speed = 0.5;
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            ++counter1;
            if(counter1 >= 5)
            {
               counter1 = 0;
               this.pollenParticle();
            }
         }
         this.leaf_frame += this.leaf_speed;
         if(this.leaf_frame > 5)
         {
            this.leaf_frame -= 5;
         }
         else if(this.leaf_frame < 0)
         {
            this.leaf_frame += 5;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.updateLeafShift();
         this.leafSprite.x = int(Math.floor(xPos + this.x_leaf_shift - camera.xPos));
         this.leafSprite.y = int(Math.floor(yPos + this.y_leaf_shift - camera.yPos));
         this.leafSprite.gfxHandleClip().gotoAndStop(this.leaf_frame + 1);
         this.leafSprite.visible = sprite.visible;
         if(this.IS_BIG_POLLEN)
         {
            sprite.x -= 7;
            sprite.y -= 5;
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            this.leafSprite.visible = false;
            onTop();
         }
      }
      
      protected function updateLeafShift() : void
      {
         this.x_leaf_shift = 8;
         this.y_leaf_shift = 4;
         if(DIRECTION == RIGHT)
         {
            this.x_leaf_shift = 9;
         }
         if(sprite.gfxHandle().frame == 1)
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1)
            {
               this.y_leaf_shift = 3;
            }
         }
      }
      
      public function sleepingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.leaf_speed = 0;
         this.leaf_frame = 5;
         aabb.height = 10;
      }
      
      public function floatAnimation() : void
      {
         if(this.IS_BIG_POLLEN)
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(3);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(!this.IS_BIG_POLLEN)
         {
            aabb.height = 13;
         }
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         if(this.IS_BIG_POLLEN)
         {
            sprite.gfxHandle().gotoAndStop(5);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         if(ai_index == 0)
         {
            Utils.SLEEPING_POLLEN_HIT = true;
         }
         counter1 = counter2 = 0;
         this.leaf_speed = 0;
         yVel = 0;
         if(level.hero.xPos + level.hero.WIDTH * 0.5 < xPos + 8)
         {
            this.WAS_HERO_SX_WHEN_HIT = true;
         }
      }
      
      protected function pollenParticle() : void
      {
         var _vel:Number = -1.25;
         if(DIRECTION == LEFT)
         {
            _vel = 1.25;
         }
         var pSprite:PollenParticleSprite = new PollenParticleSprite();
         var angle:Number = Math.random() * Math.PI * 2;
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + 7 + Math.sin(angle) * 4,yPos + 6 + Math.cos(angle) * 4,_vel * (1 + Math.random() * 0.5),-(int(Math.random() * 2) + 1),1,Math.random() * 0.02 + 0.01,Math.random() * 4 + 4,0);
      }
   }
}
