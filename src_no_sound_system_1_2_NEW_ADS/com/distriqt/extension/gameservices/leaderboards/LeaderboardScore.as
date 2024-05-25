package com.distriqt.extension.gameservices.leaderboards
{
   import com.distriqt.extension.gameservices.Player;
   
   public class LeaderboardScore
   {
       
      
      public var player:Player;
      
      public var displayRank:String;
      
      public var displayScore:String;
      
      public var rank:Number;
      
      public var rawScore:Number;
      
      public var tag:String;
      
      public var timestamp:Number;
      
      public function LeaderboardScore()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : LeaderboardScore
      {
         var _loc2_:LeaderboardScore = new LeaderboardScore();
         if(param1.hasOwnProperty("player"))
         {
            _loc2_.player = Player.fromObject(param1.player);
         }
         if(param1.hasOwnProperty("displayRank"))
         {
            _loc2_.displayRank = param1.displayRank;
         }
         if(param1.hasOwnProperty("displayScore"))
         {
            _loc2_.displayScore = param1.displayScore;
         }
         if(param1.hasOwnProperty("rank"))
         {
            _loc2_.rank = param1.rank;
         }
         if(param1.hasOwnProperty("rawScore"))
         {
            _loc2_.rawScore = param1.rawScore;
         }
         if(param1.hasOwnProperty("tag"))
         {
            _loc2_.tag = param1.tag;
         }
         if(param1.hasOwnProperty("timestamp"))
         {
            _loc2_.timestamp = param1.timestamp;
         }
         return _loc2_;
      }
   }
}
