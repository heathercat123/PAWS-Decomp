package starling.display
{
   import entities.Easings;
   
   public class Raylight extends Quad
   {
       
      
      protected var tickness:Number;
      
      protected var minAge:Number;
      
      protected var maxAge:Number;
      
      protected var age:Number;
      
      protected var size:Number;
      
      protected var angle:Number;
      
      protected var speed:Number;
      
      protected var IS_GROWING:Boolean;
      
      protected var LINEAR:Boolean;
      
      protected var IS_SPINNING:Boolean;
      
      protected var IS_VANISHING:Boolean;
      
      public var IS_DONE:Boolean;
      
      protected var counter1:int;
      
      protected var tick:Number;
      
      protected var counter2:int;
      
      protected var tick2:Number;
      
      protected var originalTickness:Number;
      
      public function Raylight(_age:Number, _size:Number, _angle:Number)
      {
         super(1,1,16773608);
         this.IS_DONE = false;
         this.IS_GROWING = false;
         this.IS_SPINNING = false;
         this.IS_VANISHING = false;
         this.LINEAR = false;
         this.age = _age;
         this.size = _size;
         this.angle = _angle;
         this.evaluateSpeed();
         setVertexAlpha(0,1);
         setVertexAlpha(1,0);
         setVertexAlpha(2,0);
         setVertexAlpha(3,0);
         scaleX = scaleY = this.size * (this.age / 100);
         rotation = this.angle;
         this.setTickness(0.1);
      }
      
      public function update() : void
      {
         var var1:Number = NaN;
         if(this.IS_GROWING)
         {
            --this.counter1;
            if(this.counter1 < 0)
            {
               this.tick += 1 / 60;
               if(this.tick >= 4)
               {
                  this.tick = 4;
               }
               if(!this.LINEAR)
               {
                  var1 = Easings.easeInBounce(this.tick,0,1,4) * this.size;
               }
               else
               {
                  var1 = Easings.easeOutBack(this.tick,0,1,4) * this.size;
               }
               scaleX = scaleY = var1 * 0.5;
               this.setTickness(var1);
            }
            --this.counter2;
            if(this.counter2 < 0)
            {
               this.tick2 += 1 / 60;
               if(this.tick2 >= 4)
               {
                  this.tick2 = 4;
                  this.IS_DONE = true;
               }
               var1 = Easings.easeOutBounce(this.tick2,0,1,4);
               if(!this.LINEAR)
               {
                  rotation += var1 * this.speed;
                  if(rotation >= Math.PI * 2)
                  {
                     rotation -= Math.PI * 2;
                  }
               }
            }
         }
         else if(this.IS_SPINNING)
         {
            rotation += this.speed;
            if(rotation >= Math.PI * 2)
            {
               rotation -= Math.PI * 2;
            }
         }
         else if(this.IS_VANISHING)
         {
            this.tick += 1 / 60;
            if(this.tick >= 4)
            {
               this.tick = 4;
            }
            var1 = Easings.easeLinear(this.tick,1,2,4);
            rotation += this.speed * var1;
            if(rotation >= Math.PI * 2)
            {
               rotation -= Math.PI * 2;
            }
            if(this.tick >= 2)
            {
               this.tick2 += 1 / 60;
               if(this.tick2 >= 2)
               {
                  this.tick2 = 2;
                  this.IS_DONE = true;
               }
               this.tickness = this.originalTickness * Easings.easeLinear(this.tick2,1,-1,2);
               this.setTickness(this.tickness);
            }
         }
      }
      
      public function setTickness(value:Number) : void
      {
         this.tickness = value;
         _vertexData.setPoint(1,"position",0.5 + 0.5 * this.tickness,0.5 - 0.5 * this.tickness);
         _vertexData.setPoint(2,"position",0.5 - 0.5 * this.tickness,0.5 + 0.5 * this.tickness);
      }
      
      public function grow(_linear:Boolean = false) : void
      {
         this.IS_DONE = this.IS_SPINNING = this.IS_VANISHING = false;
         this.IS_GROWING = true;
         this.LINEAR = _linear;
         this.setTickness(0.01);
         scaleX = scaleY = 0.1;
         this.counter1 = (100 - this.age) * (100 - this.age) / 25;
         this.tick = 0;
         this.counter2 = Math.abs(this.age - this.maxAge) * Math.abs(this.age - this.maxAge) * 0.025;
         this.tick2 = 0;
      }
      
      public function spin() : void
      {
         this.IS_DONE = this.IS_GROWING = this.IS_VANISHING = false;
         this.IS_SPINNING = true;
      }
      
      public function vanish() : void
      {
         this.IS_DONE = this.IS_GROWING = this.IS_SPINNING = false;
         this.IS_VANISHING = true;
         this.counter1 = this.counter2 = 0;
         this.tick = this.tick2 = 0;
         this.originalTickness = this.tickness;
      }
      
      public function setMinMaxAge(_min:int, _max:int) : void
      {
         this.minAge = _min;
         this.maxAge = _max;
      }
      
      protected function evaluateSpeed() : void
      {
         this.speed = Math.abs(this.age * this.age) * 0.00008;
         this.speed *= 0.1;
      }
   }
}
