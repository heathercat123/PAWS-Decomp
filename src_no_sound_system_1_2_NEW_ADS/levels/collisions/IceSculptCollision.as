package levels.collisions
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class IceSculptCollision extends Collision
   {
       
      
      internal var ice_button:Button;
      
      public function IceSculptCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = null;
         this.ice_button = new Button(TextureManager.sTextureAtlas.getTexture("ice_sculpt_collision"),"",TextureManager.sTextureAtlas.getTexture("ice_sculpt_collision_pressed"));
         Image(Sprite(this.ice_button.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         Utils.backWorld.addChild(this.ice_button);
         this.ice_button.addEventListener(Event.TRIGGERED,this.iceClickHandler);
      }
      
      protected function iceClickHandler(event:Event) : void
      {
         SoundSystem.PlaySound("brick_destroyed");
         if(this.ice_button.alpha >= 0.5)
         {
            this.ice_button.alpha = 0;
         }
         else
         {
            this.ice_button.alpha = 1;
         }
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(this.ice_button);
         this.ice_button.removeEventListener(Event.TRIGGERED,this.iceClickHandler);
         this.ice_button.dispose();
         this.ice_button = null;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.ice_button.x = int(Math.floor(xPos - camera.xPos));
         this.ice_button.y = int(Math.floor(yPos - camera.yPos));
      }
   }
}
