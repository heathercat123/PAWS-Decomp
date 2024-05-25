package entities
{
   import entities.fishing.BaseFish;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.fishing.LureSprite;
   
   public class Lure extends Entity
   {
       
      
      protected var IS_REELING:Boolean;
      
      protected var IS_FIGHTING:Boolean;
      
      public var sxArrow:LureSprite;
      
      public var dxArrow:LureSprite;
      
      protected var ARROWS_OFFSET:Number;
      
      protected var disappear_counter_1:int;
      
      public function Lure(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
         sprite = new LureSprite(0);
         Utils.world.addChild(sprite);
         sprite.visible = false;
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.sxArrow = new LureSprite(1);
         this.dxArrow = new LureSprite(1);
         this.dxArrow.scaleX = -1;
         Utils.world.addChild(this.sxArrow);
         Utils.world.addChild(this.dxArrow);
         this.sxArrow.visible = false;
         this.dxArrow.visible = false;
         WIDTH = HEIGHT = 16;
         this.IS_REELING = false;
         this.IS_FIGHTING = false;
         this.ARROWS_OFFSET = 16;
         this.disappear_counter_1 = 0;
         aabb = new Rectangle(-3,-3,6,6);
         aabbPhysics.x = aabbPhysics.y = -2;
         aabbPhysics.width = aabbPhysics.height = 4;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.sxArrow);
         Utils.world.removeChild(this.dxArrow);
         this.sxArrow.destroy();
         this.dxArrow.destroy();
         this.sxArrow.dispose();
         this.dxArrow.dispose();
         this.sxArrow = null;
         this.dxArrow = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.IS_REELING)
         {
            gravity_friction = 0.01;
            MAX_Y_VEL = 0.8;
            this.integratePositionAndCollisionDetection();
            if(yPos <= Utils.SEA_LEVEL + 8)
            {
               yPos = Utils.SEA_LEVEL + 8;
            }
         }
         else if(this.IS_FIGHTING)
         {
            gravity_friction = 0;
            yVel = 0;
            this.integratePositionAndCollisionDetection();
            if(yPos <= Utils.SEA_LEVEL + 8)
            {
               yPos = Utils.SEA_LEVEL + 8;
            }
         }
      }
      
      public function fightingDirectionAboutToChange() : void
      {
         ++this.disappear_counter_1;
         if(this.disappear_counter_1 < 4)
         {
            this.sxArrow.visible = this.dxArrow.visible = false;
         }
         else if(this.disappear_counter_1 >= 8)
         {
            this.disappear_counter_1 = 0;
         }
      }
      
      public function reset() : void
      {
         this.disappear_counter_1 = 0;
         this.IS_REELING = false;
         this.IS_FIGHTING = false;
         sprite.visible = false;
         this.sxArrow.visible = this.dxArrow.visible = false;
      }
      
      public function setReeling() : void
      {
         this.IS_REELING = true;
         this.IS_FIGHTING = false;
         sprite.visible = true;
         this.sxArrow.visible = this.dxArrow.visible = false;
      }
      
      public function setFighting() : void
      {
         this.IS_REELING = false;
         this.IS_FIGHTING = true;
         sprite.visible = false;
         this.sxArrow.visible = this.dxArrow.visible = false;
         xVel = yVel = 0;
      }
      
      public function setCaught() : void
      {
         this.IS_REELING = false;
         this.IS_FIGHTING = false;
         sprite.visible = false;
         this.sxArrow.visible = this.dxArrow.visible = false;
         xVel = yVel = 0;
      }
      
      protected function integratePositionAndCollisionDetection() : void
      {
         yVel += 0.4 * gravity_friction;
         xVel *= x_friction;
         if(xVel >= MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel <= -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel >= MAX_Y_VEL)
         {
            yVel = MAX_Y_VEL;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         this.sxArrow.x = sprite.x - this.ARROWS_OFFSET;
         this.dxArrow.x = sprite.x + this.ARROWS_OFFSET;
         this.sxArrow.y = this.dxArrow.y = sprite.y;
         sprite.updateScreenPosition();
      }
      
      public function setAABBPhysics(_fish:BaseFish) : void
      {
         if(_fish == null)
         {
            aabbPhysics.x = aabbPhysics.y = -2;
            aabbPhysics.width = aabbPhysics.height = 4;
         }
         else
         {
            aabbPhysics.x = _fish.aabbPhysics.x;
            aabbPhysics.y = _fish.aabbPhysics.y;
            aabbPhysics.width = _fish.aabbPhysics.width;
            aabbPhysics.height = _fish.aabbPhysics.height;
         }
      }
   }
}
