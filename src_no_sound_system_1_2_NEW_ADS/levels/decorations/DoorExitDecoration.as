package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.DoorCollisionSprite;
   
   public class DoorExitDecoration extends Decoration
   {
       
      
      protected var IS_SX_EXIT:Boolean;
      
      protected var IS_OPENING:Boolean;
      
      protected var IS_CLOSING:Boolean;
      
      public function DoorExitDecoration(_level:Level, _xPos:Number, _yPos:Number, _dir:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new DoorCollisionSprite();
         Utils.world.addChild(sprite);
         if(_dir > 0)
         {
            this.IS_SX_EXIT = true;
         }
         else
         {
            this.IS_SX_EXIT = false;
         }
         this.IS_OPENING = this.IS_CLOSING = false;
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.IS_OPENING)
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.IS_OPENING = false;
               sprite.gotoAndStop(3);
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(this.IS_CLOSING)
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.IS_CLOSING = false;
               sprite.gotoAndStop(1);
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var offset_x:int = this.IS_SX_EXIT ? 31 : -31;
         var offset_y:int = -8;
         sprite.x = int(Math.floor(xPos + offset_x - camera.xPos));
         sprite.y = int(Math.floor(yPos + offset_y - camera.yPos));
         sprite.updateScreenPosition();
      }
      
      public function setOnTop() : void
      {
         Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
      }
      
      public function openDoor() : void
      {
         this.IS_OPENING = true;
         this.IS_CLOSING = false;
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      public function closeDoor() : void
      {
         this.IS_OPENING = false;
         this.IS_CLOSING = true;
         sprite.gotoAndStop(4);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
   }
}
