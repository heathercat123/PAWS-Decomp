package interfaces.map
{
   import game_utils.GameSlot;
   import levels.GenericScript;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MapTiles
   {
       
      
      public var worldMap:WorldMap;
      
      protected var images:Array;
      
      protected var container:Sprite;
      
      public function MapTiles(_worldMap:WorldMap)
      {
         var i:int = 0;
         var image:Image = null;
         var scale_mult:Number = NaN;
         var scale_mult_y:Number = NaN;
         var isBack:Boolean = false;
         var gScript:GenericScript = null;
         super();
         this.worldMap = _worldMap;
         this.images = new Array();
         this.container = new Sprite();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            image = new Image(TextureManager.map1TextureAtlas.getTexture("mapBackground1"));
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            image = new Image(TextureManager.map1TextureAtlas.getTexture("mapBackground2"));
         }
         else
         {
            image = new Image(TextureManager.map1TextureAtlas.getTexture("mapBackground1"));
         }
         image.touchable = false;
         this.container.addChild(image);
         this.images.push(image);
         for(i = 0; i < this.worldMap.mapLoader.mapTiles.length; i++)
         {
            scale_mult = 1;
            scale_mult_y = 1;
            isBack = false;
            if(this.worldMap.mapLoader.mapTiles[i].type == 0)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 1)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 2)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 3)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 4)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 5)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 6)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 7)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 8)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 9)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 10)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 11)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 12)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 13)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 14)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 15)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 16)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 17)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 18)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 19)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 20)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 21)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 22)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 23)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 24)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lake_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 25)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 26)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 27)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 28)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 29)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 30)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 31)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 32)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 33)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sand_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 34)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_sea_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 35)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 36)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 37)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 38)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 39)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 40)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 41)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 42)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("lighthouse_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 43)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 44)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 45)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 46)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 47)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 48)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 49)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 50)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 51)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 52)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 53)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 54)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 55)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 56)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 57)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 58)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 59)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_15"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 60)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_16"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 61)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_cactus_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 62)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_cactus_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 63)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_cactus_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 64)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pond_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 65)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pond_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 66)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pond_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 67)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pond_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 68)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pond_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 69)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_17"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 70)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_18"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 71)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_19"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 72)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_20"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 73)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_21"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 74)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_canyon_tile_22"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 75)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 76)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 77)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tree_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 78)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tree_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 79)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tree_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 80)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tree_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 81)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tree_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 82)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tree_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 83)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 84)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 85)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 86)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 87)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 88)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 89)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 90)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 91)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 92)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 93)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 94)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 95)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 96)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 97)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 98)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 99)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 100)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 101)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 102)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 103)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 104)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 105)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 106)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 107)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 108)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_lava_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 109)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 110)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 111)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 112)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 113)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 114)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 115)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 116)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 117)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 118)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 119)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 120)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 121)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 122)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 123)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 124)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 125)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 126)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_15"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 127)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_16"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 128)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 129)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_17"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 130)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_18"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 131)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_jungle_tile_20"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 132)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 133)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 134)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_15"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 135)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_fence_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 136)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_tree_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 137)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_16"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 138)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_17"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 139)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_18"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 140)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_19"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 141)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_grass_tile_20"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 142)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 143)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 144)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 145)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 146)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 147)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 148)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 149)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 150)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 151)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 152)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 153)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 154)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 155)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 156)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 157)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 158)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 159)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 160)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 161)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 162)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 163)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 164)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_river_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 165)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 166)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 167)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 168)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_city_tile_15"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 169)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_bridge_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 170)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_bridge_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 171)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("low_water_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 172)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("low_water_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 173)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("low_water_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 174)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("low_water_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 175)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 176)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 177)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 178)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 179)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 180)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 181)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 182)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 183)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 184)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 185)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_10"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 186)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_11"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 187)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_12"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 188)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_desert_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 189)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pot_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 190)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_15"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 191)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 192)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 193)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 194)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 195)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 196)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 197)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 198)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 199)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pyramid_tile_9"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 200)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rail_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 201)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rail_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 202)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rail_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 203)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rail_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 204)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rail_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 205)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 206)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 207)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 208)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_13"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 209)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_rock_tile_14"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 210)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_lake_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 211)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_lake_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 212)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_lake_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 213)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 214)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 215)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 216)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_lake_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 217)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_ice_lake_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 218)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 219)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 220)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 221)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_graveyard_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 222)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_graveyard_tile_2"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 223)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_graveyard_tile_3"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 224)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_graveyard_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 225)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_4"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 226)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_5"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 227)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_castle_tile_1"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 228)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 229)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_6"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 230)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_7"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 231)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_pine_tile_8"));
            }
            else if(this.worldMap.mapLoader.mapTiles[i].type == 232)
            {
               image = new Image(TextureManager.hudTextureAtlas.getTexture("map_mountain_tile_8"));
            }
            image.x = Math.round(this.worldMap.mapLoader.mapTiles[i].x);
            image.y = Math.round(this.worldMap.mapLoader.mapTiles[i].y);
            image.width = Math.round(this.worldMap.mapLoader.mapTiles[i].width);
            image.height = Math.round(this.worldMap.mapLoader.mapTiles[i].height);
            if(this.worldMap.mapLoader.mapTiles[i].rotation == 1)
            {
               image.scaleX = -1;
            }
            if(this.worldMap.mapLoader.mapTiles[i].ai == 1)
            {
               image.scaleY = -1;
            }
            this.container.addChild(image);
            this.images.push(image);
         }
         Utils.backWorld.addChild(this.container);
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.images.length; i++)
         {
            if(this.images[i] != null)
            {
               this.container.removeChild(this.images[i]);
               this.images[i].dispose();
               this.images[i] = null;
            }
         }
         this.images = null;
         Utils.backWorld.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         this.worldMap = null;
      }
      
      public function update() : void
      {
      }
      
      public function updateScreenPosition(camera:MapCamera) : void
      {
         this.container.x = int(Math.floor(-camera.xPos));
         this.container.y = int(Math.floor(-camera.yPos));
      }
   }
}
