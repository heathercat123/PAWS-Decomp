package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.achievements.Achievement;
   import flash.events.Event;
   
   public class AchievementEvent extends Event
   {
      
      public static const ACHIEVEMENTS_LOADED:String = "achievements:loaded";
      
      public static const ACHIEVEMENTS_ERROR:String = "achievements:error";
      
      public static const ACHIEVEMENTS_UI_CLOSED:String = "achievements:ui:closed";
      
      public static const ACHIEVEMENTS_RESET_COMPLETE:String = "achievements:reset:complete";
      
      public static const ACHIEVEMENTS_RESET_ERROR:String = "achievements:reset:error";
       
      
      public var achievement:Achievement;
      
      public var data:*;
      
      public function AchievementEvent(param1:String, param2:Achievement, param3:*, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.achievement = param2;
         this.data = param3;
      }
      
      override public function clone() : Event
      {
         return new AchievementEvent(type,achievement,data,bubbles,cancelable);
      }
   }
}
