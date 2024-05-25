package entities.enemies
{
   import flash.geom.Point;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.FireFlameBulletSprite;
   import sprites.collisions.DarkSmallSpotCollisionSprite;
   import sprites.enemies.FireFlameEnemySprite;
   
   public class FireFlameEnemy extends Enemy
   {
       
      
      protected var ORIGINAL_SIDE:int;
      
      protected var SIDE:int;
      
      protected var mid_point:Point;
      
      protected var front_point:Point;
      
      protected var original_rotation:int;
      
      protected var original_flipped_hor:int;
      
      protected var last_flame_x_t:int;
      
      protected var last_flame_y_t:int;
      
      protected var flame_wait_counter:int;
      
      protected var light:DarkSmallSpotCollisionSprite;
      
      public function FireFlameEnemy(_level:Level, _xPos:Number, _yPos:Number, _flipped_hor:int, _flipped_ver:int, __rotation:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,0,_ai_index);
         WIDTH = 16;
         HEIGHT = 16;
         this.original_flipped_hor = _flipped_hor;
         this.original_rotation = __rotation;
         this.last_flame_x_t = this.last_flame_y_t = -1;
         this.flame_wait_counter = 0;
         speed = 0.4;
         this.front_point = new Point();
         this.mid_point = new Point();
         sprite = new FireFlameEnemySprite();
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
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_FRONT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TURNING_FRONT_STATE",this.turningFrontAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         if(Utils.IS_DARK)
         {
            this.light = new DarkSmallSpotCollisionSprite();
            this.light.gotoAndStop(1);
            level.darkManager.maskContainer.addChild(this.light);
         }
         else
         {
            this.light = null;
         }
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
         if(this.light != null)
         {
            level.darkManager.maskContainer.removeChild(this.light);
            this.light.destroy();
            this.light.dispose();
            this.light = null;
         }
         super.destroy();
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
         energy = 1;
      }
      
      protected function fireFlamesRoutine() : void
      {
         var _offset_x:int = 0;
         var _offset_y:int = 0;
         var invalid_position:Boolean = false;
         var bSprite:FireFlameBulletSprite = null;
         var x_t:int = getTileX(WIDTH * 0.5);
         var y_t:int = getTileY(HEIGHT * 0.5);
         if(this.last_flame_x_t != x_t || this.last_flame_y_t != y_t)
         {
            ++this.flame_wait_counter;
            if(this.flame_wait_counter > 10)
            {
               this.last_flame_x_t = x_t;
               this.last_flame_y_t = y_t;
               _offset_x = 0;
               _offset_y = 0;
               invalid_position = false;
               bSprite = new FireFlameBulletSprite();
               if(this.SIDE == 0)
               {
                  _offset_x = int(8);
                  _offset_y = int(13);
                  if(level.levelData.getTileValueAt(x_t,y_t + 1) == 0)
                  {
                     invalid_position = true;
                  }
               }
               else if(this.SIDE == 1)
               {
                  _offset_x = int(13);
                  _offset_y = int(8);
                  bSprite.rotation = -Math.PI * 0.5;
                  if(level.levelData.getTileValueAt(x_t + 1,y_t) == 0)
                  {
                     invalid_position = true;
                  }
               }
               else if(this.SIDE == 2)
               {
                  _offset_x = int(8);
                  _offset_y = int(3);
                  bSprite.rotation = Math.PI;
                  if(level.levelData.getTileValueAt(x_t,y_t - 1) == 0)
                  {
                     invalid_position = true;
                  }
               }
               else if(this.SIDE == 3)
               {
                  _offset_x = int(3);
                  _offset_y = int(9);
                  bSprite.rotation = Math.PI * 0.5;
                  if(level.levelData.getTileValueAt(x_t - 1,y_t) == 0)
                  {
                     invalid_position = true;
                  }
               }
               if(!invalid_position)
               {
                  level.bulletsManager.pushBackBullet(bSprite,x_t * Utils.TILE_WIDTH + _offset_x,y_t * Utils.TILE_HEIGHT + _offset_y,0,0,0);
                  this.flame_wait_counter = 0;
               }
            }
         }
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
            this.fireFlamesRoutine();
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_FRONT_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
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
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            if(this.light != null)
            {
               this.light.scaleX -= 0.05;
               if(this.light.scaleX <= 0)
               {
                  this.light.scaleX = 0;
               }
               this.light.scaleY = this.light.scaleX;
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
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.light != null)
         {
            this.light.x = int(sprite.x + DebugInputPanel.getInstance().s1);
            this.light.y = int(sprite.y + DebugInputPanel.getInstance().s2);
            this.light.updateScreenPosition();
            if(isInsideInnerScreen(-64))
            {
               this.light.visible = true;
            }
            else
            {
               this.light.visible = false;
            }
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
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         setHitVariables();
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
   }
}
