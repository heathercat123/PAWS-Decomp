package levels.collisions
{
   import entities.bullets.Bullet;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   
   public class Collision
   {
       
      
      public var level:Level;
      
      public var sprite:GameSprite;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var originalXPos:Number;
      
      public var originalYPos:Number;
      
      public var WIDTH:Number;
      
      public var HEIGHT:Number;
      
      public var RADIUS:Number;
      
      public var aabb:Rectangle;
      
      public var dead:Boolean;
      
      public var active:Boolean;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      public var yValue:Number;
      
      public var IS_MELTING:Boolean;
      
      public var COLLISION_ID:int;
      
      public function Collision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super();
         this.level = _level;
         this.xPos = this.originalXPos = _xPos;
         this.yPos = this.originalYPos = _yPos;
         this.WIDTH = this.HEIGHT = this.RADIUS = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.yValue = 0;
         this.sprite = null;
         this.active = true;
         this.dead = false;
         this.aabb = new Rectangle();
         this.IS_MELTING = false;
         this.COLLISION_ID = -1;
      }
      
      public function destroy() : void
      {
         if(this.sprite != null)
         {
            this.sprite.destroy();
            this.sprite.dispose();
            this.sprite = null;
         }
         this.aabb = null;
         this.level = null;
      }
      
      public function update() : void
      {
      }
      
      public function isBulletCollision(bullet:Bullet) : Boolean
      {
         return false;
      }
      
      public function bulletCollision(bullet:Bullet) : void
      {
      }
      
      public function activate() : void
      {
         this.active = true;
      }
      
      public function deactivate() : void
      {
         this.active = false;
      }
      
      public function checkEntitiesCollision() : void
      {
      }
      
      public function checkPostUpdateEntitiesCollision() : void
      {
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.sprite != null)
         {
            this.sprite.x = int(Math.floor(this.xPos - camera.xPos));
            this.sprite.y = int(Math.floor(this.yPos - camera.yPos));
            this.sprite.updateScreenPosition();
         }
      }
      
      public function postInit() : void
      {
      }
      
      public function shake() : void
      {
      }
      
      public function getMidXPos() : Number
      {
         return this.xPos + this.WIDTH * 0.5;
      }
      
      public function getMidYPos() : Number
      {
         return this.yPos + this.HEIGHT * 0.5;
      }
      
      public function getTileValue() : int
      {
         return -1;
      }
      
      public function getAABB() : Rectangle
      {
         return new Rectangle(this.xPos + this.aabb.x,this.yPos + this.aabb.y,this.aabb.width,this.aabb.height);
      }
      
      public function reset() : void
      {
         this.xPos = this.originalXPos;
         this.yPos = this.originalYPos;
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
      
      public function isInsideInnerScreen(offset:int = 16) : Boolean
      {
         var area:Rectangle = new Rectangle(this.xPos,this.yPos,this.WIDTH,this.HEIGHT);
         var camera:Rectangle = new Rectangle(this.level.camera.xPos + offset,this.level.camera.yPos + offset,this.level.camera.WIDTH - offset * 2,this.level.camera.HEIGHT - offset * 2);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
   }
}
