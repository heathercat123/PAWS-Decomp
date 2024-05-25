package com.distriqt.extension.gameservices.turnbasedmultiplayer
{
   import com.distriqt.extension.gameservices.multiplayer.Invitation;
   import com.distriqt.extension.gameservices.multiplayer.PlayerSelectionOptions;
   import flash.events.IEventDispatcher;
   
   [Event(name="turnbasedmultiplayer:creatematchui:success",type="com.distriqt.extension.gameservices.events.TurnBasedMultiplayerEvent")]
   [Event(name="turnbasedmultiplayer:creatematchui:error",type="com.distriqt.extension.gameservices.events.TurnBasedMultiplayerEvent")]
   [Event(name="turnbasedmultiplayer:creatematchui:cancel",type="com.distriqt.extension.gameservices.events.TurnBasedMultiplayerEvent")]
   [Event(name="turnbasedmultiplayer:loadmatches:success",type="com.distriqt.extension.gameservices.events.TurnBasedMultiplayerEvent")]
   [Event(name="turnbasedmultiplayer:loadmatches:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMultiplayerEvent")]
   [Event(name="turnbasedmultiplayer:match:loadmatch:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:loadmatch:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:create:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:create:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:updated",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:match:removed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:acceptinvitation:success",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   [Event(name="turnbasedmultiplayer:acceptinvitation:failed",type="com.distriqt.extension.gameservices.events.TurnBasedMatchEvent")]
   public interface TurnBasedMultiplayer extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function loadMatches(param1:Array = null) : void;
      
      function loadMatch(param1:String) : void;
      
      function displayCreateMatchUI(param1:PlayerSelectionOptions) : void;
      
      function createMatch(param1:TurnBasedMatchConfig) : void;
      
      function acceptInvitation(param1:Invitation) : void;
      
      function declineInvitation(param1:Invitation) : void;
      
      function dismissInvitation(param1:Invitation) : void;
   }
}
