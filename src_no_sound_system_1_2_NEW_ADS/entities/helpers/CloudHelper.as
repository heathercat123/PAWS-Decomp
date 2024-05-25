package entities.helpers
{
   import entities.bullets.Bullet;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.bullets.ThunderHelperBulletSprite;
   import sprites.helpers.CloudHelperSprite;
   import sprites.particles.ElectroParticleSprite;
   import starling.display.Image;
   
   public class CloudHelper extends Helper
   {
       
      
      protected var electricity:Image;
      
      protected var electricity_top:Image;
      
      protected var electro_counter_1:int;
      
      protected var electro_counter_2:int;
      
      protected var electro_counter_3:int;
      
      protected var electroBullet:Bullet;
      
      public function CloudHelper(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,LevelItems.ITEM_HELPER_CLOUD);
         this.setParams();
         this.initSprites();
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_EGG_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TARGET_ENEMY_ACTION","IS_TARGETING_ENEMY_STATE");
         stateMachine.setRule("IS_TARGETING_ENEMY_STATE","CLOSE_ACTION","IS_ATTACKING_STATE");
         stateMachine.setRule("IS_TARGETING_ENEMY_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_POST_ATTACKING_STATE");
         stateMachine.setRule("IS_POST_ATTACKING_STATE","ATTACK_ACTION","IS_TARGETING_ENEMY_STATE");
         stateMachine.setRule("IS_POST_ATTACKING_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_CUTSCENE_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","SET_FREE_ACTION","IS_FLYING_AWAY_STATE");
         stateMachine.setFunctionToState("IS_EGG_STATE",this.eggAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_HERO_STATE",this.targetingHeroAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_ENEMY_STATE",this.targetingEnemyAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         stateMachine.setFunctionToState("IS_POST_ATTACKING_STATE",this.postAttackingAnimation);
         stateMachine.setFunctionToState("IS_FLYING_AWAY_STATE",this.flyingAwayAnimation);
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setState("IS_TARGETING_HERO_STATE");
      }
      
      override protected function initSprites() : void
      {
         sprite = new CloudHelperSprite(LEVEL);
         Utils.world.addChild(sprite);
         topSprite = new CloudHelperSprite(LEVEL);
         Utils.topWorld.addChild(topSprite);
         topSprite.visible = false;
         this.electricity = this.electricity_top = null;
         this.electricity = new Image(TextureManager.sTextureAtlas.getTexture("cloud_helper_electricity"));
         this.electricity_top = new Image(TextureManager.sTextureAtlas.getTexture("cloud_helper_electricity"));
         this.electricity.touchable = this.electricity_top.touchable = false;
         Utils.world.addChild(this.electricity);
         Utils.topWorld.addChild(this.electricity_top);
      }
      
      override public function destroy() : void
      {
         if(this.electricity != null)
         {
            Utils.world.removeChild(this.electricity);
            this.electricity.dispose();
            this.electricity = null;
         }
         this.electroBullet = null;
         super.destroy();
      }
      
      override protected function setParams() : void
      {
         this.electro_counter_1 = this.electro_counter_2 = this.electro_counter_3 = 0;
         this.electroBullet = null;
         if(LEVEL == 1)
         {
            if(IS_IN_WATER)
            {
               RADIUS_MAX_DISTANCE_FROM_HERO = 48;
               MAX_X_VEL = 1;
            }
            else
            {
               RADIUS_MAX_DISTANCE_FROM_HERO = 64;
               MAX_X_VEL = 2;
            }
         }
         else if(IS_IN_WATER)
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 64;
            MAX_X_VEL = 1;
         }
         else
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 80;
            MAX_X_VEL = 4;
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_EGG_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               level.particlesManager.eggExplosion(xPos,yPos);
               stateMachine.performAction("END_ACTION");
            }
            followHero();
         }
         else if(stateMachine.currentState == "IS_FLYING_AWAY_STATE")
         {
            flyAway();
         }
         else if(stateMachine.currentState == "IS_TARGETING_HERO_STATE")
         {
            followHero();
            if(canTargetEnemy() && !IS_IN_WATER)
            {
               stateMachine.performAction("TARGET_ENEMY_ACTION");
            }
            else if(DIRECTION != level.hero.DIRECTION)
            {
               stateMachine.performAction("TURN_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            followHero();
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TARGETING_ENEMY_STATE")
         {
            if(target != null)
            {
               targetEnemy();
               if(isTargetTooDistantFromHero())
               {
                  stateMachine.performAction("END_ACTION");
               }
               if(Math.abs(target.getMidXPos() + -xPos) < 2 && target.getMidYPos() - yPos > 16)
               {
                  if(level.levelData.getTileValueAt(xPos / Utils.TILE_WIDTH,yPos / Utils.TILE_HEIGHT) == 0)
                  {
                     stateMachine.performAction("CLOSE_ACTION");
                  }
               }
            }
            else
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               if(LEVEL == 1)
               {
                  attackCooldownCounter = 90;
               }
               else if(LEVEL == 2)
               {
                  attackCooldownCounter = 60;
               }
               else
               {
                  attackCooldownCounter = 30;
               }
               if(IS_IN_WATER)
               {
                  attackCooldownCounter *= 5;
               }
               stateMachine.performAction("END_ACTION");
               SoundSystem.PlaySound("thunder");
               if(IS_IN_WATER)
               {
                  level.bulletsManager.pushBullet(new ThunderHelperBulletSprite(),xPos,yPos + 8 + offset_y,0,2,1,LEVEL,0,1);
               }
               else
               {
                  level.bulletsManager.pushBullet(new ThunderHelperBulletSprite(),xPos,yPos + 8 + offset_y,0,4,1,LEVEL,0,0);
               }
               this.electroParticles();
            }
         }
         else if(stateMachine.currentState == "IS_POST_ATTACKING_STATE")
         {
            if(target == null)
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(isTargetTooDistantFromHero() || !target.isInsideInnerScreen() || !target.isTargetable())
            {
               stateMachine.performAction("END_ACTION");
            }
            else
            {
               --attackCooldownCounter;
               if(attackCooldownCounter <= 0)
               {
                  stateMachine.performAction("ATTACK_ACTION");
               }
            }
         }
         if(target != null)
         {
            if(target.dead || target.stateMachine.currentState == "IS_HIT_STATE")
            {
               target = null;
            }
         }
         x_friction = y_friction = 0.9;
         xVel *= x_friction;
         yVel *= y_friction;
         if(xVel > MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel < -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel > MAX_X_VEL)
         {
            yVel = MAX_X_VEL;
         }
         else if(yVel < -MAX_X_VEL)
         {
            yVel = -MAX_X_VEL;
         }
         xPos += xVel;
         yPos += yVel;
         checkWater();
         if(this.electricity != null)
         {
            if(LEVEL >= 3 || IS_IN_WATER)
            {
               ++this.electro_counter_1;
               if(this.electro_counter_1 < 120)
               {
                  this.electricity.visible = false;
               }
               else
               {
                  if(this.electro_counter_1 == 121)
                  {
                     this.electroBullet = level.bulletsManager.pushBullet(new ThunderHelperBulletSprite(),xPos,yPos + 8 + offset_y,0,0,1,LEVEL,1,IS_IN_WATER ? 1 : 0);
                  }
                  this.electricity.visible = true;
                  ++this.electro_counter_2;
                  if(this.electro_counter_2 >= 3)
                  {
                     this.electricity.visible = false;
                     if(this.electro_counter_2 >= 6)
                     {
                        this.electro_counter_2 = 0;
                        ++this.electro_counter_3;
                        if(this.electro_counter_3 >= 12)
                        {
                           this.electro_counter_1 = this.electro_counter_2 = this.electro_counter_3 = 0;
                           this.electroBullet = null;
                           SoundSystem.PlaySound("electricity_end");
                        }
                        else
                        {
                           SoundSystem.PlaySound("electricity_mid");
                        }
                     }
                  }
               }
            }
         }
         if(this.electroBullet != null)
         {
            this.electroBullet.xPos = xPos;
            this.electroBullet.yPos = yPos + offset_y;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.electricity != null)
         {
            this.electricity.x = this.electricity_top.x = sprite.x - 13;
            this.electricity.y = this.electricity_top.y = sprite.y - 12;
            this.electricity_top.visible = this.electricity.visible;
            this.electricity_top.alpha = 0.25;
         }
      }
      
      override public function setInvisible() : void
      {
         super.setInvisible();
         if(this.electricity != null)
         {
            this.electricity.visible = this.electricity_top.visible = false;
         }
      }
      
      override public function setActive() : void
      {
         super.setActive();
         if(this.electricity != null)
         {
            this.electricity.visible = this.electricity_top.visible = false;
         }
      }
      
      protected function electroParticles() : void
      {
         var pSprite:GameSprite = new ElectroParticleSprite();
         level.particlesManager.pushParticle(pSprite,xPos + 2,yPos + 8 + offset_y,2,1,0.8);
         pSprite = new ElectroParticleSprite();
         pSprite.scaleX = -1;
         level.particlesManager.pushParticle(pSprite,xPos - 2,yPos + 8 + offset_y,-2,1,0.8);
      }
      
      public function eggAnimation() : void
      {
         counter1 = 0;
         float_y = 0;
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function flyingAwayAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function cutsceneAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function targetingHeroAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function targetingEnemyAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function attackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function postAttackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
   }
}
