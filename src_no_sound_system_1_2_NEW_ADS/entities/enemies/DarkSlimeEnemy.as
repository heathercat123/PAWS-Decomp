package entities.enemies
{
   import entities.Hero;
   import entities.bullets.Bullet;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.DarkSlimeEnemySprite;
   
   public class DarkSlimeEnemy extends Enemy
   {
       
      
      public function DarkSlimeEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         x_friction = 0.8;
         sprite = new DarkSlimeEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_SUBMERGING_STATE");
         stateMachine.setRule("IS_SUBMERGING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","END_ACTION","IS_EMERGING_STATE");
         stateMachine.setRule("IS_EMERGING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SUBMERGING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_EMERGING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_SUBMERGING_STATE",this.submergeAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_EMERGING_STATE",this.emergeAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 2;
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_STANDING_STATE");
         energy = 2;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState != "IS_STANDING_STATE" && stateMachine.currentState != "IS_SUBMERGING_STATE" && stateMachine.currentState != "IS_WALKING_STATE" && stateMachine.currentState != "IS_EMERGING_STATE" && stateMachine.currentState != "IS_TURNING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(stateMachine.currentState != "IS_STANDING_STATE" && stateMachine.currentState != "IS_SUBMERGING_STATE" && stateMachine.currentState != "IS_WALKING_STATE" && stateMachine.currentState != "IS_EMERGING_STATE" && stateMachine.currentState != "IS_TURNING_STATE")
         {
            return;
         }
         super.bulletImpact(bullet);
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            ++counter1;
            if(counter1++ >= 60)
            {
               if(DIRECTION == LEFT)
               {
                  if(xPos <= path_start_x)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else
                  {
                     stateMachine.performAction("WALK_ACTION");
                  }
               }
               else if(xPos + WIDTH >= path_end_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               else
               {
                  stateMachine.performAction("WALK_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_SUBMERGING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel = -2;
               if(xPos <= path_start_x)
               {
                  xPos = path_start_x;
                  stateMachine.performAction("END_ACTION");
               }
            }
            else
            {
               xVel = 2;
               if(xPos + WIDTH >= path_end_x)
               {
                  xPos = path_end_x - WIDTH;
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_EMERGING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
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
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
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
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_EMERGING_STATE" || stateMachine.currentState == "IS_SUBMERGING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         if(stateMachine.lastState == "IS_TURNING_STATE")
         {
            counter1 = 60;
         }
         else
         {
            counter1 = 0;
         }
         x_friction = 0.8;
         xVel = yVel = 0;
      }
      
      public function submergeAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function emergeAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         xVel = yVel = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
