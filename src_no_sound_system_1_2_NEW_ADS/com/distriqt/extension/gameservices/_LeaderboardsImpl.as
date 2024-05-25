package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.leaderboards.Leaderboards;
   import flash.events.EventDispatcher;
   
   internal class _LeaderboardsImpl extends EventDispatcher implements Leaderboards
   {
       
      
      public function _LeaderboardsImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function loadPlayerCenteredScores(param1:String, param2:int = 10, param3:String = "alltime", param4:String = "public", param5:Boolean = false) : void
      {
      }
      
      public function loadPlayerScore(param1:String, param2:String = "alltime", param3:String = "public") : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function loadLeaderboards(param1:Boolean = false) : void
      {
      }
      
      public function loadTopScores(param1:String, param2:int = 10, param3:String = "alltime", param4:String = "public", param5:Boolean = false) : void
      {
      }
      
      public function submitScore(param1:String, param2:int, param3:String = "") : void
      {
      }
      
      public function displayLeaderboardUI(param1:String = "") : void
      {
      }
   }
}
