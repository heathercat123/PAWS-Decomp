package levels.cutscenes
{
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class Cutscene
   {
       
      
      public var level:Level;
      
      public var dead:Boolean;
      
      public var IS_OVER:Boolean;
      
      public var IS_BLACK_BANDS:Boolean;
      
      public var stateMachine:StateMachine;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var PROGRESSION:int;
      
      public function Cutscene(_level:Level)
      {
         super();
         this.level = _level;
         this.dead = this.IS_OVER = false;
         this.IS_BLACK_BANDS = true;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_INIT_STATE","START_ACTION","IS_EXECUTING_STATE");
         this.stateMachine.setRule("IS_EXECUTING_STATE","END_ACTION","IS_OVER_STATE");
         this.stateMachine.setFunctionToState("IS_INIT_STATE",this.initState);
         this.stateMachine.setFunctionToState("IS_EXECUTING_STATE",this.execState);
         this.stateMachine.setFunctionToState("IS_OVER_STATE",this.overState);
         this.stateMachine.setState("IS_INIT_STATE");
      }
      
      public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.level = null;
      }
      
      public function update() : void
      {
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
      
      public function postUpdate() : void
      {
      }
      
      protected function initState() : void
      {
         this.counter1 = this.counter2 = this.counter3 = this.PROGRESSION = 0;
         if(this.isShowHideCatButtonCutscene())
         {
            this.level.soundHud.hideCatButton();
         }
         this.stateMachine.performAction("START_ACTION");
      }
      
      protected function execState() : void
      {
      }
      
      protected function overState() : void
      {
         if(this.isShowHideCatButtonCutscene())
         {
            this.level.soundHud.showCatButton();
         }
         this.dead = true;
         this.level.endCutscene(this);
      }
      
      protected function isShowHideCatButtonCutscene() : Boolean
      {
         return true;
      }
   }
}
