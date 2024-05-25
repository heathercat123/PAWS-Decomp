package levels.backgrounds.elements
{
   import entities.Easings;
   import levels.Level;
   import levels.cameras.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class DesertSunBackgroundElement extends BackgroundElement
   {
       
      
      protected var TYPE:int;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var sin_counter1:Number;
      
      protected var lines:Vector.<Image>;
      
      public function DesertSunBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false, type:int = 0)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level,_x,_y,_name,_container,isFlipped);
         this.TYPE = type;
         var amount:int = 12;
         this.counter1 = this.counter2 = 0;
         this.sin_counter1 = 0;
         if(this.TYPE == 1)
         {
            amount = 24;
         }
         this.lines = new Vector.<Image>();
         for(i = 0; i < amount; i++)
         {
            if(this.TYPE == 0)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("desert_bg_16"));
            }
            else if(i == 0 || i == 1 || i == 3)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("beach_night_bg_2"));
            }
            else if(i == 23)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("beach_night_bg_6"));
            }
            else if(i == 22 || i == 21)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("beach_night_bg_5"));
            }
            else if(i == 20 || i == 19 || i == 18 || i == 17)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("beach_night_bg_4"));
            }
            else
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("beach_night_bg_3"));
            }
            image.touchable = false;
            this.lines.push(image);
            container.addChild(image);
            if(this.TYPE == 0)
            {
               image.width = 156;
            }
            image.height = 1;
            image.x = 0;
            if(this.TYPE == 0)
            {
               image.y = 64 + i;
            }
            else
            {
               image.y = i;
            }
            image.alpha = this.getAlpha(i);
         }
      }
      
      protected function getAlpha(i:int) : Number
      {
         if(this.TYPE == 1)
         {
            if(i < 12)
            {
               return 1;
            }
            return 1;
         }
         if(i == 6 || i == 7)
         {
            return 0.8;
         }
         if(i == 8)
         {
            return 0.6;
         }
         if(i == 9)
         {
            return 0.5;
         }
         if(i > 9)
         {
            return 0.2;
         }
         return 1;
      }
      
      override public function update() : void
      {
         super.update();
         this.sin_counter1 += 0.025;
         if(this.sin_counter1 > Math.PI * 2)
         {
            this.sin_counter1 -= Math.PI * 2;
         }
         if(this.TYPE == 0)
         {
            xPos = level.camera.WIDTH * 0.5 - 80;
         }
         else
         {
            xPos = level.camera.WIDTH * 0.5 - 32;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var amount:Number = NaN;
         super.updateScreenPosition(camera);
         var alpha_decrease:Number = 1 / (this.lines.length * 2 + 1);
         for(i = 0; i < this.lines.length; i++)
         {
            if(this.TYPE == 1)
            {
               alpha_decrease = Easings.easeOutQuart(i,0,1,this.lines.length);
            }
            if(this.TYPE == 0)
            {
               this.lines[i].x = int(Math.floor(xPos + 2 + Math.sin(this.sin_counter1 + i * 0.8) * (24 * (alpha_decrease * i))));
            }
            else
            {
               this.lines[i].x = -container.x + int(Math.floor(xPos + 2 + Math.sin(this.sin_counter1 + i * 0.8) * (4 * alpha_decrease)));
            }
            if(this.TYPE == 0)
            {
               this.lines[i].y = int(Math.floor(yPos + 65 + i));
            }
            else
            {
               this.lines[i].y = int(Math.floor(yPos + i));
            }
            if(this.TYPE == 1)
            {
               container.setChildIndex(this.lines[i],container.numChildren - 1);
            }
         }
      }
   }
}
