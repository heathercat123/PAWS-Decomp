package entities.helpers
{
   import flash.geom.*;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.ClodCollision;
   import sprites.GameSprite;
   import sprites.bullets.SeedHelperBulletSprite;
   import sprites.enemies.SmallPollenLeafSprite;
   import sprites.helpers.SeedHelperSprite;
   import sprites.particles.ElectroParticleSprite;
   
   public class SeedHelper extends Helper
   {
       
      
      protected var leafSprite:SmallPollenLeafSprite;
      
      protected var topLeafSprite:SmallPollenLeafSprite;
      
      protected var leaf_frame:Number;
      
      protected var target_x_shift:Number;
      
      protected var clod:ClodCollision;
      
      protected var seeding_counter:int;
      
      public function SeedHelper(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,LevelItems.ITEM_HELPER_COCONUT);
         this.setParams();
         this.initSprites();
         this.clod = null;
         this.seeding_counter = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_EGG_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TARGET_ENEMY_ACTION","IS_TARGETING_ENEMY_STATE");
         stateMachine.setRule("IS_TARGETING_ENEMY_STATE","CLOSE_ACTION","IS_ATTACKING_STATE");
         stateMachine.setRule("IS_TARGETING_ENEMY_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TARGET_CLOD_ACTION","IS_TARGETING_CLOD_STATE");
         stateMachine.setRule("IS_TARGETING_CLOD_STATE","CLOSE_ACTION","IS_SEEDING_STATE");
         stateMachine.setRule("IS_SEEDING_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_CLOD_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
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
         stateMachine.setFunctionToState("IS_TARGETING_CLOD_STATE",this.targetingClodAnimation);
         stateMachine.setFunctionToState("IS_SEEDING_STATE",this.seedingAnimation);
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setState("IS_TARGETING_HERO_STATE");
         this.leaf_frame = 0;
      }
      
      override protected function setParams() : void
      {
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
      
      override protected function initSprites() : void
      {
         sprite = new SeedHelperSprite(LEVEL);
         Utils.world.addChild(sprite);
         if(LEVEL <= 2)
         {
            this.leafSprite = new SmallPollenLeafSprite();
         }
         else
         {
            this.leafSprite = new SmallPollenLeafSprite(2);
         }
         Utils.world.addChild(this.leafSprite);
         topSprite = new SeedHelperSprite(LEVEL);
         Utils.topWorld.addChild(topSprite);
         topSprite.visible = false;
         if(LEVEL <= 2)
         {
            this.topLeafSprite = new SmallPollenLeafSprite();
         }
         else
         {
            this.topLeafSprite = new SmallPollenLeafSprite(2);
         }
         Utils.topWorld.addChild(this.topLeafSprite);
         this.topLeafSprite.visible = false;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(this.topLeafSprite);
         this.topLeafSprite.destroy();
         this.topLeafSprite.dispose();
         this.topLeafSprite = null;
         Utils.world.removeChild(this.leafSprite);
         this.leafSprite.destroy();
         this.leafSprite.dispose();
         this.leafSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:SeedHelperBulletSprite = null;
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
            if(this.canTargetClod())
            {
               stateMachine.performAction("TARGET_CLOD_ACTION");
            }
            else if(canTargetEnemy())
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
         else if(stateMachine.currentState == "IS_TARGETING_CLOD_STATE")
         {
            this.followClod();
            if(this.clod.stateMachine.currentState != "IS_NORMAL_STATE")
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(Math.abs(xPos - this.clod.getMidXPos()) < 2 && Math.abs(yPos - this.clod.getMidYPos()) <= 40 && yPos <= this.clod.getMidYPos())
            {
               xPos = this.clod.getMidXPos();
               stateMachine.performAction("CLOSE_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SEEDING_STATE")
         {
            if(this.clod.stateMachine.currentState != "IS_NORMAL_STATE")
            {
               stateMachine.performAction("END_ACTION");
            }
            else
            {
               --this.seeding_counter;
               if(this.seeding_counter == 1)
               {
                  sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  this.seeding_counter = 60;
                  SoundSystem.PlaySound("seed_attack");
                  if(LEVEL == 3)
                  {
                     pSprite = new SeedHelperBulletSprite(2);
                  }
                  else
                  {
                     pSprite = new SeedHelperBulletSprite(0);
                  }
                  level.bulletsManager.pushBullet(pSprite,xPos,yPos + 8,0,0,1,LEVEL);
               }
            }
         }
         else if(stateMachine.currentState == "IS_TARGETING_ENEMY_STATE")
         {
            if(target != null)
            {
               this.targetEnemy();
               if(isTargetTooDistantFromHero())
               {
                  stateMachine.performAction("END_ACTION");
               }
               if(Math.abs(target.getMidXPos() + this.target_x_shift - xPos) < 8 && target.getMidYPos() - yPos > 16)
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
                  attackCooldownCounter = 60;
               }
               else if(LEVEL == 2)
               {
                  attackCooldownCounter = 30;
               }
               else
               {
                  attackCooldownCounter = 20;
               }
               if(IS_IN_WATER)
               {
                  attackCooldownCounter *= 5;
               }
               stateMachine.performAction("END_ACTION");
               SoundSystem.PlaySound("seed_attack");
               if(LEVEL == 3)
               {
                  pSprite = new SeedHelperBulletSprite(2);
               }
               else
               {
                  pSprite = new SeedHelperBulletSprite(0);
               }
               if(LEVEL == 1)
               {
                  if(Utils.SEA_LEVEL > 0 && yPos > Utils.SEA_LEVEL)
                  {
                     level.bulletsManager.pushBullet(pSprite,xPos,yPos + 8 + offset_y,0,0,1,LEVEL);
                  }
                  else if(Math.random() * 100 > 50)
                  {
                     pSprite.scaleX = -1;
                     level.bulletsManager.pushBullet(pSprite,xPos - 6,yPos + 8 + offset_y,-(Math.random() * 1.5 + 0.5),0,1,LEVEL);
                  }
                  else
                  {
                     level.bulletsManager.pushBullet(pSprite,xPos + 6,yPos + 8 + offset_y,Math.random() * 1.5 + 0.5,0,1,LEVEL);
                  }
               }
               else if(Utils.SEA_LEVEL > 0 && yPos > Utils.SEA_LEVEL)
               {
                  level.bulletsManager.pushBullet(pSprite,xPos,yPos + 8 + offset_y,0,0,1,LEVEL);
               }
               else
               {
                  level.bulletsManager.pushBullet(pSprite,xPos + 6,yPos + 8 + offset_y,Math.random() * 1.5 + 0.5,0,1,LEVEL);
                  if(LEVEL == 3)
                  {
                     pSprite = new SeedHelperBulletSprite(2);
                  }
                  else
                  {
                     pSprite = new SeedHelperBulletSprite(0);
                  }
                  pSprite.scaleX = -1;
                  level.bulletsManager.pushBullet(pSprite,xPos - 6,yPos + 8 + offset_y,-(Math.random() * 1.5 + 0.5),0,1,LEVEL);
               }
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
         else if(stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
         }
         if(target != null)
         {
            if(target.dead || target.stateMachine.currentState == "IS_HIT_STATE")
            {
               target = null;
            }
         }
         if(sprite.gfxHandle().frame == 1)
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,Math.random() * 2 + 2);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
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
         var speed_power:Number = Math.sqrt(xVel * xVel + yVel * yVel);
         if(speed_power < 0.7)
         {
            speed_power = 0.7;
         }
         this.leaf_frame += speed_power * 0.25;
         if(this.leaf_frame >= 6)
         {
            this.leaf_frame -= 6;
         }
      }
      
      override protected function targetEnemy() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         dest_x = target.getMidXPos() + this.target_x_shift;
         dest_y = target.getMidYPos() - (target.HEIGHT * 0.5 + Utils.TILE_HEIGHT * 1.5);
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
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
         this.leafSprite.visible = false;
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function cutsceneAnimation() : void
      {
         this.leafSprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function targetingHeroAnimation() : void
      {
         this.leafSprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function targetingClodAnimation() : void
      {
         this.leafSprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function flyingAwayAnimation() : void
      {
         this.leafSprite.visible = true;
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
         this.target_x_shift = (Math.round(Math.random() * 3) - 1.5) * Utils.TILE_WIDTH;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function attackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function seedingAnimation() : void
      {
         xVel = 0;
         this.seeding_counter = 0;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function postAttackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos + offset_y - camera.yPos));
         if(LEVEL == 3)
         {
            this.leafSprite.x = sprite.x + 1;
         }
         else if(DIRECTION == RIGHT)
         {
            this.leafSprite.x = sprite.x + 1;
         }
         else
         {
            this.leafSprite.x = sprite.x;
         }
         this.leafSprite.y = sprite.y - 4;
         this.leafSprite.gfxHandleClip().gotoAndStop(this.leaf_frame + 1);
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               sprite.gfxHandle().scaleX = -1;
            }
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
         var isInsideObstacle:Boolean = false;
         topSprite.visible = this.topLeafSprite.visible = true;
         topSprite.alpha = this.topLeafSprite.alpha = 0.25;
         topSprite.gfxHandle().gotoAndStop(sprite.gfxHandle().frame);
         topSprite.gfxHandle().gfxHandleClip().gotoAndStop(sprite.gfxHandle().gfxHandleClip().currentFrame + 1);
         this.topLeafSprite.gfxHandleClip().gotoAndStop(this.leafSprite.gfxHandleClip().currentFrame + 1);
         topSprite.x = sprite.x;
         topSprite.y = sprite.y;
         this.topLeafSprite.x = this.leafSprite.x;
         this.topLeafSprite.y = this.leafSprite.y;
         topSprite.gfxHandle().scaleX = sprite.gfxHandle().scaleX;
         topSprite.updateScreenPosition();
         if(LEVEL == 1)
         {
            this.leafSprite.visible = false;
            this.topLeafSprite.visible = false;
         }
         if(stateMachine.currentState == "IS_EGG_STATE")
         {
            this.topLeafSprite.visible = this.leafSprite.visible = false;
         }
      }
      
      override public function setVisible() : void
      {
         super.setVisible();
         this.leafSprite.visible = true;
         this.topLeafSprite.visible = true;
      }
      
      override public function setInvisible() : void
      {
         super.setInvisible();
         this.leafSprite.visible = false;
         this.topLeafSprite.visible = false;
      }
      
      protected function followClod() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         dest_x = this.clod.getMidXPos();
         dest_y = this.clod.getMidYPos() - 32;
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         if(dist_perc <= 0.1)
         {
            dist_perc = 0.1;
         }
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function canTargetClod() : Boolean
      {
         var i:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         diff_x = level.hero.getMidXPos() - xPos;
         diff_y = level.hero.getMidYPos() - yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > 144)
         {
            return false;
         }
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is ClodCollision)
               {
                  if(level.collisionsManager.collisions[i].stateMachine.currentState == "IS_NORMAL_STATE")
                  {
                     diff_x = level.collisionsManager.collisions[i].getMidXPos() - xPos;
                     diff_y = level.collisionsManager.collisions[i].getMidYPos() - yPos;
                     distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                     if(distance <= ACTION_RADIUS)
                     {
                        diff_x = level.collisionsManager.collisions[i].getMidXPos() - level.hero.getMidXPos();
                        diff_y = level.collisionsManager.collisions[i].getMidYPos() - level.hero.getMidYPos();
                        distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                        if(distance <= 128)
                        {
                           if(level.collisionsManager.collisions[i].isInsideInnerScreen())
                           {
                              this.clod = level.collisionsManager.collisions[i];
                              return true;
                           }
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
   }
}
