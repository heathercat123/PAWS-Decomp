package com.distriqt.extension.adverts.builders
{
   import com.distriqt.extension.adverts.AdViewParams;
   
   public class AdViewParamsBuilder
   {
      
      private static const TAG:String = "AdViewParamsBuilder";
       
      
      private var _params:AdViewParams;
      
      public function AdViewParamsBuilder()
      {
         super();
         _params = new AdViewParams();
      }
      
      public function setHorizontalAlign(param1:String) : AdViewParamsBuilder
      {
         _params.horizontalAlign = param1;
         return this;
      }
      
      public function setVerticalAlign(param1:String) : AdViewParamsBuilder
      {
         _params.verticalAlign = param1;
         return this;
      }
      
      public function setX(param1:int) : AdViewParamsBuilder
      {
         _params.x = param1;
         return this;
      }
      
      public function setY(param1:int) : AdViewParamsBuilder
      {
         _params.y = param1;
         return this;
      }
      
      public function setWidth(param1:int) : AdViewParamsBuilder
      {
         _params.width = param1;
         return this;
      }
      
      public function setHeight(param1:int) : AdViewParamsBuilder
      {
         _params.height = param1;
         return this;
      }
      
      public function build() : AdViewParams
      {
         return _params;
      }
   }
}
