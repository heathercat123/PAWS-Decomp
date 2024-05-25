package levels.collisions
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.ExitCollisionSprite;
   
   public class FenceExitCollision extends ExitCollision
   {
       
      
      protected var ADJUST_POSITION_ASAP:Boolean;
      
      protected var IS_INVISIBLE:Boolean;
      
      protected var DIRECTION:int;
      
      public function FenceExitCollision(_level:Level, _xPos:Number, _yPos:Number, _flipped:int, _isDynamic:int = 0, _isInvisible:int = 0, _width:Number = 0, _height:Number = 0)
      {
         super(_level,_xPos,_yPos);
         sprite = new ExitCollisionSprite();
         Utils.backWorld.addChild(sprite);
         this.DIRECTION = -1;
         if(_isDynamic != 2)
         {
            if(_isDynamic > 0)
            {
               this.ADJUST_POSITION_ASAP = true;
            }
            else
            {
               this.ADJUST_POSITION_ASAP = false;
            }
         }
         if(_isInvisible > 0)
         {
            this.IS_INVISIBLE = true;
         }
         else
         {
            this.IS_INVISIBLE = false;
         }
         sprite.visible = !this.IS_INVISIBLE;
         if(_isDynamic != 2)
         {
            if(_flipped > 0)
            {
               IS_SX_EXIT = false;
               sprite.scaleX = -1;
               aabb.x = -32;
               aabb.y = 0;
               aabb.width = 32;
               aabb.height = 16;
            }
            else
            {
               IS_SX_EXIT = true;
               aabb.x = 0;
               aabb.y = 0;
               aabb.width = 32;
               aabb.height = 16;
            }
         }
         else if(_isDynamic == 2)
         {
            aabb.width = _width;
            aabb.height = _height;
            this.DIRECTION = _flipped;
         }
         initDoorId();
         EXIT_FLAG = false;
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function startOutroCutscene() : void
      {
      }
      
      override protected function exitSound() : void
      {
         var sfx_played:Boolean = false;
         if(this.DIRECTION > -1)
         {
            Utils.EXIT_DIRECTION = this.DIRECTION;
            if(Utils.EXIT_DIRECTION == 2 && level.hero.IS_IN_WATER == false)
            {
               SoundSystem.PlaySound("flyingship_falldown");
               sfx_played = true;
            }
         }
         if(!sfx_played)
         {
            SoundSystem.PlaySound("fence_exit");
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.ADJUST_POSITION_ASAP)
         {
            this.ADJUST_POSITION_ASAP = false;
            if(IS_SX_EXIT)
            {
               xPos = level.camera.xPos;
            }
            else
            {
               xPos = level.camera.xPos + level.camera.WIDTH;
            }
         }
      }
   }
}
