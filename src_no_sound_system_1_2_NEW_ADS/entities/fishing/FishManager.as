package entities.fishing
{
   import entities.Entity;
   import entities.Lure;
   import flash.geom.Point;
   import game_utils.Random;
   import levels.Level;
   import levels.cameras.*;
   import levels.worlds.fishing.LevelFishing;
   
   public class FishManager
   {
      
      protected static var fishData:Vector.<FishData> = null;
       
      
      public var level:Level;
      
      public var fish:Array;
      
      protected var fish_types:Array;
      
      public var spawn_x:Number;
      
      internal var lake_max_x:Number;
      
      internal var lake_size:Number;
      
      internal var lake_start_x:Number;
      
      public function FishManager(_level:Level)
      {
         super();
         this.level = _level;
         this.lake_start_x = this.spawn_x = 368;
         if(this.level.SUB_LEVEL == 0)
         {
            this.lake_max_x = 1200;
         }
         else if(this.level.SUB_LEVEL == 1)
         {
            this.lake_max_x = 1392;
         }
         else
         {
            this.lake_max_x = 1392;
         }
         this.lake_size = this.lake_max_x - this.spawn_x;
         initFishData();
         this.fish = new Array();
         this.fish_types = new Array();
         if(this.level.SUB_LEVEL == 0)
         {
            if(Utils.TIME == Utils.DAYLIGHT)
            {
               this.fish_types.push(Fish.TADPOLE);
               this.fish_types.push(Fish.GOLDFISH);
               this.fish_types.push(Fish.CAT_FISH);
               this.fish_types.push(Fish.GREEN_CARP);
               this.fish_types.push(Fish.TURTLE);
            }
            else if(Utils.TIME == Utils.NIGHT)
            {
               this.fish_types.push(Fish.GOLDFISH);
               this.fish_types.push(Fish.CAT_FISH);
               this.fish_types.push(Fish.GREEN_CARP);
               this.fish_types.push(Fish.SNAIL);
               this.fish_types.push(Fish.SALAMANDER);
               this.fish_types.push(Fish.FROG);
            }
            else if(Utils.TIME == Utils.DUSK)
            {
               this.fish_types.push(Fish.SNAIL);
               this.fish_types.push(Fish.SALAMANDER);
               this.fish_types.push(Fish.FROG);
               this.fish_types.push(Fish.GOLDFISH);
               this.fish_types.push(Fish.CAT_FISH);
               this.fish_types.push(Fish.GREEN_CARP);
               this.fish_types.push(Fish.TURTLE);
            }
         }
         else if(this.level.SUB_LEVEL == 1)
         {
            if(Utils.TIME == Utils.DAYLIGHT)
            {
               this.fish_types.push(Fish.SQUID);
               this.fish_types.push(Fish.CRAB);
               this.fish_types.push(Fish.RED_JUMPER);
               this.fish_types.push(Fish.BLOWFISH);
               this.fish_types.push(Fish.SHARK);
               this.fish_types.push(Fish.OCTOPUS);
            }
            else if(Utils.TIME == Utils.NIGHT)
            {
               this.fish_types.push(Fish.JELLYFISH);
               this.fish_types.push(Fish.CRAB);
               this.fish_types.push(Fish.RED_JUMPER);
               this.fish_types.push(Fish.BLOWFISH);
               this.fish_types.push(Fish.SHARK);
               this.fish_types.push(Fish.STINGRAY);
            }
            else
            {
               this.fish_types.push(Fish.SQUID);
               this.fish_types.push(Fish.CRAB);
               this.fish_types.push(Fish.RED_JUMPER);
               this.fish_types.push(Fish.BLOWFISH);
               this.fish_types.push(Fish.SHARK);
               this.fish_types.push(Fish.STINGRAY);
               this.fish_types.push(Fish.OCTOPUS);
            }
         }
      }
      
      public static function GetFishData() : Vector.<FishData>
      {
         if(fishData == null)
         {
            initFishData();
         }
         return fishData;
      }
      
      protected static function initFishData() : void
      {
         if(fishData != null)
         {
            return;
         }
         fishData = new Vector.<FishData>();
         fishData.push(new FishData(Fish.GREEN_CARP,Fish.RANK_1_2,10,50,607,1056,1,1));
         fishData.push(new FishData(Fish.SNAIL,Fish.RANK_1,2,15,0,768,0.5,0.75));
         fishData.push(new FishData(Fish.CAT_FISH,Fish.RANK_2,30,90,728,9999,1.2,1.25));
         fishData.push(new FishData(Fish.GOLDFISH,Fish.RANK_1,5,25,426,657,1,1));
         fishData.push(new FishData(Fish.TADPOLE,Fish.RANK_1,2,10,0,575,0.8,0.75));
         fishData.push(new FishData(Fish.SALAMANDER,Fish.RANK_2_3,40,120,832,9999,0.8,0.75));
         fishData.push(new FishData(Fish.TURTLE,Fish.RANK_2_3,35,100,832,9999,1.2,0.75));
         fishData.push(new FishData(Fish.FROG,Fish.RANK_1,4,20,0,575,1.2,0.75));
         fishData.push(new FishData(Fish.SQUID,Fish.RANK_1_2,10,40,480,720,1,0.75));
         fishData.push(new FishData(Fish.CRAB,Fish.RANK_1_2,5,30,0,688,0.8,1));
         fishData.push(new FishData(Fish.RED_JUMPER,Fish.RANK_2_3,12,60,720,1120,1,1));
         fishData.push(new FishData(Fish.BLOWFISH,Fish.RANK_2,8,35,544,944,1.2,1.2));
         fishData.push(new FishData(Fish.SHARK,Fish.RANK_3,30,90,832,9999,1.2,1.25));
         fishData.push(new FishData(Fish.STINGRAY,Fish.RANK_3_4,20,85,936,9999,1.1,0.75));
         fishData.push(new FishData(Fish.OCTOPUS,Fish.RANK_3_4,25,150,936,9999,1,0.75));
         fishData.push(new FishData(Fish.JELLYFISH,Fish.RANK_1_2,5,50,0,928,1.2,0.75));
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.fish.length; i++)
         {
            if(this.fish[i] != null)
            {
               this.fish[i].destroy();
               this.fish[i] = null;
            }
         }
         this.fish = null;
         this.fish_types = null;
         this.level = null;
      }
      
      public function postInit() : void
      {
         this.spawnFish();
      }
      
      public function spawnFish() : void
      {
         var _fish:Fish = null;
         var i:int = 0;
         var j:int = 0;
         var spawn_y:Number = NaN;
         var rand_step:Number = NaN;
         var lake_depth:Number = NaN;
         var found:Boolean = false;
         var _type:int = 0;
         var _size:Number = NaN;
         var _rank:int = 0;
         if(Utils.Slot.gameProgression[15] != 2)
         {
            _fish = new Fish(this.level,Fish.GOLDFISH,this.getFishRank(Fish.GOLDFISH),496,216,Math.random() * 100 > 50 ? Entity.LEFT : Entity.RIGHT,this.getFishSize(Fish.GOLDFISH,0.2));
            this.fish.push(_fish);
            return;
         }
         var amount:int = 20;
         var fish_positions:Array = new Array();
         if(this.fish_types.length < 1)
         {
            amount = 0;
         }
         for(i = 0; i < amount; i++)
         {
            found = true;
            rand_step = 32 + Math.random() * 128;
            this.spawn_x += rand_step;
            if(this.spawn_x >= this.lake_max_x)
            {
               this.spawn_x -= this.lake_size;
            }
            lake_depth = this.getDepthAt(this.spawn_x) - Utils.SEA_LEVEL - Utils.TILE_HEIGHT * 2;
            if(lake_depth <= 0)
            {
               spawn_y = Utils.SEA_LEVEL + Utils.TILE_HEIGHT;
            }
            else
            {
               spawn_y = Utils.SEA_LEVEL + Utils.TILE_HEIGHT + Math.random() * lake_depth;
            }
            if(fish_positions.length > 0)
            {
               for(j = 0; j < fish_positions.length; j++)
               {
                  if(Point.distance(fish_positions[j],new Point(this.spawn_x,spawn_y)) < 24)
                  {
                     found = false;
                     j = int(fish_positions.length);
                  }
               }
            }
            if(found)
            {
               fish_positions.push(new Point(this.spawn_x,spawn_y));
            }
            else
            {
               i--;
            }
         }
         for(i = 0; i < fish_positions.length; i++)
         {
            _type = this.getFishType(fish_positions[i].x);
            _size = this.getFishSize(_type);
            _rank = this.getFishRank(_type);
            _fish = new Fish(this.level,_type,_rank,fish_positions[i].x,fish_positions[i].y,Math.random() * 100 > 50 ? Entity.LEFT : Entity.RIGHT,_size);
            this.fish.push(_fish);
         }
      }
      
      public function spawnNextFish() : void
      {
         var i:int = 0;
         var j:int = 0;
         var found:Boolean = false;
         var rand_step:Number = NaN;
         var spawn_y:Number = NaN;
         var lake_depth:Number = NaN;
         var _fish:Fish = null;
         var _type:int = 0;
         var _size:Number = NaN;
         var _rank:int = 0;
         this.spawn_x = this.spawn_x + Math.random() * 128 - 64;
         if(this.spawn_x <= this.lake_start_x)
         {
            this.spawn_x += this.lake_start_x;
         }
         else if(this.spawn_x >= this.lake_max_x)
         {
            this.spawn_x -= this.lake_size;
         }
         for(i = 0; i < 1; i++)
         {
            found = true;
            lake_depth = this.getDepthAt(this.spawn_x) - Utils.SEA_LEVEL - Utils.TILE_HEIGHT * 2;
            if(lake_depth <= 0)
            {
               spawn_y = Utils.SEA_LEVEL + Utils.TILE_HEIGHT;
            }
            else
            {
               spawn_y = Utils.SEA_LEVEL + Utils.TILE_HEIGHT + Math.random() * lake_depth;
            }
            for(j = 0; j < this.fish.length; j++)
            {
               if(this.fish[j] != null)
               {
                  if(Point.distance(new Point(this.fish[j].xPos,this.fish[j].yPos),new Point(this.spawn_x,spawn_y)) < 40)
                  {
                     found = false;
                     j = int(this.fish.length);
                  }
               }
            }
            if(!found)
            {
               rand_step = 32 + Math.random() * 128;
               this.spawn_x += rand_step;
               if(this.spawn_x >= this.lake_max_x)
               {
                  this.spawn_x -= this.lake_size;
               }
               i--;
            }
         }
         _type = this.getFishType(this.spawn_x);
         _size = this.getFishSize(_type);
         _rank = this.getFishRank(_type);
         _fish = new Fish(this.level,_type,_rank,this.spawn_x,spawn_y,Math.random() * 100 > 50 ? Entity.LEFT : Entity.RIGHT,_size);
         _fish.sprite.alpha = 0;
         _fish.spawn_counter = 0;
         this.fish.push(_fish);
      }
      
      public function update(lure:Lure) : void
      {
         var i:int = 0;
         var fLevel:LevelFishing = this.level as LevelFishing;
         for(i = 0; i < this.fish.length; i++)
         {
            if(this.fish[i] != null)
            {
               this.fish[i].update();
               if(fLevel.fStateMachine.currentState == "IS_REELING_STATE")
               {
                  this.fish[i].checkLureCollisionDetection(lure);
               }
               if(this.fish[i].dead)
               {
                  this.fish[i].destroy();
                  this.fish[i] = null;
               }
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.fish.length; i++)
         {
            if(this.fish[i] != null)
            {
               this.fish[i].updateScreenPosition(camera);
            }
         }
      }
      
      protected function getDepthAt(_xPos:Number) : Number
      {
         var start_y:Number = Utils.SEA_LEVEL;
         var found:Boolean = false;
         var x_t:int = int(_xPos / Utils.TILE_WIDTH);
         var y_t:int = int(Utils.SEA_LEVEL / Utils.TILE_HEIGHT);
         while(!found)
         {
            y_t += 1;
            if(this.level.levelData.getTileValueAt(x_t,y_t) != 0)
            {
               return y_t * Utils.TILE_HEIGHT;
            }
         }
         return -1;
      }
      
      protected function getFishType(_xPos:Number) : int
      {
         var i:int = 0;
         var point:Point = null;
         var availableFishIndex:Array = new Array();
         for(i = 0; i < this.fish_types.length; i++)
         {
            point = this.getFishMinMaxPosition(this.fish_types[i]);
            if(_xPos >= point.x && _xPos <= point.y)
            {
               availableFishIndex.push(this.fish_types[i]);
            }
         }
         var rand:int = int(Math.random() * availableFishIndex.length);
         return availableFishIndex[rand];
      }
      
      protected function getFishRank(_id:int) : int
      {
         return fishData[_id].RANK;
      }
      
      protected function getFishSize(_id:int, _forced:Number = -1) : int
      {
         var min_x:Number = fishData[_id].MIN_SIZE;
         var max_x:Number = fishData[_id].MAX_SIZE;
         var diff:Number = max_x - min_x;
         var rand:Number = Random.GaussianRandom();
         if(_forced > 0)
         {
            rand = _forced;
         }
         return int(Math.round(min_x + diff * rand));
      }
      
      public function getFishMinMaxPosition(_id:*) : Point
      {
         return new Point(fishData[_id].MIN_SPAWN_X,fishData[_id].MAX_SPAWN_X);
      }
   }
}
