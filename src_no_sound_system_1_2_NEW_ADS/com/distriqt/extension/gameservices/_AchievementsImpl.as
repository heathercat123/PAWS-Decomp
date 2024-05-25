package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.achievements.Achievements;
   import flash.events.EventDispatcher;
   
   internal class _AchievementsImpl extends EventDispatcher implements Achievements
   {
       
      
      public function _AchievementsImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function loadAchievements(param1:Boolean = false) : void
      {
      }
      
      public function get canResetAchievements() : Boolean
      {
         return false;
      }
      
      public function resetAchievements() : void
      {
      }
      
      public function achievementReveal(param1:String) : void
      {
      }
      
      public function achievementUnlock(param1:String) : void
      {
      }
      
      public function achievementStepsSet(param1:String, param2:int) : void
      {
      }
      
      public function achievementStepsIncrement(param1:String, param2:int) : void
      {
      }
      
      public function displayAchievementsUI() : void
      {
      }
   }
}
