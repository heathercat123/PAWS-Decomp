package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CloudLeftSlopeAreaCollision extends Collision
   {
       
      
      public function CloudLeftSlopeAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         level.levelData.setTileValueToArea(new Rectangle(xPos,yPos,WIDTH,HEIGHT),4);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
   }
}
