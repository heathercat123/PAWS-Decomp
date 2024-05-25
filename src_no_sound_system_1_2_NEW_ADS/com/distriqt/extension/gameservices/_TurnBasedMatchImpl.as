package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.multiplayer.Participant;
   import com.distriqt.extension.gameservices.turnbasedmultiplayer.TurnBasedMatch;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   internal class _TurnBasedMatchImpl extends EventDispatcher implements TurnBasedMatch
   {
       
      
      private var _matchId:String = "";
      
      private var _status:int;
      
      private var _turnStatus:int;
      
      private var _variant:int;
      
      private var _created:int;
      
      private var _canRematch:Boolean = false;
      
      private var _participants:Array;
      
      private var _data:ByteArray;
      
      private var _dataMaxSize:uint = 0;
      
      public function _TurnBasedMatchImpl()
      {
         super();
         _participants = [];
      }
      
      public function dispose() : void
      {
      }
      
      public function get matchId() : String
      {
         return _matchId;
      }
      
      public function set matchId(param1:String) : void
      {
         _matchId = param1;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function set status(param1:int) : void
      {
         _status = param1;
      }
      
      public function get turnStatus() : int
      {
         return _turnStatus;
      }
      
      public function set turnStatus(param1:int) : void
      {
         _turnStatus = param1;
      }
      
      public function get variant() : int
      {
         return _variant;
      }
      
      public function set variant(param1:int) : void
      {
         _variant = param1;
      }
      
      public function get created() : int
      {
         return _created;
      }
      
      public function set created(param1:int) : void
      {
         _created = param1;
      }
      
      public function get canRematch() : Boolean
      {
         return _canRematch;
      }
      
      public function set canRematch(param1:Boolean) : void
      {
         _canRematch = param1;
      }
      
      public function get participants() : Array
      {
         return _participants;
      }
      
      public function set participants(param1:Array) : void
      {
         _participants = param1;
      }
      
      public function get data() : ByteArray
      {
         return _data;
      }
      
      public function set data(param1:ByteArray) : void
      {
         _data = param1;
      }
      
      public function get dataMaxSize() : uint
      {
         return _dataMaxSize;
      }
      
      public function set dataMaxSize(param1:uint) : void
      {
         _dataMaxSize = param1;
      }
      
      public function takeTurn(param1:Participant) : void
      {
      }
      
      public function finishMatch(param1:Array) : void
      {
      }
      
      public function cancelMatch() : void
      {
      }
      
      public function dismissMatch() : void
      {
      }
      
      public function leaveMatch() : void
      {
      }
      
      public function leaveMatchDuringTurn(param1:Participant) : void
      {
      }
      
      public function rematch() : void
      {
      }
   }
}
