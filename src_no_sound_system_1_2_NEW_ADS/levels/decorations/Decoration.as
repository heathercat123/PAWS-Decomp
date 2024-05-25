package levels.decorations
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   
   public class Decoration
   {
       
      
      public var level:Level;
      
      public var sprite:GameSprite;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var originalXPos:Number;
      
      public var originalYPos:Number;
      
      public var WIDTH:Number;
      
      public var HEIGHT:Number;
      
      public var dead:Boolean;
      
      public var level_index:int;
      
      public function Decoration(_level:Level, _xPos:Number, _yPos:Number)
      {
         super();
         this.level = _level;
         this.sprite = null;
         this.xPos = this.originalXPos = _xPos;
         this.yPos = this.originalYPos = _yPos;
         this.WIDTH = this.HEIGHT = 0;
         this.level_index = -1;
         this.dead = false;
      }
      
      public function destroy() : void
      {
         this.sprite.destroy();
         this.sprite.dispose();
         this.sprite = null;
         this.level = null;
      }
      
      public function update() : void
      {
      }
      
      public function shake() : void
      {
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.sprite.x = int(Math.floor(this.xPos - camera.xPos));
         this.sprite.y = int(Math.floor(this.yPos - camera.yPos));
         this.sprite.updateScreenPosition();
      }
      
      public function onTop() : void
      {
      }
      
      public function isInsideScreen() : Boolean
      {
         var area:Rectangle = new Rectangle(this.xPos,this.yPos,this.WIDTH,this.HEIGHT);
         var camera:Rectangle = new Rectangle(this.level.camera.xPos - 48,this.level.camera.yPos - 48,this.level.camera.WIDTH + 96,this.level.camera.HEIGHT + 96);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
      
      public function isOutsideScreen() : Boolean
      {
         var area:Rectangle = new Rectangle(this.xPos,this.yPos,this.WIDTH,this.HEIGHT);
         var camera:Rectangle = this.level.camera.getCameraOuterRect();
         if(area.intersects(camera))
         {
            return false;
         }
         return true;
      }
   }
}
