package levels.cameras.behaviours
{
   import entities.Easings;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class VerTweenShiftBehaviour extends CameraBehaviour
   {
       
      
      public var y_start:Number;
      
      public var y_end:Number;
      
      protected var y_diff:Number;
      
      public var tick:Number;
      
      public var time:Number;
      
      public var POSITION_REACHED_FLAG:Boolean;
      
      public function VerTweenShiftBehaviour(_level:Level)
      {
         super(_level);
         this.y_start = this.y_end = this.tick = 0;
         this.time = 1;
         this.POSITION_REACHED_FLAG = false;
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.tick = 0;
         this.POSITION_REACHED_FLAG = false;
         this.y_diff = this.y_end - this.y_start;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         this.tick += 1 / 60;
         if(this.tick >= this.time)
         {
            this.tick = this.time;
            this.POSITION_REACHED_FLAG = true;
         }
         camera.y = Easings.easeInOutSine(this.tick,this.y_start,this.y_diff,this.time);
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
