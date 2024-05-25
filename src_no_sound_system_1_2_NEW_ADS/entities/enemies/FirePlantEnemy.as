package entities.enemies
{
   import entities.Hero;
   import entities.bullets.Bullet;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.bullets.FirePlantBulletSprite;
   import sprites.bullets.SeedHelperBulletSprite;
   import sprites.enemies.FirePlantEnemySprite;
   import sprites.particles.DirtParticleSprite;
   
   public class FirePlantEnemy extends Enemy
   {
       
      
      protected var shootFlag:Boolean;
      
      protected var shoot_B:Boolean;
      
      protected var just_once:Boolean;
      
      public function FirePlantEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int, _shoot_time:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 16;
         this.shootFlag = false;
         sprite = new FirePlantEnemySprite(ai_index);
         Utils.topWorld.addChild(sprite);
         if(_shoot_time > 0)
         {
            this.shoot_B = true;
         }
         else
         {
            this.shoot_B = false;
         }
         this.just_once = true;
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","SHOOT_ACTION","IS_SHOOTING_START_STATE");
         stateMachine.setRule("IS_SHOOTING_START_STATE","END_ACTION","IS_SHAKING_STATE");
         stateMachine.setRule("IS_SHAKING_STATE","END_ACTION","IS_SHOOTING_STATE");
         stateMachine.setRule("IS_SHOOTING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIDE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_HIDDEN_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SHOOTING_START_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SHAKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SHOOTING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_SHOOTING_START_STATE",this.shootingStartAnimation);
         stateMachine.setFunctionToState("IS_SHAKING_STATE",this.shakingAnimation);
         stateMachine.setFunctionToState("IS_SHOOTING_STATE",this.shootingAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_UNHIDING_STATE",this.unhidingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 1;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState != "IS_STANDING_STATE" && stateMachine.currentState != "IS_SHOOTING_START_STATE" && stateMachine.currentState != "IS_SHAKING_STATE" && stateMachine.currentState != "IS_SHOOTING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(stateMachine.currentState != "IS_STANDING_STATE" && stateMachine.currentState != "IS_SHOOTING_START_STATE" && stateMachine.currentState != "IS_SHAKING_STATE" && stateMachine.currentState != "IS_SHOOTING_STATE")
         {
            return;
         }
         super.bulletImpact(bullet);
         stateMachine.performAction("HIDE_ACTION");
      }
      
      override public function reset() : void
      {
         this.just_once = true;
         xPos = originalXPos;
         yPos = originalYPos;
         xVel = yVel = 0;
         DIRECTION = ORIGINAL_DIRECTION;
         stateMachine.setState("IS_STANDING_STATE");
         energy = 1;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 2 + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(this.isHeroClose())
            {
               SoundSystem.PlaySound("dig");
               stateMachine.performAction("HIDE_ACTION");
            }
            else
            {
               ++counter1;
               if(counter1 >= 120)
               {
                  stateMachine.performAction("SHOOT_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_SHOOTING_START_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SHAKING_STATE")
         {
            ++counter1;
            if(counter1 >= 5)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SHOOTING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1)
            {
               if(!this.shootFlag)
               {
                  this.shootFlag = true;
                  this.shootBullets();
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIDING_STATE")
         {
            if(!this.shootFlag)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 2)
               {
                  this.dirtParticles();
                  this.shootFlag = true;
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            ++counter1;
            if(counter1 >= 90)
            {
               counter1 = 90;
               if(!this.isHeroClose())
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            ++counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(counter1 >= wait_time)
            {
               counter1 = 0;
               ++counter2;
               sprite.visible = !sprite.visible;
               if(counter2 > 12)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      protected function isHeroClose() : Boolean
      {
         if(level.hero.yPos >= yPos + 16)
         {
            return false;
         }
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var mid_x:Number = xPos + WIDTH * 0.5;
         var mid_y:Number = yPos + HEIGHT * 0.5;
         var diff_x:Number = mid_x - hero_mid_x;
         var diff_y:Number = mid_y - hero_mid_y;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance < 64)
         {
            return true;
         }
         return false;
      }
      
      protected function shootBullets() : void
      {
         if(ai_index == 0)
         {
            if(isInsideScreen())
            {
               SoundSystem.PlaySound("fire_bullet");
            }
            level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos + WIDTH * 0.5,yPos,-0.75,-2.5,1);
            level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos + WIDTH * 0.5,yPos,0.75,-2.5,1);
         }
         else
         {
            if(isInsideScreen())
            {
               SoundSystem.PlaySound("item_pop");
            }
            level.bulletsManager.pushBullet(new SeedHelperBulletSprite(1),xPos + WIDTH * 0.5,yPos,-0.75,-(3.5 + Math.random() * 1.5),1);
            level.bulletsManager.pushBullet(new SeedHelperBulletSprite(1),xPos + WIDTH * 0.5,yPos,0.75,-(3.5 + Math.random() * 1.5),1);
         }
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIDING_STATE" || stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      protected function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         if(this.shoot_B && this.just_once)
         {
            counter1 = 60;
            this.just_once = false;
         }
      }
      
      protected function shootingStartAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function shakingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      protected function shootingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.shootFlag = false;
      }
      
      protected function hidingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("mole");
         }
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.shootFlag = false;
      }
      
      protected function hiddenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      protected function unhidingAnimation() : void
      {
         SoundSystem.PlaySound("dig");
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.dirtParticles();
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      protected function dirtParticles() : void
      {
         var pSprite:DirtParticleSprite = null;
         pSprite = new DirtParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + WIDTH * 0.25,yPos + HEIGHT,-(Math.random() * 1),-(Math.random() * 1 + 2),1);
         pSprite = new DirtParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + WIDTH * 0.75,yPos + HEIGHT,Math.random() * 1,-(Math.random() * 1 + 2),1);
      }
   }
}
