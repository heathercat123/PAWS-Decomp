package levels.collisions
{
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.FireBallCollisionSprite;
   import sprites.collisions.FireBrickCollisionSprite;
   import sprites.tutorials.*;
   
   public class FireCircleCollision extends Collision
   {
       
      
      protected var TYPE:int;
      
      protected var fireBallSprites:Array;
      
      protected var fireBallData:Array;
      
      protected var angle:Number;
      
      protected var animation_counter:Number;
      
      protected var IS_CLOCKWISE:Boolean;
      
      public function FireCircleCollision(_level:Level, _xPos:Number, _yPos:Number, _clockwise:int, _type:int = 0, __width:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         if(this.TYPE == 0)
         {
            sprite = new FireBrickCollisionSprite(1);
         }
         else
         {
            sprite = new FireBrickCollisionSprite(2);
         }
         sprite.gfxHandleClip().gotoAndStop(1);
         if(this.TYPE == 0)
         {
            Utils.topWorld.addChild(sprite);
         }
         else
         {
            Utils.world.addChild(sprite);
         }
         if(_clockwise == 0)
         {
            this.IS_CLOCKWISE = true;
         }
         else
         {
            this.IS_CLOCKWISE = false;
         }
         aabb.x = xPos - 8;
         aabb.y = yPos - 8;
         aabb.width = aabb.height = 16;
         RADIUS = 0;
         this.angle = 0;
         this.animation_counter = 120;
         if(this.TYPE == 0)
         {
            this.fetchRadius();
            this.initFireballs();
         }
         else if(this.TYPE == 2)
         {
            this.fireBallSprites = null;
            this.fireBallData = null;
         }
         else
         {
            RADIUS = __width - 32;
            this.fetchRadius();
            this.initFireballs();
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.TYPE == 0)
         {
            Utils.topWorld.removeChild(sprite);
         }
         else
         {
            Utils.world.removeChild(sprite);
         }
         if(this.fireBallData != null)
         {
            for(i = 0; i < this.fireBallSprites.length; i++)
            {
               Utils.world.removeChild(this.fireBallSprites[i]);
               this.fireBallSprites[i].destroy();
               this.fireBallSprites[i].dispose();
               this.fireBallSprites[i] = null;
               this.fireBallData[i] = null;
            }
            this.fireBallSprites = null;
            this.fireBallData = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         if(this.TYPE != 2)
         {
            if(this.IS_CLOCKWISE)
            {
               this.angle -= 0.025;
               if(this.angle <= 0)
               {
                  this.angle += Math.PI * 2;
               }
            }
            else
            {
               this.angle += 0.025;
               if(this.angle >= Math.PI * 2)
               {
                  this.angle -= Math.PI * 2;
               }
            }
            for(i = 0; i < this.fireBallData.length; i++)
            {
               this.fireBallData[i].x = originalXPos + Math.sin(this.angle) * (i * 10 + 14);
               this.fireBallData[i].y = originalYPos + Math.cos(this.angle) * (i * 10 + 14);
               --this.fireBallData[i].width;
               if(this.fireBallData[i].width <= 0)
               {
                  this.fireBallData[i].width = 60 + this.fireBallData.length * 5;
                  this.fireBallSprites[i].gfxHandleClip().gotoAndPlay(1);
               }
            }
            if(this.TYPE == 1)
            {
               xPos = originalXPos + Math.sin(this.angle) * RADIUS;
               yPos = originalYPos + Math.cos(this.angle) * RADIUS;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         if(this.TYPE == 0 || this.TYPE == 1)
         {
            for(i = 0; i < this.fireBallData.length; i++)
            {
               this.fireBallSprites[i].x = int(Math.floor(this.fireBallData[i].x - camera.xPos));
               this.fireBallSprites[i].y = int(Math.floor(this.fireBallData[i].y - camera.yPos));
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         var heroAABB:Rectangle = level.hero.getAABB();
         var fireAABB:Rectangle = new Rectangle();
         if(this.TYPE == 0)
         {
            for(i = 1; i < this.fireBallData.length; i++)
            {
               fireAABB.x = this.fireBallData[i].x - 4;
               fireAABB.y = this.fireBallData[i].y - 4;
               fireAABB.width = 8;
               fireAABB.height = 8;
               if(heroAABB.intersects(fireAABB))
               {
                  level.hero.hurt(fireAABB.x + 4,fireAABB.y + 4,null);
               }
            }
         }
         else
         {
            fireAABB.x = xPos - 6.5;
            fireAABB.y = yPos - 6.5;
            fireAABB.width = fireAABB.height = 13;
            if(heroAABB.intersects(fireAABB))
            {
               level.hero.hurt(fireAABB.x + 6.5,fireAABB.y + 6.5,null);
            }
         }
      }
      
      protected function fetchRadius() : void
      {
         var i:int = 0;
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var rect:Rectangle = new Rectangle();
         if(this.TYPE == 0)
         {
            for(i = 0; i < level.scriptsManager.circularRayScripts.length; i++)
            {
               if(level.scriptsManager.circularRayScripts[i] != null)
               {
                  rect.x = level.scriptsManager.circularRayScripts[i].x - level.scriptsManager.circularRayScripts[i].width * 0.5;
                  rect.y = level.scriptsManager.circularRayScripts[i].y - level.scriptsManager.circularRayScripts[i].height * 0.5;
                  rect.width = level.scriptsManager.circularRayScripts[i].width;
                  rect.height = level.scriptsManager.circularRayScripts[i].height;
                  if(aabb.intersects(rect))
                  {
                     RADIUS = rect.width * 0.5;
                  }
               }
            }
         }
         var point_:Point = new Point();
         for(i = 0; i < level.scriptsManager.levelNumberAreas.length; i++)
         {
            if(level.scriptsManager.levelNumberAreas[i] != null)
            {
               if(level.scriptsManager.levelNumberAreas[i].width == 1)
               {
                  rect.x = xPos - RADIUS;
                  rect.y = yPos - RADIUS;
                  rect.width = RADIUS * 2;
                  rect.height = RADIUS * 2;
                  point_.x = level.scriptsManager.levelNumberAreas[i].x;
                  point_.y = level.scriptsManager.levelNumberAreas[i].y;
                  if(rect.containsPoint(point_))
                  {
                     x_diff = Math.abs(xPos - point_.x);
                     y_diff = Math.abs(yPos - point_.y);
                     if(x_diff > y_diff)
                     {
                        if(point_.x > xPos)
                        {
                           this.angle = Math.PI * 0.5;
                        }
                        else
                        {
                           this.angle = Math.PI * 1.5;
                        }
                     }
                     else if(point_.y > yPos)
                     {
                        this.angle = 0;
                     }
                     else
                     {
                        this.angle = Math.PI;
                     }
                  }
               }
            }
         }
      }
      
      protected function initFireballs() : void
      {
         var i:int = 0;
         var pSprite:FireBallCollisionSprite = null;
         var amount:int = int(RADIUS / 10 + 0);
         if(amount <= 0)
         {
            amount = 1;
         }
         this.fireBallSprites = new Array();
         this.fireBallData = new Array();
         for(i = 0; i < amount; i++)
         {
            if(this.TYPE == 0)
            {
               pSprite = new FireBallCollisionSprite();
            }
            else
            {
               pSprite = new FireBallCollisionSprite(1);
            }
            Utils.world.addChild(pSprite);
            this.fireBallSprites.push(pSprite);
            this.fireBallData.push(new Rectangle(0,0,60 + i * 5,0));
         }
         if(this.TYPE == 1)
         {
            Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
         }
      }
   }
}
