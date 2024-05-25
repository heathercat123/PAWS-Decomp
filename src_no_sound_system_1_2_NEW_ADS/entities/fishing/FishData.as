package entities.fishing
{
   import flash.geom.*;
   import game_utils.LevelItems;
   
   public class FishData
   {
       
      
      public var TYPE:int;
      
      public var RANK:int;
      
      public var MIN_SIZE:Number;
      
      public var MAX_SIZE:Number;
      
      public var MIN_SPAWN_X:Number;
      
      public var MAX_SPAWN_X:Number;
      
      public var ESCAPE_DISTANCE:Number;
      
      public var STAMINA_INCREASE_MULT:Number;
      
      public var SPEED_MULT:Number;
      
      public var FIGHT_BASE:Number;
      
      public var FIGHT_RAND:Number;
      
      public var STAMINA_DECREASE_MULT:Number;
      
      public function FishData(_type:int, _rank:int, _min_size:Number, _max_size:Number, _min_spawn_x:Number, _max_spawn_x:Number, _speed:Number, _stamina:Number)
      {
         super();
         this.TYPE = _type;
         this.RANK = _rank;
         this.MIN_SIZE = _min_size;
         this.MAX_SIZE = _max_size;
         this.MIN_SPAWN_X = _min_spawn_x;
         this.MAX_SPAWN_X = _max_spawn_x;
         this.ESCAPE_DISTANCE = this.getEscapeDistance(this.RANK);
         this.SPEED_MULT = _speed;
         this.STAMINA_INCREASE_MULT = this.getStaminaIncreaseMult(this.RANK);
         this.FIGHT_BASE = this.getFightBase(this.RANK);
         this.FIGHT_RAND = this.getFightRand(this.RANK);
         this.STAMINA_DECREASE_MULT = this.getStaminaDecreaseMult(this.RANK);
      }
      
      public static function GetFishRankFromInventoryIndex(item_index:int) : int
      {
         if(item_index == LevelItems.ITEM_FISH_SNAIL || item_index == LevelItems.ITEM_FISH_GOLDFISH || item_index == LevelItems.ITEM_FISH_TADPOLE || item_index == LevelItems.ITEM_FISH_FROG)
         {
            return Fish.RANK_1;
         }
         if(item_index == LevelItems.ITEM_FISH_GREEN_CARP || item_index == LevelItems.ITEM_FISH_SQUID || item_index == LevelItems.ITEM_FISH_CRAB || item_index == LevelItems.ITEM_FISH_JELLYFISH)
         {
            return Fish.RANK_1_2;
         }
         if(item_index == LevelItems.ITEM_FISH_CAT_FISH || item_index == LevelItems.ITEM_FISH_BLOWFISH)
         {
            return Fish.RANK_2;
         }
         if(item_index == LevelItems.ITEM_FISH_SALAMANDER || item_index == LevelItems.ITEM_FISH_TURTLE || item_index == LevelItems.ITEM_FISH_RED_JUMPER)
         {
            return Fish.RANK_2_3;
         }
         if(item_index == LevelItems.ITEM_FISH_SHARK)
         {
            return Fish.RANK_3;
         }
         if(item_index == LevelItems.ITEM_FISH_STINGRAY || item_index == LevelItems.ITEM_FISH_OCTOPUS)
         {
            return Fish.RANK_3_4;
         }
         return Fish.RANK_1;
      }
      
      public function getMedianSize() : Number
      {
         var diff:Number = this.MAX_SIZE - this.MIN_SIZE;
         return this.MIN_SIZE + diff * 0.5;
      }
      
      public function getPowerMultiplier(_size:Number) : Number
      {
         var min_size:Number = this.MIN_SIZE;
         var max_size:Number = this.MAX_SIZE;
         var size:Number = _size;
         max_size -= min_size;
         size -= min_size;
         min_size = 0;
         var perc:Number = size / max_size;
         return 1 + perc * 0.5;
      }
      
      public function getEscapeDistance(rank:*) : Number
      {
         var fishing_rod_level:int = Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1] - 1;
         if(fishing_rod_level == 0)
         {
            if(rank <= Fish.RANK_1)
            {
               return 512;
            }
            if(rank == Fish.RANK_1_2)
            {
               return 320;
            }
            if(rank == Fish.RANK_2)
            {
               return 256;
            }
            if(rank == Fish.RANK_2_3)
            {
               return 128;
            }
            return 64;
         }
         if(fishing_rod_level == 1)
         {
            if(rank <= Fish.RANK_2)
            {
               return 512;
            }
            if(rank == Fish.RANK_2_3)
            {
               return 320;
            }
            if(rank == Fish.RANK_3)
            {
               return 256;
            }
            if(rank == Fish.RANK_3_4)
            {
               return 128;
            }
            return 64;
         }
         if(fishing_rod_level == 2)
         {
            if(rank <= Fish.RANK_3)
            {
               return 512;
            }
            if(rank == Fish.RANK_3_4)
            {
               return 320;
            }
            if(rank == Fish.RANK_4)
            {
               return 256;
            }
            if(rank == Fish.RANK_4_5)
            {
               return 128;
            }
            return 64;
         }
         if(fishing_rod_level == 3)
         {
            if(rank <= Fish.RANK_4)
            {
               return 512;
            }
            if(rank == Fish.RANK_4_5)
            {
               return 320;
            }
            if(rank == Fish.RANK_5)
            {
               return 256;
            }
            if(rank == Fish.RANK_5_6)
            {
               return 128;
            }
            return 64;
         }
         if(fishing_rod_level == 4)
         {
            if(rank <= Fish.RANK_5)
            {
               return 512;
            }
            if(rank == Fish.RANK_5_6)
            {
               return 320;
            }
            if(rank >= Fish.RANK_6)
            {
               return 256;
            }
         }
         else if(fishing_rod_level == 5)
         {
            if(rank <= Fish.RANK_6)
            {
               return 512;
            }
         }
         return 128;
      }
      
      public function getFightBase(rank:*) : Number
      {
         if(rank == Fish.RANK_1)
         {
            return 300;
         }
         if(rank == Fish.RANK_1_2)
         {
            return 270;
         }
         if(rank == Fish.RANK_2)
         {
            return 240;
         }
         if(rank == Fish.RANK_2_3)
         {
            return 210;
         }
         if(rank == Fish.RANK_3)
         {
            return 180;
         }
         if(rank == Fish.RANK_3_4)
         {
            return 150;
         }
         if(rank == Fish.RANK_4)
         {
            return 120;
         }
         if(rank == Fish.RANK_4_5)
         {
            return 90;
         }
         if(rank == Fish.RANK_5)
         {
            return 60;
         }
         if(rank == Fish.RANK_5_6)
         {
            return 30;
         }
         if(rank == Fish.RANK_6)
         {
            return 15;
         }
         return 300;
      }
      
      public function getFightRand(rank:*) : Number
      {
         if(rank == Fish.RANK_1)
         {
            return 300;
         }
         if(rank == Fish.RANK_1_2)
         {
            return 240;
         }
         if(rank == Fish.RANK_2)
         {
            return 210;
         }
         if(rank == Fish.RANK_2_3)
         {
            return 210;
         }
         if(rank == Fish.RANK_3)
         {
            return 180;
         }
         if(rank == Fish.RANK_3_4)
         {
            return 150;
         }
         if(rank == Fish.RANK_4)
         {
            return 120;
         }
         if(rank == Fish.RANK_4_5)
         {
            return 98;
         }
         if(rank == Fish.RANK_5)
         {
            return 75;
         }
         if(rank == Fish.RANK_5_6)
         {
            return 60;
         }
         if(rank == Fish.RANK_6)
         {
            return 30;
         }
         return 600;
      }
      
      public function getStaminaDecreaseMult(rank:*) : Number
      {
         var fishing_rod_level:int = Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1] - 1;
         if(fishing_rod_level == 0)
         {
            if(rank <= Fish.RANK_1)
            {
               return 1;
            }
            if(rank == Fish.RANK_1_2)
            {
               return 0.75;
            }
            if(rank == Fish.RANK_2)
            {
               return 0.5;
            }
            return 0.25;
         }
         if(fishing_rod_level == 1)
         {
            if(rank <= Fish.RANK_2)
            {
               return 1;
            }
            if(rank == Fish.RANK_2_3)
            {
               return 0.75;
            }
            if(rank == Fish.RANK_3)
            {
               return 0.55;
            }
            return 0.25;
         }
         if(fishing_rod_level == 2)
         {
            if(rank <= Fish.RANK_3)
            {
               return 1;
            }
            if(rank == Fish.RANK_3_4)
            {
               return 0.5;
            }
            if(rank == Fish.RANK_4)
            {
               return 0.25;
            }
            return 0;
         }
         if(fishing_rod_level == 3)
         {
            if(rank <= Fish.RANK_4)
            {
               return 1;
            }
            if(rank == Fish.RANK_4_5)
            {
               return 0.5;
            }
            if(rank == Fish.RANK_5)
            {
               return 0.25;
            }
            return 0;
         }
         if(fishing_rod_level == 4)
         {
            if(rank <= Fish.RANK_5)
            {
               return 1;
            }
            if(rank == Fish.RANK_5_6)
            {
               return 0.5;
            }
            if(rank == Fish.RANK_6)
            {
               return 0.25;
            }
            return 0;
         }
         if(fishing_rod_level == 5)
         {
            return 1;
         }
         return 1;
      }
      
      public function getStaminaIncreaseMult(rank:*) : Number
      {
         var fishing_rod_level:int = Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1] - 1;
         if(fishing_rod_level == 0)
         {
            if(rank > Fish.RANK_2)
            {
               return 2;
            }
            if(rank == Fish.RANK_2)
            {
               return 1.5;
            }
            if(rank == Fish.RANK_1_2)
            {
               return 1;
            }
            if(rank == Fish.RANK_1)
            {
               return 0.5;
            }
            return 0.25;
         }
         if(fishing_rod_level == 1)
         {
            if(rank > Fish.RANK_3)
            {
               return 4;
            }
            if(rank == Fish.RANK_3)
            {
               return 2;
            }
            if(rank == Fish.RANK_2_3)
            {
               return 1.5;
            }
            if(rank == Fish.RANK_2)
            {
               return 1;
            }
            return 0.5;
         }
         if(fishing_rod_level == 2)
         {
            if(rank > Fish.RANK_4)
            {
               return 4;
            }
            if(rank == Fish.RANK_4)
            {
               return 2;
            }
            if(rank == Fish.RANK_3_4)
            {
               return 1.5;
            }
            if(rank == Fish.RANK_3)
            {
               return 1;
            }
            return 0.5;
         }
         if(fishing_rod_level == 3)
         {
            if(rank > Fish.RANK_5)
            {
               return 4;
            }
            if(rank == Fish.RANK_5)
            {
               return 2;
            }
            if(rank == Fish.RANK_4_5)
            {
               return 1.5;
            }
            if(rank == Fish.RANK_4)
            {
               return 1;
            }
            return 0.5;
         }
         if(fishing_rod_level == 4)
         {
            if(rank > Fish.RANK_6)
            {
               return 4;
            }
            if(rank == Fish.RANK_6)
            {
               return 2;
            }
            if(rank == Fish.RANK_5_6)
            {
               return 1.5;
            }
            if(rank == Fish.RANK_5)
            {
               return 1;
            }
            return 0.5;
         }
         if(fishing_rod_level == 5)
         {
            if(rank == Fish.RANK_6)
            {
               return 1;
            }
            return 0.5;
         }
         return 1;
      }
   }
}
