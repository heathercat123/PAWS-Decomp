package entities.enemies
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.FrogEnemySprite;
   import sprites.particles.SplashParticleSprite;
   
   public class FrogEnemy extends Enemy
   {
       
      
      protected var param_2:Number;
      
      protected var jump_counter:int;
      
      public function FrogEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _param_2:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         this.param_2 = _param_2;
         this.jump_counter = 0;
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         sprite = new FrogEnemySprite();
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
         stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_IMPACT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_IMPACT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","INTO_WATER_ACTION","IS_SWIMMING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SWIMMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_IMPACT_STATE",this.groundImpactAnimation);
         stateMachine.setFunctionToState("IS_SWIMMING_STATE",this.swimmingAnimation);
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
         this.jump_counter = 0;
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         var yPosTarget:Number = NaN;
         var yPosDiff:Number = NaN;
         var yForce:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            this.boundariesCheck();
            stateMachine.performAction("JUMP_ACTION");
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_GROUND_IMPACT_STATE")
         {
            ++counter1;
            if(counter1 == 5)
            {
               sprite.gfxHandle().gotoAndStop(1);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            else if(counter1 >= 20)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(counter1++ > 30)
            {
               xVel *= 0.8;
            }
            if(yVel > 0)
            {
               stateMachine.performAction("POSITIVE_Y_VEL_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(getMidYPos() > Utils.SEA_LEVEL)
            {
               this.setInsideWater();
            }
         }
         else if(stateMachine.currentState == "IS_SWIMMING_STATE")
         {
            yPosTarget = Utils.SEA_LEVEL - 6;
            yPosDiff = yPosTarget - yPos;
            yForce = yPosDiff * 0.1;
            yVel += yForce;
            yVel *= 0.8;
            ++counter1;
            if(counter1 > 60)
            {
               counter1 = 0;
               sprite.gfxHandle().gotoAndStop(4);
               sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               if(DIRECTION == Entity.RIGHT)
               {
                  xVel = 1.5;
               }
               else
               {
                  xVel = -1.5;
               }
               yVel = -2;
               if(this.isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_water");
               }
               level.particlesManager.pushParticle(new SplashParticleSprite(0),getMidXPos(),yPos,0,0,0);
            }
            else if(counter1 > 30)
            {
               sprite.gfxHandle().gotoAndStop(3);
               sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
            }
         }
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
         stateMachine.performAction("GROUND_COLLISION_ACTION");
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
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         if(this.jump_counter == 0 || this.jump_counter == 1)
         {
            if(DIRECTION == RIGHT)
            {
               xVel = 1;
            }
            else
            {
               xVel = -1;
            }
            yVel = -0.5;
         }
         else
         {
            if(this.isInsideInnerScreen())
            {
               SoundSystem.PlaySound("frog");
            }
            if(DIRECTION == RIGHT)
            {
               xVel = 1.5;
            }
            else
            {
               xVel = -1.5;
            }
            yVel = -2.5;
         }
         ++this.jump_counter;
         if(this.jump_counter > 2)
         {
            this.jump_counter = 0;
         }
         x_friction = 0.98;
         gravity_friction = 0.2;
         counter1 = 0;
      }
      
      public function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = 0;
      }
      
      public function groundImpactAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         counter1 = 0;
      }
      
      public function swimmingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         x_friction = 0.95;
         gravity_friction = 0.2;
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      override protected function allowScubaMaskAttack() : Boolean
      {
         if(IS_IN_WATER)
         {
            return true;
         }
         return false;
      }
      
      override public function setInsideWater() : void
      {
         stateMachine.performAction("INTO_WATER_ACTION");
         IS_IN_WATER = true;
         water_friction = 0.5;
         timeInsideWater = 0;
      }
   }
}
