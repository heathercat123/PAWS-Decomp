package levels
{
   import entities.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class LevelData
   {
       
      
      public var level:Level;
      
      public var tiles:Array;
      
      public var tiles_type:Array;
      
      public var LEVEL_WIDTH:int;
      
      public var LEVEL_HEIGHT:int;
      
      public var LEVEL_GROUND_Y:int;
      
      public var LEFT_MARGIN:Number;
      
      public var TOP_MARGIN:Number;
      
      public var RIGHT_MARGIN:Number;
      
      public var BOTTOM_MARGIN:Number;
      
      public var T_WIDTH:int;
      
      public var T_HEIGHT:int;
      
      public var T_GROUND_Y:int;
      
      public var START_X:int;
      
      public var START_Y:int;
      
      public var END_X:int;
      
      public var END_Y:int;
      
      public var butterflyPositions:Array;
      
      public var bg_sea_reflections_y:int;
      
      public function LevelData(_level:Level)
      {
         var i:int = 0;
         super();
         this.level = _level;
         this.LEFT_MARGIN = this.TOP_MARGIN = this.RIGHT_MARGIN = this.BOTTOM_MARGIN = -1;
         this.bg_sea_reflections_y = -1;
         this.butterflyPositions = new Array();
         for(i = 0; i < 5; i++)
         {
            this.butterflyPositions.push(new Point(0,0));
         }
      }
      
      public function destroy() : void
      {
         var i:* = undefined;
         for(i = 0; i < this.butterflyPositions.length; i++)
         {
            this.butterflyPositions[i] = null;
         }
         this.butterflyPositions = null;
         for(i = 0; i < this.tiles.length; i++)
         {
            this.tiles[i] = null;
         }
         this.tiles = null;
         for(i = 0; i < this.tiles_type.length; i++)
         {
            this.tiles_type[i] = null;
         }
         this.tiles_type = null;
         this.level = null;
      }
      
      public function init() : void
      {
         var i:* = undefined;
         var j:int = 0;
         this.LEVEL_WIDTH = int(this.END_X - this.START_X);
         this.LEVEL_HEIGHT = int(this.END_Y - this.START_Y);
         this.T_WIDTH = int(Math.round(this.LEVEL_WIDTH / Utils.TILE_WIDTH));
         this.T_HEIGHT = int(Math.round(this.LEVEL_HEIGHT / Utils.TILE_HEIGHT));
         this.TOP_MARGIN = this.START_Y;
         this.BOTTOM_MARGIN = this.END_Y;
         this.tiles = new Array();
         this.tiles_type = new Array();
         for(i = 0; i < this.T_HEIGHT; i++)
         {
            this.tiles.push(new Array());
            this.tiles_type.push(new Array());
            for(j = 0; j < this.T_WIDTH; j++)
            {
               this.tiles[i].push(0);
               this.tiles_type[i].push(0);
            }
         }
      }
      
      public function getTileValueAt(x_t:int, y_t:int) : int
      {
         if(x_t < 0 || y_t < 0 || x_t >= this.T_WIDTH || y_t >= this.T_HEIGHT)
         {
            return -1;
         }
         return this.tiles[y_t][x_t];
      }
      
      public function setTileValueAt(x_t:int, y_t:int, t_value:int) : void
      {
         if(x_t < 0 || y_t < 0 || x_t >= this.T_WIDTH || y_t >= this.T_HEIGHT)
         {
            return;
         }
         this.tiles[y_t][x_t] = t_value;
      }
      
      public function setTileValueToArea(area:Rectangle, t_value:int) : void
      {
         var i:* = undefined;
         var j:int = 0;
         var steps_amount:int = 0;
         var x_t:int = int((area.x + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((area.y + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         var steps_amount_x:* = int(Math.round(area.width / Utils.TILE_WIDTH));
         var steps_amount_y:* = int(Math.round(area.height / Utils.TILE_HEIGHT));
         for(i = 0; i < steps_amount_y; i++)
         {
            for(j = 0; j < steps_amount_x; j++)
            {
               this.setTileValueAt(x_t + j,y_t + i,t_value);
            }
         }
      }
      
      public function getTypeTileValueAt(x_t:int, y_t:int) : int
      {
         if(x_t < 0 || y_t < 0 || x_t >= this.T_WIDTH || y_t >= this.T_HEIGHT)
         {
            return -1;
         }
         return this.tiles_type[y_t][x_t];
      }
      
      public function setTypeTileValueAt(x_t:int, y_t:int, t_value:int) : void
      {
         if(x_t < 0 || y_t < 0 || x_t >= this.T_WIDTH || y_t >= this.T_HEIGHT)
         {
            return;
         }
         this.tiles_type[y_t][x_t] = t_value;
      }
      
      public function setTypeTileValueToArea(area:Rectangle, t_value:int) : void
      {
         var i:* = undefined;
         var j:int = 0;
         var steps_amount:int = 0;
         var x_t:int = int((area.x + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((area.y + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         var steps_amount_x:* = int(Math.round(area.width / Utils.TILE_WIDTH));
         var steps_amount_y:* = int(Math.round(area.height / Utils.TILE_HEIGHT));
         for(i = 0; i < steps_amount_y; i++)
         {
            for(j = 0; j < steps_amount_x; j++)
            {
               this.setTypeTileValueAt(x_t + j,y_t + i,t_value);
            }
         }
      }
      
      public function isCollision(tile_value:int) : Boolean
      {
         if(tile_value >= 1 && tile_value <= 11)
         {
            return true;
         }
         return false;
      }
      
      public function isAreaContainingCollisionTiles(area:Rectangle, _step:Number = 8) : Boolean
      {
         var i:* = undefined;
         var j:* = undefined;
         var step_x:int = int(area.width / _step);
         var step_y:int = int(area.height / _step);
         for(i = 0; i < step_x; i++)
         {
            for(j = 0; j < step_y; j++)
            {
               if(this.getTileValueAt(int((area.x + step_x * i) / Utils.TILE_WIDTH),int((area.y + step_y * j) / Utils.TILE_HEIGHT)) != 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function traceTiles() : void
      {
         var i:int = 0;
         for(i = 0; i < this.tiles.length; i++)
         {
            trace(this.tiles[i]);
         }
         trace("==============");
      }
   }
}
