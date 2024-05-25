package entities.enemies
{
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.EggBulletSprite;
   import sprites.enemies.CrowEnemySprite;
   import sprites.particles.WhitePointParticleSprite;
   
   public class CrowEnemy extends Enemy
   {
       
      
      protected var param_2:Number;
      
      protected var fly_sin_counter:Number;
      
      protected var last_point_x:Number;
      
      protected var last_point_y:Number;
      
      protected var shooting_counter:int;
      
      public function CrowEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _param_2:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         gravity_friction = 0;
         this.fly_sin_counter = Math.random() * Math.PI * 2;
         this.last_point_x = xPos;
         this.last_point_y = yPos;
         this.shooting_counter = this.param_2 = _param_2;
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         sprite = new CrowEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = 1 + 1;
         aabb.y = -1 + 1;
         aabb.width = 14 - 2;
         aabb.height = 13 - 2;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","FLY_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","SHOOT_ACTION","IS_SHOOTING_STATE");
         stateMachine.setRule("IS_SHOOTING_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FLYING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SHOOTING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         stateMachine.setFunctionToState("IS_SHOOTING_STATE",this.shootingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_FLYING_STATE");
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
         this.shooting_counter = this.param_2;
         stateMachine.setState("IS_FLYING_STATE");
      }
      
      override public function update() : void
      {
         var point_diff_x:Number = NaN;
         var point_diff_y:Number = NaN;
         var point_dist:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            this.boundariesCheck();
            stateMachine.performAction("FLY_ACTION");
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
            this.updateFlyWave();
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            this.boundariesCheck();
            if(DIRECTION == LEFT)
            {
               xVel = -0.8;
            }
            else
            {
               xVel = 0.8;
            }
            this.updateFlyWave();
            point_diff_x = this.last_point_x - xPos;
            point_diff_y = this.last_point_y - yPos;
            point_dist = Math.sqrt(point_diff_x * point_diff_x + point_diff_y * point_diff_y);
            if(point_dist >= 24)
            {
               this.last_point_x = xPos;
               this.last_point_y = yPos;
               level.particlesManager.pushBackParticle(new WhitePointParticleSprite(),getMidXPos(),getMidYPos(),0,0,0);
            }
            if(this.shooting_counter-- < 0)
            {
               this.shooting_counter = 180;
               if(isInsideScreen())
               {
                  stateMachine.performAction("SHOOT_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_SHOOTING_STATE")
         {
            xVel *= 0.95;
            ++counter1;
            if(counter1 > 40)
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(counter1 == 10)
            {
               level.bulletsManager.pushBackBullet(new EggBulletSprite(),getMidXPos(),getMidYPos(),0,0,1);
            }
            this.updateFlyWave();
         }
         integratePositionAndCollisionDetection();
      }
      
      protected function updateFlyWave() : void
      {
         this.fly_sin_counter += 0.1;
         if(this.fly_sin_counter > Math.PI * 2)
         {
            this.fly_sin_counter -= Math.PI * 2;
         }
         yPos = originalYPos + Math.sin(this.fly_sin_counter) * 4;
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
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override public function groundCollision() : void
      {
         stateMachine.performAction("GROUND_COLLISION_ACTION");
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         var x_t:int = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function flyingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function shootingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function isInsideInnerScreen(offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
