package entities
{
   import levels.Level;
   
   public class BrainEntity extends Entity
   {
       
      
      public function BrainEntity(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      public function leftInput() : void
      {
         if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("CHANGE_DIRECTION_ACTION");
         }
         else
         {
            stateMachine.performAction("INCREASE_VEL_ACTION");
            xVel -= speed;
         }
      }
      
      public function rightInput() : void
      {
         if(DIRECTION == LEFT)
         {
            stateMachine.performAction("CHANGE_DIRECTION_ACTION");
         }
         else
         {
            stateMachine.performAction("INCREASE_VEL_ACTION");
            xVel += speed;
         }
      }
      
      public function noInput() : void
      {
      }
   }
}
