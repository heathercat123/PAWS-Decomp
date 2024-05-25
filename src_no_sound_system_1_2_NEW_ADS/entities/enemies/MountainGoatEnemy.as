package entities.enemies
{
   import entities.Entity;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.MountainGoatEnemySprite;
   
   public class MountainGoatEnemy extends Enemy
   {
       
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var fell_at_x:Number;
      
      protected var initial_friction:Number;
      
      protected var frame_counter1:Number;
      
      protected var HAS_MINION:Boolean;
      
      protected var run_offset_y:Number;
      
      public function MountainGoatEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         walking_counter = 0;
         MAX_Y_VEL = 0.5;
         oldXPos = 0;
         oldYPos = 0;
         this.fell_at_x = 0;
         this.frame_counter1 = 0;
         this.initial_friction = 0.1;
         this.HAS_MINION = false;
         if(ai_index == 1)
         {
            this.HAS_MINION = true;
         }
         sprite = new MountainGoatEnemySprite(this.HAS_MINION);
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1 - 4;
         aabb.y = -1 - 4;
         aabb.width = 14 + 8;
         aabb.height = 13 + 5;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","BRAKE_ACTION","IS_BRAKING_STATE");
         stateMachine.setRule("IS_BRAKING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","FALL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_BRAKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_BRAKING_STATE",this.brakingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         energy = 1;
      }
      
      override public function reset() : void
      {
         super.reset();
         energy = 2;
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         var old_frame_counter:Number = NaN;
         var x_t:int = 0;
         var mid_x_t:int = 0;
         var y_t:int = 0;
         super.update();
         if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               ++walking_counter;
               if(DIRECTION == LEFT)
               {
                  xVel = -speed * this.initial_friction;
               }
               else
               {
                  xVel = speed * this.initial_friction;
               }
               if(counter1++ > 15)
               {
                  this.initial_friction *= 1.2;
                  if(this.initial_friction >= 1)
                  {
                     this.initial_friction = 1;
                  }
               }
               old_frame_counter = this.frame_counter1;
               this.frame_counter1 += (1 - this.initial_friction) * 0.05 + 0.2;
               if(this.frame_counter1 >= 3)
               {
                  this.frame_counter1 -= 3;
                  this.run_offset_y = -int(2 + Math.random() * 4);
               }
               if(this.frame_counter1 >= 1)
               {
                  this.run_offset_y = 0;
               }
               yVel += 0.2;
               if(path_start_x > 0)
               {
                  if(xPos <= path_start_x && DIRECTION == LEFT)
                  {
                     stateMachine.performAction("BRAKE_ACTION");
                  }
                  else if(xPos + WIDTH >= path_end_x && DIRECTION == RIGHT)
                  {
                     stateMachine.performAction("BRAKE_ACTION");
                  }
               }
               mid_x_t = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
               y_t = int((yPos + HEIGHT * 0.5 + 6) / Utils.TILE_HEIGHT);
               if(DIRECTION == LEFT)
               {
                  x_t = int((xPos - 1) / Utils.TILE_WIDTH);
                  if(level.levelData.getTileValueAt(x_t,y_t + 1) == 0 || level.levelData.getTileValueAt(x_t,y_t) == 1 && level.levelData.getTileValueAt(mid_x_t,y_t) == 0)
                  {
                     if(ai_index == 2)
                     {
                        stateMachine.performAction("FALL_ACTION");
                     }
                     else
                     {
                        stateMachine.performAction("JUMP_ACTION");
                     }
                  }
               }
               else
               {
                  x_t = int((xPos + WIDTH + 1) / Utils.TILE_WIDTH);
                  if(level.levelData.getTileValueAt(x_t,y_t + 1) == 0 || level.levelData.getTileValueAt(x_t,y_t) == 1 && level.levelData.getTileValueAt(mid_x_t,y_t) == 0)
                  {
                     if(ai_index == 2)
                     {
                        stateMachine.performAction("FALL_ACTION");
                     }
                     else
                     {
                        stateMachine.performAction("JUMP_ACTION");
                     }
                  }
               }
               if(stateMachine.currentState == "IS_TURNING_STATE" || walking_counter < 10 || stateMachine.currentState == "IS_BRAKING_STATE")
               {
                  aabbSpike.width = aabbSpike.height = 0;
               }
               else if(DIRECTION == Entity.LEFT)
               {
                  aabbSpike.x = -8;
                  aabbSpike.y = -2 - 4;
                  aabbSpike.width = 7;
                  aabbSpike.height = 14 + 8;
               }
               else
               {
                  aabbSpike.x = 18;
                  aabbSpike.y = -2 - 4;
                  aabbSpike.width = 7;
                  aabbSpike.height = 14 + 8;
               }
               if(counter2++ > 6)
               {
                  counter2 = -Math.random() * 3;
                  level.particlesManager.groundSmokeParticles(this);
               }
            }
            else if(stateMachine.currentState == "IS_BRAKING_STATE")
            {
               if(isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_brake");
               }
               if(Math.abs(xVel) < 0.5)
               {
                  changeDirection();
                  stateMachine.performAction("END_ACTION");
               }
               if(counter2++ > 3)
               {
                  counter2 = 0;
                  level.particlesManager.groundSmokeParticles(this);
               }
            }
            else if(stateMachine.currentState == "IS_JUMPING_STATE")
            {
               if(DIRECTION == LEFT)
               {
                  xVel = -speed * 1.5;
               }
               else
               {
                  xVel = speed * 1.5;
               }
               yVel += 0.1;
               if(yVel > 0)
               {
                  stateMachine.performAction("FALL_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_FALLING_STATE")
            {
               if(DIRECTION == LEFT)
               {
                  xVel = -speed * 1.5;
               }
               else
               {
                  xVel = speed * 1.5;
               }
               yVel += 0.1;
            }
         }
         if(Utils.SEA_LEVEL > 0)
         {
            if(yPos + HEIGHT >= Utils.SEA_LEVEL)
            {
               hit(getMidXPos(),Utils.SEA_LEVEL + 16,false);
            }
         }
         xVel *= x_friction;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(level.hero.getAABB().intersects(getAABBSpike()))
         {
            return false;
         }
         return true;
      }
      
      override public function groundCollision() : void
      {
         super.groundCollision();
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            stateMachine.performAction("END_ACTION");
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(sprite.gfxHandle().frame == 2)
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(this.frame_counter1 + 1));
            sprite.y += this.run_offset_y;
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(stateMachine.currentState == "IS_BRAKING_STATE")
         {
            xVel = 0;
         }
         else if(ai_index == 2)
         {
            changeDirection();
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.run_offset_y = 0;
         counter1 = 0;
         x_friction = 0.8;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         walking_counter = 0;
         this.frame_counter1 = Math.random() * 3;
         this.run_offset_y = 0;
         if(stateMachine.lastState == "IS_BRAKING_STATE")
         {
            this.initial_friction = 0.1;
         }
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
         this.run_offset_y = 0;
         if(ai_index == 0 || ai_index == 1)
         {
            speed = 1.5;
         }
         else if(ai_index == 2)
         {
            speed = 1.5;
         }
      }
      
      public function brakingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.run_offset_y = 0;
         counter1 = 0;
         x_friction = 0.92;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.run_offset_y = 0;
         counter1 = 0;
         x_friction = 0.8;
         xVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         if(isInsideInnerScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.run_offset_y = 0;
         if(this.HAS_MINION)
         {
            if(getTileAhead(0,-1,false) == 0)
            {
               yVel = -2;
            }
            else
            {
               yVel = -2;
            }
         }
         else if(getTileAhead(0,-1,false) == 0)
         {
            yVel = -2;
         }
         else
         {
            yVel = -2;
         }
         x_friction = 0.7;
      }
      
      public function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.run_offset_y = 0;
      }
      
      public function hitAnimation() : void
      {
         var enemy:TravelerEnemy = null;
         level.freezeAction(5);
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         if(KILLED_BY_CAT)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_WILD_HOG_ENEMY_DEFEATED_BY_ANY_CAT);
         }
         this.run_offset_y = 0;
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         if(this.HAS_MINION)
         {
            enemy = new TravelerEnemy(level,xPos,yPos - 24,DIRECTION,0,0);
            enemy.updateScreenPosition(level.camera);
            level.enemiesManager.enemies.push(enemy);
            enemy.hit(hit_source_x,hit_source_y);
         }
      }
   }
}
