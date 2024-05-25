package com.distriqt.extension.gameservices.multiplayer
{
   import com.distriqt.extension.gameservices.Player;
   
   public class Participant
   {
      
      public static const STATUS_UNKNOWN:int = -1;
      
      public static const STATUS_NOT_INVITED_YET:int = 0;
      
      public static const STATUS_INVITED:int = 1;
      
      public static const STATUS_JOINED:int = 2;
      
      public static const STATUS_DECLINED:int = 3;
      
      public static const STATUS_LEFT:int = 4;
      
      public static const STATUS_FINISHED:int = 5;
      
      public static const STATUS_UNRESPONSIVE:int = 6;
       
      
      private var _participantId:String;
      
      private var _player:Player;
      
      private var _status:int = 0;
      
      private var _displayName:String;
      
      private var _iconUrl:String = "";
      
      private var _imageUrl:String = "";
      
      public function Participant()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : Participant
      {
         var _loc2_:Participant = new Participant();
         _loc2_.updateFromObject(param1);
         return _loc2_;
      }
      
      public function get participantId() : String
      {
         return _participantId;
      }
      
      public function set participantId(param1:String) : void
      {
         _participantId = param1;
      }
      
      public function get player() : Player
      {
         return _player;
      }
      
      public function set player(param1:Player) : void
      {
         _player = param1;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function set status(param1:int) : void
      {
         _status = param1;
      }
      
      public function get displayName() : String
      {
         return _displayName;
      }
      
      public function set displayName(param1:String) : void
      {
         _displayName = param1;
      }
      
      public function get iconUrl() : String
      {
         return _iconUrl;
      }
      
      public function set iconUrl(param1:String) : void
      {
         _iconUrl = param1;
      }
      
      public function get imageUrl() : String
      {
         return _imageUrl;
      }
      
      public function set imageUrl(param1:String) : void
      {
         _imageUrl = param1;
      }
      
      public function updateFromObject(param1:Object) : void
      {
         this.participantId = param1.participantId;
         this.player = Player.fromObject(param1.player);
         this.status = param1.status;
         this.displayName = param1.displayName;
         this.iconUrl = param1.iconUrl;
         this.imageUrl = param1.imageUrl;
      }
   }
}
