package entities.enemies
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.*;
   
   public class CrabEnemy extends Enemy
   {
       
      
      protected var ORIGINAL_SIDE:int;
      
      protected var SIDE:int;
      
      protected var mid_point:Point;
      
      protected var front_point:Point;
      
      protected var original_rotation:int;
      
      protected var original_flipped_hor:int;
      
      protected var appearArea:Rectangle;
      
      protected var disappearArea:Rectangle;
      
      public function CrabEnemy(_level:Level, _xPos:Number, _yPos:Number, _flipped_hor:int, _flipped_ver:int, __rotation:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,0,_ai_index);
         WIDTH = 16;
         HEIGHT = 16;
         this.original_flipped_hor = _flipped_hor;
         this.original_rotation = __rotation;
         this.appearArea = null;
         this.disappearArea = null;
         speed = 0.4;
         this.front_point = new Point();
         this.mid_point = new Point();
         sprite = new CrabEnemySprite();
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
         stateMachine.setRule("IS_WALKING_STATE","DISAPPEAR_ACTION","IS_DISAPPEARING_STATE");
         stateMachine.setRule("IS_DISAPPEARING_STATE","END_ACTION","IS_GONE_STATE");
         stateMachine.setRule("IS_GONE_STATE","APPEAR_ACTION","IS_APPEARING_STATE");
         stateMachine.setRule("IS_APPEARING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_FRONT_STATE",this.turningFrontAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_DISAPPEARING_STATE",this.disappearingAnimation);
         stateMachine.setFunctionToState("IS_APPEARING_STATE",this.appearingAnimation);
         stateMachine.setFunctionToState("IS_GONE_STATE",this.goneAnimation);
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
      
      override public function destroy() : void
      {
         this.disappearArea = null;
         this.appearArea = null;
         super.destroy();
      }
      
      override public function postInit() : void
      {
         var i:int = 0;
         var temp_index:int = 0;
         fetchNumberScript();
         if(number_index > -1)
         {
            speed = 0.6;
            for(i = 0; i < level.scriptsManager.decorationScripts.length; i++)
            {
               if(level.scriptsManager.decorationScripts[i] != null)
               {
                  if(level.scriptsManager.decorationScripts[i].name == "DisappearSpotScript1" || level.scriptsManager.decorationScripts[i].name == "AppearSpotScript1")
                  {
                     temp_index = level.scriptsManager.decorationScripts[i].param_1;
                     if(temp_index == number_index)
                     {
                        if(level.scriptsManager.decorationScripts[i].name == "DisappearSpotScript1")
                        {
                           this.disappearArea = new Rectangle(level.scriptsManager.decorationScripts[i].x + 8 - 1,level.scriptsManager.decorationScripts[i].y,2,16);
                        }
                        else if(level.scriptsManager.decorationScripts[i].name == "AppearSpotScript1")
                        {
                           this.appearArea = new Rectangle(level.scriptsManager.decorationScripts[i].x,level.scriptsManager.decorationScripts[i].y,16,16);
                        }
                     }
                  }
               }
            }
         }
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
            if(this.disappearArea != null)
            {
               if(this.disappearArea.contains(getMidXPos(),getMidYPos()))
               {
                  stateMachine.performAction("DISAPPEAR_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_GONE_STATE")
         {
            aabb.width = aabb.height = 0;
            ++counter1;
            if(counter1 >= 15)
            {
               stateMachine.performAction("APPEAR_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_DISAPPEARING_STATE" || stateMachine.currentState == "IS_APPEARING_STATE")
         {
            aabb.width = aabb.height = 0;
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_FRONT_STATE")
         {
            if(speed > 0.5)
            {
               if(counter1++ >= 3)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(counter1++ >= 6)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         aabbSpike.width = aabbSpike.height = 0;
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.SIDE == 1)
            {
               aabb.x = 4;
               aabb.y = -2;
               aabb.width = 12;
               aabb.height = 20;
               aabbSpike.x = -1 + 2;
               aabbSpike.y = -6 + 2;
               aabbSpike.width = 10 - 4;
               aabbSpike.height = 28 - 4;
            }
            else if(this.SIDE == 3)
            {
               aabb.x = 0;
               aabb.y = -2;
               aabb.width = 12;
               aabb.height = 20;
               aabbSpike.x = 7;
               aabbSpike.y = -6 + 2;
               aabbSpike.width = 10 - 2;
               aabbSpike.height = 28 - 4;
            }
            else if(this.SIDE == 0)
            {
               aabb.x = -2;
               aabb.y = 4;
               aabb.width = 20;
               aabb.height = 12;
               aabbSpike.x = -6 + 2;
               aabbSpike.y = -1 + 2;
               aabbSpike.width = 28 - 4;
               aabbSpike.height = 10 - 4;
            }
            else if(this.SIDE == 2)
            {
               aabb.x = -2;
               aabb.y = 0;
               aabb.width = 20;
               aabb.height = 12;
               aabbSpike.x = -6 + 2;
               aabbSpike.y = 7;
               aabbSpike.width = 28 - 4;
               aabbSpike.height = 10;
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
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
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
      
      public function disappearingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xPos = this.disappearArea.x - 7;
         xVel = yVel = 0;
         counter1 = 0;
      }
      
      public function goneAnimation() : void
      {
         sprite.visible = false;
         xVel = yVel = 0;
         counter1 = 0;
      }
      
      public function appearingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.setDirectionAndSide(this.original_rotation);
         if(this.original_flipped_hor <= 0)
         {
            DIRECTION = LEFT;
         }
         else
         {
            DIRECTION = RIGHT;
         }
         sprite.visible = true;
         xPos = this.appearArea.x;
         yPos = this.appearArea.y;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override protected function allowCatAttack() : Boolean
      {
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
