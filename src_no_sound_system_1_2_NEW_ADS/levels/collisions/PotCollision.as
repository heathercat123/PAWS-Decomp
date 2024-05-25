package levels.collisions
{
   import levels.Level;
   import sprites.collisions.PotCollisionSprite;
   
   public class PotCollision extends Collision
   {
       
      
      public function PotCollision(_level:Level, _xPos:Number, _yPos:Number, _value:int = 0)
      {
         super(_level,_xPos,_yPos);
         sprite = new PotCollisionSprite();
         Utils.topWorld.addChild(sprite);
         aabb.x = aabb.y = 0;
         aabb.width = 32;
         aabb.height = 24;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function checkEntitiesCollision() : void
      {
      }
   }
}
