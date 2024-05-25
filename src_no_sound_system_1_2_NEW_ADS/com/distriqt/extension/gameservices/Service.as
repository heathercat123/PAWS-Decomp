package com.distriqt.extension.gameservices
{
   public class Service
   {
      
      public static const GOOGLE_PLAY_GAME_SERVICES:String = "google:play:game:services";
      
      public static const IOS_GAME_CENTER:String = "ios:game:center";
      
      public static const AMAZON_GAME_CIRCLE:String = "amazon:game:circle";
       
      
      private var _service:String;
      
      private var _serviceId:String = "";
      
      private var _serverClientId:String = "";
      
      private var _enableSavedGames:Boolean = false;
      
      private var _enableTurnBasedMultiplayer:Boolean = false;
      
      private var _environment:String = "production";
      
      public function Service(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _service = param1;
         _serviceId = param2;
         _enableSavedGames = param3;
         _enableTurnBasedMultiplayer = param4;
      }
      
      public function get service() : String
      {
         return _service;
      }
      
      public function set service(param1:String) : void
      {
         _service = param1;
      }
      
      public function get serviceId() : String
      {
         return _serviceId;
      }
      
      public function set serviceId(param1:String) : void
      {
         _serviceId = param1;
      }
      
      public function get serverClientId() : String
      {
         return _serverClientId;
      }
      
      public function set serverClientId(param1:String) : void
      {
         _serverClientId = param1;
      }
      
      public function get enableSavedGames() : Boolean
      {
         return _enableSavedGames;
      }
      
      public function set enableSavedGames(param1:Boolean) : void
      {
         _enableSavedGames = param1;
      }
      
      public function get enableTurnBasedMultiplayer() : Boolean
      {
         return _enableTurnBasedMultiplayer;
      }
      
      public function set enableTurnBasedMultiplayer(param1:Boolean) : void
      {
         _enableTurnBasedMultiplayer = param1;
      }
      
      public function get environment() : String
      {
         return _environment;
      }
      
      public function set environment(param1:String) : void
      {
         _environment = param1;
      }
   }
}
