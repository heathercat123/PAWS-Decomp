package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.bullets.Bullet;
   import flash.geom.*;
   import game_utils.QuestsManager;
   import levels.Level;
   import levels.cameras.*;
   import sprites.bullets.BubbleHelperBulletSprite;
   import sprites.bullets.SeedHelperBulletSprite;
   import sprites.bullets.ThunderHelperBulletSprite;
   import sprites.particles.EnemyHurtParticleSprite;
   
   public class Enemy extends Entity
   {
       
      
      protected var tick_counter:Number;
      
      protected var tick_time:Number;
      
      protected var tick_start:Number;
      
      protected var tick_diff:Number;
      
      protected var t_hurt_start_x:Number;
      
      protected var t_hurt_start_y:Number;
      
      protected var t_hurt_diff_x:Number;
      
      protected var t_hurt_diff_y:Number;
      
      protected var t_hurt_tick:Number;
      
      protected var t_hurt_time:Number;
      
      protected var path_start_y:Number;
      
      protected var path_end_y:Number;
      
      protected var path_start_x:Number;
      
      public var path_end_x:Number;
      
      protected var hit_source_x:Number;
      
      protected var hit_source_y:Number;
      
      protected var sinCounter1:Number;
      
      protected var ORIGINAL_DIRECTION:int;
      
      public var ai_index:int;
      
      public var energy:Number;
      
      public var BULLET_HIT_FLAG:Boolean;
      
      public var bullet_hit_counter1:int;
      
      public var bullet_hit_counter2:int;
      
      protected var number_index:int;
      
      protected var fixed_t_hurt_diff_x:Number;
      
      public var KILLED_BY_CAT:Boolean;
      
      public var IS_MINIBOSS:Boolean;
      
      public var IS_BOSS:Boolean;
      
      public function Enemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction);
         this.ai_index = _ai_index;
         this.ORIGINAL_DIRECTION = _direction;
         this.KILLED_BY_CAT = this.IS_MINIBOSS = this.IS_BOSS = false;
         WIDTH = HEIGHT = 16;
         this.energy = 1;
         this.number_index = -1;
         this.tick_counter = this.tick_time = this.tick_start = this.tick_diff = 0;
         this.path_start_y = this.path_end_y = this.path_start_x = this.path_end_x = 0;
         this.hit_source_x = this.hit_source_y = 0;
         this.fixed_t_hurt_diff_x = -1;
         this.BULLET_HIT_FLAG = false;
         this.t_hurt_start_x = this.t_hurt_start_y = this.t_hurt_diff_x = this.t_hurt_diff_y = this.t_hurt_tick = this.t_hurt_time = 0;
         this.bullet_hit_counter1 = this.bullet_hit_counter2 = 0;
         this.sinCounter1 = Math.random() * Math.PI * 2;
         this.fetchScripts();
      }
      
      public function postInit() : void
      {
      }
      
      public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_DEAD_STATE" || dead || hero.stunHandler.IS_STUNNED && hero.stunHandler.stun_counter_1 < 10 || hero.stateMachine.currentState == "IS_HEAD_POUND_STATE" && hero.head_pound_counter < 10)
         {
            return;
         }
         var isCatAttacking:Boolean = false;
         var isEnemyDefending:Boolean = false;
         if(hero.getAABB().intersects(getAABB()) || hero.getAABB().intersects(getAABBSpike()))
         {
            if(this.specialAttackCondition() || hero.isAttackingState())
            {
               if(this.allowCatAttack())
               {
                  isCatAttacking = true;
               }
            }
            if(this.allowEnemyDefend())
            {
               isEnemyDefending = true;
            }
            if(hero.BUBBLE_STATE > 0)
            {
               if(hero.IS_IN_WATER || this.allowScubaMaskAttack())
               {
                  isCatAttacking = true;
               }
            }
            if(hero.stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE")
            {
               isCatAttacking = true;
            }
            if(isCatAttacking)
            {
               if(isEnemyDefending)
               {
                  hero.enemyDefend(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
               }
               else
               {
                  hero.attack(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
               }
            }
            else
            {
               hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
            }
            if(hero.stateMachine.currentState != "IS_GAME_OVER_STATE")
            {
               if(isEnemyDefending)
               {
                  this.defend(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
               }
               else
               {
                  this.hit(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
               }
            }
         }
      }
      
      protected function specialAttackCondition() : Boolean
      {
         return false;
      }
      
      protected function allowScubaMaskAttack() : Boolean
      {
         return false;
      }
      
      protected function allowEnemyDefend() : Boolean
      {
         return false;
      }
      
      protected function allowCatAttack() : Boolean
      {
         return true;
      }
      
      public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            SoundSystem.PlaySound("enemy_hurt");
         }
      }
      
      public function hit(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : void
      {
         if(stateMachine.currentState != "IS_HIT_STATE")
         {
            this.playSound("hurt");
         }
         this.hit_source_x = _source_x;
         this.hit_source_y = _source_y;
         this.KILLED_BY_CAT = _isCatAttacking;
         if(this.IS_MINIBOSS)
         {
            if(stateMachine.currentState == "IS_HURT_STATE")
            {
               if(this.KILLED_BY_CAT)
               {
                  if(this.IS_MINIBOSS)
                  {
                     QuestsManager.SubmitQuestAction(QuestsManager.ACTION_MINIBOSS_DEFEATED_BY_ANY_CAT);
                  }
               }
            }
         }
         stateMachine.performAction("HIT_ACTION");
         if(this.IS_BOSS)
         {
            if(this.KILLED_BY_CAT)
            {
               if(stateMachine.currentState == "IS_DEAD_STATE")
               {
                  QuestsManager.SubmitQuestAction(QuestsManager.ACTION_BOSS_DEFEATED_BY_ANY_CAT);
               }
            }
         }
         counter1 = 0;
      }
      
      public function defend(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : *
      {
      }
      
      public function isWaterAllowed() : Boolean
      {
         return true;
      }
      
      protected function setHitVariables() : void
      {
         this.setVisible(true);
         var diff_x_mult:Number = 1;
         this.t_hurt_start_x = xPos;
         this.t_hurt_start_y = yPos;
         DIRECTION = Entity.LEFT;
         if(this.hit_source_x > getMidXPos())
         {
            diff_x_mult = -1;
            DIRECTION = Entity.RIGHT;
         }
         var mid_x_t:int = int(getMidXPos() / Utils.TILE_WIDTH);
         var mid_y_t:int = int(getMidYPos() / Utils.TILE_HEIGHT);
         if(DIRECTION == Entity.RIGHT)
         {
            if(level.levelData.getTileValueAt(mid_x_t - 1,mid_y_t) != 0 || level.levelData.getTileValueAt(mid_x_t - 2,mid_y_t) != 0 && WIDTH >= 24)
            {
               diff_x_mult = 1;
               DIRECTION = Entity.LEFT;
            }
         }
         else if(DIRECTION == Entity.LEFT)
         {
            if(level.levelData.getTileValueAt(mid_x_t + 1,mid_y_t) != 0 || level.levelData.getTileValueAt(mid_x_t + 2,mid_y_t) != 0 && WIDTH >= 24)
            {
               diff_x_mult = -1;
               DIRECTION = Entity.RIGHT;
            }
         }
         if(this.fixed_t_hurt_diff_x > -1)
         {
            this.t_hurt_diff_x = this.fixed_t_hurt_diff_x * diff_x_mult;
            this.t_hurt_diff_y = -this.fixed_t_hurt_diff_x;
         }
         else
         {
            if(Math.random() * 100 > 50)
            {
               this.t_hurt_diff_x = 16 * diff_x_mult;
            }
            else if(Math.random() * 100 > 50)
            {
               this.t_hurt_diff_x = 24 * diff_x_mult;
            }
            else
            {
               this.t_hurt_diff_x = 12 * diff_x_mult;
            }
            if(Math.random() * 100 > 50)
            {
               this.t_hurt_diff_y = -16;
            }
            else if(Math.random() * 100 > 50)
            {
               this.t_hurt_diff_y = -24;
            }
            else
            {
               this.t_hurt_diff_y = -12;
            }
         }
         this.t_hurt_tick = 0;
         this.t_hurt_time = 0.25 + int(Math.random() * 3) / 10;
      }
      
      protected function getTileAhead(t_offset_x:int, t_offset_y:int, include_platform:Boolean = true) : int
      {
         var x_t:int = 0;
         var y_t:int = 0;
         var xPoint:Number = NaN;
         var yPoint:Number = NaN;
         var t_value:int = 0;
         if(DIRECTION == RIGHT)
         {
            x_t = int((xPos + aabbPhysics.x + aabbPhysics.width) / Utils.TILE_WIDTH);
         }
         else
         {
            x_t = int((xPos + aabbPhysics.x) / Utils.TILE_WIDTH);
         }
         y_t = int((yPos + aabbPhysics.y + aabbPhysics.height - Utils.TILE_HEIGHT * 0.5 + Utils.TILE_HEIGHT * t_offset_y) / Utils.TILE_HEIGHT);
         t_value = level.levelData.getTileValueAt(x_t,y_t);
         if(t_value == 0 && include_platform)
         {
            if(colliding_platform != null)
            {
               if(DIRECTION == RIGHT)
               {
                  xPoint = xPos + aabbPhysics.x + aabbPhysics.width;
               }
               else
               {
                  xPoint = xPos + aabbPhysics.x;
               }
               yPoint = yPos + aabbPhysics.y + aabbPhysics.height - Utils.TILE_HEIGHT * 0.5 + Utils.TILE_HEIGHT * t_offset_y;
               if(colliding_platform.getAABB().contains(xPoint,yPoint))
               {
                  t_value = 1;
               }
            }
         }
         return t_value;
      }
      
      public function bulletImpact(bullet:Bullet) : void
      {
         if(this.energy <= 0)
         {
            return;
         }
         this.energy -= bullet.POWER;
         if(this.energy <= 0)
         {
            this.hit();
            level.particlesManager.hurtImpactParticle(this,bullet.xPos,bullet.yPos);
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
         else if(this.BULLET_HIT_FLAG == false)
         {
            SoundSystem.PlaySound("enemy_hurt_bullet");
            this.BULLET_HIT_FLAG = true;
            this.bullet_hit_counter1 = this.bullet_hit_counter2 = 0;
            level.particlesManager.hurtImpactParticle(this,bullet.xPos,bullet.yPos);
         }
      }
      
      public function setVisible(_value:Boolean) : void
      {
         sprite.visible = _value;
      }
      
      protected function isInvulnerableToHelperAttacks() : Boolean
      {
         return false;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         if(stunHandler)
         {
            stunHandler.update();
         }
         if(this.BULLET_HIT_FLAG)
         {
            ++this.bullet_hit_counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(this.bullet_hit_counter1 >= wait_time)
            {
               this.bullet_hit_counter1 = 0;
               ++this.bullet_hit_counter2;
               sprite.visible = !sprite.visible;
               if(this.bullet_hit_counter2 > 6)
               {
                  sprite.visible = true;
                  this.BULLET_HIT_FLAG = false;
               }
            }
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            xVel = yVel = 0;
            this.t_hurt_tick += 1 / 60;
            if(this.t_hurt_tick >= this.t_hurt_time)
            {
               this.t_hurt_tick = this.t_hurt_time;
               ++counter1;
            }
            xPos = Easings.easeOutSine(this.t_hurt_tick,this.t_hurt_start_x,this.t_hurt_diff_x,this.t_hurt_time);
            yPos = Easings.easeOutBack(this.t_hurt_tick,this.t_hurt_start_y,this.t_hurt_diff_y,this.t_hurt_time,3);
            if(this.t_hurt_tick >= this.t_hurt_time - 0.05)
            {
               level.particlesManager.pushParticle(new EnemyHurtParticleSprite(),xPos + 8,yPos + 8,0,0,0);
               stateMachine.performAction("END_ACTION");
            }
         }
      }
      
      protected function integratePositionAndCollisionDetection() : void
      {
         yVel += 0.4 * gravity_friction;
         xVel *= x_friction;
         if(xVel >= MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel <= -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel >= MAX_Y_VEL)
         {
            yVel = MAX_Y_VEL;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      public function isTargetable() : Boolean
      {
         if(!active)
         {
            return false;
         }
         if(dead)
         {
            return false;
         }
         if(!isInsideInnerScreen())
         {
            return false;
         }
         return true;
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         var area_enemy:Rectangle = new Rectangle(xPos - 16,yPos - 16,32,32);
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               if(level.scriptsManager.verPathScripts[i].intersects(area_enemy))
               {
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = level.scriptsManager.verPathScripts[i].y + level.scriptsManager.verPathScripts[i].height;
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               if(level.scriptsManager.horPathScripts[i].intersects(area_enemy))
               {
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = level.scriptsManager.horPathScripts[i].x + level.scriptsManager.horPathScripts[i].width;
               }
            }
         }
      }
      
      public function resetBoundaries() : void
      {
         this.path_start_x = this.path_end_x = 0;
         this.path_start_y = this.path_end_y = 0;
      }
      
      public function shake() : void
      {
      }
      
      public function deadAnimation() : void
      {
         dead = true;
      }
      
      protected function isOnHeroPlatform() : Boolean
      {
         var i:int = 0;
         var mid_x:Number = NaN;
         var mid_y:Number = NaN;
         var diff_t:int = 0;
         mid_x = xPos + WIDTH * 0.5;
         mid_y = yPos + HEIGHT * 0.5;
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var hero_x_t:int = int(hero_mid_x / Utils.TILE_WIDTH);
         var hero_y_t:int = int(hero_mid_y / Utils.TILE_HEIGHT);
         var x_t:int = int((xPos + 4) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + 4) / Utils.TILE_HEIGHT);
         if(Math.abs(mid_y - hero_mid_y) < Utils.TILE_HEIGHT * 1.5)
         {
            if(DIRECTION == RIGHT)
            {
               if(hero_mid_x > mid_x)
               {
                  if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * 5)
                  {
                     diff_t = hero_x_t - x_t;
                     for(i = 0; i < diff_t; i++)
                     {
                        if(level.levelData.getTileValueAt(x_t + i,y_t) != 0)
                        {
                           return false;
                        }
                     }
                     return true;
                  }
               }
            }
            else if(hero_mid_x < mid_x)
            {
               if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * 5)
               {
                  diff_t = x_t - hero_mid_x;
                  for(i = 0; i < diff_t; i++)
                  {
                     if(level.levelData.getTileValueAt(x_t - i,y_t) != 0)
                     {
                        return false;
                     }
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      protected function isSeeingHero(hor_range:Number, ver_range:Number) : Boolean
      {
         var xDiff:Number = Math.abs(getMidXPos() - level.hero.getMidXPos());
         var yDiff:Number = Math.abs(getMidYPos() - level.hero.getMidYPos());
         if(xDiff > hor_range || ver_range > 40)
         {
            return false;
         }
         if(DIRECTION == Entity.LEFT)
         {
            if(level.hero.getMidXPos() < getMidXPos())
            {
               return true;
            }
         }
         else if(level.hero.getMidXPos() > getMidXPos())
         {
            return true;
         }
         return false;
      }
      
      protected function getDistanceFromHero() : Number
      {
         var diff_x:Number = level.hero.getMidXPos() - getMidXPos();
         var diff_y:Number = level.hero.getMidYPos() - getMidYPos();
         return Math.sqrt(diff_x * diff_x + diff_y * diff_y);
      }
      
      protected function isFacingHero() : Boolean
      {
         if(getMidXPos() > level.hero.getMidXPos())
         {
            if(DIRECTION == Entity.LEFT)
            {
               return true;
            }
         }
         else if(DIRECTION == Entity.RIGHT)
         {
            return true;
         }
         return false;
      }
      
      public function isDead() : Boolean
      {
         return dead;
      }
      
      public function reset() : void
      {
         xPos = originalXPos;
         yPos = originalYPos;
         xVel = yVel = 0;
         DIRECTION = this.ORIGINAL_DIRECTION;
         this.energy = 1;
      }
      
      protected function fetchNumberScript() : void
      {
         var i:int = 0;
         for(i = 0; i < level.scriptsManager.levelNumberAreas.length; i++)
         {
            if(level.scriptsManager.levelNumberAreas[i] != null)
            {
               if(getAABB().contains(level.scriptsManager.levelNumberAreas[i].x,level.scriptsManager.levelNumberAreas[i].y))
               {
                  this.number_index = level.scriptsManager.levelNumberAreas[i].width;
               }
            }
         }
      }
      
      protected function _isFacingHero(hero_facing_enemy_too:Boolean) : Boolean
      {
         var mid_x:Number = getMidXPos();
         var hero_mid_x:Number = level.hero.getMidXPos();
         if(hero_mid_x >= mid_x)
         {
            if(DIRECTION == Entity.RIGHT)
            {
               if(hero_facing_enemy_too)
               {
                  if(level.hero.DIRECTION == Entity.LEFT)
                  {
                     return true;
                  }
                  return false;
               }
               return true;
            }
            return false;
         }
         if(DIRECTION == Entity.LEFT)
         {
            if(hero_facing_enemy_too)
            {
               if(level.hero.DIRECTION == Entity.RIGHT)
               {
                  return true;
               }
               return false;
            }
            return true;
         }
         return false;
      }
   }
}
