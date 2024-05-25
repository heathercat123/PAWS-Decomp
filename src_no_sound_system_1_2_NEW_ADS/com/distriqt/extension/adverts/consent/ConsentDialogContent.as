package com.distriqt.extension.adverts.consent
{
   public class ConsentDialogContent
   {
      
      private static const TAG:String = "ConsentDialogContent";
       
      
      public var title:String;
      
      public var contentText:String;
      
      public var moreInfoText:String;
      
      public var mediationPartnersText:String;
      
      public function ConsentDialogContent()
      {
         super();
      }
      
      public function setTitle(param1:String) : ConsentDialogContent
      {
         this.title = param1;
         return this;
      }
      
      public function setContentText(param1:String) : ConsentDialogContent
      {
         this.contentText = param1;
         return this;
      }
      
      public function setMoreInfoText(param1:String) : ConsentDialogContent
      {
         this.moreInfoText = param1;
         return this;
      }
      
      public function setMediationPartnersText(param1:String) : ConsentDialogContent
      {
         this.mediationPartnersText = param1;
         return this;
      }
   }
}
