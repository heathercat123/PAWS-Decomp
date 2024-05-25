package levels.collisions
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CloudRightIceSlopeWideAreaCollision extends Collision
   {
       
      
      public function CloudRightIceSlopeWideAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         var i:* = undefined;
         var j:int = 0;
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         var x_t:int = int(_xPos / Utils.TILE_WIDTH);
         var hor_steps:int = int(_width / Utils.TILE_WIDTH);
         var y_t:int = int(_yPos / Utils.TILE_HEIGHT);
         var ver_steps:int = int(_height / Utils.TILE_HEIGHT);
         for(i = 0; i < ver_steps; i++)
         {
            for(j = 0; j < hor_steps; j++)
            {
               if(j == 0)
               {
                  level.levelData.setTileValueAt(x_t + j,y_t + i,8);
                  level.levelData.setTypeTileValueAt(x_t + j,y_t + i,1);
               }
               else
               {
                  level.levelData.setTileValueAt(x_t + j,y_t + i,9);
                  level.levelData.setTypeTileValueAt(x_t + j,y_t + i,1);
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
   }
}
