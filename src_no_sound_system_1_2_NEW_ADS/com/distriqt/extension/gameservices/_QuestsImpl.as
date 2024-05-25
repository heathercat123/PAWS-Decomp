package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.quests.Quests;
   import flash.events.EventDispatcher;
   
   internal class _QuestsImpl extends EventDispatcher implements Quests
   {
       
      
      public function _QuestsImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function displayUI() : Boolean
      {
         return false;
      }
      
      public function loadQuests(param1:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function accept(param1:String) : Boolean
      {
         return false;
      }
      
      public function claim(param1:String, param2:String) : Boolean
      {
         return false;
      }
      
      public function listenForCompletion() : Boolean
      {
         return false;
      }
      
      public function loadEvents(param1:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function incrementEvent(param1:String, param2:int = 1) : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
      }
   }
}
