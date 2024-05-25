package entities
{
   import levels.Level;
   import sprites.GameSprite;
   import sprites.cats.GlideCatSprite;
   
   public class GlideCatHero extends Hero
   {
       
      
      public function GlideCatHero(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
      }
      
      override protected function getHeroSprite() : GameSprite
      {
         return new GlideCatSprite();
      }
      
      override public function levelStartAnimation() : void
      {
         super.levelStartAnimation();
         SoundSystem.PlaySound("cat_glide");
      }
      
      override protected function updateAABB() : void
      {
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 17;
         if(AABB_TYPE == 1)
         {
            aabb.x = 1;
            aabb.y = -3;
            aabb.width = 14;
            aabb.height = 15;
         }
         else if(AABB_TYPE == 2)
         {
            if(DIRECTION == RIGHT)
            {
               aabb.x = -3;
               aabb.y = 1;
               aabb.width = 14;
               aabb.height = 14;
            }
            else
            {
               aabb.x = 5;
               aabb.y = 1;
               aabb.width = 14;
               aabb.height = 14;
            }
         }
      }
   }
}
