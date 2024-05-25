package com.distriqt.extension.gameservices
{
   public class Player
   {
      
      public static const TIMESTAMP_UNKNOWN:Number = -1;
       
      
      public var id:String = "";
      
      public var alias:String = "";
      
      public var displayName:String = "";
      
      public var title:String = "";
      
      public var iconUrl:String = "";
      
      public var imageUrl:String = "";
      
      public var lastPlayedWithTimestamp:Number = -1;
      
      public var modifiedTimestamp:Number = -1;
      
      public function Player(param1:Object = null)
      {
         super();
         updateFromObject(param1);
      }
      
      public static function fromObject(param1:Object) : Player
      {
         var _loc2_:Player = null;
         if(param1 != null)
         {
            _loc2_ = new Player();
            _loc2_.updateFromObject(param1);
            return _loc2_;
         }
         return null;
      }
      
      internal function updateFromObject(param1:Object) : void
      {
         if(param1 != null)
         {
            if(param1.hasOwnProperty("id"))
            {
               this.id = param1["id"];
            }
            if(param1.hasOwnProperty("alias"))
            {
               this.alias = param1["alias"];
            }
            if(param1.hasOwnProperty("displayName"))
            {
               this.displayName = param1["displayName"];
            }
            if(param1.hasOwnProperty("title"))
            {
               this.title = param1["title"];
            }
            if(param1.hasOwnProperty("iconUrl"))
            {
               this.iconUrl = param1["iconUrl"];
            }
            if(param1.hasOwnProperty("imageUrl"))
            {
               this.imageUrl = param1["imageUrl"];
            }
            if(param1.hasOwnProperty("lastPlayedWithTimestamp"))
            {
               this.lastPlayedWithTimestamp = param1["lastPlayedWithTimestamp"];
            }
            if(param1.hasOwnProperty("modifiedTimestamp"))
            {
               this.modifiedTimestamp = param1["modifiedTimestamp"];
            }
         }
      }
   }
}
