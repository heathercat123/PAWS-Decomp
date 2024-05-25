package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.GenericBulletSprite;
   import sprites.enemies.WindEggEnemySprite;
   
   public class SandHippoEnemy extends Enemy
   {
       
      
      protected var pixels_walked:int;
      
      protected var shoot_counter:int;
      
      protected var isBulletLeft:Boolean;
      
      public function SandHippoEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         if(DIRECTION == Entity.RIGHT)
         {
            this.isBulletLeft = false;
         }
         else
         {
            this.isBulletLeft = true;
         }
         WIDTH = 16;
         HEIGHT = 14;
         speed = 0.8;
         this.pixels_walked = 0;
         this.shoot_counter = 30;
         MAX_Y_VEL = 0.5;
         sprite = new WindEggEnemySprite(2);
         Utils.world.addChild(sprite);
         oldXPos = xPos;
         aabbPhysics.x = 0 + 0;
         aabbPhysics.y = 3 + 0;
         aabbPhysics.width = 16 + 6;
         aabbPhysics.height = 10 - 4 + 6;
         aabb.x = 1 + -1;
         aabb.y = -1 + 8;
         aabb.width = 14 + 8;
         aabb.height = 13 + 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         gravity_friction = 0;
         y_friction = 0;
         energy = 2;
      }
      
      override public function reset() : void
      {
         super.reset();
         oldXPos = originalXPos;
         energy = 2;
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            ++counter1;
            yVel += 0.8;
            if(counter1 == 90)
            {
               sprite.gfxHandle().gotoAndStop(2);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            else if(counter1 >= 120)
            {
               this.shoot_counter = 30;
               stateMachine.performAction("WALK_ACTION");
            }
            if(counter1 >= 90)
            {
               ++counter3;
               if(counter3 >= 15)
               {
                  counter3 = 0;
                  if(isInsideScreen())
                  {
                     SoundSystem.PlaySound("enemy_shoot_sticky");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            this.pixels_walked += Math.abs(xPos - oldXPos);
            oldXPos = xPos;
            speed = 3;
            yVel = 0;
            ++counter3;
            if(counter3 >= 15)
            {
               counter3 = 0;
               if(isInsideScreen())
               {
                  SoundSystem.PlaySound("enemy_shoot_sticky");
               }
            }
            ++counter1;
            if(counter1 > 10)
            {
               counter1 = 0;
               if(DIRECTION == Entity.RIGHT)
               {
                  level.particlesManager.createDust(xPos,yPos + 10 + 2,Entity.LEFT);
               }
               else
               {
                  level.particlesManager.createDust(xPos + WIDTH,yPos + 10 + 2,Entity.RIGHT);
               }
            }
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
               if(xPos + WIDTH > path_end_x)
               {
                  stateMachine.performAction("TURN_ACTION");
                  xPos = path_end_x - WIDTH;
               }
            }
            else
            {
               xVel = -speed;
               if(xPos < path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
                  xPos = path_start_x;
               }
            }
            if(this.shoot_counter++ > 60)
            {
               this.shootBullet();
               this.shoot_counter = 0;
            }
            if(this.pixels_walked >= 320)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            changeDirection();
            stateMachine.performAction("END_ACTION");
         }
         xVel *= x_friction;
         xPos += xVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function shootBullet() : void
      {
         if(this.isBulletLeft)
         {
            level.bulletsManager.pushBullet(new GenericBulletSprite(1),xPos + WIDTH * 0.5,yPos,-1.25,-(0.25 + Math.random() * 0.25),1);
         }
         else
         {
            level.bulletsManager.pushBullet(new GenericBulletSprite(1),xPos + WIDTH * 0.5,yPos,1.25,-(0.25 + Math.random() * 0.25),1);
         }
         this.isBulletLeft = !this.isBulletLeft;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_GONE_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
      
      override public function groundCollision() : void
      {
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.pixels_walked = 0;
         counter1 = counter3 = 0;
         xVel = yVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.gfxHandle().gfxHandleClip().loop = true;
         if(stateMachine.lastState == "IS_STANDING_STATE")
         {
            oldXPos = xPos;
         }
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
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
