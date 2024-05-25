package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.decorations.GenericDecorationSprite;
   import starling.display.Image;
   
   public class StreetLampDecoration extends Decoration
   {
       
      
      public var isBlown:Boolean;
      
      protected var light:Image;
      
      protected var counter_1:int;
      
      protected var type:int;
      
      public function StreetLampDecoration(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.type = _type;
         this.light = new Image(TextureManager.sTextureAtlas.getTexture("street_lamp_light_1"));
         this.light.touchable = false;
         Utils.backWorld.addChild(this.light);
         this.light.alpha = 0.5;
         if(_type == 0)
         {
            sprite = new GenericDecorationSprite(GenericDecoration.STREET_LAMP_1);
         }
         else
         {
            sprite = new GenericDecorationSprite(GenericDecoration.STREET_LAMP_2);
         }
         Utils.backWorld.addChild(sprite);
         this.counter_1 = 0;
         if(_direction > 0)
         {
            sprite.scaleX = -1;
         }
      }
      
      override public function update() : void
      {
         super.update();
         ++this.counter_1;
         if(this.counter_1 >= 10)
         {
            this.counter_1 = 0;
            if(this.light.alpha == 0.5)
            {
               this.light.alpha = 0.47;
            }
            else
            {
               this.light.alpha = 0.5;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.light.x = sprite.x - 36;
         this.light.y = sprite.y - 32;
         Utils.backWorld.setChildIndex(this.light,0);
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(this.light);
         this.light.dispose();
         this.light = null;
         Utils.backWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
