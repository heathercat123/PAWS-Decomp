package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.players.Players;
   import flash.events.EventDispatcher;
   
   internal final class _PlayersImpl extends EventDispatcher implements Players
   {
       
      
      public function _PlayersImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function loadPlayerFriends() : Boolean
      {
         return false;
      }
   }
}
