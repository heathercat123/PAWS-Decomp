package levels.backgrounds.elements
{
   import entities.Entity;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import starling.display.Sprite;
   
   public class NightCastleTroopBackgroundElement extends BackgroundElement
   {
       
      
      protected var counter_1:int;
      
      protected var STATUS:int;
      
      protected var DIRECTION:int;
      
      protected var sprite:GameSprite;
      
      public function NightCastleTroopBackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, _dir:int)
      {
         super(_level,_x,_y,_name,_container);
         originalXPos = xPos;
         this.counter_1 = Math.random() * 30;
         this.STATUS = 0;
         this.DIRECTION = _dir;
         this.sprite.gotoAndStop(1);
         container.addChild(this.sprite);
      }
      
      override public function update() : void
      {
         super.update();
         if(this.STATUS == 0)
         {
            --this.counter_1;
            if(this.counter_1 <= 0)
            {
               this.counter_1 = int(Math.random() * 3 + 3) * 60;
               this.STATUS = 2;
               this.sprite.gotoAndStop(3);
               this.sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(this.STATUS == 1)
         {
            if(this.sprite.gfxHandleClip().isComplete)
            {
               if(this.DIRECTION == Entity.LEFT)
               {
                  this.DIRECTION = Entity.RIGHT;
               }
               else
               {
                  this.DIRECTION = Entity.LEFT;
               }
               if(Math.random() * 100 > 50)
               {
                  this.STATUS = 0;
                  this.sprite.gotoAndStop(1);
                  this.counter_1 = int(Math.random() * 3 + 1) * 60;
               }
               else
               {
                  this.STATUS = 2;
                  this.sprite.gotoAndStop(3);
                  this.counter_1 = int(Math.random() * 3 + 3) * 60;
               }
            }
         }
         else if(this.STATUS == 2)
         {
            if(this.DIRECTION == Entity.LEFT)
            {
               xPos -= 0.05;
            }
            else
            {
               xPos += 0.05;
            }
            if(this.DIRECTION == Entity.RIGHT && xPos >= originalXPos + 8 || this.DIRECTION == Entity.LEFT && xPos <= originalXPos - 8)
            {
               this.STATUS = 1;
               this.sprite.gotoAndStop(2);
               this.sprite.gfxHandleClip().gotoAndPlay(1);
            }
            else if(this.counter_1-- < 0)
            {
               this.STATUS = 0;
               this.sprite.gotoAndStop(1);
               this.counter_1 = int(Math.random() * 3 + 1) * 60;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.sprite.x = int(Math.floor(xPos));
         this.sprite.y = int(Math.floor(yPos));
         this.sprite.updateScreenPosition();
         if(this.DIRECTION == Entity.LEFT)
         {
            this.sprite.scaleX = 1;
         }
         else
         {
            this.sprite.scaleX = -1;
         }
      }
   }
}
