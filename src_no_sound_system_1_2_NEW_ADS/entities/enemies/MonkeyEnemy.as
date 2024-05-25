package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import entities.bullets.Bullet;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.collisions.RopeAreaCollision;
   import sprites.bullets.BaseballBulletSprite;
   import sprites.enemies.*;
   
   public class MonkeyEnemy extends Enemy
   {
       
      
      public var IS_ATTACKING:Boolean;
      
      protected var MOVE_ASAP:Boolean;
      
      protected var GO_UP:Boolean;
      
      protected var IS_ON_ROPE:Boolean;
      
      protected var attack_counter:int;
      
      protected var blink_counter:int;
      
      protected var hero_targeted:int;
      
      protected var walk_counter:int;
      
      protected var param_1:int;
      
      protected var rope:RopeAreaCollision;
      
      protected var time_alive:int;
      
      public function MonkeyEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int, _param_1:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         this.time_alive = 0;
         WIDTH = 16;
         HEIGHT = 14;
         speed = 0.8;
         this.blink_counter = 0;
         this.hero_targeted = 0;
         this.param_1 = _param_1;
         if(this.param_1 < 1)
         {
            this.param_1 = 32;
         }
         this.walk_counter = 0;
         this.GO_UP = true;
         this.IS_ON_ROPE = false;
         MAX_Y_VEL = 0.5;
         sprite = new MonkeyEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_LAUGHING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_LAUGHING_STATE");
         stateMachine.setRule("IS_LAUGHING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","END_ACTION","IS_LAUGHING_STATE");
         stateMachine.setRule("IS_LAUGHING_STATE","END_ACTION","IS_STANDING_LAUGHING_STATE");
         stateMachine.setRule("IS_STANDING_LAUGHING_STATE","END_ACTION","IS_LAUGHING_STATE");
         stateMachine.setRule("IS_LAUGHING_STATE","SURPRISED_ACTION","IS_SURPRISED_STATE");
         stateMachine.setRule("IS_STANDING_LAUGHING_STATE","SURPRISED_ACTION","IS_SURPRISED_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SURPRISED_ACTION","IS_SURPRISED_STATE");
         stateMachine.setRule("IS_AIMING_STATE","SURPRISED_ACTION","IS_SURPRISED_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","SURPRISED_ACTION","IS_SURPRISED_STATE");
         stateMachine.setRule("IS_SURPRISED_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","END_ACTION","IS_GONE_STATE");
         stateMachine.setRule("IS_LAUGHING_STATE","AIM_ACTION","IS_AIMING_STATE");
         stateMachine.setRule("IS_AIMING_STATE","END_ACTION","IS_TOSSING_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","END_ACTION","IS_LAUGHING_STATE");
         stateMachine.setRule("IS_ROPE_STANDING_STATE","WALK_ACTION","IS_ROPE_MOVING_STATE");
         stateMachine.setRule("IS_ROPE_MOVING_STATE","END_ACTION","IS_ROPE_STANDING_STATE");
         stateMachine.setRule("IS_ROPE_STANDING_STATE","TURN_ACTION","IS_ROPE_TURNING_STATE");
         stateMachine.setRule("IS_ROPE_TURNING_STATE","END_ACTION","IS_ROPE_STANDING_STATE");
         stateMachine.setRule("IS_ROPE_MOVING_STATE","AIM_ACTION","IS_ROPE_AIMING_STATE");
         stateMachine.setRule("IS_ROPE_STANDING_STATE","AIM_ACTION","IS_ROPE_AIMING_STATE");
         stateMachine.setRule("IS_ROPE_AIMING_STATE","END_ACTION","IS_ROPE_TOSSING_STATE");
         stateMachine.setRule("IS_ROPE_TOSSING_STATE","END_ACTION","IS_ROPE_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_LAUGHING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STANDING_LAUGHING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SURPRISED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_AIMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ROPE_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ROPE_MOVING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ROPE_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ROPE_AIMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ROPE_TOSSING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_LAUGHING_STATE",this.laughingAnimation);
         stateMachine.setFunctionToState("IS_STANDING_LAUGHING_STATE",this.standingLaughingAnimation);
         stateMachine.setFunctionToState("IS_SURPRISED_STATE",this.surprisedAnimation);
         stateMachine.setFunctionToState("IS_RUNNING_STATE",this.runningAnimation);
         stateMachine.setFunctionToState("IS_AIMING_STATE",this.aimingAnimation);
         stateMachine.setFunctionToState("IS_TOSSING_STATE",this.tossingAnimation);
         stateMachine.setFunctionToState("IS_GONE_STATE",this.goneAnimation);
         stateMachine.setFunctionToState("IS_ROPE_STANDING_STATE",this.ropeStandingAnimation);
         stateMachine.setFunctionToState("IS_ROPE_MOVING_STATE",this.ropeMovingAnimation);
         stateMachine.setFunctionToState("IS_ROPE_TURNING_STATE",this.ropeTurningAnimation);
         stateMachine.setFunctionToState("IS_ROPE_AIMING_STATE",this.ropeAimingAnimation);
         stateMachine.setFunctionToState("IS_ROPE_TOSSING_STATE",this.ropeTossingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_LAUGHING_STATE");
         if(ai_index == 1 || ai_index == 2)
         {
            this.IS_ATTACKING = true;
         }
         else
         {
            this.IS_ATTACKING = false;
         }
         if(ai_index == 2)
         {
            stateMachine.setState("IS_ROPE_STANDING_STATE");
            this.IS_ON_ROPE = true;
         }
         this.MOVE_ASAP = false;
         this.attack_counter = 0;
         energy = 2;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_LAUGHING_STATE" || stateMachine.currentState == "IS_STANDING_LAUGHING_STATE" || stateMachine.currentState == "IS_SURPRISED_STATE" || stateMachine.currentState == "IS_RUNNING_STATE" || stateMachine.currentState == "IS_AIMING_STATE" || stateMachine.currentState == "IS_TOSSING_STATE")
         {
            return super.isTargetable();
         }
         return false;
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_LAUGHING_STATE" || stateMachine.currentState == "IS_STANDING_LAUGHING_STATE" || stateMachine.currentState == "IS_SURPRISED_STATE" || stateMachine.currentState == "IS_RUNNING_STATE" || stateMachine.currentState == "IS_AIMING_STATE" || stateMachine.currentState == "IS_TOSSING_STATE")
         {
            super.bulletImpact(bullet);
         }
      }
      
      override public function postInit() : void
      {
         var i:int = 0;
         var this_area:Rectangle = null;
         var rope_area:Rectangle = null;
         super.postInit();
         if(ai_index == 2)
         {
            this_area = new Rectangle(xPos,yPos,WIDTH,HEIGHT);
            rope_area = new Rectangle(xPos,yPos,WIDTH,HEIGHT);
            for(i = 0; i < level.collisionsManager.collisions.length; i++)
            {
               if(level.collisionsManager.collisions[i] != null)
               {
                  if(level.collisionsManager.collisions[i] is RopeAreaCollision)
                  {
                     rope_area.x = level.collisionsManager.collisions[i].xPos;
                     rope_area.y = level.collisionsManager.collisions[i].yPos;
                     rope_area.width = level.collisionsManager.collisions[i].WIDTH;
                     rope_area.height = level.collisionsManager.collisions[i].HEIGHT;
                     if(this_area.intersects(rope_area))
                     {
                        this.rope = level.collisionsManager.collisions[i];
                     }
                  }
               }
            }
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(ai_index == 2)
         {
            stateMachine.setState("IS_ROPE_STANDING_STATE");
         }
         else
         {
            stateMachine.setState("IS_LAUGHING_STATE");
         }
         energy = 2;
      }
      
      override public function update() : void
      {
         super.update();
         --this.hero_targeted;
         ++this.time_alive;
         if(this.hero_targeted <= 0)
         {
            this.hero_targeted = -1;
         }
         --this.walk_counter;
         if(this.walk_counter <= 0)
         {
            this.walk_counter = 0;
         }
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var this_mid_x:Number = xPos + WIDTH * 0.5;
         if(this.IS_ON_ROPE)
         {
            if(this.rope == null)
            {
               this.postInit();
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            speed = 2;
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
         else if(stateMachine.currentState == "IS_GONE_STATE")
         {
            sprite.visible = false;
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_ROPE_TURNING_STATE")
         {
            if(stateMachine.currentState == "IS_ROPE_TURNING_STATE")
            {
               if(this.rope != null)
               {
                  xPos = this.rope.xPos;
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_LAUGHING_STATE")
         {
            if(this.MOVE_ASAP)
            {
               this.MOVE_ASAP = false;
               stateMachine.performAction("WALK_ACTION");
            }
            else
            {
               if(counter1-- < 0)
               {
                  stateMachine.performAction("END_ACTION");
               }
               if(this.IS_ATTACKING)
               {
                  if(this.hero_targeted > 0)
                  {
                     if(DIRECTION == LEFT && hero_mid_x > this_mid_x + Utils.TILE_WIDTH || DIRECTION == RIGHT && hero_mid_x < this_mid_x - Utils.TILE_WIDTH)
                     {
                        this.MOVE_ASAP = true;
                        stateMachine.performAction("TURN_ACTION");
                     }
                     else
                     {
                        this.checkAttack();
                     }
                  }
                  else if(this.walk_counter <= 0)
                  {
                     this.MOVE_ASAP = true;
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else
                  {
                     this.checkAttack();
                  }
               }
               else if(Math.abs(hero_mid_x - this_mid_x) < this.param_1 && this.time_alive > 10)
               {
                  if(Utils.CurrentLevel != 252)
                  {
                     stateMachine.performAction("SURPRISED_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_STANDING_LAUGHING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(!this.IS_ATTACKING)
            {
               if(Math.abs(hero_mid_x - this_mid_x) < Utils.TILE_WIDTH || energy < 2)
               {
                  if(this.time_alive > 10)
                  {
                     if(Utils.CurrentLevel != 252)
                     {
                        stateMachine.performAction("SURPRISED_ACTION");
                     }
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_SURPRISED_STATE")
         {
            if(counter1++ >= 25)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_RUNNING_STATE")
         {
            speed = 6;
            yVel += 0.8;
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
            }
            else
            {
               xVel = -speed;
            }
            if(Math.abs(xVel) > 0.25)
            {
               ++counter1;
               if(counter2++ > 2)
               {
                  counter2 = 0;
                  level.particlesManager.groundSmokeParticles(this);
               }
            }
            if(xPos + WIDTH < level.camera.xPos || xPos > level.camera.xPos + level.camera.WIDTH)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_AIMING_STATE")
         {
            ++counter1;
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
         else if(stateMachine.currentState == "IS_ROPE_AIMING_STATE" || stateMachine.currentState == "IS_ROPE_TOSSING_STATE")
         {
            ++counter1;
            this.updateRopePosition();
            if(counter1 >= 16)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_ROPE_STANDING_STATE")
         {
            if(counter1++ > 60)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            else
            {
               this.updateRopePosition();
               this.updateDirection();
               this.checkAttack();
            }
         }
         else if(stateMachine.currentState == "IS_ROPE_MOVING_STATE")
         {
            if(this.GO_UP)
            {
               if(counter1++ > 0)
               {
                  counter1 = 0;
                  --yPos;
                  if(this.rope != null)
                  {
                     if(yPos < this.rope.yPos + 16)
                     {
                        yPos = this.rope.yPos + 16;
                        stateMachine.performAction("END_ACTION");
                     }
                  }
               }
            }
            else
            {
               ++yPos;
               if(this.rope != null)
               {
                  if(yPos > this.rope.yPos + this.rope.HEIGHT - 16)
                  {
                     yPos = this.rope.yPos + this.rope.HEIGHT - 16;
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            this.updateRopePosition();
            this.checkAttack();
         }
         if(this.IS_ATTACKING)
         {
            if(Math.abs(this_mid_x - hero_mid_x) < 144 && level.hero.yPos < yPos - 8 || energy < 2)
            {
               if(Utils.CurrentLevel != 252)
               {
                  stateMachine.performAction("SURPRISED_ACTION");
               }
            }
         }
         xVel *= x_friction;
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function updateDirection() : void
      {
         var hero_mid_x:Number = level.hero.getMidXPos();
         var this_mid_x:Number = getMidXPos();
         if(Math.abs(hero_mid_x - this_mid_x) < 128)
         {
            if(Math.abs(hero_mid_x - this_mid_x) > 24)
            {
               if(DIRECTION == Entity.LEFT)
               {
                  if(hero_mid_x > this_mid_x)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
               else if(hero_mid_x < this_mid_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
         }
      }
      
      protected function checkAttack() : void
      {
         if(this.attack_counter-- >= 0)
         {
            return;
         }
         if(!isInsideInnerScreen(16))
         {
            return;
         }
         var hero_mid_x:Number = level.hero.getMidXPos();
         var this_mid_x:Number = getMidXPos();
         var max_amount:Number = 160;
         var min_amount:Number = 24;
         if(this.IS_ON_ROPE)
         {
            max_amount = 128;
         }
         if(this.IS_ON_ROPE)
         {
            if(level.hero.yPos < yPos + 16)
            {
               return;
            }
         }
         if(DIRECTION == LEFT && hero_mid_x < this_mid_x || DIRECTION == RIGHT && hero_mid_x > this_mid_x)
         {
            if(Math.abs(hero_mid_x - this_mid_x) < max_amount && Math.abs(hero_mid_x - this_mid_x) > min_amount)
            {
               stateMachine.performAction("AIM_ACTION");
               this.hero_targeted = 180;
            }
         }
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_GONE_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         yVel = -4;
      }
      
      override public function groundCollision() : void
      {
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = (Math.round(Math.random() * 1) + 1) * 60;
         xVel = yVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         this.walk_counter = 60;
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
      
      public function laughingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.visible = true;
         counter1 = (Math.round(Math.random() * 1) + 1) * 60;
         xVel = 0;
      }
      
      public function standingLaughingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.gfxHandle().gfxHandleClip().loop = false;
         xVel = yVel = 0;
      }
      
      public function surprisedAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         setEmotionParticle(Entity.EMOTION_SHOCKED);
         xVel = 0;
         counter1 = 0;
      }
      
      public function runningAnimation() : void
      {
         SoundSystem.PlaySound("enemy_run");
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         var camera_mid_x:Number = level.camera.xPos + level.camera.WIDTH * 0.5;
         var this_mid_x:Number = xPos + WIDTH * 0.5;
         if(level.hero.getMidXPos() < this_mid_x)
         {
            DIRECTION = RIGHT;
         }
         else
         {
            DIRECTION = LEFT;
         }
      }
      
      public function aimingAnimation() : void
      {
         this.attack_counter = int(int(Math.random() * 2) + 1) * 60;
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
      }
      
      public function tossingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(9);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
         this.tossBullet();
      }
      
      protected function tossBullet() : void
      {
         var enemy_xPos:Number = xPos + WIDTH * 0.5;
         var hero_xPos:Number = level.hero.xPos + level.hero.WIDTH * 0.5 + level.hero.xVel * 4;
         var diff_x:Number = hero_xPos - enemy_xPos;
         var diff_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - (yPos + HEIGHT * 0.5);
         var dist:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         diff_x /= dist;
         diff_y /= dist;
         var _xVel:Number = Math.abs(diff_x * 3);
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
         SoundSystem.PlaySound("throw");
         level.bulletsManager.pushBullet(new BaseballBulletSprite(),xPos + WIDTH * 0.5,yPos,_xVel,0,1,1);
      }
      
      public function goneAnimation() : void
      {
         sprite.visible = false;
         xVel = yVel = 0;
      }
      
      public function ropeStandingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(10);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.updateRopePosition();
         xVel = yVel = 0;
         counter1 = counter2 = 0;
      }
      
      protected function updateRopePosition() : void
      {
         if(this.rope != null)
         {
            if(DIRECTION == Entity.LEFT)
            {
               xPos = this.rope.xPos + 6;
            }
            else
            {
               xPos = this.rope.xPos - 6;
            }
         }
      }
      
      public function ropeMovingAnimation() : void
      {
         if(this.rope != null)
         {
            if(Math.abs(getMidYPos() - this.rope.yPos) < Math.abs(getMidYPos() - (this.rope.yPos + this.rope.HEIGHT)))
            {
               this.GO_UP = false;
            }
            else
            {
               this.GO_UP = true;
            }
         }
         sprite.gfxHandle().gotoAndStop(10);
         if(this.GO_UP)
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         else
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         }
         counter1 = counter2 = 0;
      }
      
      protected function ropeTurningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(12);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         if(this.rope == null)
         {
            xPos = this.rope.xPos;
         }
      }
      
      protected function ropeAimingAnimation() : void
      {
         this.attack_counter = int(int(Math.random() * 2) + 1) * 60;
         sprite.gfxHandle().gotoAndStop(11);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      protected function ropeTossingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(11);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         this.tossBullet();
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
