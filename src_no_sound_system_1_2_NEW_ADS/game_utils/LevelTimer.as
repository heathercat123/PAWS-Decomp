package game_utils
{
   public class LevelTimer
   {
      
      private static var _instance:LevelTimer = null;
       
      
      private var stateMachine:StateMachine;
      
      public function LevelTimer()
      {
         super();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","START_ACTION","IS_RUNNING_STATE");
         this.stateMachine.setRule("IS_RUNNING_STATE","PAUSE_ACTION","IS_PAUSED_STATE");
         this.stateMachine.setRule("IS_PAUSED_STATE","END_ACTION","IS_RUNNING_STATE");
         this.stateMachine.setRule("IS_PAUSED_STATE","STOP_ACTION","IS_STOPPED_STATE");
         this.stateMachine.setRule("IS_RUNNING_STATE","STOP_ACTION","IS_STOPPED_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offState);
         this.stateMachine.setFunctionToState("IS_RUNNING_STATE",this.runningState);
         this.stateMachine.setFunctionToState("IS_PAUSED_STATE",this.pausedState);
         this.stateMachine.setFunctionToState("IS_STOPPED_STATE",this.stoppedState);
         this.stateMachine.setState("IS_OFF_STATE");
      }
      
      public static function getInstance() : LevelTimer
      {
         if(_instance == null)
         {
            _instance = new LevelTimer();
         }
         return _instance;
      }
      
      public function resetTimer() : void
      {
         this.stateMachine.setState("IS_OFF_STATE");
      }
      
      public function startTimer() : void
      {
         if(this.stateMachine.currentState == "IS_OFF_STATE")
         {
            Utils.StartTimer();
         }
         this.stateMachine.performAction("START_ACTION");
      }
      
      public function stopTimer() : void
      {
         if(this.stateMachine.currentState == "IS_RUNNING_STATE" || this.stateMachine.currentState == "IS_PAUSED_STATE")
         {
            Utils.StopTimer();
         }
         this.stateMachine.performAction("STOP_ACTION");
      }
      
      public function startPause() : void
      {
         if(this.stateMachine.currentState == "IS_RUNNING_STATE")
         {
            Utils.StartPause();
         }
         this.stateMachine.performAction("PAUSE_ACTION");
      }
      
      public function endPause() : void
      {
         if(this.stateMachine.currentState == "IS_PAUSED_STATE")
         {
            Utils.EndPause();
         }
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function offState() : void
      {
      }
      
      protected function runningState() : void
      {
      }
      
      protected function pausedState() : void
      {
      }
      
      protected function stoppedState() : void
      {
      }
   }
}
