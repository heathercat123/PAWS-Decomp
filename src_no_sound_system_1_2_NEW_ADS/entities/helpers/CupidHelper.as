package entities.helpers
{
   import entities.Entity;
   import entities.enemies.Enemy;
   import flash.geom.*;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.bullets.GenericBulletSprite;
   import sprites.helpers.CupidHelperSprite;
   
   public class CupidHelper extends Helper
   {
       
      
      protected var MIN_DISTANCE:Number;
      
      protected var attack_counter:int;
      
      protected var dist_perc_enemy:Number;
      
      protected var IS_HEALING_HERO:Boolean;
      
      protected var bubble_counter_1:int;
      
      protected var healing_hero_cooldown_counter:int;
      
      protected var target_y:Number;
      
      protected var focus_counter:int;
      
      public function CupidHelper(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,LevelItems.ITEM_HELPER_CUPID);
         this.setParams();
         this.initSprites();
         this.IS_HEALING_HERO = false;
         this.bubble_counter_1 = this.healing_hero_cooldown_counter = 0;
         this.target_y = this.focus_counter = 0;
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
         stateMachine.setRule("IS_TARGETING_HERO_STATE","HEAL_HERO_ACTION","IS_HEALING_HERO_STATE");
         stateMachine.setRule("IS_HEALING_HERO_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","SET_FREE_ACTION","IS_FLYING_AWAY_STATE");
         stateMachine.setRule("IS_CUTSCENE_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setFunctionToState("IS_EGG_STATE",this.eggAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_HERO_STATE",this.targetingHeroAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_ENEMY_STATE",this.targetingEnemyAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         stateMachine.setFunctionToState("IS_POST_ATTACKING_STATE",this.postAttackingAnimation);
         stateMachine.setFunctionToState("IS_FLYING_AWAY_STATE",this.flyingAwayAnimation);
         stateMachine.setFunctionToState("IS_HEALING_HERO_STATE",this.healingHeroAnimation);
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setState("IS_TARGETING_HERO_STATE");
         this.randomizeAttackCooldown();
         this.MIN_DISTANCE = 48;
         this.dist_perc_enemy = 0;
         IS_IN_WATER = false;
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
               MAX_X_VEL = 3;
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
         sprite = new CupidHelperSprite(LEVEL);
         Utils.world.addChild(sprite);
         topSprite = new CupidHelperSprite(LEVEL);
         Utils.topWorld.addChild(topSprite);
         topSprite.visible = false;
      }
      
      override public function update() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         super.update();
         --this.healing_hero_cooldown_counter;
         if(stateMachine.currentState == "IS_EGG_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               level.particlesManager.eggExplosion(xPos,yPos);
               stateMachine.performAction("END_ACTION");
            }
            this.IS_HEALING_HERO = false;
            this.followHero();
         }
         else if(stateMachine.currentState == "IS_FLYING_AWAY_STATE")
         {
            flyAway();
         }
         else if(stateMachine.currentState == "IS_TARGETING_HERO_STATE")
         {
            this.IS_HEALING_HERO = false;
            this.followHero();
            if(this.canTargetEnemy() && attackCooldownCounter <= 0)
            {
               stateMachine.performAction("TARGET_ENEMY_ACTION");
            }
            else if(DIRECTION != level.hero.DIRECTION)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            if(this.healing_hero_cooldown_counter < 0)
            {
               if(level.hero.stunHandler.IS_STUNNED)
               {
                  if(LEVEL == 1 && level.hero.stunHandler.stun_percent <= 25)
                  {
                     stateMachine.performAction("HEAL_HERO_ACTION");
                  }
                  else if(LEVEL >= 2 && level.hero.stunHandler.stun_percent <= 50)
                  {
                     stateMachine.performAction("HEAL_HERO_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_HEALING_HERO_STATE")
         {
            this.IS_HEALING_HERO = true;
            this.followHero();
            diff_x = Math.abs(level.hero.getMidXPos() - xPos);
            diff_y = Math.abs(level.hero.getMidYPos() - yPos);
            if(Math.sqrt(diff_x * diff_x + diff_y * diff_y) < 24)
            {
               ++this.bubble_counter_1;
               if(this.bubble_counter_1 >= 5)
               {
                  QuestsManager.SubmitQuestAction(QuestsManager.ACTION_HEALED_BY_CUPID_HELPER);
                  SoundSystem.PlaySound("wink");
                  level.hero.stunHandler.unstun();
                  level.hero.setEmotionParticle(Entity.EMOTION_LOVE);
                  stateMachine.performAction("END_ACTION");
                  this.healing_hero_cooldown_counter = int(5 + Math.random() * 5) * 60;
               }
            }
            else
            {
               --this.bubble_counter_1;
               if(this.bubble_counter_1 <= 0)
               {
                  this.bubble_counter_1 = 0;
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            this.IS_HEALING_HERO = false;
            this.followHero();
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
               this.targetEnemy();
               if(isTargetTooDistantFromHero())
               {
                  stateMachine.performAction("END_ACTION");
               }
               if(this.dist_perc_enemy < 4)
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
            this.targetEnemy();
            if(target != null)
            {
               if(target.getMidXPos() > xPos)
               {
                  DIRECTION = RIGHT;
               }
               else
               {
                  DIRECTION = LEFT;
               }
            }
            if(Math.abs(yPos - this.target_y) <= 8 && this.focus_counter++ >= 15 || target == null || isTargetTooDistantFromHero())
            {
               this.randomizeAttackCooldown();
               stateMachine.performAction("END_ACTION");
               this.shootBubble();
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
            else if(attackCooldownCounter <= 0)
            {
               stateMachine.performAction("ATTACK_ACTION");
            }
            else
            {
               this.targetEnemy();
            }
         }
         --attackCooldownCounter;
         if(attackCooldownCounter <= 0)
         {
            attackCooldownCounter = 0;
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
         var max_vel_mult:Number = 1;
         if(this.IS_HEALING_HERO)
         {
            max_vel_mult = 4;
         }
         if(xVel > MAX_X_VEL * max_vel_mult)
         {
            xVel = MAX_X_VEL * max_vel_mult;
         }
         else if(xVel < -MAX_X_VEL * max_vel_mult)
         {
            xVel = -MAX_X_VEL * max_vel_mult;
         }
         if(yVel > MAX_X_VEL * max_vel_mult)
         {
            yVel = MAX_X_VEL * max_vel_mult;
         }
         else if(yVel < -MAX_X_VEL * max_vel_mult)
         {
            yVel = -MAX_X_VEL * max_vel_mult;
         }
         xPos += xVel;
         yPos += yVel;
         checkWater();
         if(IS_IN_WATER)
         {
            this.MIN_DISTANCE = 16;
         }
         else
         {
            this.MIN_DISTANCE = 32;
         }
      }
      
      protected function randomizeAttackCooldown() : void
      {
         attackCooldownCounter = (3 + Math.random() * 2) * 60;
      }
      
      override protected function canTargetEnemy() : Boolean
      {
         var i:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         if(LEVEL < 3)
         {
            return false;
         }
         diff_x = level.hero.getMidXPos() - xPos;
         diff_y = level.hero.getMidYPos() - yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > 144)
         {
            return false;
         }
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               if(level.enemiesManager.enemies[i].isTargetable())
               {
                  diff_x = level.enemiesManager.enemies[i].getMidXPos() - xPos;
                  diff_y = level.enemiesManager.enemies[i].getMidYPos() - yPos;
                  distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                  if(distance <= ACTION_RADIUS)
                  {
                     diff_x = level.enemiesManager.enemies[i].getMidXPos() - level.hero.getMidXPos();
                     diff_y = level.enemiesManager.enemies[i].getMidYPos() - level.hero.getMidYPos();
                     distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                     if(distance <= 128)
                     {
                        if(this.canBeAttacked(level.enemiesManager.enemies[i]))
                        {
                           if(level.enemiesManager.enemies[i].getMidYPos() - Utils.TILE_HEIGHT * 3 > level.camera.yPos)
                           {
                              target = level.enemiesManager.enemies[i];
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
      
      override protected function followHero() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         if(this.IS_HEALING_HERO)
         {
            dest_x = level.hero.getMidXPos();
            dest_y = level.hero.getMidYPos();
         }
         else
         {
            if(level.hero.DIRECTION == RIGHT)
            {
               dest_x = level.hero.xPos - Utils.TILE_WIDTH;
            }
            else
            {
               dest_x = level.hero.xPos + level.hero.WIDTH + Utils.TILE_WIDTH;
            }
            dest_y = level.hero.yPos - Utils.TILE_HEIGHT;
         }
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         if(this.IS_HEALING_HERO)
         {
            if(dist_perc <= 0.25)
            {
               dist_perc = 0.25;
            }
         }
         else if(dist_perc <= 0.1)
         {
            dist_perc = 0;
         }
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      override protected function targetEnemy() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var angle:Number = NaN;
         if(target == null)
         {
            return;
         }
         if(level.hero.DIRECTION == RIGHT)
         {
            dest_x = level.hero.xPos - Utils.TILE_WIDTH;
         }
         else
         {
            dest_x = level.hero.xPos + level.hero.WIDTH + Utils.TILE_WIDTH;
         }
         dest_y = this.target_y = target.getMidYPos() - 8;
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         this.dist_perc_enemy = distance / 160;
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * this.dist_perc_enemy;
         yVel += Math.sin(angle) * this.dist_perc_enemy;
      }
      
      protected function shootBubble() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var angle:Number = NaN;
         var bulletSprite:GenericBulletSprite = null;
         if(target != null)
         {
            diff_x = target.getMidXPos() + target.xVel * 2 - xPos;
            diff_y = target.getMidYPos() - (yPos + offset_y);
            angle = getAngle(1,0,diff_x,diff_y);
            if(!IS_IN_WATER)
            {
               angle += Math.random() * 0.5 - 0.25;
            }
            SoundSystem.PlaySound("arrow");
            bulletSprite = new GenericBulletSprite(GenericBulletSprite.ARROW_HELPER);
            if(DIRECTION == Entity.RIGHT)
            {
               bulletSprite.scaleX = -1;
            }
            if(DIRECTION == Entity.LEFT)
            {
               level.bulletsManager.pushBackBullet(bulletSprite,xPos - 6,yPos + offset_y + 5,-6,0,1,1,LEVEL);
            }
            else
            {
               level.bulletsManager.pushBackBullet(bulletSprite,xPos + 6,yPos + offset_y + 5,6,0,1,1,LEVEL);
            }
         }
      }
      
      override protected function canBeAttacked(enemy:Enemy) : Boolean
      {
         return true;
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
      
      public function healingHeroAnimation() : void
      {
         this.bubble_counter_1 = 0;
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
         this.focus_counter = 0;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function attackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
      }
      
      public function postAttackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
   }
}
