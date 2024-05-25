package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.leaderboards.Leaderboard;
   import flash.events.Event;
   
   public class LeaderboardEvent extends Event
   {
      
      public static const LEADERBOARDS_LOADED:String = "leaderboards:loaded";
      
      public static const LEADERBOARDS_ERROR:String = "leaderboards:error";
      
      public static const TOPSCORES_LOADED:String = "leaderboard:topscores:loaded";
      
      public static const TOPSCORES_ERROR:String = "leaderboard:topscores:error";
      
      public static const SCORES_LOADED:String = "leaderboard:scores:loaded";
      
      public static const SCORES_ERROR:String = "leaderboard:scores:error";
      
      public static const PLAYERCENTEREDSCORES_LOADED:String = "leaderboard:playercenteredscores:loaded";
      
      public static const PLAYERCENTEREDSCORES_ERROR:String = "leaderboard:playercenteredscores:error";
      
      public static const PLAYERSCORE_LOADED:String = "leaderboard:playerscore:loaded";
      
      public static const PLAYERSCORE_ERROR:String = "leaderboard:playerscore:error";
      
      public static const SUBMITSCORE_SUCCESS:String = "leaderboard:submitscore:success";
      
      public static const SUBMITSCORE_ERROR:String = "leaderboard:submitscore:error";
      
      public static const UI_CLOSED:String = "leaderboard:ui:closed";
       
      
      public var leaderboard:Leaderboard = null;
      
      public var data:*;
      
      public function LeaderboardEvent(param1:String, param2:Leaderboard, param3:*, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.leaderboard = param2;
         this.data = param3;
      }
      
      override public function clone() : Event
      {
         return new LeaderboardEvent(type,data,bubbles,cancelable);
      }
   }
}
