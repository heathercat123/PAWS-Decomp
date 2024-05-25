package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class RopeAreaCollision extends Collision
   {
       
      
      public function RopeAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         aabb.x = 4;
         aabb.y = 0;
         aabb.width = WIDTH - 8;
         aabb.height = HEIGHT;
      }
      
      override public function deactivate() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABBPhysics();
         var this_aabb:Rectangle = getAABB();
         if(hero_aabb.intersects(this_aabb))
         {
            level.hero.ropeCollision(this,this_aabb.x + this_aabb.width * 0.5,this_aabb.y,this_aabb.y + this_aabb.height);
         }
      }
   }
}
