package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   
   public class IceAreaCollision extends Collision
   {
       
      
      public function IceAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, ice_type:int = 0)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         Utils.ICE_TYPE = ice_type;
         level.levelData.setTileValueToArea(new Rectangle(xPos,yPos,WIDTH,HEIGHT),13);
      }
   }
}
