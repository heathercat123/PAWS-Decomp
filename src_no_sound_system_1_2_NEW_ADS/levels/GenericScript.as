package levels
{
   public class GenericScript
   {
       
      
      public var type:int;
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var rotation:Number;
      
      public var ai:int;
      
      public var value1:Number;
      
      public var value2:Number;
      
      public var value3:Number;
      
      public var front_tile:Boolean;
      
      public function GenericScript(_type:int, _x:Number, _y:Number, _width:Number = 0, _height:Number = 0, _rotation:Number = 0)
      {
         super();
         this.type = _type;
         this.x = _x;
         this.y = _y;
         this.width = _width;
         this.height = _height;
         this.rotation = _rotation;
         this.ai = this.value1 = this.value2 = this.value3 = 0;
         this.front_tile = false;
      }
   }
}
