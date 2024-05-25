package interfaces.dialogs.balloons
{
   import game_utils.StateMachine;
   import interfaces.dialogs.Dialog;
   import starling.display.Sprite;
   
   public class Balloon extends Sprite
   {
       
      
      public var dialog:Dialog;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var stateMachine:StateMachine;
      
      public function Balloon(_dialog:Dialog, _width:int, _height:int)
      {
         super();
         this.dialog = _dialog;
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","START_ACTION","IS_ENTERING_STATE");
         this.stateMachine.setRule("IS_ENTERING_STATE","END_ACTION","IS_STAYING_STATE");
         this.stateMachine.setRule("IS_STAYING_STATE","EXIT_ACTION","IS_EXITING_STATE");
         this.stateMachine.setRule("IS_EXITING_STATE","END_ACTION","IS_OVER_STATE");
         this.stateMachine.setRule("IS_WAITING_STATE","EXIT_ACTION","IS_EXITING_STATE");
         this.stateMachine.setRule("IS_ENTERING_STATE","EXIT_ACTION","IS_EXITING_STATE");
         this.stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingState);
         this.stateMachine.setFunctionToState("IS_ENTERING_STATE",this.enteringState);
         this.stateMachine.setFunctionToState("IS_STAYING_STATE",this.stayingState);
         this.stateMachine.setFunctionToState("IS_EXITING_STATE",this.exitingState);
         this.stateMachine.setFunctionToState("IS_OVER_STATE",this.overState);
         this.stateMachine.setState("IS_WAITING_STATE");
      }
      
      public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.dialog = null;
      }
      
      public function update() : void
      {
      }
      
      protected function waitingState() : void
      {
      }
      
      protected function enteringState() : void
      {
      }
      
      protected function stayingState() : void
      {
      }
      
      protected function exitingState() : void
      {
      }
      
      protected function overState() : void
      {
      }
      
      public function fadeIn() : void
      {
         this.stateMachine.performAction("START_ACTION");
      }
      
      public function fadeOut() : void
      {
         this.stateMachine.performAction("EXIT_ACTION");
      }
      
      public function setOffset(amount:int) : void
      {
      }
   }
}
