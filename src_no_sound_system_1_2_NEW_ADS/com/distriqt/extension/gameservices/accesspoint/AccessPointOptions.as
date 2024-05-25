package com.distriqt.extension.gameservices.accesspoint
{
   public class AccessPointOptions
   {
      
      private static const TAG:String = "AccessPointOptions";
      
      public static const LOCATION_TOP_LEADING:int = 0;
      
      public static const LOCATION_TOP_TRAILING:int = 1;
      
      public static const LOCATION_BOTTOM_LEADING:int = 2;
      
      public static const LOCATION_BOTTOM_TRAILING:int = 3;
       
      
      public var location:int = 0;
      
      public var showHighlights:Boolean = false;
      
      public function AccessPointOptions()
      {
         super();
      }
      
      public function setLocation(param1:int) : AccessPointOptions
      {
         this.location = param1;
         return this;
      }
      
      public function setShowHighlights(param1:Boolean) : AccessPointOptions
      {
         this.showHighlights = param1;
         return this;
      }
   }
}
