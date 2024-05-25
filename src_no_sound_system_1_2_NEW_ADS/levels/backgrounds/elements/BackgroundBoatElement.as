package levels.backgrounds.elements
{
   import levels.Level;
   import starling.display.Sprite;
   
   public class BackgroundBoatElement extends BackgroundElement
   {
       
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var sin_counter:Number;
      
      protected var radius:Number;
      
      public function BackgroundBoatElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false)
      {
         super(_level,_x,_y,_name,_container,isFlipped);
         this.counter1 = this.counter2 = 0;
         this.sin_counter = Math.random() * Math.PI * 2;
         this.radius = 4;
      }
      
      override public function update() : void
      {
         super.update();
         this.sin_counter += 0.01;
         if(this.sin_counter >= Math.PI * 2)
         {
            this.sin_counter -= Math.PI * 2;
         }
         yPos = originalYPos + Math.sin(this.sin_counter) * this.radius;
      }
   }
}
