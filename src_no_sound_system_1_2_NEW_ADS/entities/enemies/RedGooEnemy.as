package entities.enemies
{
   import entities.Hero;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.RedGooEnemySprite;
   import sprites.particles.DewParticleSprite;
   
   public class RedGooEnemy extends Enemy
   {
       
      
      public var TYPE:int;
      
      public function RedGooEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.TYPE = _type;
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         sprite = new RedGooEnemySprite(this.TYPE);
         Utils.world.addChild(sprite);
         aabb.x = 1 + 1;
         aabb.y = -1 + 1;
         aabb.width = 14 - 2;
         aabb.height = 13 - 2;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","HIDE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_UNHIDING_STATE",this.unhidingAnimation);
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
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(counter1++ > (this.TYPE == 0 ? 60 : 120))
            {
               counter1 = 0;
               stateMachine.performAction("HIDE_ACTION");
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
            if(path_end_x == 0 && this.TYPE == 1)
            {
               if(counter1++ > (this.TYPE == 0 ? 120 : 60))
               {
                  stateMachine.performAction("STOP_ACTION");
               }
            }
            else
            {
               if(DIRECTION == RIGHT)
               {
                  xVel = speed;
               }
               else
               {
                  xVel = -speed;
               }
               this.boundariesCheck();
            }
         }
         else if(stateMachine.currentState == "IS_HIDING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(this.TYPE == 1)
         {
            gravity_friction = 0;
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
                  stateMachine.performAction("STOP_ACTION");
               }
            }
            else if(xPos + WIDTH >= path_end_x)
            {
               stateMachine.performAction("STOP_ACTION");
            }
         }
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
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
      
      public function walkingAnimation() : void
      {
         if(!(path_end_x == 0 && this.TYPE == 1))
         {
            sprite.gfxHandle().gotoAndStop(3);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         counter1 = 0;
         gravity_friction = 1;
         speed = 2;
         x_friction = 0.8;
         xVel = 0;
      }
      
      public function hidingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("mud");
         }
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function unhidingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("mud");
         }
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.TYPE == 1)
         {
            if(isInsideInnerScreen(-64))
            {
               level.particlesManager.pushParticle(new DewParticleSprite(1),xPos + 8,yPos + 4,0,0,1);
               Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            }
         }
         changeDirection();
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
