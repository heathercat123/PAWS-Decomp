package com.distriqt.extension.gameservices.turnbasedmultiplayer
{
   public class TurnBasedMatchConfig
   {
       
      
      private var _invitedPlayers:Array;
      
      private var _minAutoMatchPlayers:int = 0;
      
      private var _maxAutoMatchPlayers:int = 0;
      
      private var _variant:int = -1;
      
      public function TurnBasedMatchConfig()
      {
         super();
         _invitedPlayers = [];
      }
      
      public static function fromObject(param1:Object) : TurnBasedMatchConfig
      {
         var _loc2_:TurnBasedMatchConfig = new TurnBasedMatchConfig();
         for each(var _loc3_:int in param1.invitees)
         {
            _loc2_.invitedPlayers.push(_loc3_);
         }
         _loc2_.minAutoMatchPlayers = param1.minAutoMatchPlayers;
         _loc2_.maxAutoMatchPlayers = param1.maxAutoMatchPlayers;
         return _loc2_;
      }
      
      public function get invitedPlayers() : Array
      {
         return _invitedPlayers;
      }
      
      public function set invitedPlayers(param1:Array) : void
      {
         _invitedPlayers = param1;
      }
      
      public function get minAutoMatchPlayers() : int
      {
         return _minAutoMatchPlayers;
      }
      
      public function set minAutoMatchPlayers(param1:int) : void
      {
         _minAutoMatchPlayers = param1;
      }
      
      public function get maxAutoMatchPlayers() : int
      {
         return _maxAutoMatchPlayers;
      }
      
      public function set maxAutoMatchPlayers(param1:int) : void
      {
         _maxAutoMatchPlayers = param1;
      }
      
      public function get variant() : int
      {
         return _variant;
      }
      
      public function set variant(param1:int) : void
      {
         _variant = param1;
      }
   }
}
