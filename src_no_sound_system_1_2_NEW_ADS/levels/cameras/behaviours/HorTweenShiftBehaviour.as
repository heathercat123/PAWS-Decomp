package levels.cameras.behaviours
{
   import entities.Easings;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class HorTweenShiftBehaviour extends CameraBehaviour
   {
       
      
      public var x_start:Number;
      
      public var x_end:Number;
      
      protected var x_diff:Number;
      
      public var tick:Number;
      
      public var time:Number;
      
      public var POSITION_REACHED_FLAG:Boolean;
      
      protected var TYPE:int;
      
      public var easingFunction:Function;
      
      public function HorTweenShiftBehaviour(_level:Level, _type:int = 0)
      {
         super(_level);
         this.TYPE = _type;
         this.x_start = this.x_end = this.tick = 0;
         this.time = 1;
         this.POSITION_REACHED_FLAG = false;
         if(this.TYPE == 0)
         {
            this.easingFunction = Easings.easeInOutSine;
         }
         else
         {
            this.easingFunction = Easings.linear;
         }
      }
      
      override public function destroy() : void
      {
         this.easingFunction = null;
         super.destroy();
      }
      
      override public function enterBehaviour(camera:ScreenCamera) : void
      {
         this.tick = 0;
         this.POSITION_REACHED_FLAG = false;
         this.x_diff = this.x_end - this.x_start;
      }
      
      override public function updateBehaviour(camera:ScreenCamera) : void
      {
         if(!Utils.GameOverOn)
         {
            this.tick += 1 / 60;
         }
         if(this.tick >= this.time)
         {
            this.tick = this.time;
            this.POSITION_REACHED_FLAG = true;
         }
         camera.x = this.easingFunction(this.tick,this.x_start,this.x_diff,this.time);
      }
      
      override public function exitBehaviour(camera:ScreenCamera) : void
      {
      }
   }
}
