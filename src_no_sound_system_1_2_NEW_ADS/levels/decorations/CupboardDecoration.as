package levels.decorations
{
   import levels.Level;
   import levels.cameras.*;
   import sprites.decorations.GenericDecorationSprite;
   import starling.display.*;
   
   public class CupboardDecoration extends Decoration
   {
       
      
      public var ID:int;
      
      protected var leds:Vector.<Image>;
      
      protected var container:Sprite;
      
      protected var counter:int;
      
      public function CupboardDecoration(_level:Level, _xPos:Number, _yPos:Number, _flipped:int, _id:int)
      {
         super(_level,_xPos,_yPos);
         if(_id == GenericDecoration.CUPBOARD_1)
         {
            this.ID = 0;
         }
         else if(_id == GenericDecoration.CUPBOARD_2)
         {
            this.ID = 1;
         }
         else if(_id == GenericDecoration.CUPBOARD_3)
         {
            this.ID = 2;
         }
         sprite = new GenericDecorationSprite(_id);
         if(_flipped > 0)
         {
            sprite.scaleX = -1;
         }
         this.counter = Math.random() * 30 + 30;
         this.container = new Sprite();
         this.container.addChild(sprite);
         Utils.backWorld.addChild(this.container);
         if(this.ID == 2)
         {
            this.initLeds();
         }
         if(this.ID == 0)
         {
            Utils.backWorld.setChildIndex(this.container,0);
         }
      }
      
      override public function destroy() : void
      {
         this.container.removeChild(sprite);
         Utils.world.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.ID == 2)
         {
            if(this.counter-- < 0)
            {
               this.counter = Math.random() * 30 + 30;
               this.randomizeLeds();
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
         sprite.updateScreenPosition();
      }
      
      protected function initLeds() : void
      {
         var i:int = 0;
         var image:Image = null;
         var rand_x:int = 0;
         var rand_y:int = 0;
         var amount:int = 12;
         this.leds = new Vector.<Image>();
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("tree_tile_6"));
            image.width = image.height = 1;
            image.touchable = false;
            this.leds.push(image);
            this.container.addChild(image);
         }
         this.randomizeLeds();
      }
      
      protected function randomizeLeds() : void
      {
         var i:int = 0;
         var rand_x:int = 0;
         var rand_y:int = 0;
         for(i = 0; i < this.leds.length; i++)
         {
            rand_x = int(Math.random() * 8);
            rand_y = int(Math.random() * 3);
            this.leds[i].x = int(8 + 2 * rand_x);
            this.leds[i].y = int(8 + 9 * rand_y);
         }
      }
   }
}
