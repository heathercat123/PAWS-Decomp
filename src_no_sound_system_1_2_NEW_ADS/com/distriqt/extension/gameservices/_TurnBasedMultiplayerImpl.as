package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.multiplayer.Invitation;
   import com.distriqt.extension.gameservices.multiplayer.PlayerSelectionOptions;
   import com.distriqt.extension.gameservices.turnbasedmultiplayer.TurnBasedMatchConfig;
   import com.distriqt.extension.gameservices.turnbasedmultiplayer.TurnBasedMultiplayer;
   import flash.events.EventDispatcher;
   
   internal class _TurnBasedMultiplayerImpl extends EventDispatcher implements TurnBasedMultiplayer
   {
       
      
      public function _TurnBasedMultiplayerImpl()
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
      
      public function displayCreateMatchUI(param1:PlayerSelectionOptions) : void
      {
      }
      
      public function loadMatches(param1:Array = null) : void
      {
      }
      
      public function loadMatch(param1:String) : void
      {
      }
      
      public function displayPlayerSelectionUI(param1:PlayerSelectionOptions) : void
      {
      }
      
      public function createMatch(param1:TurnBasedMatchConfig) : void
      {
      }
      
      public function acceptInvitation(param1:Invitation) : void
      {
      }
      
      public function declineInvitation(param1:Invitation) : void
      {
      }
      
      public function dismissInvitation(param1:Invitation) : void
      {
      }
   }
}
