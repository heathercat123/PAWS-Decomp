package game_utils
{
   public class EntityData
   {
       
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var xVel:Number;
      
      public var yVel:Number;
      
      public var xFriction:Number;
      
      public var yFriction:Number;
      
      public var counter1:Number;
      
      public var counter2:Number;
      
      public var counter3:Number;
      
      public var counter4:Number;
      
      public function EntityData(_xPos:Number = 0, _yPos:Number = 0, _xVel:Number = 0, _yVel:Number = 0, _xFriction:Number = 0, _yFriction:Number = 0, _counter1:Number = 0, _counter2:Number = 0, _counter3:Number = 0, _counter4:Number = 0)
      {
         super();
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.xVel = _xVel;
         this.yVel = _yVel;
         this.xFriction = _xFriction;
         this.yFriction = _yFriction;
         this.counter1 = _counter1;
         this.counter2 = _counter2;
         this.counter3 = _counter3;
         this.counter4 = _counter4;
      }
   }
}
