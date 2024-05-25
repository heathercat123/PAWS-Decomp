package neutronized
{
   public class NeutronizedAdConfigXML
   {
       
      
      public var enabledAdConfig:Boolean;
      
      public var modeAdConfig:String;
      
      public var frequencyNode:Vector.<int>;
      
      public var startNode:Vector.<int>;
      
      public var forceCrossPromotion:Boolean;
      
      public function NeutronizedAdConfigXML(xml:XML)
      {
         var i:int = 0;
         var prop:XML = null;
         super();
         var target_string:String = "ios";
         target_string = "android";
         this.frequencyNode = new Vector.<int>();
         this.startNode = new Vector.<int>();
         for each(prop in xml.config)
         {
            if(prop.@platform == target_string)
            {
               this.enabledAdConfig = prop.enabled;
               this.modeAdConfig = prop.mode;
               for(i = 0; i < prop.frequency.children().length(); i++)
               {
                  this.frequencyNode.push(prop.frequency[i]);
               }
               for(i = 0; i < prop.start.children().length(); i++)
               {
                  this.startNode.push(prop.start[i]);
               }
               this.forceCrossPromotion = prop.forceCrossPromotion;
            }
         }
      }
   }
}
