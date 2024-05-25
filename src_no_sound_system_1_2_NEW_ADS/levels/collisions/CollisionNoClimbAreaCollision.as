package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   
   public class CollisionNoClimbAreaCollision extends Collision
   {
       
      
      protected var TYPE:int;
      
      public function CollisionNoClimbAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _TYPE:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _TYPE;
         WIDTH = _width;
         HEIGHT = _height;
         if(this.TYPE == 0)
         {
            level.levelData.setTileValueToArea(new Rectangle(xPos,yPos,WIDTH,HEIGHT),11);
         }
         else
         {
            level.levelData.setTileValueToArea(new Rectangle(xPos,yPos,WIDTH,HEIGHT),16);
         }
      }
   }
}
