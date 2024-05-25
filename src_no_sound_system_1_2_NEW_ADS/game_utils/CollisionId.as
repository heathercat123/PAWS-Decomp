package game_utils
{
   import entities.Entity;
   
   public class CollisionId
   {
       
      
      public var entity:Entity;
      
      public var IS_COLLIDING:Boolean;
      
      public function CollisionId(_entity:Entity)
      {
         super();
         this.entity = _entity;
         this.IS_COLLIDING = false;
      }
      
      public function destroy() : void
      {
         this.entity = null;
      }
   }
}
