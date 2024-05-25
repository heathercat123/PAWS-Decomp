package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   
   public class CollisionAreaCollision extends Collision
   {
       
      
      public function CollisionAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         level.levelData.setTileValueToArea(new Rectangle(xPos,yPos,WIDTH,HEIGHT),1);
      }
   }
}
