package levels.collisions
{
   import entities.Easings;
   import entities.Entity;
   import flash.geom.*;
   import game_utils.CollisionId;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class YellowPlatformCollision extends Collision
   {
      
      public static var YELLOW_PLATFORM_COLLISION_ID:int = 20000;
       
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var path_start_x:int;
      
      protected var path_end_x:int;
      
      protected var path_start_y:int;
      
      protected var path_end_y:int;
      
      protected var time:Number;
      
      protected var time_tick:Number;
      
      protected var time_start:Number;
      
      protected var time_diff:Number;
      
      protected var stateMachine:StateMachine;
      
      protected var IS_A_TO_B:Boolean;
      
      protected var ORIGINAL_IS_A_TO_B:Boolean;
      
      protected var IS_HORIZONTAL:Boolean;
      
      protected var IS_STILL:Boolean;
      
      protected var gearsSprite:Array;
      
      protected var gearsData:Array;
      
      protected var _entities:Vector.<CollisionId>;
      
      public var IS_TICK_TOCK:Boolean;
      
      public var IS_TICK:Boolean;
      
      public function YellowPlatformCollision(_level:Level, _xPos:Number, _yPos:Number, _isTickTock:int = 0)
      {
         super(_level,_xPos,_yPos);
         if(_isTickTock > 0)
         {
            this.IS_TICK_TOCK = true;
         }
         else
         {
            this.IS_TICK_TOCK = false;
         }
         if(this.IS_TICK_TOCK)
         {
            sprite = new YellowPlatformCollisionSprite(3);
            if(_isTickTock == 1)
            {
               this.IS_TICK = true;
               sprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               this.IS_TICK = false;
               sprite.gfxHandleClip().gotoAndStop(2);
            }
         }
         else
         {
            sprite = new YellowPlatformCollisionSprite();
         }
         Utils.world.addChild(sprite);
         WIDTH = 64;
         HEIGHT = 8;
         this.ORIGINAL_IS_A_TO_B = this.IS_A_TO_B = true;
         this.IS_STILL = false;
         aabb.x = 0 - 2;
         aabb.y = -2;
         aabb.width = 64 + 4;
         aabb.height = 12;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.time = 0;
         this.time_tick = 0;
         this.fetchScripts();
         this.initGears();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","MOVE_ACTION","IS_MOVING_STATE");
         this.stateMachine.setRule("IS_MOVING_STATE","STOP_ACTION","IS_WAITING_STATE");
         this.stateMachine.setRule("IS_STILL_STATE","END_ACTION","IS_WAITING_STATE");
         this.stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingState);
         this.stateMachine.setFunctionToState("IS_MOVING_STATE",this.movingState);
         this.stateMachine.setFunctionToState("IS_STILL_STATE",this.stillState);
         if(this.IS_STILL)
         {
            this.stateMachine.setState("IS_STILL_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_WAITING_STATE");
         }
         COLLISION_ID = YellowPlatformCollision.YELLOW_PLATFORM_COLLISION_ID++;
         this._entities = new Vector.<CollisionId>();
      }
      
      public function setWidth(_amount:int) : void
      {
         aabb.width = _amount + 4;
         WIDTH = _amount;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               this._entities[i].destroy();
               this._entities[i] = null;
            }
         }
         this._entities = null;
         for(i = 0; i < this.gearsData.length; i++)
         {
            Utils.world.removeChild(this.gearsSprite[i]);
            this.gearsSprite[i].destroy();
            this.gearsSprite[i].dispose();
            this.gearsSprite[i] = null;
            this.gearsData[i] = null;
         }
         this.gearsSprite = null;
         this.gearsData = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var x_diff:Number = NaN;
         super.update();
         if(this.IS_TICK_TOCK)
         {
            if(this.IS_TICK == Utils.IS_TICK)
            {
               sprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               sprite.gfxHandleClip().gotoAndStop(2);
            }
         }
         if(this.stateMachine.currentState == "IS_WAITING_STATE")
         {
            ++counter1;
            if(counter1 >= 120)
            {
               this.stateMachine.performAction("MOVE_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_MOVING_STATE")
         {
            this.time_tick += 1 / 60;
            if(this.time_tick >= this.time)
            {
               this.time_tick = this.time;
               this.IS_A_TO_B = !this.IS_A_TO_B;
               this.stateMachine.performAction("STOP_ACTION");
            }
            if(this.IS_HORIZONTAL)
            {
               xPos = Math.round(Easings.linear(this.time_tick,this.time_start,this.time_diff,this.time));
            }
            else
            {
               yPos = Math.round(Easings.linear(this.time_tick,this.time_start,this.time_diff,this.time));
            }
         }
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity != null)
               {
                  if(this._entities[i].IS_COLLIDING)
                  {
                     x_diff = xPos - this.oldXPos;
                     this._entities[i].entity.xPos += x_diff;
                  }
               }
            }
         }
         this.oldXPos = xPos;
      }
      
      override public function checkEntitiesCollision() : void
      {
         var entityAABB:Rectangle = null;
         var entity:Entity = null;
         var index:int = 0;
         var i:int = 0;
         var thisAABB:Rectangle = getAABB();
         if(this.IS_TICK_TOCK)
         {
            if(sprite.gfxHandleClip().frame == 2)
            {
               return;
            }
         }
         index = this.getCollisionIndex(level.hero);
         if(index < 0)
         {
            this._entities.push(new CollisionId(level.hero));
            index = this.getCollisionIndex(level.hero);
         }
         entityAABB = new Rectangle(this._entities[index].entity.xPos + this._entities[index].entity.aabbPhysics.x,this._entities[index].entity.yPos + this._entities[index].entity.aabbPhysics.y,this._entities[index].entity.aabbPhysics.width,this._entities[index].entity.aabbPhysics.height);
         if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this))
         {
            this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
            this._entities[index].entity.yVel = 0;
            this._entities[index].entity.setOnPlatform(this);
            this._entities[index].IS_COLLIDING = true;
         }
         else if(this._entities[index].IS_COLLIDING)
         {
            this._entities[index].entity.IS_ON_PLATFORM = false;
            this._entities[index].entity.colliding_platform = null;
            this._entities[index].IS_COLLIDING = false;
         }
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               index = this.getCollisionIndex(level.enemiesManager.enemies[i]);
               if(index < 0)
               {
                  this._entities.push(new CollisionId(level.enemiesManager.enemies[i]));
                  index = this.getCollisionIndex(level.enemiesManager.enemies[i]);
               }
               entityAABB = new Rectangle(this._entities[index].entity.xPos + this._entities[index].entity.aabbPhysics.x,this._entities[index].entity.yPos + this._entities[index].entity.aabbPhysics.y,this._entities[index].entity.aabbPhysics.width,this._entities[index].entity.aabbPhysics.height);
               if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this))
               {
                  this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
                  this._entities[index].entity.yVel = 0;
                  this._entities[index].entity.setOnPlatform(this);
                  this._entities[index].entity.colliding_platform = this;
                  this._entities[index].IS_COLLIDING = true;
               }
               else if(this._entities[index].IS_COLLIDING)
               {
                  this._entities[index].entity.IS_ON_PLATFORM = false;
                  this._entities[index].entity.colliding_platform = null;
                  this._entities[index].IS_COLLIDING = false;
               }
            }
         }
         for(i = 0; i < level.bulletsManager.bullets.length; i++)
         {
            if(level.bulletsManager.bullets[i] != null)
            {
               index = this.getCollisionIndex(level.bulletsManager.bullets[i]);
               if(index < 0)
               {
                  this._entities.push(new CollisionId(level.bulletsManager.bullets[i]));
                  index = this.getCollisionIndex(level.bulletsManager.bullets[i]);
               }
               entityAABB = new Rectangle(this._entities[index].entity.xPos + this._entities[index].entity.aabbPhysics.x,this._entities[index].entity.yPos + this._entities[index].entity.aabbPhysics.y,this._entities[index].entity.aabbPhysics.width,this._entities[index].entity.aabbPhysics.height);
               if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this))
               {
                  this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
                  this._entities[index].entity.yVel = 0;
                  this._entities[index].entity.setOnPlatform(this);
                  this._entities[index].entity.colliding_platform = this;
                  this._entities[index].IS_COLLIDING = true;
               }
               else if(this._entities[index].IS_COLLIDING)
               {
                  this._entities[index].entity.IS_ON_PLATFORM = false;
                  this._entities[index].entity.colliding_platform = null;
                  this._entities[index].IS_COLLIDING = false;
               }
            }
         }
         for(i = 0; i < level.itemsManager.items.length; i++)
         {
            if(level.itemsManager.items[i] != null)
            {
               index = this.getCollisionIndex(level.itemsManager.items[i]);
               if(index < 0)
               {
                  this._entities.push(new CollisionId(level.itemsManager.items[i]));
                  index = this.getCollisionIndex(level.itemsManager.items[i]);
               }
               entityAABB = new Rectangle(this._entities[index].entity.xPos + this._entities[index].entity.aabbPhysics.x,this._entities[index].entity.yPos + this._entities[index].entity.aabbPhysics.y,this._entities[index].entity.aabbPhysics.width,this._entities[index].entity.aabbPhysics.height);
               if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this))
               {
                  this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
                  this._entities[index].entity.yVel = 0;
                  this._entities[index].entity.setOnPlatform(this);
                  this._entities[index].entity.colliding_platform = this;
                  this._entities[index].IS_COLLIDING = true;
               }
               else if(this._entities[index].IS_COLLIDING)
               {
                  this._entities[index].entity.IS_ON_PLATFORM = false;
                  this._entities[index].entity.colliding_platform = null;
                  this._entities[index].IS_COLLIDING = false;
               }
            }
         }
      }
      
      protected function getCollisionIndex(entity:Entity) : int
      {
         var i:int = 0;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity == entity)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      protected function deleteEntityIndex(entity:Entity) : void
      {
         var i:int = 0;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity == entity)
               {
                  this._entities[i].destroy();
                  this._entities[i] = null;
               }
            }
         }
      }
      
      protected function waitingState() : void
      {
         counter1 = 0;
      }
      
      protected function movingState() : void
      {
         this.time_tick = 0;
         if(this.IS_HORIZONTAL)
         {
            if(this.IS_A_TO_B)
            {
               this.time_start = this.path_start_x;
               this.time_diff = this.path_end_x - this.path_start_x;
            }
            else
            {
               this.time_start = this.path_end_x;
               this.time_diff = this.path_start_x - this.path_end_x;
            }
         }
         else if(this.IS_A_TO_B)
         {
            this.time_start = this.path_start_y;
            this.time_diff = this.path_end_y - this.path_start_y;
         }
         else
         {
            this.time_start = this.path_end_y;
            this.time_diff = this.path_start_y - this.path_end_y;
         }
      }
      
      protected function stillState() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         for(i = 0; i < this.gearsData.length; i++)
         {
            this.gearsSprite[i].x = int(Math.floor(this.gearsData[i].x - camera.xPos));
            this.gearsSprite[i].y = int(Math.floor(this.gearsData[i].y - camera.yPos));
            Utils.world.setChildIndex(this.gearsSprite[i],0);
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this.IS_STILL)
         {
            this.stateMachine.setState("IS_STILL_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_WAITING_STATE");
         }
         this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B;
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         var area_enemy:Rectangle = new Rectangle(xPos,yPos,WIDTH,Utils.TILE_HEIGHT);
         this.IS_STILL = true;
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               if(level.scriptsManager.verPathScripts[i].intersects(area_enemy))
               {
                  this.IS_STILL = false;
                  this.IS_HORIZONTAL = false;
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = level.scriptsManager.verPathScripts[i].y + level.scriptsManager.verPathScripts[i].height;
                  if(Math.abs(yPos - this.path_start_y) < Math.abs(yPos - this.path_end_y))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                  }
                  this.time = int((this.path_end_y - this.path_start_y) / 32) * 0.5;
                  if(this.time < 1)
                  {
                     this.time = 1;
                  }
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               if(level.scriptsManager.horPathScripts[i].intersects(area_enemy))
               {
                  this.IS_STILL = false;
                  this.IS_HORIZONTAL = true;
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = level.scriptsManager.horPathScripts[i].x + level.scriptsManager.horPathScripts[i].width;
                  if(Math.abs(xPos + WIDTH * 0.5 - this.path_start_x) < Math.abs(xPos + WIDTH * 0.5 - this.path_end_x))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                     xPos = originalXPos = this.path_end_x;
                  }
                  this.time = int((this.path_end_x - this.path_start_x) / 32) * 0.5;
                  if(this.time < 1)
                  {
                     this.time = 1;
                  }
               }
            }
         }
      }
      
      protected function initGears() : void
      {
         var i:int = 0;
         var _length:Number = NaN;
         var _amount:int = 0;
         var sprite:PlatformGearCollisionSprite = null;
         this.gearsSprite = new Array();
         this.gearsData = new Array();
         if(this.IS_HORIZONTAL)
         {
            _length = this.path_end_x - this.path_start_x;
            _amount = int(_length / 32) + 2;
            if(this.IS_STILL)
            {
               _amount = 0;
            }
            for(i = 0; i < _amount; i++)
            {
               sprite = new PlatformGearCollisionSprite();
               Utils.world.addChild(sprite);
               this.gearsSprite.push(sprite);
               this.gearsData.push(new Point(this.path_start_x + i * 32 + 16,yPos + 4));
            }
         }
         else
         {
            _length = this.path_end_y - this.path_start_y;
            _amount = int(_length / 32) + 1;
            if(this.IS_STILL)
            {
               _amount = 0;
            }
            for(i = 0; i < _amount; i++)
            {
               sprite = new PlatformGearCollisionSprite();
               Utils.world.addChild(sprite);
               this.gearsSprite.push(sprite);
               this.gearsData.push(new Point(xPos + WIDTH * 0.5,this.path_start_y + i * 32 + 4));
            }
         }
      }
   }
}
