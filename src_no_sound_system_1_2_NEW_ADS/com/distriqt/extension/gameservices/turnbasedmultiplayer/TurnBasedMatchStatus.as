package com.distriqt.extension.gameservices.turnbasedmultiplayer
{
   public class TurnBasedMatchStatus
   {
      
      public static const MATCH_STATUS_UNKNOWN:int = -1;
      
      public static const MATCH_STATUS_AUTO_MATCHING:int = 0;
      
      public static const MATCH_STATUS_ACTIVE:int = 1;
      
      public static const MATCH_STATUS_COMPLETE:int = 2;
      
      public static const MATCH_STATUS_EXPIRED:int = 3;
      
      public static const MATCH_STATUS_CANCELED:int = 4;
      
      public static const MATCH_TURN_STATUS_UNKNOWN:int = -1;
      
      public static const MATCH_TURN_STATUS_INVITED:int = 0;
      
      public static const MATCH_TURN_STATUS_MY_TURN:int = 1;
      
      public static const MATCH_TURN_STATUS_THEIR_TURN:int = 2;
      
      public static const MATCH_TURN_STATUS_COMPLETE:int = 3;
      
      public static const MATCH_VARIANT_DEFAULT:int = -1;
      
      public static const ALL_TURN_STATUSES:Array = [0,1,2,3];
       
      
      public function TurnBasedMatchStatus()
      {
         super();
      }
   }
}
