package interfaces.map.coins
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import interfaces.map.*;
   
   public class MapCoins
   {
       
      
      public var worldMap:WorldMap;
      
      public var coins:Array;
      
      public function MapCoins(_worldMap:WorldMap)
      {
         var i:int = 0;
         var j:int = 0;
         var level_index:int = 0;
         var mapCoin:MapCoin = null;
         var coinsChoice:Array = null;
         var selectedCoins:Array = null;
         var randomValue:int = 0;
         var found:Boolean = false;
         super();
         this.worldMap = _worldMap;
         coinsChoice = new Array();
         selectedCoins = new Array();
         for(i = 0; i < this.worldMap.mapLoader.mapCoins.length; i++)
         {
            level_index = int(this.worldMap.mapLoader.mapCoins[i].width);
            if(Utils.Slot.levelSeqUnlocked[level_index - 1])
            {
               coinsChoice.push(level_index);
            }
         }
         var amount:int = int(coinsChoice.length * 0.5);
         for(i = 0; i < amount; i++)
         {
            do
            {
               randomValue = int(Math.random() * coinsChoice.length);
               found = true;
               for(j = 0; j < selectedCoins.length; j++)
               {
                  if(selectedCoins[j] == coinsChoice[randomValue])
                  {
                     found = false;
                  }
               }
               if(found)
               {
                  selectedCoins.push(coinsChoice[randomValue]);
               }
            }
            while(found == false);
            
         }
         this.coins = new Array();
         for(i = 0; i < this.worldMap.mapLoader.mapCoins.length; i++)
         {
            for(j = 0; j < selectedCoins.length; j++)
            {
               if(selectedCoins[j] == this.worldMap.mapLoader.mapCoins[i].width)
               {
                  if(Math.random() * 100 > 75)
                  {
                     mapCoin = new MapCoin(this.worldMap,this.worldMap.mapLoader.mapCoins[i].x,this.worldMap.mapLoader.mapCoins[i].y,this.worldMap.mapLoader.mapCoins[i].width);
                     this.coins.push(mapCoin);
                  }
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               this.coins[i].destroy();
               this.coins[i] = null;
            }
         }
         this.coins = null;
         this.worldMap = null;
      }
      
      public function processInput(xPos:Number, yPos:Number) : void
      {
         var i:int = 0;
         var rectangle:Rectangle = null;
         if(Utils.PauseOn || Utils.GateUnlockOn || Utils.PremiumOn || Utils.QuestAvailablePanelOn)
         {
            return;
         }
         var point:Point = new Point(xPos,yPos);
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               rectangle = this.coins[i].getAABB();
               if(rectangle.containsPoint(point))
               {
                  this.coins[i].collect();
               }
            }
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               this.coins[i].update();
               if(this.coins[i].dead)
               {
                  this.coins[i].destroy();
                  this.coins[i] = null;
               }
            }
         }
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               this.coins[i].updateScreenPosition(mapCamera);
            }
         }
      }
      
      public function enableButtons() : void
      {
      }
      
      public function disableButtons() : void
      {
      }
   }
}
