package neutronized
{
   public class NeutronizedCrossPromotionXML
   {
       
      
      public var frequencyCrossPromotion:int;
      
      public var startCrossPromotion:int;
      
      public var resetCrossPromotion:int;
      
      public var slot:Vector.<NeutronizedCrossPromotionNode>;
      
      public function NeutronizedCrossPromotionXML(xml:XML)
      {
         var nNode:NeutronizedCrossPromotionNode = null;
         var prop:XML = null;
         super();
         this.frequencyCrossPromotion = xml.@frequency;
         this.startCrossPromotion = xml.@start;
         this.resetCrossPromotion = xml.@reset;
         this.slot = new Vector.<NeutronizedCrossPromotionNode>();
         for each(prop in xml.slot)
         {
            nNode = new NeutronizedCrossPromotionNode();
            nNode.__id = prop.@id;
            nNode.__image = prop.@image;
            nNode.__icon = prop.@icon;
            nNode.__url = prop.@url;
            nNode.__game = prop.@game;
            nNode.__packageName = prop.@packageName;
            nNode.__appId = prop.@appId;
            nNode.__urlScheme = prop.@urlScheme;
            nNode.__message = prop.@message;
            this.slot.push(nNode);
         }
      }
   }
}
