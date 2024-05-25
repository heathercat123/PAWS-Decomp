package entities.enemies
{
   import entities.Easings;
   import entities.Hero;
   import entities.StunHandler;
   import entities.bullets.Bullet;
   import game_utils.QuestsManager;
   import levels.Level;
   import sprites.bullets.BubbleHelperBulletSprite;
   import sprites.bullets.SeedHelperBulletSprite;
   import sprites.bullets.ThunderHelperBulletSprite;
   import sprites.particles.EnemyBigHurtParticleSprite;
   
   public class GiantEnemy extends Enemy
   {
       
      
      protected var hero_collision_detection_cool_off_counter:int;
      
      protected var bullet_cool_counter_1:int;
      
      protected var helper_bullet_quest_event_just_once:Boolean;
      
      public function GiantEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai);
         stunHandler = new StunHandler(level,this);
         stunHandler.stun_x_offset = 0;
         stunHandler.stun_y_offset = -9;
         this.helper_bullet_quest_event_just_once = true;
         this.hero_collision_detection_cool_off_counter = 0;
         this.bullet_cool_counter_1 = 0;
         energy = 2;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         if(stunHandler)
         {
            stunHandler.update();
         }
         --this.hero_collision_detection_cool_off_counter;
         if(this.hero_collision_detection_cool_off_counter < 0)
         {
            this.hero_collision_detection_cool_off_counter = 0;
         }
         --this.bullet_cool_counter_1;
         if(this.bullet_cool_counter_1 < 0)
         {
            this.bullet_cool_counter_1 = 0;
         }
         if(BULLET_HIT_FLAG)
         {
            ++bullet_hit_counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(bullet_hit_counter1 >= wait_time)
            {
               bullet_hit_counter1 = 0;
               ++bullet_hit_counter2;
               sprite.visible = !sprite.visible;
               if(bullet_hit_counter2 > 6)
               {
                  sprite.visible = true;
                  BULLET_HIT_FLAG = false;
               }
            }
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            xVel = yVel = 0;
            t_hurt_tick += 1 / 60;
            if(t_hurt_tick >= t_hurt_time)
            {
               t_hurt_tick = t_hurt_time;
               ++counter1;
            }
            xPos = Easings.easeOutSine(t_hurt_tick,t_hurt_start_x,t_hurt_diff_x,t_hurt_time);
            yPos = Easings.easeOutBack(t_hurt_tick,t_hurt_start_y,t_hurt_diff_y,t_hurt_time,3);
            if(t_hurt_tick >= t_hurt_time - 0.05)
            {
               level.particlesManager.pushParticle(new EnemyBigHurtParticleSprite(),getMidXPos(),getMidYPos(),0,0,0);
               stateMachine.performAction("END_ACTION");
            }
            stunHandler.unstun();
         }
         if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(stunHandler.IS_STUNNED == false)
            {
               this.restoreEnergy();
               stateMachine.performAction("END_ACTION");
            }
         }
      }
      
      protected function restoreEnergy() : void
      {
         energy = 2;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_DEAD_STATE" || dead || hero.stunHandler.IS_STUNNED && hero.stunHandler.stun_counter_1 < 10)
         {
            return;
         }
         if(this.hero_collision_detection_cool_off_counter > 0)
         {
            return;
         }
         var isCatAttacking:Boolean = false;
         if(hero.getAABB().intersects(getAABB()) || hero.getAABB().intersects(getAABBSpike()))
         {
            if(hero.stateMachine.currentState == "IS_RUNNING_STATE" || hero.stateMachine.currentState == "IS_JUMPING_STATE" || hero.stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || hero.stateMachine.currentState == "IS_HOPPING_STATE" && !hero.wasOnRope() || specialAttackCondition())
            {
               if(allowCatAttack())
               {
                  isCatAttacking = true;
               }
            }
            if(hero.stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE" && allowCatAttack())
            {
               isCatAttacking = true;
            }
            hit(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
            this.hero_collision_detection_cool_off_counter = 5;
            if(!isCatAttacking)
            {
               hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
            }
            else if(stateMachine.currentState == "IS_HIT_STATE")
            {
               hero.attack(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
            }
            else
            {
               hero.stateMachine.performAction("WALL_COLLISION_ACTION");
            }
         }
      }
      
      override public function reset() : void
      {
         this.helper_bullet_quest_event_just_once = true;
         xPos = originalXPos;
         yPos = originalYPos;
         xVel = yVel = 0;
         DIRECTION = ORIGINAL_DIRECTION;
         energy = 2;
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(isInvulnerableToHelperAttacks())
         {
            return;
         }
         if(this.bullet_cool_counter_1 > 0)
         {
            return;
         }
         energy -= bullet.POWER;
         if(energy <= 0)
         {
            hit();
            level.particlesManager.hurtImpactParticle(this,bullet.xPos,bullet.yPos);
            if(stateMachine.currentState == "IS_HIT_STATE" && this.helper_bullet_quest_event_just_once)
            {
               this.helper_bullet_quest_event_just_once = false;
               if(bullet.sprite is SeedHelperBulletSprite)
               {
                  QuestsManager.SubmitQuestAction(QuestsManager.ACTION_ENEMY_DEFEATED_BY_COCONUT_HELPER);
               }
               else if(bullet.sprite is BubbleHelperBulletSprite)
               {
                  QuestsManager.SubmitQuestAction(QuestsManager.ACTION_ENEMY_DEFEATED_BY_JELLYFISH_HELPER);
               }
               else if(bullet.sprite is ThunderHelperBulletSprite)
               {
                  QuestsManager.SubmitQuestAction(QuestsManager.ACTION_ENEMY_DEFEATED_BY_CLOUD_HELPER);
               }
            }
         }
         else if(BULLET_HIT_FLAG == false)
         {
            SoundSystem.PlaySound("enemy_hurt_bullet");
            BULLET_HIT_FLAG = true;
            bullet_hit_counter1 = bullet_hit_counter2 = 0;
            level.particlesManager.hurtImpactParticle(this,bullet.xPos,bullet.yPos);
         }
      }
      
      override protected function setHitVariables() : void
      {
         super.setHitVariables();
         t_hurt_diff_x *= 1.25;
         t_hurt_diff_y *= 1.25;
         t_hurt_time *= 1.25;
      }
      
      public function hurtAnimation() : void
      {
         stunHandler.stun();
         this.restoreEnergy();
      }
   }
}
