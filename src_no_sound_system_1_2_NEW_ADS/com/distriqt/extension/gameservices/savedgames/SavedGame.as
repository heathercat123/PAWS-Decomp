package com.distriqt.extension.gameservices.savedgames
{
   import com.distriqt.extension.gameservices.Player;
   import com.distriqt.extension.gameservices.utils.Base64;
   import flash.utils.ByteArray;
   
   public class SavedGame
   {
       
      
      public var id:String = "";
      
      private var _uniqueName:String;
      
      private var _description:String = "";
      
      private var _modified:Number;
      
      private var _playedTime:Number;
      
      private var _owner:Player;
      
      private var _data:ByteArray;
      
      public function SavedGame()
      {
         super();
         _data = new ByteArray();
      }
      
      public static function fromObject(param1:Object) : SavedGame
      {
         var _loc3_:String = null;
         var _loc2_:SavedGame = new SavedGame();
         if(param1.hasOwnProperty("uniqueName"))
         {
            _loc2_.uniqueName = param1.uniqueName;
         }
         if(param1.hasOwnProperty("description"))
         {
            _loc2_.description = param1.description;
         }
         if(param1.hasOwnProperty("playedTime"))
         {
            _loc2_.playedTime = param1.playedTime;
         }
         if(param1.hasOwnProperty("lastModifiedTimestamp"))
         {
            _loc2_.modified = param1.lastModifiedTimestamp;
         }
         if(param1.hasOwnProperty("modified"))
         {
            _loc2_.modified = param1.modified;
         }
         if(param1.hasOwnProperty("player"))
         {
            _loc2_.owner = Player.fromObject(param1.player);
         }
         if(param1.hasOwnProperty("data"))
         {
            _loc3_ = String(param1.data.replace(/[\s\r\n]+/gim,""));
            _loc2_.data = Base64.decodeToByteArray(_loc3_);
         }
         else
         {
            _loc2_.data = new ByteArray();
         }
         return _loc2_;
      }
      
      public function get uniqueName() : String
      {
         return _uniqueName;
      }
      
      public function set uniqueName(param1:String) : void
      {
         _uniqueName = param1;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get modified() : Number
      {
         return _modified;
      }
      
      public function set modified(param1:Number) : void
      {
         _modified = param1;
      }
      
      public function get playedTime() : Number
      {
         return _playedTime;
      }
      
      public function set playedTime(param1:Number) : void
      {
         _playedTime = param1;
      }
      
      public function get owner() : Player
      {
         return _owner;
      }
      
      public function set owner(param1:Player) : void
      {
         _owner = param1;
      }
      
      public function get data() : ByteArray
      {
         return _data;
      }
      
      public function set data(param1:ByteArray) : void
      {
         _data = param1;
      }
   }
}
