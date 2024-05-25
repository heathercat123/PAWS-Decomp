package com.distriqt.extension.gameservices.achievements
{
   public class Achievement
   {
       
      
      private var _id:String = "";
      
      private var _name:String = "";
      
      private var _description:String = "";
      
      private var _points:int = 0;
      
      private var _state:int;
      
      private var _type:int;
      
      private var _currentSteps:int = 0;
      
      private var _totalSteps:int = 0;
      
      private var _iconUnlockedUrl:String = "";
      
      private var _iconLockedUrl:String = "";
      
      public function Achievement()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : Achievement
      {
         var _loc2_:Achievement = new Achievement();
         _loc2_.id = param1.id;
         _loc2_.name = param1.name;
         _loc2_.description = param1.description;
         _loc2_.state = param1.state;
         _loc2_.type = param1.type;
         _loc2_.iconLockedUrl = param1.iconLockedUrl;
         _loc2_.iconUnlockedUrl = param1.iconUnlockedUrl;
         _loc2_.currentSteps = param1.currentSteps;
         _loc2_.totalSteps = param1.totalSteps;
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
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function set points(param1:int) : void
      {
         _points = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get currentSteps() : int
      {
         return _currentSteps;
      }
      
      public function set currentSteps(param1:int) : void
      {
         _currentSteps = param1;
      }
      
      public function get totalSteps() : int
      {
         return _totalSteps;
      }
      
      public function set totalSteps(param1:int) : void
      {
         _totalSteps = param1;
      }
      
      public function get iconUnlockedUrl() : String
      {
         return _iconUnlockedUrl;
      }
      
      public function set iconUnlockedUrl(param1:String) : void
      {
         _iconUnlockedUrl = param1;
      }
      
      public function get iconLockedUrl() : String
      {
         return _iconLockedUrl;
      }
      
      public function set iconLockedUrl(param1:String) : void
      {
         _iconLockedUrl = param1;
      }
   }
}
