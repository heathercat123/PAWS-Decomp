package interfaces.panels
{
   import game_utils.StateMachine;
   import levels.cameras.ScreenCamera;
   import starling.display.Sprite;
   
   public class LightSource extends Sprite
   {
       
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      protected var stateMachine:StateMachine;
      
      protected var radius:Number;
      
      protected var speed:Number;
      
      public var IS_SPINNING:Boolean;
      
      public function LightSource(_xPos:Number, _yPos:Number, _radius:Number)
      {
         super();
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.radius = _radius;
         this.speed = 0;
         this.IS_SPINNING = false;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","ON_ACTION","IS_GROWING_STATE");
         this.stateMachine.setRule("IS_GROWING_STATE","END_ACTION","IS_SPINNING_STATE");
         this.stateMachine.setRule("IS_SPINNING_STATE","OFF_ACTION","IS_VANISHING_STATE");
         this.stateMachine.setRule("IS_VANISHING_STATE","END_ACTION","IS_OFF_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offState);
         this.stateMachine.setFunctionToState("IS_GROWING_STATE",this.growState);
         this.stateMachine.setFunctionToState("IS_SPINNING_STATE",this.spinState);
         this.stateMachine.setFunctionToState("IS_VANISHING_STATE",this.vanishState);
         this.stateMachine.setState("IS_OFF_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var j:int = 0;
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         x = int(Math.floor(this.xPos - camera.xPos));
         y = int(Math.floor(this.yPos - camera.yPos));
      }
      
      protected function offState() : void
      {
         visible = false;
      }
      
      protected function growState() : void
      {
         var i:int = 0;
         visible = true;
      }
      
      protected function spinState() : void
      {
         var i:int = 0;
         this.IS_SPINNING = true;
         visible = true;
      }
      
      protected function vanishState() : void
      {
         var i:int = 0;
      }
      
      private function initRaylights() : void
      {
      }
      
      public function start() : void
      {
         this.stateMachine.performAction("ON_ACTION");
      }
      
      public function end() : void
      {
         this.stateMachine.performAction("OFF_ACTION");
      }
   }
}
