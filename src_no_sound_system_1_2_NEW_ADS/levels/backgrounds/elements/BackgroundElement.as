package levels.backgrounds.elements
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class BackgroundElement
   {
       
      
      protected var level:Level;
      
      public var image:Image;
      
      public var originalXPos:Number;
      
      public var originalYPos:Number;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var xVel:Number;
      
      public var yVel:Number;
      
      public var container:Sprite;
      
      public function BackgroundElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, isFlipped:Boolean = false, isFlippedVer:Boolean = false, _width:int = -1, _height:int = -1)
      {
         super();
         this.level = _level;
         this.container = _container;
         if(_name != "")
         {
            this.image = new Image(TextureManager.GetBackgroundTexture().getTexture(_name));
            if(isFlipped)
            {
               this.image.scaleX = -1;
            }
            if(isFlippedVer)
            {
               this.image.scaleY = -1;
            }
            if(_width > 0)
            {
               this.image.width = _width * this.image.scaleX;
            }
            if(_height > 0)
            {
               this.image.height = _height * this.image.scaleY;
            }
            this.container.addChild(this.image);
         }
         else
         {
            this.image = null;
         }
         this.xPos = this.originalXPos = _x;
         this.yPos = this.originalYPos = _y;
      }
      
      public function destroy() : void
      {
         if(this.image != null)
         {
            this.container.removeChild(this.image);
            this.image.dispose();
            this.image = null;
         }
         this.container = null;
         this.level = null;
      }
      
      public function update() : void
      {
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.image != null)
         {
            this.image.x = int(Math.floor(this.xPos));
            this.image.y = int(Math.floor(this.yPos));
         }
      }
   }
}
