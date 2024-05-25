package com.distriqt.extension.gameservices.players
{
   import flash.events.IEventDispatcher;
   
   [Event(name="players:loadPlayerFriends:success",type="com.distriqt.extension.gameservices.events.PlayersEvent")]
   [Event(name="players:loadPlayerFriends:error",type="com.distriqt.extension.gameservices.events.PlayersEvent")]
   public interface Players extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function loadPlayerFriends() : Boolean;
   }
}
