package entities.enemies
{
   import entities.Entity;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.*;
   import states.LevelState;
   
   public class GiantCrabEnemy extends GiantEnemy
   {
       
      
      protected var ORIGINAL_SIDE:int;
      
      protected var SIDE:int;
      
      protected var SIDE_TO_REACH:int;
      
      protected var mid_point:Point;
      
      protected var front_point:Point;
      
      protected var original_rotation:int;
      
      protected var original_flipped_hor:int;
      
      protected var walk_counter:int;
      
      protected var walk_sound_counter:int;
      
      protected var IS_SPIKES_OUT:Boolean;
      
      protected var first_time:Boolean;
      
      public function GiantCrabEnemy(_level:Level, _xPos:Number, _yPos:Number, _flipped_hor:int, _flipped_ver:int, __rotation:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,0,_ai_index);
         IS_MINIBOSS = true;
         WIDTH = 16;
         HEIGHT = 16;
         this.IS_SPIKES_OUT = false;
         this.SIDE_TO_REACH = 0;
         this.walk_sound_counter = 0;
         this.original_flipped_hor = _flipped_hor;
         this.original_rotation = __rotation;
         this.walk_counter = 90;
         this.first_time = true;
         speed = 0.4;
         this.front_point = new Point();
         this.mid_point = new Point();
         sprite = new CrabEnemySprite(1);
         Utils.world.addChild(sprite);
         aabb.x = aabbPhysics.x = 0;
         aabb.y = aabbPhysics.y = 0;
         aabb.width = aabbPhysics.width = 16;
         aabb.height = aabbPhysics.height = 16;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_FRONT_ACTION","IS_TURNING_FRONT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SPIKES_OUT_ACTION","IS_SPIKES_OUT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SPIKES_IN_ACTION","IS_SPIKES_IN_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SPIKES_OUT_ACTION","IS_SPIKES_OUT_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SPIKES_IN_ACTION","IS_SPIKES_IN_STATE");
         stateMachine.setRule("IS_SPIKES_OUT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_SPIKES_IN_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","END_ACTION","IS_IMPACT_STATE");
         stateMachine.setRule("IS_IMPACT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_SPIKES_OUT_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_SPIKES_IN_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_IMPACT_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_FRONT_STATE",this.turningFrontAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_SPIKES_OUT_STATE",this.spikesOutAnimation);
         stateMachine.setFunctionToState("IS_SPIKES_IN_STATE",this.spikesInAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_IMPACT_STATE",this.impactAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         this.setDirectionAndSide(__rotation);
         if(_flipped_hor <= 0)
         {
            DIRECTION = LEFT;
         }
         else
         {
            DIRECTION = RIGHT;
         }
         this.ORIGINAL_SIDE = this.SIDE;
         energy = 2;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function isInvulnerableToHelperAttacks() : Boolean
      {
         if(this.IS_SPIKES_OUT)
         {
            return true;
         }
         return false;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.setDirectionAndSide(this.original_rotation);
         if(this.original_flipped_hor <= 0)
         {
            DIRECTION = LEFT;
         }
         else
         {
            DIRECTION = RIGHT;
         }
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         var this_mid_x:Number = NaN;
         var hero_mid_x:Number = NaN;
         var this_mid_y:Number = NaN;
         var hero_mid_y:Number = NaN;
         var rectangle:Rectangle = null;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(level.stateMachine.currentState != "IS_CUTSCENE_STATE")
            {
               --counter1;
               if(counter1 < 0)
               {
                  if(this.first_time)
                  {
                     stateMachine.performAction("WALK_ACTION");
                     this.first_time = false;
                  }
                  else if(this.IS_SPIKES_OUT)
                  {
                     stateMachine.performAction("SPIKES_IN_ACTION");
                  }
                  else
                  {
                     stateMachine.performAction("SPIKES_OUT_ACTION");
                  }
                  this_mid_x = getMidXPos();
                  hero_mid_x = level.hero.getMidXPos();
                  this_mid_y = getMidYPos();
                  hero_mid_y = level.hero.getMidYPos();
                  if(this.SIDE == 0)
                  {
                     if(hero_mid_x < this_mid_x)
                     {
                        DIRECTION = Entity.LEFT;
                     }
                     else
                     {
                        DIRECTION = Entity.RIGHT;
                     }
                  }
                  else if(this.SIDE == 2)
                  {
                     if(hero_mid_x > this_mid_x)
                     {
                        DIRECTION = Entity.LEFT;
                     }
                     else
                     {
                        DIRECTION = Entity.RIGHT;
                     }
                  }
                  else if(this.SIDE == 3)
                  {
                     if(hero_mid_y < this_mid_y)
                     {
                        DIRECTION = Entity.LEFT;
                     }
                     else
                     {
                        DIRECTION = Entity.RIGHT;
                     }
                  }
                  else if(this.SIDE == 1)
                  {
                     if(hero_mid_y > this_mid_y)
                     {
                        DIRECTION = Entity.LEFT;
                     }
                     else
                     {
                        DIRECTION = Entity.RIGHT;
                     }
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            speed = 2;
            if(this.SIDE == 0)
            {
               this.updateTop();
            }
            else if(this.SIDE == 1)
            {
               this.updateLeft();
            }
            else if(this.SIDE == 2)
            {
               this.updateBottom();
            }
            else if(this.SIDE == 3)
            {
               this.updateRight();
            }
            if(level.stateMachine.currentState != "IS_CUTSCENE_STATE")
            {
               rectangle = new Rectangle(664,152,176,64);
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] != LevelState.LEVEL_2_4_7)
               {
                  rectangle.width = rectangle.height = 0;
               }
               if(!((this.SIDE == 1 || this.SIDE == 3) && rectangle.contains(getMidXPos(),getMidYPos())))
               {
                  --this.walk_counter;
               }
               if(this.walk_counter <= 0)
               {
                  if(this.IS_SPIKES_OUT)
                  {
                     this.walk_counter = 60;
                  }
                  else
                  {
                     this.walk_counter = 240;
                  }
                  stateMachine.performAction("STOP_ACTION");
               }
               else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
               {
                  if(getMidYPos() >= 216)
                  {
                     if(getMidXPos() >= 696 && getMidXPos() <= 808)
                     {
                        if(level.hero.getMidXPos() >= 696 && level.hero.getMidXPos() <= 808)
                        {
                           if(level.hero.getMidYPos() <= 176)
                           {
                              stateMachine.performAction("JUMP_ACTION");
                           }
                        }
                     }
                  }
                  else if(getMidYPos() <= 152)
                  {
                     if(getMidXPos() >= 696 && getMidXPos() <= 808)
                     {
                        if(level.hero.getMidXPos() >= 696 && level.hero.getMidXPos() <= 808)
                        {
                           if(level.hero.getMidYPos() <= 176)
                           {
                              stateMachine.performAction("JUMP_ACTION");
                           }
                        }
                     }
                  }
                  else if(level.hero.getMidYPos() >= 200)
                  {
                     if(getMidXPos() >= 696 && getMidXPos() <= 808 && getMidYPos() && this.SIDE == 2)
                     {
                        stateMachine.performAction("JUMP_ACTION");
                     }
                  }
               }
            }
            else
            {
               ++this.walk_sound_counter;
               if(this.walk_sound_counter >= 15)
               {
                  this.walk_sound_counter = 0;
                  SoundSystem.PlaySound("wiggle");
               }
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(counter1++ >= 15)
            {
               this.SIDE = this.SIDE_TO_REACH;
               xVel = 0;
               if(this.SIDE == 2)
               {
                  yVel = -2;
               }
               else if(this.SIDE == 0)
               {
                  yVel = 2;
               }
               integratePositionAndCollisionDetection();
            }
         }
         else if(stateMachine.currentState == "IS_IMPACT_STATE")
         {
            if(counter1++ >= 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SPIKES_OUT_STATE" || stateMachine.currentState == "IS_SPIKES_IN_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               if(stateMachine.currentState == "IS_SPIKES_OUT_STATE")
               {
                  this.IS_SPIKES_OUT = true;
                  if(isInsideScreen())
                  {
                     SoundSystem.PlaySound("dig");
                  }
               }
               else
               {
                  SoundSystem.PlaySound("enemy_jump_low");
               }
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_FRONT_STATE")
         {
            stateMachine.performAction("END_ACTION");
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(this.SIDE == 0)
            {
               integratePositionAndCollisionDetection();
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_IMPACT_STATE" || stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(this.SIDE == 1)
            {
               aabb.x = 4 - 5;
               aabb.y = -2 - 4;
               aabb.width = 12 + 5;
               aabb.height = 20 + 8;
               aabbSpike.x = -1 - 5;
               aabbSpike.y = -6 - 5;
               aabbSpike.width = 10 + 12 - 4;
               aabbSpike.height = 28 + 10;
            }
            else if(this.SIDE == 3)
            {
               aabb.x = 0 + 0;
               aabb.y = -2 - 4;
               aabb.width = 12 + 5;
               aabb.height = 20 + 8;
               aabbSpike.x = 7 - 7 + 4;
               aabbSpike.y = -6 - 5;
               aabbSpike.width = 10 + 11 - 4;
               aabbSpike.height = 28 + 10;
            }
            else if(this.SIDE == 0)
            {
               aabb.x = -6;
               aabb.y = -1;
               aabb.width = 28;
               aabb.height = 10 + 7;
               aabbSpike.x = -6 - 5;
               aabbSpike.y = -1 - 5;
               aabbSpike.width = 28 + 10;
               aabbSpike.height = 10 + 12 - 4;
            }
            else if(this.SIDE == 2)
            {
               aabb.x = -2 - 4;
               aabb.y = 0 + 0;
               aabb.width = 20 + 8;
               aabb.height = 12 + 5;
               aabbSpike.x = -6 - 5;
               aabbSpike.y = 7 - 7 + 4;
               aabbSpike.width = 28 + 10;
               aabbSpike.height = 10 + 11 - 4;
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_FRONT_STATE")
         {
            if(stateMachine.currentState == "IS_TURNING_STATE")
            {
               if(this.SIDE == 1)
               {
                  aabb.x = 4;
                  aabb.y = -3;
               }
               else if(this.SIDE == 2)
               {
                  aabb.x = -3;
                  aabb.y = -4;
               }
               else if(this.SIDE == 3)
               {
                  aabb.x = -4;
                  aabb.y = 3;
               }
               else
               {
                  aabb.x = 3;
                  aabb.y = 4;
               }
               aabb.width = aabb.height = 16;
            }
            else
            {
               aabb.x = aabb.y = 1;
               aabb.width = aabb.height = 14;
            }
         }
         if(this.IS_SPIKES_OUT == false)
         {
            aabbSpike.width = aabbSpike.height = 0;
         }
      }
      
      override public function ceilCollision() : void
      {
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            level.camera.shake();
            SoundSystem.PlaySound("ground_stomp");
            stateMachine.performAction("END_ACTION");
         }
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            level.camera.shake();
            SoundSystem.PlaySound("ground_stomp");
            stateMachine.performAction("END_ACTION");
         }
      }
      
      override public function isWaterAllowed() : Boolean
      {
         return false;
      }
      
      protected function updateTop() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = WIDTH * 0.5;
         this.mid_point.y = HEIGHT;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = 0;
            this.front_point.y = HEIGHT * 0.5;
            xVel = -speed;
            yVel += 4;
            this.integratePosition();
            if(path_start_x > 0)
            {
               if(xPos <= path_start_x)
               {
                  changeDirection();
               }
            }
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = y_t * Utils.TILE_HEIGHT - 8;
               xVel = yVel = 0;
               this.SIDE = 1;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t + 1) * Utils.TILE_WIDTH;
               yPos = (y_t - 0) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 3;
            }
         }
         else
         {
            this.front_point.x = WIDTH;
            this.front_point.y = HEIGHT * 0.5;
            xVel = speed;
            yVel += 4;
            this.integratePosition();
            if(path_start_x > 0)
            {
               if(xPos + 16 >= path_end_x)
               {
                  changeDirection();
               }
            }
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = y_t * Utils.TILE_HEIGHT - 8;
               xVel = yVel = 0;
               this.SIDE = 3;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t - 1) * Utils.TILE_WIDTH;
               yPos = (y_t - 0) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 1;
            }
         }
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function updateLeft() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = WIDTH;
         this.mid_point.y = HEIGHT * 0.5;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = HEIGHT;
            yVel = speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH - 8;
               yPos = y_t * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 2;
            }
            if(path_start_y > 0)
            {
               if(yPos + 16 >= path_end_y)
               {
                  changeDirection();
               }
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = (y_t - 1) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 0;
            }
         }
         else
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = 0;
            yVel = -speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH - 8;
               yPos = y_t * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 0;
            }
            if(path_start_y > 0)
            {
               if(yPos <= path_start_y)
               {
                  changeDirection();
               }
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t - 0) * Utils.TILE_WIDTH;
               yPos = (y_t + 1) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 2;
            }
         }
      }
      
      protected function updateBottom() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = WIDTH * 0.5;
         this.mid_point.y = 0;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = WIDTH;
            this.front_point.y = HEIGHT * 0.5;
            xVel = speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y - 1) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = y_t * Utils.TILE_HEIGHT + 8;
               xVel = yVel = 0;
               this.SIDE = 3;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t - 1) * Utils.TILE_WIDTH;
               yPos = (y_t - 0) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 1;
            }
         }
         else
         {
            this.front_point.x = 0;
            this.front_point.y = HEIGHT * 0.5;
            xVel = -speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y - 1) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = y_t * Utils.TILE_HEIGHT + 8;
               xVel = yVel = 0;
               this.SIDE = 1;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t + 1) * Utils.TILE_WIDTH;
               yPos = (y_t - 0) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 3;
            }
         }
      }
      
      protected function updateRight() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = 0;
         this.mid_point.y = HEIGHT * 0.5;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = 0;
            yVel = -speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x - 1) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH + 8;
               yPos = y_t * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 0;
            }
            if(path_start_y > 0)
            {
               if(yPos <= path_start_y)
               {
                  changeDirection();
               }
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t - 0) * Utils.TILE_WIDTH;
               yPos = (y_t + 1) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 2;
            }
         }
         else
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = HEIGHT;
            yVel = speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x - 1) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH + 8;
               yPos = y_t * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 2;
            }
            if(path_start_y > 0)
            {
               if(yPos + 16 >= path_end_y)
               {
                  changeDirection();
               }
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1 || level.levelData.getTileValueAt(x_t,y_t) == 10)
            {
               stateMachine.performAction("TURN_FRONT_ACTION");
               xPos = (x_t - 0) * Utils.TILE_WIDTH;
               yPos = (y_t - 1) * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 0;
            }
         }
      }
      
      protected function integratePosition() : void
      {
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
      }
      
      override public function shake() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.SIDE == 1)
         {
            sprite.gfxHandle().rotation = -Math.PI * 0.5;
            if(stunHandler != null)
            {
               stunHandler.sprite.rotation = -Math.PI * 0.5;
               stunHandler.stun_x_offset = -20;
               stunHandler.stun_y_offset = 8;
            }
         }
         else if(this.SIDE == 2)
         {
            sprite.gfxHandle().rotation = Math.PI;
            if(stunHandler != null)
            {
               stunHandler.sprite.rotation = Math.PI;
               stunHandler.stun_x_offset = 0;
               stunHandler.stun_y_offset = 24 + 4;
            }
         }
         else if(this.SIDE == 3)
         {
            sprite.gfxHandle().rotation = Math.PI * 0.5;
            if(stunHandler != null)
            {
               stunHandler.sprite.rotation = Math.PI * 0.5;
               stunHandler.stun_x_offset = 20;
               stunHandler.stun_y_offset = 8;
            }
         }
         else
         {
            sprite.gfxHandle().rotation = 0;
            if(stunHandler != null)
            {
               stunHandler.sprite.rotation = 0;
               stunHandler.stun_x_offset = 0;
               stunHandler.stun_y_offset = -(9 + 4);
            }
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
      }
      
      public function standingAnimation() : void
      {
         if(this.IS_SPIKES_OUT)
         {
            sprite.gfxHandle().gotoAndStop(4);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(1);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = yVel = 0;
         counter1 = 60;
      }
      
      public function walkingAnimation() : void
      {
         if(this.IS_SPIKES_OUT)
         {
            sprite.gfxHandle().gotoAndStop(4);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(1);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.walk_sound_counter = 0;
      }
      
      public function turningAnimation() : void
      {
         counter1 = 0;
      }
      
      public function turningFrontAnimation() : void
      {
         if(ai_index == 0)
         {
            sprite.gfxHandle().gotoAndStop(3);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         counter1 = 0;
      }
      
      public function spikesOutAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function spikesInAnimation() : void
      {
         this.IS_SPIKES_OUT = false;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         counter1 = 0;
         SoundSystem.PlaySound("woosh");
         gravity_friction = 0.4;
         x_friction = 0.95;
         if(this.SIDE == 0)
         {
            this.SIDE_TO_REACH = 2;
         }
         else if(this.SIDE == 2)
         {
            this.SIDE_TO_REACH = 0;
         }
      }
      
      public function impactAnimation() : void
      {
         var this_mid_x:Number = NaN;
         var this_mid_y:Number = NaN;
         var hero_mid_x:Number = NaN;
         var hero_mid_y:Number = NaN;
         counter1 = 0;
         this.walk_counter += 30;
         if(this.SIDE == 0)
         {
            this_mid_x = getMidXPos();
            this_mid_y = getMidYPos();
            hero_mid_x = level.hero.getMidXPos();
            hero_mid_y = level.hero.getMidYPos();
            if(hero_mid_x < this_mid_x)
            {
               DIRECTION = Entity.LEFT;
            }
            else
            {
               DIRECTION = Entity.RIGHT;
            }
         }
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         if(this.IS_SPIKES_OUT)
         {
            sprite.gfxHandle().gotoAndStop(6);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(5);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.SIDE == 0)
         {
            if(level.hero.getMidXPos() > getMidXPos())
            {
               xVel = -2;
            }
            else
            {
               xVel = 2;
            }
            yVel = -2;
            gravity_friction = 0.4;
            x_friction = 0.95;
         }
         else
         {
            xVel = yVel = 0;
         }
      }
      
      public function hitAnimation() : void
      {
         SoundSystem.PlaySound("giant_turnip_defeat");
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            return false;
         }
         if(level.hero.getAABB().intersects(getAABBSpike()))
         {
            return false;
         }
         return true;
      }
      
      protected function setDirectionAndSide(__rotation:int) : void
      {
         if(__rotation == 0)
         {
            this.SIDE = 0;
         }
         else if(__rotation == -90)
         {
            this.SIDE = 1;
         }
         else if(__rotation == 180)
         {
            this.SIDE = 2;
         }
         else if(__rotation == 90)
         {
            this.SIDE = 3;
         }
      }
   }
}
