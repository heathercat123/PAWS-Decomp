package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.turnbasedmultiplayer.TurnBasedMatch;
   import flash.events.Event;
   
   public class TurnBasedMatchEvent extends Event
   {
      
      public static const LOADMATCH_SUCCESS:String = "turnbasedmultiplayer:match:loadmatch:success";
      
      public static const LOADMATCH_FAILED:String = "turnbasedmultiplayer:match:loadmatch:failed";
      
      public static const CREATE_SUCCESS:String = "turnbasedmultiplayer:match:create:success";
      
      public static const CREATE_FAILED:String = "turnbasedmultiplayer:match:create:failed";
      
      public static const MATCH_UPDATED:String = "turnbasedmultiplayer:match:updated";
      
      public static const MATCH_REMOVED:String = "turnbasedmultiplayer:match:removed";
      
      public static const TAKETURN_SUCCESS:String = "turnbasedmultiplayer:match:taketurn:success";
      
      public static const TAKETURN_FAILED:String = "turnbasedmultiplayer:match:taketurn:failed";
      
      public static const FINISH_SUCCESS:String = "turnbasedmultiplayer:match:finishMatch:success";
      
      public static const FINISH_FAILED:String = "turnbasedmultiplayer:match:finishMatch:failed";
      
      public static const LEAVE_SUCCESS:String = "turnbasedmultiplayer:match:leaveMatch:success";
      
      public static const LEAVE_FAILED:String = "turnbasedmultiplayer:match:leaveMatch:failed";
      
      public static const REMATCH_SUCCESS:String = "turnbasedmultiplayer:match:rematch:success";
      
      public static const REMATCH_FAILED:String = "turnbasedmultiplayer:match:rematch:failed";
      
      public static const CANCEL_SUCCESS:String = "turnbasedmultiplayer:match:cancelMatch:success";
      
      public static const CANCEL_FAILED:String = "turnbasedmultiplayer:match:cancelMatch:failed";
      
      public static const ACCEPTINVITATION_SUCCESS:String = "turnbasedmultiplayer:acceptinvitation:success";
      
      public static const ACCEPTINVITATION_FAILED:String = "turnbasedmultiplayer:acceptinvitation:failed";
       
      
      public var match:TurnBasedMatch;
      
      public var message:String;
      
      public function TurnBasedMatchEvent(param1:String, param2:TurnBasedMatch, param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.match = param2;
         this.message = param3;
      }
      
      override public function clone() : Event
      {
         return new TurnBasedMatchEvent(type,match,message,bubbles,cancelable);
      }
   }
}
