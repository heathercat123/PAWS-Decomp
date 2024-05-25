package com.distriqt.extension.gameservices.leaderboards
{
   import flash.events.IEventDispatcher;
   
   [Event(name="leaderboards:loaded",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboards:error",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:topscores:loaded",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:scores:loaded",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:scores:error",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:playercenteredscores:loaded",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:playercenteredscores:error",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:playerscore:loaded",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:playerscore:error",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:submitscore:success",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:submitscore:error",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   [Event(name="leaderboard:ui:closed",type="com.distriqt.extension.gameservices.events.LeaderboardEvent")]
   public interface Leaderboards extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function loadLeaderboards(param1:Boolean = false) : void;
      
      function loadTopScores(param1:String, param2:int = 10, param3:String = "alltime", param4:String = "public", param5:Boolean = false) : void;
      
      function loadPlayerCenteredScores(param1:String, param2:int = 10, param3:String = "alltime", param4:String = "public", param5:Boolean = false) : void;
      
      function loadPlayerScore(param1:String, param2:String = "alltime", param3:String = "public") : void;
      
      function submitScore(param1:String, param2:int, param3:String = "") : void;
      
      function displayLeaderboardUI(param1:String = "") : void;
   }
}
