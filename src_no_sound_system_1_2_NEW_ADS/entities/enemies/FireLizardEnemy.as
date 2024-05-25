package entities.enemies
{
   import entities.Hero;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.bullets.FireballBulletSprite;
   import sprites.enemies.FireLizardEnemySprite;
   
   public class FireLizardEnemy extends Enemy
   {
       
      
      protected var MOVE_ASAP:Boolean;
      
      protected var HAS_SEEN_HERO:Boolean;
      
      protected var STAND_STILL_FOREVER:Boolean;
      
      protected var STAND_STILL_UNTIL_HERO_IS_SEEN:Boolean;
      
      protected var bullets_shot_counter:int;
      
      protected var attack_counter:int;
      
      public function FireLizardEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         this.bullets_shot_counter = 0;
         WIDTH = 16;
         HEIGHT = 14;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         sprite = new FireLizardEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","AIM_ACTION","IS_AIMING_STATE");
         stateMachine.setRule("IS_AIMING_STATE","END_ACTION","IS_TOSSING_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_AIMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_AIMING_STATE",this.aimingAnimation);
         stateMachine.setFunctionToState("IS_TOSSING_STATE",this.tossingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         this.MOVE_ASAP = false;
         this.attack_counter = 0;
         this.HAS_SEEN_HERO = false;
         this.STAND_STILL_FOREVER = false;
         this.STAND_STILL_UNTIL_HERO_IS_SEEN = false;
         if(path_end_x <= 0)
         {
            this.STAND_STILL_FOREVER = true;
         }
         if(ai_index == 1)
         {
            this.STAND_STILL_UNTIL_HERO_IS_SEEN = true;
         }
         energy = 2;
      }
      
      override public function reset() : void
      {
         super.reset();
         if(path_end_x <= 0)
         {
            this.STAND_STILL_FOREVER = true;
         }
         if(ai_index == 1)
         {
            this.STAND_STILL_UNTIL_HERO_IS_SEEN = true;
         }
         energy = 2;
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         super.update();
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var this_mid_x:Number = xPos + WIDTH * 0.5;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(this.MOVE_ASAP && !this.STAND_STILL_FOREVER && !this.STAND_STILL_UNTIL_HERO_IS_SEEN)
            {
               this.MOVE_ASAP = false;
               stateMachine.performAction("WALK_ACTION");
            }
            else if(this.HAS_SEEN_HERO)
            {
               if(DIRECTION == LEFT && hero_mid_x > this_mid_x || DIRECTION == RIGHT && hero_mid_x < this_mid_x || this.bullets_shot_counter >= 2)
               {
                  this.MOVE_ASAP = true;
                  if(!this.STAND_STILL_FOREVER && !this.STAND_STILL_UNTIL_HERO_IS_SEEN)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  this.HAS_SEEN_HERO = false;
               }
               else if(this.attack_counter-- < 0)
               {
                  if(DIRECTION == LEFT && hero_mid_x < this_mid_x || DIRECTION == RIGHT && hero_mid_x > this_mid_x)
                  {
                     if(Math.abs(hero_mid_x - this_mid_x) < 160 && Math.abs(hero_mid_x - this_mid_x) > 48)
                     {
                        stateMachine.performAction("AIM_ACTION");
                     }
                     else
                     {
                        this.HAS_SEEN_HERO = false;
                     }
                  }
                  else
                  {
                     this.HAS_SEEN_HERO = false;
                  }
               }
            }
            else if(counter1++ > 30 && !this.STAND_STILL_FOREVER && !this.STAND_STILL_UNTIL_HERO_IS_SEEN)
            {
               counter1 = 0;
               this.MOVE_ASAP = true;
               stateMachine.performAction("TURN_ACTION");
               this.HAS_SEEN_HERO = false;
            }
            else if(this.attack_counter-- < 0)
            {
               if(DIRECTION == LEFT && hero_mid_x < this_mid_x || DIRECTION == RIGHT && hero_mid_x > this_mid_x)
               {
                  if(Math.abs(hero_mid_x - this_mid_x) < 160 && Math.abs(hero_mid_x - this_mid_x) > 48)
                  {
                     stateMachine.performAction("AIM_ACTION");
                     this.HAS_SEEN_HERO = true;
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            speed = 1;
            yVel += 0.8;
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
               if(xPos + WIDTH > path_end_x)
               {
                  stateMachine.performAction("END_ACTION");
                  xPos = path_end_x - WIDTH;
               }
            }
            else
            {
               xVel = -speed;
               if(xPos < path_start_x)
               {
                  stateMachine.performAction("END_ACTION");
                  xPos = path_start_x;
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_AIMING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TOSSING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            yVel += 0.2;
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
         xVel *= x_friction;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_GONE_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function groundCollision() : void
      {
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.gfxHandle().gfxHandleClip().loop = true;
         this.bullets_shot_counter = 0;
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function aimingAnimation() : void
      {
         this.STAND_STILL_UNTIL_HERO_IS_SEEN = false;
         this.HAS_SEEN_HERO = true;
         this.attack_counter = 60;
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
      }
      
      public function tossingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
         var enemy_xPos:Number = xPos + WIDTH * 0.5;
         var hero_xPos:Number = level.hero.xPos + level.hero.WIDTH * 0.5 + level.hero.xVel * 4;
         var diff_x:Number = hero_xPos - enemy_xPos;
         var diff_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - (yPos + HEIGHT * 0.5);
         var dist:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         diff_x /= dist;
         diff_y /= dist;
         var _xVel:Number = Math.abs(diff_x * 2.5);
         if(_xVel < 2)
         {
            _xVel = 2;
         }
         else if(_xVel > 4)
         {
            _xVel = 4;
         }
         if(DIRECTION == LEFT)
         {
            _xVel *= -1;
         }
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("fire_dragon_shoot");
         }
         if(DIRECTION == LEFT)
         {
            level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos + WIDTH * 0.5 - 4,yPos + 2,_xVel,0,1);
         }
         else
         {
            level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos + WIDTH * 0.5 + 4,yPos + 2,_xVel,0,1);
         }
         ++this.bullets_shot_counter;
      }
      
      public function hitAnimation() : void
      {
         setHitVariables();
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
