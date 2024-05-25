package com.distriqt.extension.gameservices.savedgames
{
   import flash.events.IEventDispatcher;
   
   [Event(name="savedgames:load:success",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:load:error",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:ui:select",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:ui:new",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:ui:closed",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:conflict",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:conflict:resolve:success",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:conflict:resolve:error",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:create:success",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:create:failed",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:create:error",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:open:success",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:open:notfound",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:open:failed",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:open:error",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:save:success",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:save:error",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:conflict",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   [Event(name="savedgames:conflict",type="com.distriqt.extension.gameservices.events.SavedGamesEvent")]
   public interface SavedGames extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function displaySavedGamesUI(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1) : Boolean;
      
      function loadSavedGames(param1:Boolean = false) : void;
      
      function createGame(param1:String) : void;
      
      function openGame(param1:SavedGame) : void;
      
      function saveGame(param1:SavedGame) : void;
      
      function deleteGame(param1:SavedGame) : void;
      
      function resolveConflict(param1:String, param2:SavedGame) : void;
   }
}
