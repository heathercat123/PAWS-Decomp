package states
{
   import flash.net.*;
   import levels.*;
   import levels.backgrounds.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class TilesTestState implements IState
   {
      
      public static const Map:Class = TilesTestState_Map;
       
      
      internal var map:XML;
      
      public function TilesTestState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         var obj:XML = null;
         var image:Image = null;
         game.enterTilesTestState();
         Utils.world = new Sprite();
         Utils.world.scaleX = Utils.world.scaleY = Utils.GFX_SCALE;
         Utils.rootMovie.addChild(Utils.world);
         this.map = new XML(new Map());
         for each(obj in this.map.tiles[0].obj)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture(obj.@name));
            image.x = obj.@x;
            image.y = obj.@y;
            image.width = obj.@w;
            image.height = obj.@h;
            if(obj.@f_x > 0)
            {
               image.scaleX = -1;
            }
            if(obj.@f_y > 0)
            {
               image.scaleY = -1;
            }
            if(obj.@back > 0)
            {
               image.alpha = 0.5;
            }
            Utils.world.addChild(image);
         }
      }
      
      public function updateState(game:Game) : void
      {
         game.updateTilesTestState();
      }
      
      public function exitState(game:Game) : void
      {
         game.exitTilesTestState();
      }
   }
}
