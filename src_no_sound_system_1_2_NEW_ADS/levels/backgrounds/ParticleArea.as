package levels.backgrounds
{
   import flash.geom.Rectangle;
   
   public class ParticleArea
   {
       
      
      public var aabb:Rectangle;
      
      public var counter1:int;
      
      public var counter2:int;
      
      public var counter3:int;
      
      public function ParticleArea(x:Number, y:Number, width:Number, height:Number)
      {
         super();
         this.aabb = new Rectangle(x,y,width,height);
         this.counter1 = -Math.random() * 30;
         this.counter2 = this.counter3 = 0;
      }
      
      public function destroy() : void
      {
         this.aabb = null;
      }
   }
}
