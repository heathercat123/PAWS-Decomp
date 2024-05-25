package game_utils
{
   public class FrameData
   {
       
      
      public var x:int;
      
      public var y:int;
      
      public var hat_frame:int;
      
      public var x_offset:int;
      
      public var rotation:Number;
      
      public var inv_scale:Number;
      
      public function FrameData(_x:int, _y:int, _hat_frame:int, _x_offset:int, _rotation:Number = 0, _inv_scale:Number = 1)
      {
         super();
         this.x = _x;
         this.y = _y;
         this.hat_frame = _hat_frame;
         this.x_offset = _x_offset;
         this.rotation = _rotation;
         this.inv_scale = _inv_scale;
      }
   }
}
