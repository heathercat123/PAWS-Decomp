package levels.backgrounds.elements
{
   import entities.Easings;
   import levels.Level;
   import levels.cameras.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class AuroraBackgroundElement extends BackgroundElement
   {
      
      public static var counter:int = 0;
       
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var sin_counter1:Number;
      
      protected var lines:Vector.<Image>;
      
      public function AuroraBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level,_x,_y,_name,_container,isFlipped);
         var amount:int = 12;
         this.counter1 = this.counter2 = 0;
         this.sin_counter1 = Math.random() * Math.PI * 2;
         amount = 24;
         this.lines = new Vector.<Image>();
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_aurora_2"));
            image.touchable = false;
            this.lines.push(image);
            container.addChild(image);
            image.x = 0;
            image.y = i * 1;
            if(xPos <= Utils.WIDTH * 0.5)
            {
               image.pivotX = 24;
            }
            else
            {
               image.pivotX = 0;
            }
            image.pivotY = 24;
            image.scaleX = (24 - i) / 4;
            image.alpha = this.getAlpha(i);
         }
         ++AuroraBackgroundElement.counter;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.lines.length; i++)
         {
            container.removeChild(this.lines[i]);
            this.lines[i].dispose();
            this.lines[i] = null;
         }
         this.lines = null;
         super.destroy();
      }
      
      protected function getAlpha(i:int) : Number
      {
         return (24 - i) / 24;
      }
      
      override public function update() : void
      {
         super.update();
         this.sin_counter1 += 0.025;
         if(this.sin_counter1 > Math.PI * 2)
         {
            this.sin_counter1 -= Math.PI * 2;
         }
         if(xPos <= Utils.WIDTH * 0.5)
         {
            xPos = level.camera.WIDTH * 0.4;
         }
         else
         {
            xPos = level.camera.WIDTH * 0.6;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var amount:Number = NaN;
         super.updateScreenPosition(camera);
         var alpha_decrease:Number = 1 / (this.lines.length * 2 + 1);
         for(i = int(this.lines.length - 1); i >= 0; i--)
         {
            alpha_decrease = Easings.easeOutQuart(i,0,1,this.lines.length);
            if(alpha_decrease <= 0.2)
            {
               alpha_decrease = 0.2;
            }
            this.lines[i].x = -container.x + int(Math.floor(xPos + Math.sin(this.sin_counter1 + i * 0.8) * (4 * alpha_decrease)));
            this.lines[i].y = int(Math.floor(yPos + i * 1)) - 8;
            container.setChildIndex(this.lines[i],container.numChildren - 1);
         }
      }
   }
}
