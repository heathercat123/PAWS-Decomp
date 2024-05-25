package com.distriqt.extension.gameservices.achievements
{
   import flash.events.IEventDispatcher;
   
   [Event(name="achievements:loaded",type="com.distriqt.extension.gameservices.events.AchievementEvent")]
   [Event(name="achievements:error",type="com.distriqt.extension.gameservices.events.AchievementEvent")]
   [Event(name="achievements:ui:closed",type="com.distriqt.extension.gameservices.events.AchievementEvent")]
   [Event(name="achievements:reset:complete",type="com.distriqt.extension.gameservices.events.AchievementEvent")]
   [Event(name="achievements:reset:error",type="com.distriqt.extension.gameservices.events.AchievementEvent")]
   public interface Achievements extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function loadAchievements(param1:Boolean = false) : void;
      
      function get canResetAchievements() : Boolean;
      
      function resetAchievements() : void;
      
      function achievementReveal(param1:String) : void;
      
      function achievementUnlock(param1:String) : void;
      
      function achievementStepsSet(param1:String, param2:int) : void;
      
      function achievementStepsIncrement(param1:String, param2:int) : void;
      
      function displayAchievementsUI() : void;
   }
}
