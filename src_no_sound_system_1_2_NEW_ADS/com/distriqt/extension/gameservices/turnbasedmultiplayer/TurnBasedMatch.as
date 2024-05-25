package com.distriqt.extension.gameservices.turnbasedmultiplayer
{
   import com.distriqt.extension.gameservices.multiplayer.Participant;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   [Event(name="turnbasedmultiplayer:match:updated",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:removed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:taketurn:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:taketurn:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:finishMatch:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:finishMatch:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:leaveMatch:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:leaveMatch:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:rematch:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:rematch:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:cancelMatch:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:cancelMatch:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   public interface TurnBasedMatch extends IEventDispatcher
   {
       
      
      function get matchId() : String;
      
      function get status() : int;
      
      function get turnStatus() : int;
      
      function get variant() : int;
      
      function get created() : int;
      
      function get data() : ByteArray;
      
      function get dataMaxSize() : uint;
      
      function get participants() : Array;
      
      function get canRematch() : Boolean;
      
      function takeTurn(param1:Participant) : void;
      
      function leaveMatch() : void;
      
      function leaveMatchDuringTurn(param1:Participant) : void;
      
      function dismissMatch() : void;
      
      function cancelMatch() : void;
      
      function finishMatch(param1:Array) : void;
      
      function rematch() : void;
   }
}
