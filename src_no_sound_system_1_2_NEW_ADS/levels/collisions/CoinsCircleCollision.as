package levels.collisions
{
   import entities.Easings;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import levels.items.CoinItem;
   import levels.items.DarkCoinItem;
   import levels.items.ItemsManager;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class CoinsCircleCollision extends Collision
   {
       
      
      public var coins:Array;
      
      protected var sinCounter1:Number;
      
      protected var redCoinFlag:Boolean;
      
      protected var FORCED_AMOUNT:int;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var MOVEMENT_TYPE:int;
      
      protected var IS_GOING_UP:Boolean;
      
      protected var path_start_y:Number;
      
      protected var path_end_y:Number;
      
      protected var path_start_x:Number;
      
      protected var path_end_x:Number;
      
      public function CoinsCircleCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _forcedAmount:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.FORCED_AMOUNT = _forcedAmount;
         WIDTH = _width;
         sprite = null;
         this.path_start_y = this.path_end_y = this.path_start_x = this.path_end_x = this.sinCounter1 = 0;
         if(_height == 0)
         {
            this.redCoinFlag = false;
         }
         else
         {
            this.redCoinFlag = true;
         }
         this.fetchScripts();
         this.initCoins();
         this.MOVEMENT_TYPE = 0;
         this.IS_GOING_UP = false;
         if(this.path_start_y > 0)
         {
            this.MOVEMENT_TYPE = 1;
            this.setPathEasingVariables();
         }
      }
      
      override public function destroy() : void
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
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
         if(this.MOVEMENT_TYPE == 1)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.setPathEasingVariables();
            }
            yPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         var speed:Number = 0.6 * (1 / WIDTH);
         if(Utils.SEA_LEVEL > 0)
         {
            if(yPos >= Utils.SEA_LEVEL)
            {
               speed *= 0.5;
            }
         }
         this.sinCounter1 -= speed;
         if(this.sinCounter1 < 0)
         {
            this.sinCounter1 += Math.PI * 2;
         }
         var step:Number = Math.PI * 2 / this.coins.length;
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               this.coins[i].update();
               this.coins[i].xPos = xPos + Math.sin(i * step + this.sinCounter1) * WIDTH - 8;
               this.coins[i].yPos = yPos + Math.cos(i * step + this.sinCounter1) * WIDTH - 8;
            }
         }
      }
      
      protected function setPathEasingVariables() : void
      {
         if(this.MOVEMENT_TYPE == 1)
         {
            if(yPos > (this.path_start_y + this.path_end_y) * 0.5)
            {
               yPos = this.t_start = this.path_end_y;
               this.t_diff = -(this.path_end_y - this.path_start_y);
               this.t_time = Math.abs(this.path_end_y - this.path_start_y) / 24;
               if(this.t_time < 1)
               {
                  this.t_time = 1;
               }
               this.t_tick = 0;
               if(Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL)
               {
                  this.t_time *= 2;
               }
            }
            else
            {
               yPos = this.t_start = this.path_start_y;
               this.t_diff = this.path_end_y - this.path_start_y;
               this.t_time = Math.abs(this.path_end_y - this.path_start_y) / 24;
               if(this.t_time < 1)
               {
                  this.t_time = 1;
               }
               this.t_tick = 0;
               if(Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL)
               {
                  this.t_time *= 2;
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var i:int = 0;
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               this.coins[i].checkEntitiesCollision();
               if(this.coins[i].dead)
               {
                  this.coins[i].destroy();
                  this.coins[i] = null;
               }
            }
         }
      }
      
      protected function waitingState() : void
      {
         counter1 = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         for(i = 0; i < this.coins.length; i++)
         {
            if(this.coins[i] != null)
            {
               this.coins[i].updateScreenPosition(camera);
            }
         }
      }
      
      protected function initCoins() : void
      {
         var i:int = 0;
         var coin:CoinItem = null;
         var redCoin:DarkCoinItem = null;
         this.coins = new Array();
         var amount:int = Math.round(WIDTH / 4);
         if(this.FORCED_AMOUNT != 0)
         {
            amount = this.FORCED_AMOUNT;
         }
         var step:Number = Math.PI * 2 / amount;
         for(i = 0; i < amount; i++)
         {
            if(this.redCoinFlag && i == 0)
            {
               redCoin = new DarkCoinItem(level,xPos + Math.sin(step * i) * WIDTH,yPos + Math.cos(step * i) * WIDTH);
               redCoin.level_index = ItemsManager.start_index;
               this.coins.push(redCoin);
               if(Utils.LEVEL_ITEMS[ItemsManager.start_index])
               {
                  redCoin.dead = true;
               }
            }
            else
            {
               coin = new CoinItem(level,xPos + Math.sin(step * i) * WIDTH,yPos + Math.cos(step * i) * WIDTH);
               coin.level_index = ItemsManager.start_index;
               this.coins.push(coin);
               if(Utils.LEVEL_ITEMS[ItemsManager.start_index])
               {
                  coin.dead = true;
               }
            }
            ++ItemsManager.start_index;
         }
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var area_enemy:Rectangle = new Rectangle(xPos - 8,yPos - 8,16,16);
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               area.x = level.scriptsManager.verPathScripts[i].x;
               area.y = level.scriptsManager.verPathScripts[i].y;
               area.width = level.scriptsManager.verPathScripts[i].width;
               area.height = level.scriptsManager.verPathScripts[i].height;
               if(area.intersects(area_enemy))
               {
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = area.y + level.scriptsManager.verPathScripts[i].height;
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               area.x = level.scriptsManager.horPathScripts[i].x;
               area.y = level.scriptsManager.horPathScripts[i].y;
               area.width = level.scriptsManager.horPathScripts[i].width;
               area.height = level.scriptsManager.horPathScripts[i].height;
               if(area.intersects(area_enemy))
               {
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = area.x + level.scriptsManager.horPathScripts[i].width;
               }
            }
         }
      }
   }
}
