package com.distriqt.extension.gameservices.multiplayer
{
   public class Invitation
   {
      
      public static const INVITATION_TYPE_REAL_TIME:int = 0;
      
      public static const INVITATION_TYPE_TURN_BASED:int = 1;
       
      
      private var _id:String;
      
      private var _created:int;
      
      private var _type:int;
      
      private var _inviter:Participant;
      
      public function Invitation()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : Invitation
      {
         var _loc2_:Invitation = new Invitation();
         _loc2_.id = param1.id;
         _loc2_.created = param1.created;
         _loc2_.type = param1.type;
         _loc2_.inviter = Participant.fromObject(param1.inviter);
         return _loc2_;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function set id(param1:String) : void
      {
         _id = param1;
      }
      
      public function get created() : int
      {
         return _created;
      }
      
      public function set created(param1:int) : void
      {
         _created = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get inviter() : Participant
      {
         return _inviter;
      }
      
      public function set inviter(param1:Participant) : void
      {
         _inviter = param1;
      }
   }
}
