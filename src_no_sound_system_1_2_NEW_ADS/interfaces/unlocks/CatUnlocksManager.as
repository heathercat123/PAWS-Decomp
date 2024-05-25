package interfaces.unlocks
{
   import game_utils.AchievementsManager;
   import game_utils.StateMachine;
   import levels.Level;
   
   public class CatUnlocksManager
   {
       
      
      public var level:Level;
      
      public var stateMachine:StateMachine;
      
      public var unlockScene:CatUnlockScene;
      
      protected var __ID:int;
      
      protected var IS_BOSS:Boolean;
      
      public function CatUnlocksManager(_level:Level)
      {
         super();
         this.level = _level;
         this.unlockScene = null;
         this.__ID = 0;
         this.IS_BOSS = false;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_NO_SCENE_STATE","PLAY_SCENE_ACTION","IS_SCENE_STATE");
         this.stateMachine.setRule("IS_SCENE_STATE","END_ACTION","IS_SCENE_END_STATE");
         this.stateMachine.setRule("IS_SCENE_END_STATE","END_ACTION","IS_NO_SCENE_STATE");
         this.stateMachine.setFunctionToState("IS_NO_SCENE_STATE",this.noSceneState);
         this.stateMachine.setFunctionToState("IS_SCENE_STATE",this.sceneState);
         this.stateMachine.setFunctionToState("IS_SCENE_END_STATE",this.sceneEndState);
         this.stateMachine.setState("IS_NO_SCENE_STATE");
      }
      
      public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         if(this.unlockScene != null)
         {
            this.unlockScene.destroy();
            this.unlockScene = null;
         }
         this.level = null;
      }
      
      public function update() : void
      {
         if(this.stateMachine.currentState == "IS_SCENE_STATE")
         {
            this.unlockScene.update();
            if(this.unlockScene.DEAD)
            {
               if(this.__ID != 1)
               {
                  AchievementsManager.SubmitAchievement("CAT_" + this.__ID);
               }
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_SCENE_END_STATE")
         {
            if(this.unlockScene == null)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_NO_SCENE_STATE")
         {
         }
      }
      
      public function showUnlockScene(_ID:int) : void
      {
         this.__ID = _ID;
         this.IS_BOSS = false;
         this.unlockScene = new CatUnlockScene(this.level,_ID,false);
         this.stateMachine.performAction("PLAY_SCENE_ACTION");
      }
      
      public function showBossScene(_ID:int) : void
      {
         this.__ID = _ID;
         this.IS_BOSS = true;
         this.unlockScene = new CatUnlockScene(this.level,_ID,true);
         this.stateMachine.performAction("PLAY_SCENE_ACTION");
      }
      
      protected function noSceneState() : void
      {
      }
      
      protected function sceneState() : void
      {
      }
      
      protected function sceneEndState() : void
      {
         this.unlockScene.destroy();
         this.unlockScene = null;
      }
   }
}
