package entities.helpers
{
   import entities.enemies.Enemy;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.bullets.BubbleHelperBulletSprite;
   import sprites.helpers.JellyfishHelperSprite;
   
   public class JellyfishHelper extends Helper
   {
       
      
      protected var MIN_DISTANCE:Number;
      
      protected var attack_counter:int;
      
      protected var dist_perc_enemy:Number;
      
      protected var IS_CREATING_BUBBLE:Boolean;
      
      protected var bubble_counter_1:int;
      
      protected var bubble_cooldown_counter:int;
      
      public function JellyfishHelper(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,LevelItems.ITEM_HELPER_JELLYFISH);
         this.setParams();
         this.initSprites();
         this.IS_CREATING_BUBBLE = false;
         this.bubble_counter_1 = this.bubble_cooldown_counter = 0;
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
         stateMachine.setRule("IS_TARGETING_HERO_STATE","CREATE_BUBBLE_ACTION","IS_CREATING_BUBBLE_STATE");
         stateMachine.setRule("IS_CREATING_BUBBLE_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","SET_FREE_ACTION","IS_FLYING_AWAY_STATE");
         stateMachine.setRule("IS_CUTSCENE_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setFunctionToState("IS_EGG_STATE",this.eggAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_HERO_STATE",this.targetingHeroAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_ENEMY_STATE",this.targetingEnemyAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         stateMachine.setFunctionToState("IS_POST_ATTACKING_STATE",this.postAttackingAnimation);
         stateMachine.setFunctionToState("IS_FLYING_AWAY_STATE",this.flyingAwayAnimation);
         stateMachine.setFunctionToState("IS_CREATING_BUBBLE_STATE",this.creatingBubbleAnimation);
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setState("IS_TARGETING_HERO_STATE");
         this.MIN_DISTANCE = 48;
         this.dist_perc_enemy = 0;
         IS_IN_WATER = false;
      }
      
      override protected function setParams() : void
      {
         if(LEVEL == 1)
         {
            if(!IS_IN_WATER)
            {
               RADIUS_MAX_DISTANCE_FROM_HERO = 48;
               MAX_X_VEL = 2;
            }
            else
            {
               RADIUS_MAX_DISTANCE_FROM_HERO = 64;
               MAX_X_VEL = 1;
            }
         }
         else if(!IS_IN_WATER)
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 64;
            MAX_X_VEL = 2;
         }
         else
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 80;
            MAX_X_VEL = 1;
         }
      }
      
      override protected function initSprites() : void
      {
         sprite = new JellyfishHelperSprite(LEVEL);
         Utils.world.addChild(sprite);
         topSprite = new JellyfishHelperSprite(LEVEL);
         Utils.topWorld.addChild(topSprite);
         topSprite.visible = false;
      }
      
      override public function update() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         super.update();
         --this.bubble_cooldown_counter;
         if(stateMachine.currentState == "IS_EGG_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               level.particlesManager.eggExplosion(xPos,yPos);
               stateMachine.performAction("END_ACTION");
            }
            this.IS_CREATING_BUBBLE = false;
            this.followHero();
         }
         else if(stateMachine.currentState == "IS_FLYING_AWAY_STATE")
         {
            flyAway();
         }
         else if(stateMachine.currentState == "IS_TARGETING_HERO_STATE")
         {
            this.IS_CREATING_BUBBLE = false;
            this.followHero();
            if(canTargetEnemy())
            {
               stateMachine.performAction("TARGET_ENEMY_ACTION");
            }
            else if(DIRECTION != level.hero.DIRECTION)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            if(LEVEL >= 3 && this.bubble_cooldown_counter < 0)
            {
               if(level.hero.BUBBLE_STATE == 0 && level.hero.IS_IN_WATER)
               {
                  if(level.hero.getMidYPos() >= Utils.SEA_LEVEL + 16)
                  {
                     stateMachine.performAction("CREATE_BUBBLE_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_CREATING_BUBBLE_STATE")
         {
            this.IS_CREATING_BUBBLE = true;
            this.followHero();
            diff_x = Math.abs(level.hero.getMidXPos() - xPos);
            diff_y = Math.abs(level.hero.getMidYPos() - yPos);
            if(Math.sqrt(diff_x * diff_x + diff_y * diff_y) < 16)
            {
               ++this.bubble_counter_1;
               if(this.bubble_counter_1 >= 15)
               {
                  SoundSystem.PlaySound("item_pop");
                  level.hero.BUBBLE_STATE = 1;
                  stateMachine.performAction("END_ACTION");
                  this.bubble_cooldown_counter = int(5 + Math.random() * 5) * 60;
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
            this.IS_CREATING_BUBBLE = false;
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
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               attackCooldownCounter = 30;
               if(!IS_IN_WATER)
               {
                  attackCooldownCounter = 60;
               }
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
            else
            {
               --attackCooldownCounter;
               if(attackCooldownCounter <= 0)
               {
                  stateMachine.performAction("ATTACK_ACTION");
               }
               else
               {
                  this.targetEnemy();
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
         if(IS_IN_WATER)
         {
            this.MIN_DISTANCE = 16;
         }
         else
         {
            this.MIN_DISTANCE = 32;
         }
      }
      
      override protected function followHero() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         if(this.IS_CREATING_BUBBLE)
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
         if(dist_perc <= 0.1)
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
         dest_x = (target.getMidXPos() - level.hero.getMidXPos()) * 0.5 + level.hero.getMidXPos();
         if(IS_IN_WATER)
         {
            dest_y = (target.getMidYPos() - level.hero.getMidYPos()) * 0.5 + level.hero.getMidYPos();
         }
         else
         {
            dest_y = (target.getMidYPos() - level.hero.getMidYPos()) * 0.5 + (level.hero.getMidYPos() - 24);
         }
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
         var bulletSprite:BubbleHelperBulletSprite = null;
         if(target != null)
         {
            diff_x = target.getMidXPos() + target.xVel * 2 - xPos;
            diff_y = target.getMidYPos() - (yPos + offset_y);
            angle = getAngle(1,0,diff_x,diff_y);
            if(!IS_IN_WATER)
            {
               angle += Math.random() * 0.5 - 0.25;
            }
            SoundSystem.PlaySound("bubble_attack");
            bulletSprite = new BubbleHelperBulletSprite(LEVEL);
            if(Math.random() * 100 > 50)
            {
               bulletSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               bulletSprite.gfxHandleClip().gotoAndStop(2);
            }
            if(IS_IN_WATER)
            {
               level.bulletsManager.pushBackBullet(bulletSprite,xPos,yPos + offset_y,Math.cos(angle) * 2,Math.sin(angle) * 2,1,1,LEVEL);
            }
            else
            {
               level.bulletsManager.pushBackBullet(bulletSprite,xPos,yPos + offset_y,Math.cos(angle) * 2,Math.sin(angle) * 2,1,0,LEVEL);
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
      
      public function creatingBubbleAnimation() : void
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
