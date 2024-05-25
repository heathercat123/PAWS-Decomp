package entities.enemies
{
   import entities.Hero;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.SnowmanEnemySprite;
   
   public class SnowmanEnemy extends Enemy
   {
       
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var jump_counter:int;
      
      protected var fell_at_x:Number;
      
      protected var sin_wave:Number;
      
      protected var param_1:int;
      
      public function SnowmanEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int, _param_1:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         MAX_Y_VEL = 4;
         oldXPos = 0;
         oldYPos = 0;
         this.fell_at_x = 0;
         this.sin_wave = 0;
         if(_param_1 > 0)
         {
            this.param_1 = -90;
         }
         this.jump_counter = this.param_1;
         sprite = new SnowmanEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","POSITIVE_Y_VEL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_IMPACT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_SNOWBALL_STATE","GROUND_COLLISION_ACTION","IS_EMERGING_STATE");
         stateMachine.setRule("IS_EMERGING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_SNOWBALL_STATE",this.snowballAnimation);
         stateMachine.setFunctionToState("IS_EMERGING_STATE",this.emergingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_IMPACT_STATE",this.groundImpactAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 1)
         {
            stateMachine.setState("IS_SNOWBALL_STATE");
            path_start_x = path_end_x = 0;
         }
         else if(ai_index == 2)
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(ai_index == 2)
         {
            stateMachine.setState("IS_STANDING_STATE");
            this.jump_counter = this.param_1;
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
      }
      
      override public function update() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         var wait_time:int = 0;
         super.update();
         x_friction = 0.8;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index == 2)
            {
               if(counter1 == 0)
               {
                  if(this.jump_counter++ > 30)
                  {
                     sprite.gfxHandle().gotoAndStop(1);
                     sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
                     counter1 = 1;
                     this.jump_counter = 0;
                  }
               }
               else if(counter1 == 1)
               {
                  if(this.jump_counter++ > 30)
                  {
                     stateMachine.performAction("JUMP_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(yVel > 0)
            {
               stateMachine.performAction("POSITIVE_Y_VEL_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
            {
               if(counter1 == 0)
               {
                  ++counter1;
                  if(counter2 == 2)
                  {
                     yVel = -1.5;
                  }
               }
               if(DIRECTION == LEFT)
               {
                  xVel -= 0.2;
               }
               else
               {
                  xVel += 0.2;
               }
            }
            else
            {
               counter1 = 0;
            }
            if(path_start_x > 0)
            {
               if(xPos <= path_start_x && DIRECTION == LEFT)
               {
                  xPos = path_start_x;
                  stateMachine.performAction("TURN_ACTION");
               }
               else if(xPos + WIDTH >= path_end_x && DIRECTION == RIGHT)
               {
                  xPos = path_end_x - WIDTH;
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else
            {
               y_t = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
               if(DIRECTION == LEFT)
               {
                  x_t = int((xPos - 1) / Utils.TILE_WIDTH);
                  if(level.levelData.getTileValueAt(x_t,y_t) == 0 && level.levelData.getTileValueAt(x_t,y_t + 1) == 0)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else if(level.levelData.getTileValueAt(x_t,y_t) == 1)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
               else
               {
                  x_t = int((xPos + WIDTH + 1) / Utils.TILE_WIDTH);
                  if(level.levelData.getTileValueAt(x_t,y_t) == 0 && level.levelData.getTileValueAt(x_t,y_t + 1) == 0)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else if(level.levelData.getTileValueAt(x_t,y_t) == 1)
                  {
                     stateMachine.performAction("TURN_ACTION");
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
         else if(stateMachine.currentState == "IS_GROUND_IMPACT_STATE")
         {
            ++counter1;
            if(counter1 > 1 && counter2 < 5)
            {
               ++counter2;
               counter1 = 0;
               if(xPos == originalXPos)
               {
                  xPos = originalXPos + 1;
               }
               else
               {
                  xPos = originalXPos;
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
               xPos = originalXPos;
            }
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(counter3 == 0)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 6)
               {
                  counter3 = 1;
                  if(isInsideScreen())
                  {
                     SoundSystem.PlaySound("dig");
                  }
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete == false)
            {
               yVel = 0;
            }
            else
            {
               yVel = 2;
            }
         }
         else if(stateMachine.currentState == "IS_EMERGING_STATE")
         {
            ++counter1;
            if(counter1 == 60)
            {
               if(isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_water");
               }
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(2);
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
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
         aabb.y = -1;
         aabb.height = 13;
         integratePositionAndCollisionDetection();
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_FALLING_STATE" && yVel > 0)
         {
            return false;
         }
         return true;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_EMERGING_STATE" || stateMachine.currentState == "IS_SNOWBALL_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            xPos = originalXPos;
            SoundSystem.PlaySound("snow_bullet_impact");
         }
         stateMachine.performAction("GROUND_COLLISION_ACTION");
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = 0;
         xVel = 0;
         x_friction = 0.8;
         gravity_friction = 1;
         MAX_Y_VEL = 4;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function snowballAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = 1;
      }
      
      public function emergingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = yVel = 0;
         x_friction = 0.8;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         SoundSystem.PlaySound("enemy_jump");
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
         this.jump_counter = 0;
         yVel = -2;
         gravity_friction = 0.1;
      }
      
      public function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = counter3 = 0;
         MAX_Y_VEL = 4;
         gravity_friction = 0.1;
      }
      
      public function groundImpactAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = counter2 = 0;
         MAX_Y_VEL = 4;
      }
   }
}
