package levels.backgrounds.elements
{
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import starling.display.Sprite;
   
   public class BackgroundLightElement extends BackgroundElement
   {
       
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var IS_CAVE:Boolean;
      
      protected var IS_UNDERWATER:Boolean;
      
      protected var sin_counter:Number;
      
      public function BackgroundLightElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false)
      {
         super(_level,_x,_y,_name,_container,isFlipped);
         this.IS_CAVE = false;
         this.IS_UNDERWATER = false;
         if(level.getBackgroundId() == BackgroundsManager.MINERAL_CAVE)
         {
            this.IS_CAVE = true;
         }
         else if(level.getBackgroundId() == BackgroundsManager.UNDERWATER)
         {
            this.IS_UNDERWATER = true;
            this.sin_counter = Math.random() * Math.PI * 2;
         }
         this.counter1 = this.counter2 = 0;
         container.setChildIndex(image,0);
      }
      
      override public function update() : void
      {
         super.update();
         if(this.IS_UNDERWATER)
         {
            image.alpha = 0.12;
            this.sin_counter += 0.01;
            if(this.sin_counter > Math.PI * 2)
            {
               this.sin_counter -= Math.PI * 2;
            }
            xPos = originalXPos + Math.sin(this.sin_counter) * 8;
            image.alpha = 0.12 + Math.sin(this.sin_counter) * 0.1;
         }
         else if(++this.counter1 > 2)
         {
            this.counter1 = 0;
            if(this.counter2 == 0)
            {
               if(this.IS_CAVE)
               {
                  image.alpha = 0.12;
               }
               else
               {
                  image.alpha = 0.2;
               }
               this.counter2 = 1;
            }
            else
            {
               if(this.IS_CAVE)
               {
                  image.alpha = 0.14;
               }
               else
               {
                  image.alpha = 0.25;
               }
               this.counter2 = 0;
            }
         }
      }
   }
}
