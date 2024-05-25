package neutronized
{
   public class NeutronizedCrossPromotionNode
   {
       
      
      public var __id:int;
      
      public var __image:String;
      
      public var __icon:String;
      
      public var __url:String;
      
      public var __game:String;
      
      public var __packageName:String;
      
      public var __appId:int;
      
      public var __urlScheme:String;
      
      public var __message:String;
      
      public function NeutronizedCrossPromotionNode()
      {
         super();
      }
      
      public function NeutronizedCrossPromotionXML() : void
      {
         this.__id = -1;
         this.__image = "";
         this.__icon = "";
         this.__url = "";
         this.__game = "";
         this.__packageName = "";
         this.__appId = -1;
         this.__urlScheme = "";
         this.__message = "";
      }
      
      public function traceSlot() : void
      {
         trace(this.__id);
         trace(this.__image);
         trace(this.__icon);
         trace(this.__url);
         trace(this.__game);
         trace(this.__packageName);
         trace(this.__appId);
         trace(this.__urlScheme);
         trace(this.__message);
      }
   }
}
