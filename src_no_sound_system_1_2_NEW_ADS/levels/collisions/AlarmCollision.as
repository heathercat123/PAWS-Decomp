package levels.collisions
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.AlarmCollisionSprite;
   import starling.display.Image;
   
   public class AlarmCollision extends Collision
   {
       
      
      protected var IS_ON:Boolean;
      
      protected var light_image:Image;
      
      protected var light_image_sin:Number;
      
      public function AlarmCollision(_level:Level, _xPos:Number, _yPos:Number, _value:int = 0)
      {
         super(_level,_xPos,_yPos);
         WIDTH = HEIGHT = 16;
         this.IS_ON = false;
         sprite = new AlarmCollisionSprite();
         Utils.world.addChild(sprite);
         sprite.gfxHandleClip().gotoAndStop(1);
         this.light_image = new Image(TextureManager.sTextureAtlas.getTexture("alarmRedLight"));
         this.light_image.touchable = false;
         this.light_image.pivotX = int(this.light_image.width * 0.5);
         this.light_image.pivotY = 1;
         Utils.world.addChild(this.light_image);
         this.light_image.visible = false;
         this.light_image_sin = 0;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         Utils.world.removeChild(this.light_image);
         this.light_image.dispose();
         this.light_image = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.IS_ON)
         {
            if(counter1++ >= 1)
            {
               counter1 = 0;
               this.light_image.visible = !this.light_image.visible;
            }
            this.light_image_sin += 0.125;
            if(this.light_image_sin >= Math.PI * 2)
            {
               this.light_image_sin -= Math.PI * 2;
            }
         }
      }
      
      public function setOn(value:Boolean) : void
      {
         this.IS_ON = value;
         if(this.IS_ON)
         {
            sprite.gfxHandleClip().gotoAndPlay(1);
            this.light_image.visible = true;
            this.light_image_sin = Math.random() * Math.PI * 2;
            counter1 = counter2 = 0;
         }
         else
         {
            sprite.gfxHandleClip().gotoAndStop(1);
            this.light_image.visible = false;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.light_image.x = sprite.x + 8 + int(Math.sin(this.light_image_sin) * 20);
         this.light_image.y = sprite.y;
         if(this.light_image_sin >= Math.PI * 0.5 && this.light_image_sin < Math.PI * 1.5)
         {
            Utils.world.setChildIndex(this.light_image,Utils.world.getChildIndex(sprite) - 1);
         }
         else
         {
            Utils.world.setChildIndex(this.light_image,Utils.world.getChildIndex(sprite) + 1);
         }
      }
   }
}
