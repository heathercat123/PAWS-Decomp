package com.distriqt.extension.inappbilling
{
   public class SubscriptionOffer
   {
       
      
      public var id:String;
      
      public var requiresSignature:Boolean = false;
      
      public var storeDeterminedEligible:Boolean = false;
      
      private var _phases:Vector.<SubscriptionPhase>;
      
      private var _tags:Vector.<String>;
      
      public function SubscriptionOffer()
      {
         super();
         _phases = new Vector.<SubscriptionPhase>(0);
         _tags = new Vector.<String>(0);
      }
      
      internal static function fromObject(param1:Object) : SubscriptionOffer
      {
         var _loc2_:SubscriptionOffer = new SubscriptionOffer();
         if(param1.hasOwnProperty("id"))
         {
            _loc2_.id = param1.id;
         }
         if(param1.hasOwnProperty("phases"))
         {
            for each(var _loc3_:int in param1.phases)
            {
               _loc2_._phases.push(SubscriptionPhase.fromObject(_loc3_));
            }
         }
         if(param1.hasOwnProperty("tags"))
         {
            for each(var _loc4_:int in param1.tags)
            {
               _loc2_._tags.push(_loc4_);
            }
         }
         if(param1.hasOwnProperty("requiresSignature"))
         {
            _loc2_.requiresSignature = param1.requiresSignature;
         }
         if(param1.hasOwnProperty("storeDeterminedEligible"))
         {
            _loc2_.storeDeterminedEligible = param1.storeDeterminedEligible;
         }
         return _loc2_;
      }
      
      public function get pricingPhases() : Vector.<SubscriptionPhase>
      {
         return _phases;
      }
      
      public function get tags() : Vector.<String>
      {
         return _tags;
      }
   }
}
