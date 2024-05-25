package levels.collisions
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.GenericBulletSprite;
   
   public class SpawnerCollision extends Collision
   {
       
      
      public var TYPE:int;
      
      public function SpawnerCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _type:int)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         WIDTH = _width;
         HEIGHT = _height;
      }
      
      override public function postInit() : void
      {
         if(this.TYPE == 0)
         {
            level.bulletsManager.pushBullet(new GenericBulletSprite(GenericBulletSprite.BEACH_BALL),xPos,yPos,0,0,0.99);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
   }
}
