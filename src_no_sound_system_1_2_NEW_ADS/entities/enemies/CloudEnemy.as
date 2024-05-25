package entities.enemies
{
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.CloudEnemySprite;
   import sprites.particles.ElectroParticleSprite;
   
   public class CloudEnemy extends Enemy
   {
       
      
      protected var sin_counter:Number;
      
      protected var last_particle_x_pos:Number;
      
      protected var last_particle_y_pos:Number;
      
      protected var LIMIT_X_POS:Boolean;
      
      protected var GO_DOWN:Boolean;
      
      protected var turn_counter:int;
      
      protected var attack_counter:int;
      
      public function CloudEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = HEIGHT = 16;
         speed = 0.8;
         this.last_particle_x_pos = getMidXPos();
         this.last_particle_y_pos = getMidYPos();
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         this.GO_DOWN = true;
         this.turn_counter = this.attack_counter = 0;
         sprite = new CloudEnemySprite();
         Utils.world.addChild(sprite);
         this.sin_counter = Math.random() * Math.PI * 2;
         aabb.x = 1 + 1;
         aabb.y = 2;
         aabb.width = 14 - 2;
         aabb.height = 13 - 2;
         aabbPhysics.x = 1;
         aabbPhysics.y = 1;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
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
      
      override public function update() : void
      {
         var diff_friction_y:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            this.sin_counter += 0.05;
            if(this.sin_counter >= Math.PI * 2)
            {
               this.sin_counter -= Math.PI * 2;
            }
            yPos = originalYPos + Math.sin(this.sin_counter) * 2;
            if(path_start_y > 0)
            {
               stateMachine.performAction("WALK_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(Math.abs(getMidYPos() - path_start_y) < 4)
            {
               diff_friction_y = Math.abs(getMidYPos() - path_start_y);
               x_friction = diff_friction_y / 4;
            }
            else if(Math.abs(getMidYPos() - path_end_y) < 4)
            {
               diff_friction_y = Math.abs(getMidYPos() - path_end_y);
               x_friction = diff_friction_y / 4;
            }
            else
            {
               x_friction = 1;
            }
            if(x_friction < 0.4)
            {
               x_friction = 0.4;
            }
            sinCounter1 += 0.04;
            xPos = originalXPos + Math.sin(sinCounter1) * 6;
            if(this.GO_DOWN)
            {
               yVel = 0.4;
               if(getMidYPos() >= path_end_y)
               {
                  this.GO_DOWN = false;
               }
            }
            else
            {
               yVel = -0.4;
               if(getMidYPos() <= path_start_y)
               {
                  this.GO_DOWN = true;
               }
            }
         }
         yVel *= x_friction;
         gravity_friction = 0;
         integratePositionAndCollisionDetection();
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
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         var x_t:int = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(stateMachine.currentState == "IS_SWIMMING_STATE")
         {
            xVel = 0;
            changeDirection();
         }
         else if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      public function hiddenAnimation() : void
      {
         sprite.visible = false;
         xVel = yVel = gravity_friction = 0;
         counter1 = counter2 = 0;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         gravity_friction = 0;
         xVel = yVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         if(!this.GO_DOWN)
         {
            ++this.turn_counter;
            if(this.turn_counter >= 1)
            {
               this.GO_DOWN = true;
               this.turn_counter = 0;
            }
         }
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 120;
         xVel = yVel = 0;
      }
      
      public function attackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.attack_counter = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      protected function electroParticles() : void
      {
         var pSprite:GameSprite = new ElectroParticleSprite();
         level.particlesManager.pushParticle(pSprite,getMidXPos() + 2,yPos + HEIGHT,2,1,0.8);
         pSprite = new ElectroParticleSprite();
         pSprite.scaleX = -1;
         level.particlesManager.pushParticle(pSprite,getMidXPos() - 2,yPos + HEIGHT,-2,1,0.8);
      }
   }
}
