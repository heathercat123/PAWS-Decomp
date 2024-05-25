package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class RedPlatformCollision extends Collision
   {
       
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var xxPos:Number;
      
      protected var path_start_x:int;
      
      protected var path_end_x:int;
      
      protected var path_start_y:int;
      
      protected var path_end_y:int;
      
      protected var time:Number;
      
      protected var time_tick:Number;
      
      protected var time_start:Number;
      
      protected var time_diff:Number;
      
      protected var IS_A_TO_B:Boolean;
      
      protected var ORIGINAL_IS_A_TO_B:Boolean;
      
      protected var IS_HORIZONTAL:Boolean;
      
      protected var MAX_VEL:Number;
      
      protected var gearsSprite:Array;
      
      protected var gearsData:Array;
      
      protected var xVel:Number;
      
      protected var woodGear:WoodGearCollisionSprite;
      
      protected var gearFrame:Number;
      
      protected var spriteDX:RedPlatformCollisionSprite;
      
      protected var hasSteppedRight:Boolean;
      
      protected var hasSteppedLeft:Boolean;
      
      public function RedPlatformCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = new RedPlatformCollisionSprite();
         Utils.world.addChild(sprite);
         this.spriteDX = new RedPlatformCollisionSprite();
         Utils.world.addChild(this.spriteDX);
         this.spriteDX.scaleX = -1;
         this.woodGear = new WoodGearCollisionSprite();
         Utils.topWorld.addChild(this.woodGear);
         sprite.gfxHandleClip().gotoAndStop(1);
         this.spriteDX.gfxHandleClip().gotoAndStop(1);
         this.gearFrame = 0;
         WIDTH = 64;
         HEIGHT = 8;
         this.ORIGINAL_IS_A_TO_B = this.IS_A_TO_B = true;
         this.xxPos = xPos;
         this.hasSteppedRight = this.hasSteppedLeft = false;
         aabb.x = 0 - 4;
         aabb.y = -2;
         aabb.width = 64 + 8;
         aabb.height = 12;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.time = 0;
         this.time_tick = 0;
         this.xVel = 0;
         this.MAX_VEL = 1.5;
         this.fetchScripts();
         this.initGears();
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
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
         Utils.world.removeChild(this.woodGear);
         this.woodGear.destroy();
         this.woodGear.dispose();
         this.woodGear = null;
         Utils.world.removeChild(sprite);
         this.entity = null;
         Utils.world.removeChild(this.spriteDX);
         this.spriteDX.destroy();
         this.spriteDX.dispose();
         this.spriteDX = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var mid_x:Number = NaN;
         var x_diff:Number = NaN;
         super.update();
         if(this.entity != null)
         {
            mid_x = level.hero.xPos + level.hero.WIDTH * 0.5;
            if(mid_x >= xPos + 32)
            {
               this.xVel += 0.05;
               if(!this.hasSteppedRight)
               {
                  this.hasSteppedRight = true;
                  this.hasSteppedLeft = false;
                  this.spriteDX.gfxHandleClip().gotoAndPlay(1);
                  sprite.gfxHandleClip().gotoAndStop(1);
               }
            }
            else
            {
               this.xVel -= 0.05;
               if(!this.hasSteppedLeft)
               {
                  this.hasSteppedLeft = true;
                  this.hasSteppedRight = false;
                  this.spriteDX.gfxHandleClip().gotoAndStop(1);
                  sprite.gfxHandleClip().gotoAndPlay(1);
               }
            }
         }
         else
         {
            this.hasSteppedLeft = false;
            this.hasSteppedRight = false;
            this.spriteDX.gfxHandleClip().gotoAndStop(1);
            sprite.gfxHandleClip().gotoAndStop(1);
         }
         this.xVel *= 0.99;
         this.xxPos += this.xVel;
         if(Math.abs(this.xVel) < 0.01)
         {
            this.xVel = 0;
         }
         xPos = int(this.xxPos);
         if(this.xVel >= this.MAX_VEL)
         {
            this.xVel = this.MAX_VEL;
         }
         else if(this.xVel <= -this.MAX_VEL)
         {
            this.xVel = -this.MAX_VEL;
         }
         if(xPos < this.path_start_x)
         {
            xPos = this.xxPos = this.path_start_x;
            this.xVel = 0;
         }
         else if(xPos >= this.path_end_x)
         {
            xPos = this.xxPos = this.path_end_x;
            this.xVel = 0;
         }
         var last_gear_frame:int = this.gearFrame;
         this.gearFrame += this.xVel * 0.2;
         if(last_gear_frame != int(this.gearFrame))
         {
            if(isInsideScreen())
            {
               SoundSystem.PlaySound("red_platform");
            }
         }
         if(this.gearFrame > 3)
         {
            this.gearFrame -= 3;
         }
         else if(this.gearFrame < 0)
         {
            this.gearFrame += 3;
         }
         if(this.entity != null)
         {
            x_diff = xPos - this.oldXPos;
            this.entity.xPos += x_diff;
         }
         this.oldXPos = xPos;
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(heroAABB.intersects(thisAABB) && level.hero.yPos + 13 < yPos && level.hero.yVel >= 0)
         {
            level.hero.setOnPlatform(this);
            level.hero.yPos = yPos - level.hero.HEIGHT;
            level.hero.yVel = 0;
            this.entity = level.hero;
         }
         else if(this.entity != null)
         {
            this.entity = null;
            level.hero.IS_ON_PLATFORM = false;
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
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         this.spriteDX.x = sprite.x + WIDTH;
         this.spriteDX.y = sprite.y;
         this.woodGear.x = int(Math.floor(xPos + 32 - camera.xPos));
         this.woodGear.y = int(Math.floor(yPos + 4 - camera.yPos));
         this.woodGear.gfxHandleClip().gotoAndStop(this.gearFrame + 1);
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
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         var area_enemy:Rectangle = new Rectangle(xPos,yPos,WIDTH,Utils.TILE_HEIGHT);
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               area.x = level.scriptsManager.verPathScripts[i].x;
               area.y = level.scriptsManager.verPathScripts[i].y;
               area.width = level.scriptsManager.verPathScripts[i].width;
               area.height = level.scriptsManager.verPathScripts[i].height;
               if(area.intersects(area_enemy))
               {
                  this.IS_HORIZONTAL = false;
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = area.y + level.scriptsManager.verPathScripts[i].height;
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
               area.x = level.scriptsManager.horPathScripts[i].x;
               area.y = level.scriptsManager.horPathScripts[i].y;
               area.width = level.scriptsManager.horPathScripts[i].width;
               area.height = level.scriptsManager.horPathScripts[i].height;
               if(area.intersects(area_enemy))
               {
                  this.IS_HORIZONTAL = true;
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = area.x + level.scriptsManager.horPathScripts[i].width;
                  if(Math.abs(xPos + WIDTH * 0.5 - this.path_start_x) < Math.abs(xPos + WIDTH * 0.5 - this.path_end_x))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
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
