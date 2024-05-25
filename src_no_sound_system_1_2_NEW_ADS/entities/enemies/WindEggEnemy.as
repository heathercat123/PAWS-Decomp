package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.WindEggEnemySprite;
   
   public class WindEggEnemy extends Enemy
   {
       
      
      protected var slide_y_pos:Number;
      
      protected var bounce_amount:int;
      
      protected var last_attack_counter:int;
      
      protected var IS_HERO_COLLIDING:Boolean;
      
      protected var IS_GROUNDED:Boolean;
      
      protected var jump_amount:int;
      
      protected var TYPE:int;
      
      public function WindEggEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 24;
         HEIGHT = 23;
         speed = 0.8;
         this.last_attack_counter = this.jump_amount = 0;
         MAX_Y_VEL = 0.5;
         this.IS_HERO_COLLIDING = false;
         this.IS_GROUNDED = false;
         sprite = new WindEggEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 22;
         aabbPhysics.height = 23;
         aabb.x = 1;
         aabb.y = 0;
         aabb.width = 22;
         aabb.height = 23;
         ground_friction_time = 0.5;
         ground_friction = 1;
         this.slide_y_pos = 0;
         this.bounce_amount = 0;
         fixed_t_hurt_diff_x = 32;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","ATTACK_ACTION","IS_BLOWING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","ATTACK_ACTION","IS_BLOWING_STATE");
         stateMachine.setRule("IS_BLOWING_STATE","END_ACTION","IS_RESTING_STATE");
         stateMachine.setRule("IS_RESTING_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","GROUND_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_RESTING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_BLOWING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_RESTING_STATE",this.restingAnimation);
         stateMachine.setFunctionToState("IS_BLOWING_STATE",this.blowingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 2;
      }
      
      override public function reset() : void
      {
         super.reset();
         energy = 2;
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         x_friction = 1;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            --this.last_attack_counter;
            if(counter1++ > 20)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            else if(isSeeingHero(80,40) && this.last_attack_counter <= 0)
            {
               stateMachine.performAction("ATTACK_ACTION");
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            --this.last_attack_counter;
            if(sprite.gfxHandle().gfxHandleClip().currentFrame % 2 == 1)
            {
               if(DIRECTION == LEFT)
               {
                  xVel = -1;
               }
               else
               {
                  xVel = 1;
               }
            }
            else
            {
               xVel = 0;
            }
            if(DIRECTION == LEFT && xPos < path_start_x && path_start_x > 0)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            else if(DIRECTION == RIGHT && xPos + WIDTH > path_end_x && path_start_x > 0)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            else if(isSeeingHero(80,40) && this.last_attack_counter <= 0)
            {
               stateMachine.performAction("ATTACK_ACTION");
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
            yVel += 0.5;
         }
         else if(stateMachine.currentState == "IS_RESTING_STATE")
         {
            if(counter1++ > 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_BLOWING_STATE")
         {
            SoundSystem.PlaySound("blow");
            ++counter1;
            if(counter1 > 0)
            {
               counter1 = -3;
               if(DIRECTION == Entity.LEFT)
               {
                  level.particlesManager.airParticles(xPos,yPos + 14 + (Math.random() * 4 - 2),WIDTH,DIRECTION);
               }
               else
               {
                  level.particlesManager.airParticles(xPos + WIDTH,yPos + 14 + (Math.random() * 4 - 2),WIDTH,DIRECTION);
               }
            }
            ++counter2;
            if(counter2 >= 60)
            {
               stateMachine.performAction("END_ACTION");
               if(this.IS_HERO_COLLIDING)
               {
                  level.hero.stateMachine.performAction("ZERO_X_VEL_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            yVel += 0.25;
            this.IS_GROUNDED = false;
         }
         MAX_X_VEL = 1;
         xVel *= x_friction;
         if(xVel > MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel < -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function groundCollision() : void
      {
         yVel = 0;
         if(!this.IS_GROUNDED)
         {
            if(stateMachine.currentState == "IS_JUMPING_STATE")
            {
               ++this.jump_amount;
               if(this.jump_amount <= 2)
               {
                  yVel = -4;
                  SoundSystem.PlaySound("enemy_jump_low");
               }
               else
               {
                  stateMachine.performAction("GROUND_ACTION");
               }
            }
         }
         this.IS_GROUNDED = true;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         var hero_mid_x:Number = NaN;
         var hero_mid_y:Number = NaN;
         var this_mid_x:Number = NaN;
         var this_mid_y:Number = NaN;
         super.checkHeroCollisionDetection(hero);
         if(stateMachine.currentState == "IS_BLOWING_STATE")
         {
            hero_mid_x = level.hero.getMidXPos();
            hero_mid_y = level.hero.getMidYPos();
            this_mid_x = getMidXPos();
            this_mid_y = getMidYPos();
            if(Math.abs(hero_mid_y - this_mid_y) < 40 && Math.abs(hero_mid_x - this_mid_x) < 128)
            {
               if(DIRECTION == Entity.LEFT)
               {
                  if(hero_mid_x < this_mid_x)
                  {
                     this.IS_HERO_COLLIDING = true;
                     level.hero.xForce = -1;
                     if(level.hero.DIRECTION == Entity.RIGHT && level.rightPressed)
                     {
                        level.hero.xVel *= 0.2;
                     }
                  }
               }
               else if(DIRECTION == Entity.RIGHT)
               {
                  if(hero_mid_x > this_mid_x)
                  {
                     this.IS_HERO_COLLIDING = true;
                     level.hero.xForce = 1;
                     if(level.hero.DIRECTION == Entity.LEFT && level.leftPressed)
                     {
                        level.hero.xVel *= 0.2;
                     }
                  }
               }
            }
            else
            {
               this.IS_HERO_COLLIDING = false;
            }
         }
      }
      
      override protected function specialAttackCondition() : Boolean
      {
         if(level.hero.stateMachine.currentState == "IS_FALLING_STATE" && level.hero.stateMachine.lastState == "IS_FALLING_RUNNING_STATE" && stateMachine.currentState == "IS_BLOWING_STATE")
         {
            return true;
         }
         return false;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
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
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         level.camera.shake(6);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function restingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function blowingAnimation() : void
      {
         this.last_attack_counter = 120;
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         this.jump_amount = 0;
         xVel = yVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = 0;
         yVel = -4;
         SoundSystem.PlaySound("enemy_jump_low");
         this.IS_GROUNDED = false;
      }
      
      override protected function removeGroundFriction() : void
      {
         ground_friction = 1;
         ground_friction_tick = ground_friction_time;
      }
      
      override public function isInsideScreen() : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos - 8,level.camera.yPos - 8,level.camera.WIDTH + 16,level.camera.HEIGHT + 16);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      override protected function isOnHeroPlatform() : Boolean
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
         if(Math.abs(mid_y - hero_mid_y) < Utils.TILE_HEIGHT * 2)
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
   }
}
