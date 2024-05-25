package levels.items
{
   import flash.geom.Point;
   import levels.GenericScript;
   import levels.Level;
   import levels.cameras.*;
   
   public class ItemsManager
   {
      
      public static var start_index:int = 0;
       
      
      public var level:Level;
      
      public var items:Array;
      
      public var coin_frame:int;
      
      public var coin_frame_counter:int;
      
      public function ItemsManager(_level:Level)
      {
         var i:int = 0;
         var item:Item = null;
         var gScript:GenericScript = null;
         super();
         this.level = _level;
         this.items = new Array();
         start_index = Utils.CurrentSubLevel * Utils.ITEMS_PER_LEVEL;
         for(i = 0; i < this.level.scriptsManager.levelItems.length; i++)
         {
            gScript = this.level.scriptsManager.levelItems[i];
            if(Utils.LEVEL_ITEMS[start_index] == false)
            {
               if(gScript.type == 0)
               {
                  item = new BellItem(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
               }
               else if(gScript.type == 1)
               {
                  item = new KeyItem(this.level,gScript.x,gScript.y,gScript.width);
               }
               else if(gScript.type == 2)
               {
                  item = new BottleItem(this.level,gScript.x,gScript.y);
               }
               else if(gScript.type == 3)
               {
                  item = new CoinItem(this.level,gScript.x,gScript.y,gScript.width);
               }
               else if(gScript.type == 4)
               {
                  item = new DarkCoinItem(this.level,gScript.x,gScript.y);
               }
               else if(gScript.type == 6)
               {
                  item = new CakeItem(this.level,gScript.x,gScript.y,gScript.width);
               }
               else if(gScript.type == 7)
               {
                  item = new QuestionMarkItem(this.level,gScript.x,gScript.y,0,0,1);
               }
               else if(gScript.type == 8)
               {
                  item = new EggItem(this.level,gScript.x,gScript.y);
               }
               item.level_index = start_index;
               this.items.push(item);
            }
            ++start_index;
         }
         this.coin_frame = 0;
         this.coin_frame_counter = 0;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.items.length; i++)
         {
            if(this.items[i] != null)
            {
               this.items[i].destroy();
               this.items[i] = null;
            }
         }
         this.items = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         ++this.coin_frame_counter;
         if(this.coin_frame_counter > 9)
         {
            this.coin_frame_counter = 0;
            ++this.coin_frame;
            if(this.coin_frame >= 4)
            {
               this.coin_frame = 0;
            }
         }
         for(i = 0; i < this.items.length; i++)
         {
            if(this.items[i] != null)
            {
               this.items[i].update();
               this.items[i].checkEntitiesCollision();
               if(this.items[i].dead)
               {
                  this.items[i].destroy();
                  this.items[i] = null;
               }
            }
         }
      }
      
      public function postInit() : void
      {
         var i:int = 0;
         for(i = 0; i < this.items.length; i++)
         {
            if(this.items[i] != null)
            {
               this.items[i].postInit();
            }
         }
      }
      
      public function updateFreeze() : void
      {
         var i:int = 0;
         for(i = 0; i < this.items.length; i++)
         {
            if(this.items[i] != null)
            {
               this.items[i].updateFreeze();
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.items.length; i++)
         {
            if(this.items[i] != null)
            {
               this.items[i].updateScreenPosition(camera);
            }
         }
      }
      
      public function getItemAt(xPos:Number, yPos:Number) : Item
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         for(i = 0; i < this.items.length; i++)
         {
            if(this.items[i] != null)
            {
               if(this.items[i].containsPoint(point))
               {
                  return this.items[i];
               }
            }
         }
         return null;
      }
      
      public function createButterflies() : void
      {
         var i:int = 0;
         ButterflyItem.CAUGHT_COUNTER = 0;
         for(i = 0; i < 5; i++)
         {
            this.items.push(new ButterflyItem(this.level,this.level.levelData.butterflyPositions[i].x,this.level.levelData.butterflyPositions[i].y,i));
         }
      }
   }
}
