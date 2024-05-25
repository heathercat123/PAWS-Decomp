package entities.enemies
{
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.ScarecrowEnemySprite;
   
   public class ScarecrowEnemy extends Enemy
   {
       
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var fell_at_x:Number;
      
      protected var pre_jump_x_pos:Number;
      
      protected var timer:int;
      
      protected var jump_delay:int;
      
      protected var jump_delay_original_value:int;
      
      public function ScarecrowEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int, _delay:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         this.jump_delay = this.jump_delay_original_value = _delay;
         this.timer = 0;
         MAX_Y_VEL = 4;
         this.fell_at_x = 0;
         this.pre_jump_x_pos = xPos;
         sprite = new ScarecrowEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = -3;
         aabb.y = -1;
         aabb.width = 22;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_READY_TO_JUMP_STATE");
         stateMachine.setRule("IS_READY_TO_JUMP_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_IMPACT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_READY_TO_JUMP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_READY_TO_JUMP_STATE",this.readyToJumpAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_IMPACT_STATE",this.groundImpactAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 1;
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_STANDING_STATE");
         this.jump_delay = this.jump_delay_original_value;
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index != 1)
            {
               if(this.jump_delay-- < 0)
               {
                  if(counter1++ > 30)
                  {
                     stateMachine.performAction("JUMP_ACTION");
                  }
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
         else if(stateMachine.currentState == "IS_READY_TO_JUMP_STATE")
         {
            ++counter1;
            ++counter2;
            if(counter2 > 2)
            {
               counter2 = 0;
               if(counter3 == 0)
               {
                  xPos = this.pre_jump_x_pos + 1;
                  counter3 = 1;
               }
               else
               {
                  xPos = this.pre_jump_x_pos;
                  counter3 = 0;
               }
            }
            if(counter1 > 15)
            {
               xPos = this.pre_jump_x_pos;
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            ++this.timer;
         }
         else if(stateMachine.currentState == "IS_GROUND_IMPACT_STATE")
         {
            ++counter1;
            if(counter1 > 5)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            aabbSpike.x = -7;
            aabbSpike.y = -2 - 3;
            aabbSpike.width = 30;
            aabbSpike.height = 13;
         }
         else
         {
            aabbSpike.x = -7;
            aabbSpike.y = -2;
            aabbSpike.width = 30;
            aabbSpike.height = 13;
         }
         aabb.y = -3 - 10;
         aabb.height = 15 + 10;
         aabb.x = -3 + 3;
         aabb.width = 22 - 6;
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
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.boundariesCheck();
         counter1 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function readyToJumpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = counter3 = 0;
         this.pre_jump_x_pos = xPos;
      }
      
      public function jumpingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         yVel = -1.8;
         if(ai_index == 2)
         {
            if(DIRECTION == LEFT)
            {
               xVel = -0.5;
            }
            else
            {
               xVel = 0.5;
            }
         }
         gravity_friction = 0.1;
         x_friction = 1;
         this.timer = 0;
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(level.hero.getAABB().intersects(getAABBSpike()))
         {
            return false;
         }
         return true;
      }
      
      public function groundImpactAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = 0;
         this.fell_at_x = xPos + WIDTH * 0.5;
         gravity_friction = 1;
         x_friction = 0.8;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
