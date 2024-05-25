package levels.collisions
{
   import levels.Level;
   
   public class GearCollision extends Collision
   {
       
      
      public var GEAR_ID:int;
      
      public var IS_LOCKED:Boolean;
      
      public function GearCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         this.GEAR_ID = -1;
         this.IS_LOCKED = false;
      }
      
      public function spin(_power:Number) : void
      {
      }
   }
}
