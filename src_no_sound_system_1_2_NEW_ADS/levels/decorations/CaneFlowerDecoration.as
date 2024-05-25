package levels.decorations
{
   import flash.geom.Point;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.decorations.CaneFlowerDecorationSprite;
   
   public class CaneFlowerDecoration extends Decoration
   {
       
      
      protected var TYPE:int;
      
      protected var bodySprite:GameSprite;
      
      protected var bodyHeight:int;
      
      protected var leavesSprite:Array;
      
      protected var leavesData:Array;
      
      protected var ground_level:Number;
      
      public function CaneFlowerDecoration(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0)
      {
         this.TYPE = _type;
         super(_level,_xPos + 4,_yPos);
         sprite = new CaneFlowerDecorationSprite(this.TYPE);
         sprite.gotoAndStop(1);
         Utils.topWorld.addChild(sprite);
         this.bodySprite = new CaneFlowerDecorationSprite(this.TYPE);
         this.bodySprite.gotoAndStop(2);
         this.bodySprite.gfxHandleClip().gotoAndStop(1);
         Utils.topWorld.addChild(this.bodySprite);
         var x_t:int = int(xPos / 8);
         if(x_t % 2 == 0)
         {
            sprite.gfxHandleClip().gotoAndPlay(2);
         }
         this.findBodyHeight();
         this.initLeaves();
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
         Utils.topWorld.removeChild(this.bodySprite);
         this.bodySprite.destroy();
         this.bodySprite.dispose();
         this.bodySprite = null;
      }
      
      protected function findBodyHeight() : void
      {
         var j:int = 0;
         var x_t:int = 0;
         var y_t:int = 0;
         var found:Boolean = false;
         this.ground_level = 0;
         x_t = xPos / Utils.TILE_WIDTH;
         for(j = 0; j < 6; j++)
         {
            y_t = int((yPos + j * 16) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) != 0 && !found)
            {
               found = true;
               this.ground_level = y_t * Utils.TILE_HEIGHT;
            }
         }
         this.bodyHeight = this.ground_level - (yPos + 20) + 1;
      }
      
      protected function initLeaves() : void
      {
         var i:int = 0;
         var amount:int = 0;
         var gSprite:GameSprite = null;
         var underwaterBodyHeight:Number = NaN;
         var isEven:Boolean = false;
         var x_t:int = 0;
         this.leavesSprite = null;
         this.leavesData = null;
         if(this.ground_level > Utils.SEA_LEVEL && Utils.SEA_LEVEL != 0)
         {
            underwaterBodyHeight = this.ground_level - Utils.SEA_LEVEL;
            isEven = false;
            x_t = int(xPos / 8);
            if(x_t % 2 == 0)
            {
               isEven = true;
            }
            amount = int(underwaterBodyHeight / 8);
            if(amount > 0)
            {
               this.leavesSprite = new Array();
               this.leavesData = new Array();
               for(i = 0; i < amount; i++)
               {
                  if(isEven && i % 2 == 0 || !isEven && i % 2 != 0)
                  {
                     gSprite = new CaneFlowerDecorationSprite(this.TYPE);
                     gSprite.gotoAndStop(2);
                     gSprite.gfxHandleClip().gotoAndStop(2);
                     this.leavesSprite.push(gSprite);
                     Utils.topWorld.addChild(gSprite);
                     this.leavesData.push(new Point(0,i));
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         this.bodySprite.x = sprite.x + 0;
         this.bodySprite.y = sprite.y + 20;
         this.bodySprite.height = this.bodyHeight;
         this.bodySprite.updateScreenPosition();
         if(this.leavesSprite != null)
         {
            for(i = 0; i < this.leavesSprite.length; i++)
            {
               this.leavesSprite[i].x = sprite.x;
               this.leavesSprite[i].y = int(Math.floor(Utils.SEA_LEVEL + this.leavesData[i].y * 8 - camera.yPos));
               this.leavesSprite[i].updateScreenPosition();
            }
         }
      }
   }
}
