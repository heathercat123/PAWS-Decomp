package entities.enemies
{
   import entities.Entity;
   import flash.geom.Point;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.WoodBeetleEnemySprite;
   
   public class WoodBeetleEnemy extends Enemy
   {
       
      
      protected var ORIGINAL_SIDE:int;
      
      protected var SIDE:int;
      
      protected var mid_point:Point;
      
      protected var front_point:Point;
      
      protected var original_rotation:int;
      
      protected var original_flipped_hor:int;
      
      protected var MAX_X_POS:Number;
      
      public function WoodBeetleEnemy(_level:Level, _xPos:Number, _yPos:Number, _flipped_hor:int, _flipped_ver:int, __rotation:int, _ai_index:int, _max_x_pos:Number = 0)
      {
         super(_level,_xPos,_yPos,0,_ai_index);
         WIDTH = 16;
         HEIGHT = 16;
         this.MAX_X_POS = _max_x_pos;
         this.original_flipped_hor = _flipped_hor;
         this.original_rotation = __rotation;
         speed = 0.4;
         this.front_point = new Point();
         this.mid_point = new Point();
         sprite = new WoodBeetleEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = aabbPhysics.x = 0;
         aabb.y = aabbPhysics.y = 0;
         aabb.height = aabbPhysics.height = 16;
         aabb.width = aabbPhysics.width = 16;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_FRONT_ACTION","IS_TURNING_FRONT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SHAKE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","SHAKE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","SHAKE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_FRONT_STATE",this.turningFrontAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_UNHIDING_STATE",this.unhidingAnimation);
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
         energy = 1;
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
         super.update();
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
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
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_FRONT_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIDING_STATE")
         {
            ++counter1;
            if(counter1 >= 240)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.MAX_X_POS > 0)
            {
               if(DIRECTION == Entity.RIGHT)
               {
                  if(this.original_flipped_hor == 1)
                  {
                     if(xPos >= this.MAX_X_POS)
                     {
                        xPos = this.MAX_X_POS;
                        changeDirection();
                     }
                  }
                  else if(xPos >= originalXPos)
                  {
                     xPos = originalXPos;
                     changeDirection();
                  }
                  if(xPos >= path_end_x && path_end_x > 0)
                  {
                     xPos = path_end_x;
                     changeDirection();
                  }
               }
               else if(DIRECTION == Entity.LEFT)
               {
                  if(this.original_flipped_hor == 1)
                  {
                     if(xPos <= originalXPos)
                     {
                        xPos = originalXPos;
                        changeDirection();
                     }
                  }
                  else if(xPos <= this.MAX_X_POS)
                  {
                     xPos = this.MAX_X_POS;
                     changeDirection();
                  }
                  if(xPos <= path_start_x && path_start_x > 0)
                  {
                     xPos = path_start_x;
                     changeDirection();
                  }
               }
            }
            else if(DIRECTION == Entity.RIGHT)
            {
               if(xPos >= path_end_x && path_end_x > 0)
               {
                  xPos = path_end_x;
                  changeDirection();
               }
            }
            else if(DIRECTION == Entity.LEFT)
            {
               if(xPos <= path_start_x && path_start_x > 0)
               {
                  xPos = path_start_x;
                  changeDirection();
               }
            }
            if(this.SIDE == 1 || this.SIDE == 3)
            {
               aabb.x = 0;
               aabb.y = 2;
               aabb.width = 16;
               aabb.height = 12;
            }
            else
            {
               aabb.x = 2;
               aabb.y = 0;
               aabb.width = 12;
               aabb.height = 16;
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
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
         xPos += xVel;
         yPos += yVel;
      }
      
      override public function shake() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
         if(this.SIDE == 1)
         {
            sprite.gfxHandle().rotation = -Math.PI * 0.5;
         }
         else if(this.SIDE == 2)
         {
            sprite.gfxHandle().rotation = Math.PI;
         }
         else if(this.SIDE == 3)
         {
            sprite.gfxHandle().rotation = Math.PI * 0.5;
         }
         else
         {
            sprite.gfxHandle().rotation = 0;
         }
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function turningFrontAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         if(KILLED_BY_CAT)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_WOOD_BEETLE_DEFEATED_BY_ANY_CAT);
         }
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function hidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function unhidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         this.randomizeUnhiding();
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
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
      
      protected function randomizeUnhiding() : void
      {
         var time_left:Number = NaN;
         var amount:Number = 0;
         var total:Number = 0;
         amount = int(Math.random() * 2 + 1) * 0.1;
         sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,amount);
         total += amount;
         amount = int(Math.random() * 2 + 1) * 0.1;
         sprite.gfxHandle().gfxHandleClip().setFrameDuration(1,amount);
         total += amount;
         amount = int(Math.random() * 2 + 1) * 0.1;
         sprite.gfxHandle().gfxHandleClip().setFrameDuration(2,amount);
         total += amount;
         amount = int(Math.random() * 2 + 1) * 0.1;
         sprite.gfxHandle().gfxHandleClip().setFrameDuration(3,amount);
         total += amount;
         time_left = 1 - total;
         sprite.gfxHandle().gfxHandleClip().setFrameDuration(4,time_left);
      }
   }
}
