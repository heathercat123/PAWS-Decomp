package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import entities.bullets.Bullet;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.bullets.BoneBulletSprite;
   import sprites.enemies.RaiderEnemySprite;
   
   public class RaiderEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var attack_counter:int;
      
      protected var blink_counter:int;
      
      protected var param_1:int;
      
      protected var jump_delay:int;
      
      public function RaiderEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int, _param_1:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 14;
         speed = 0.8;
         this.blink_counter = 0;
         this.jump_delay = this.param_1 = _param_1;
         MAX_Y_VEL = 2;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new RaiderEnemySprite();
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
         stateMachine.setRule("IS_STANDING_STATE","RUN_AWAY_ACTION","IS_RUNNING_AWAY_STATE");
         stateMachine.setRule("IS_STANDING_STATE","AIM_ACTION","IS_AIMING_STATE");
         stateMachine.setRule("IS_AIMING_STATE","END_ACTION","IS_TOSSING_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_READY_TO_JUMP_STATE");
         stateMachine.setRule("IS_READY_TO_JUMP_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","AIM_ACTION","IS_MID_AIR_STATE");
         stateMachine.setRule("IS_MID_AIR_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_AIMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_READY_TO_JUMP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_MID_AIR_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_RUNNING_AWAY_STATE",this.runningAwayAnimation);
         stateMachine.setFunctionToState("IS_AIMING_STATE",this.aimingAnimation);
         stateMachine.setFunctionToState("IS_TOSSING_STATE",this.tossingAnimation);
         stateMachine.setFunctionToState("IS_READY_TO_JUMP_STATE",this.readyToJumpAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_MID_AIR_STATE",this.midAirAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         this.attack_counter = 0;
         energy = 2;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_STANDING_STATE" || stateMachine.currentState == "IS_AIMING_STATE" || stateMachine.currentState == "IS_TOSSING_STATE")
         {
            return super.isTargetable();
         }
         return false;
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_STANDING_STATE" || stateMachine.currentState == "IS_AIMING_STATE" || stateMachine.currentState == "IS_TOSSING_STATE")
         {
            super.bulletImpact(bullet);
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_STANDING_STATE");
         this.jump_delay = this.param_1;
         energy = 2;
      }
      
      override public function update() : void
      {
         super.update();
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var this_mid_x:Number = xPos + WIDTH * 0.5;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index == 0)
            {
               if(counter2++ > 90 || Math.abs(getMidXPos() - level.hero.getMidXPos()) < 32)
               {
                  stateMachine.performAction("RUN_AWAY_ACTION");
               }
            }
            else if(ai_index == 1)
            {
               if(this.walk_counter-- < 0)
               {
                  this.walk_counter = int(Math.random() * 2 + 3) * 60;
                  if(path_start_x != 0)
                  {
                     if(DIRECTION == LEFT)
                     {
                        if(xPos <= path_start_x)
                        {
                           stateMachine.performAction("TURN_ACTION");
                           this.walk_counter = -1;
                        }
                        else
                        {
                           stateMachine.performAction("WALK_ACTION");
                        }
                     }
                     else if(xPos + WIDTH >= path_end_x)
                     {
                        stateMachine.performAction("TURN_ACTION");
                        this.walk_counter = -1;
                     }
                     else
                     {
                        stateMachine.performAction("WALK_ACTION");
                     }
                  }
                  else
                  {
                     stateMachine.performAction("WALK_ACTION");
                  }
               }
               else if(this.attack_counter-- < 0)
               {
                  if(this.isHeroAboveSand())
                  {
                     if(DIRECTION == LEFT && hero_mid_x < this_mid_x || DIRECTION == RIGHT && hero_mid_x > this_mid_x)
                     {
                        if(Math.abs(hero_mid_x - this_mid_x) <= 112 && Math.abs(hero_mid_x - this_mid_x) > 24)
                        {
                           stateMachine.performAction("AIM_ACTION");
                        }
                     }
                  }
               }
            }
            else
            {
               if(this.jump_delay++ > 90)
               {
                  this.jump_delay = 0;
                  stateMachine.performAction("JUMP_ACTION");
               }
               if(DIRECTION == Entity.LEFT)
               {
                  if(level.hero.getMidXPos() > getMidXPos() + 8)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
               else if(level.hero.getMidXPos() < getMidXPos() - 8)
               {
                  stateMachine.performAction("TURN_ACTION");
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
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            speed = 1;
            yVel += 0.8;
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 3 + 1) * 30;
               stateMachine.performAction("END_ACTION");
            }
            else if(DIRECTION == RIGHT)
            {
               xVel = speed;
               if(xPos + WIDTH > path_end_x)
               {
                  this.walk_counter = int(Math.random() * 1 + 2) * 60;
                  stateMachine.performAction("END_ACTION");
                  xPos = path_end_x - WIDTH;
               }
            }
            else
            {
               xVel = -speed;
               if(xPos < path_start_x)
               {
                  this.walk_counter = int(Math.random() * 1 + 2) * 60;
                  stateMachine.performAction("END_ACTION");
                  xPos = path_start_x;
               }
            }
            if(Math.abs(xVel) > 0.25)
            {
               ++counter1;
               if(counter2++ > 4 && counter1 < 30)
               {
                  counter2 = 0;
                  level.particlesManager.groundSmokeParticles(this);
               }
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
         else if(stateMachine.currentState == "IS_READY_TO_JUMP_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(yVel > 0)
            {
               stateMachine.performAction("AIM_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_MID_AIR_STATE")
         {
            yVel = 0;
            if(counter1++ > 20)
            {
               stateMachine.performAction("END_ACTION");
               if(DIRECTION == Entity.LEFT)
               {
                  level.bulletsManager.pushBullet(new BoneBulletSprite(),xPos + WIDTH * 0.5,yPos,-2,1,1);
               }
               else
               {
                  level.bulletsManager.pushBullet(new BoneBulletSprite(),xPos + WIDTH * 0.5,yPos,2,1,1);
               }
            }
         }
         else if(stateMachine.currentState != "IS_FALLING_STATE")
         {
            if(stateMachine.currentState == "IS_RUNNING_AWAY_STATE")
            {
               if(counter1 == 0)
               {
                  if(sprite.gfxHandle().gfxHandleClip().isComplete)
                  {
                     sprite.gfxHandle().gotoAndStop(8);
                     sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                     SoundSystem.PlaySound("enemy_jump");
                     xVel = 4;
                     yVel = -2.5;
                     counter1 = 1;
                     gravity_friction = 0.2;
                  }
               }
               else if(counter1 == 1)
               {
                  if(xPos > level.camera.xPos + level.camera.WIDTH)
                  {
                     dead = true;
                  }
               }
            }
         }
         integratePositionAndCollisionDetection();
      }
      
      protected function isHeroAboveSand() : Boolean
      {
         if(Utils.SAND_LEVEL <= 0)
         {
            return true;
         }
         if(level.hero.yPos > Utils.SAND_LEVEL)
         {
            return false;
         }
         return true;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(getTileAhead(1,-1,true) == 0)
         {
            yVel = -4;
         }
      }
      
      override public function groundCollision() : void
      {
         stateMachine.performAction("GROUND_COLLISION_ACTION");
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = (Math.round(Math.random() * 1) + 1) * 60;
         counter2 = 0;
         xVel = yVel = 0;
         gravity_friction = 1;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.gfxHandle().gfxHandleClip().loop = true;
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
      
      public function runningAwayAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = 0;
      }
      
      public function aimingAnimation() : void
      {
         this.attack_counter = int(int(Math.random() * 2) + 1) * 60;
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
         var _xVel:Number = Math.abs(diff_x * 3);
         _xVel = 2;
         if(DIRECTION == LEFT)
         {
            _xVel *= -1;
         }
         SoundSystem.PlaySound("throw");
         level.bulletsManager.pushBullet(new BoneBulletSprite(),xPos + WIDTH * 0.5,yPos,_xVel,0,1);
      }
      
      public function readyToJumpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         counter1 = 0;
      }
      
      public function jumpingAnimation() : void
      {
         if(isInsideInnerScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         yVel = -3;
         counter1 = 0;
         gravity_friction = 0.2;
      }
      
      public function midAirAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         gravity_friction = 0;
         counter1 = 0;
      }
      
      public function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         gravity_friction = 1;
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
