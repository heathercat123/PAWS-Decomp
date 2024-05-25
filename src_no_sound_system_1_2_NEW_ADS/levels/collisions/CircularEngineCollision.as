package levels.collisions
{
   import flash.geom.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import states.LevelState;
   
   public class CircularEngineCollision extends Collision
   {
       
      
      public var collisions:Array;
      
      protected var sinCounter:Number;
      
      protected var gearsSprite:Array;
      
      protected var centerGearSprite:PlatformGearCollisionSprite;
      
      protected var start_dist:Number;
      
      protected var step:Number;
      
      protected var IS_CLOCKWISE:Boolean;
      
      public function CircularEngineCollision(_level:Level, _xPos:Number, _yPos:Number, _radius:Number, _clockwise:int)
      {
         var i:int = 0;
         super(_level,_xPos,_yPos);
         RADIUS = _radius;
         if(_clockwise < 1)
         {
            this.IS_CLOCKWISE = false;
         }
         else
         {
            this.IS_CLOCKWISE = true;
         }
         sprite = null;
         this.sinCounter = 0;
         this.collisions = new Array();
         var rect:Rectangle = new Rectangle();
         var area:Rectangle = new Rectangle(_xPos - RADIUS,_yPos - RADIUS,RADIUS * 2,RADIUS * 2);
         for(i = 0; i < level.scriptsManager.greenPlatforms.length; i++)
         {
            if(level.scriptsManager.greenPlatforms[i] != null)
            {
               if(level.scriptsManager.greenPlatforms[i].name == "GreenPlatformScript")
               {
                  rect.x = level.scriptsManager.greenPlatforms[i].x;
                  rect.y = level.scriptsManager.greenPlatforms[i].y;
                  rect.width = level.scriptsManager.greenPlatforms[i].width;
                  rect.height = level.scriptsManager.greenPlatforms[i].height;
                  if(area.intersects(rect))
                  {
                     this.collisions.push(new GreenPlatformCollision(level,rect.x,rect.y,0));
                  }
               }
               else if(level.scriptsManager.greenPlatforms[i].name == "GreenPlatformScript2")
               {
                  rect.x = level.scriptsManager.greenPlatforms[i].x;
                  rect.y = level.scriptsManager.greenPlatforms[i].y;
                  rect.width = level.scriptsManager.greenPlatforms[i].width;
                  rect.height = level.scriptsManager.greenPlatforms[i].height;
                  if(area.intersects(rect))
                  {
                     this.collisions.push(new GreenPlatformCollision(level,rect.x,rect.y,1));
                  }
               }
            }
         }
         this.initGears();
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < this.gearsSprite.length; i++)
         {
            for(j = 0; j < this.gearsSprite[i].length; j++)
            {
               Utils.world.removeChild(this.gearsSprite[i][j]);
               this.gearsSprite[i][j].destroy();
               this.gearsSprite[i][j].dispose();
               this.gearsSprite[i][j] = null;
            }
            this.gearsSprite[i] = null;
         }
         this.gearsSprite = null;
         Utils.world.removeChild(this.centerGearSprite);
         this.centerGearSprite.destroy();
         this.centerGearSprite.dispose();
         this.centerGearSprite = null;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].destroy();
               this.collisions[i] = null;
            }
         }
         this.collisions = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
         var step:Number = Math.PI * 2 / this.collisions.length;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] != LevelState.LEVEL_1_5_4)
         {
            if(this.IS_CLOCKWISE)
            {
               if(RADIUS <= 40)
               {
                  this.sinCounter -= 0.01875;
               }
               else
               {
                  this.sinCounter -= 0.0125;
               }
               if(this.sinCounter <= -Math.PI * 2)
               {
                  this.sinCounter += Math.PI * 2;
               }
            }
            else
            {
               if(RADIUS <= 40)
               {
                  this.sinCounter += 0.01875;
               }
               else
               {
                  this.sinCounter += 0.0125;
               }
               if(this.sinCounter >= Math.PI * 2)
               {
                  this.sinCounter -= Math.PI * 2;
               }
            }
         }
         for(i = 0; i < this.collisions.length; i++)
         {
            this.collisions[i].xPos = Math.floor(xPos + Math.sin(this.sinCounter + step * i) * RADIUS - 32);
            this.collisions[i].yPos = Math.floor(yPos + Math.cos(this.sinCounter + step * i) * RADIUS - this.collisions[i].HEIGHT * 0.5);
            this.collisions[i].update();
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         for(i = 0; i < this.collisions.length; i++)
         {
            this.collisions[i].checkEntitiesCollision();
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var j:int = 0;
         super.updateScreenPosition(camera);
         for(i = 0; i < this.collisions.length; i++)
         {
            this.collisions[i].updateScreenPosition(camera);
         }
         var step:Number = Math.PI * 2 / this.collisions.length;
         for(i = 0; i < this.gearsSprite.length; i++)
         {
            for(j = 0; j < this.gearsSprite[i].length; j++)
            {
               this.gearsSprite[i][j].x = int(Math.floor(xPos + Math.sin(this.sinCounter + step * i) * (j * 16 + this.start_dist) - camera.xPos));
               this.gearsSprite[i][j].y = int(Math.floor(yPos + Math.cos(this.sinCounter + step * i) * (j * 16 + this.start_dist) - camera.yPos));
               Utils.world.setChildIndex(this.gearsSprite[i][j],0);
            }
         }
         this.centerGearSprite.x = int(Math.floor(xPos - camera.xPos));
         this.centerGearSprite.y = int(Math.floor(yPos - camera.yPos));
         Utils.world.setChildIndex(this.centerGearSprite,0);
      }
      
      protected function initGears() : void
      {
         var i:int = 0;
         var j:int = 0;
         var pSprite:GameSprite = null;
         this.step = Utils.TILE_WIDTH;
         var amount:int = int(RADIUS / this.step) - 1;
         var distance:Number = (amount - 1) * this.step;
         var diff:Number = RADIUS - distance;
         this.start_dist = diff * 0.5;
         this.gearsSprite = new Array();
         for(i = 0; i < this.collisions.length; i++)
         {
            this.gearsSprite.push(new Array());
            for(j = 0; j < amount; j++)
            {
               pSprite = new PlatformGearCollisionSprite();
               Utils.world.addChild(pSprite);
               this.gearsSprite[i].push(pSprite);
            }
         }
         this.centerGearSprite = new PlatformGearCollisionSprite();
         Utils.world.addChild(this.centerGearSprite);
      }
   }
}
