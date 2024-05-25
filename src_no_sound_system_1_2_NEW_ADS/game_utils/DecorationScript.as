package game_utils
{
   public class DecorationScript
   {
       
      
      public var type:int;
      
      public var name:String;
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var scale_x:Number;
      
      public var scale_y:Number;
      
      public var param_1:int;
      
      public var param_2:int;
      
      public function DecorationScript(_name:String, _x:Number, _y:Number, _width:Number = 0, _height:Number = 0, _scale_x:Number = 1, _scale_y:Number = 1, _param_1:int = 0, _param_2:int = 0)
      {
         super();
         this.type = 0;
         this.name = _name;
         this.x = _x;
         this.y = _y;
         this.width = _width;
         this.height = _height;
         this.scale_x = _scale_x;
         this.scale_y = _scale_y;
         this.param_1 = _param_1;
         this.param_2 = _param_2;
      }
      
      public function destroy() : void
      {
         this.name = null;
      }
   }
}
