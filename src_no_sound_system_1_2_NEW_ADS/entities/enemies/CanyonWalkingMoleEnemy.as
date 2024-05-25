package entities.enemies
{
   import entities.Hero;
   import entities.bullets.Bullet;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.CanyonWalkingMoleSprite;
   import sprites.particles.GlimpseParticleSprite;
   
   public class CanyonWalkingMoleEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      public function CanyonWalkingMoleEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         this.wait_time = 0;
         sprite = new CanyonWalkingMoleSprite();
         Utils.world.addChild(sprite);
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SCARED_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SCARED_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_SCARED_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","TURN_ACTION","IS_TURNING_RUNNING_STATE");
         stateMachine.setRule("IS_TURNING_RUNNING_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SCARED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_RUNNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_SCARED_STATE",this.scaredAnimation);
         stateMachine.setFunctionToState("IS_RUNNING_STATE",this.runningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_RUNNING_STATE",this.turnRunningAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 1;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         if(stateMachine != null)
         {
            stateMachine.destroy();
            stateMachine = null;
         }
         if(stunHandler != null)
         {
            stunHandler.destroy();
            stunHandler = null;
         }
         aabb = aabbPhysics = null;
         level = null;
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         super.bulletImpact(bullet);
         stateMachine.performAction("SCARED_ACTION");
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_MISSING_STATE" || stateMachine.currentState == "IS_HIDING_STATE" || stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            ++counter1;
            if(counter1 >= this.wait_time)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            else if(this.isOnHeroPlatform())
            {
               stateMachine.performAction("SCARED_ACTION");
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 3 + 1));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_RUNNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == RIGHT)
            {
               xVel = 0.5;
            }
            else
            {
               xVel = -0.5;
            }
            if(this.isOnHeroPlatform())
            {
               stateMachine.performAction("SCARED_ACTION");
            }
            else
            {
               this.boundariesCheck();
            }
         }
         else if(stateMachine.currentState == "IS_RUNNING_STATE")
         {
            if(DIRECTION == RIGHT)
            {
               xVel = 2.5;
            }
            else
            {
               xVel = -2.5;
            }
            if(counter2++ > 6)
            {
               counter2 = 0;
               level.particlesManager.groundSmokeParticles(this);
            }
         }
         else if(stateMachine.currentState == "IS_SCARED_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         yVel += 0.5;
         xVel *= x_friction;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function boundariesCheck() : void
      {
         if(path_start_x != 0)
         {
            if(DIRECTION == LEFT)
            {
               if(xPos <= path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(xPos + WIDTH >= path_end_x)
            {
               stateMachine.performAction("TURN_ACTION");
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
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
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         stateMachine.performAction("TURN_ACTION");
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         x_friction = 0.8;
         this.wait_time = int(Math.random() * 3 + 1) * 60;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function turnRunningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
         changeDirection();
         stateMachine.performAction("END_ACTION");
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
         this.wait_time = int(Math.random() * 2 + 2) * 60;
      }
      
      public function scaredAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         var pSprite:GlimpseParticleSprite = new GlimpseParticleSprite();
         if(DIRECTION == LEFT)
         {
            level.particlesManager.pushParticle(pSprite,xPos + 4,yPos,0,0,0);
         }
         else
         {
            pSprite.scaleX = -1;
            level.particlesManager.pushParticle(pSprite,xPos + WIDTH - 4,yPos,0,0,0);
         }
         counter1 = 0;
         xVel = 0;
      }
      
      public function runningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function missingAnimation() : void
      {
      }
   }
}
