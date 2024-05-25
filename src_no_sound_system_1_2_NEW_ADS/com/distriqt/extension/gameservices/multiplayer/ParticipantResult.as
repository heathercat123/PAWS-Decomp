package com.distriqt.extension.gameservices.multiplayer
{
   public class ParticipantResult
   {
      
      public static const MATCH_RESULT_UNINITIALIZED:int = -1;
      
      public static const MATCH_RESULT_WIN:int = 0;
      
      public static const MATCH_RESULT_LOSS:int = 1;
      
      public static const MATCH_RESULT_TIE:int = 2;
      
      public static const MATCH_RESULT_NONE:int = 3;
      
      public static const MATCH_RESULT_DISCONNECT:int = 4;
      
      public static const MATCH_RESULT_DISAGREED:int = 5;
       
      
      private var _participant:Participant;
      
      private var _result:int = -1;
      
      private var _placing:int = -1;
      
      private var _score:int = 0;
      
      public function ParticipantResult()
      {
         super();
      }
      
      public function get participant() : Participant
      {
         return _participant;
      }
      
      public function set participant(param1:Participant) : void
      {
         _participant = param1;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function set result(param1:int) : void
      {
         _result = param1;
      }
      
      public function get placing() : int
      {
         return _placing;
      }
      
      public function set placing(param1:int) : void
      {
         _placing = param1;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(param1:int) : void
      {
         _score = param1;
      }
   }
}
