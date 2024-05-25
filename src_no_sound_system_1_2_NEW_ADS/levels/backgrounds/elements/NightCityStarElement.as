package levels.backgrounds.elements
{
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.NightStarBackgroundSprite;
   import starling.display.Sprite;
   
   public class NightCityStarElement extends BackgroundElement
   {
       
      
      protected var index:int;
      
      protected var type:int;
      
      protected var sprite:GameSprite;
      
      public function NightCityStarElement(_level:Level, _x:Number, _y:Number, _name:String, _container:Sprite, _index:int)
      {
         var perc:Number = Utils.WIDTH / 406;
         super(_level,int(_x * perc),_y,_name,_container);
         this.index = _index;
         var _speed:Number = 0.5;
         if(level.getBackgroundId() == BackgroundsManager.DESERT)
         {
            this.type = 1;
            _speed = 1;
         }
         else
         {
            this.type = 0;
         }
         this.sprite = new NightStarBackgroundSprite(this.index,_speed,this.type);
         container.addChild(this.sprite);
      }
      
      override public function destroy() : void
      {
         container.removeChild(this.sprite);
         this.sprite.destroy();
         this.sprite.dispose();
         this.sprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.sprite.x = int(Math.floor(xPos));
         this.sprite.y = int(Math.floor(yPos));
         this.sprite.updateScreenPosition();
      }
   }
}
