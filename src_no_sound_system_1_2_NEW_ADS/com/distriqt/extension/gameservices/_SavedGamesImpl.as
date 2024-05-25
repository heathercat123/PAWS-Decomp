package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.savedgames.SavedGame;
   import com.distriqt.extension.gameservices.savedgames.SavedGames;
   import flash.events.EventDispatcher;
   
   internal class _SavedGamesImpl extends EventDispatcher implements SavedGames
   {
       
      
      public function _SavedGamesImpl()
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
      
      public function displaySavedGamesUI(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1) : Boolean
      {
         return false;
      }
      
      public function loadSavedGames(param1:Boolean = false) : void
      {
      }
      
      public function createGame(param1:String) : void
      {
      }
      
      public function openGame(param1:SavedGame) : void
      {
      }
      
      public function saveGame(param1:SavedGame) : void
      {
      }
      
      public function deleteGame(param1:SavedGame) : void
      {
      }
      
      public function resolveConflict(param1:String, param2:SavedGame) : void
      {
      }
   }
}
