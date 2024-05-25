package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class BackgroundsManager
   {
      
      public static const KITTY_HOUSE_ROOF:int = 0;
      
      public static const KITTY_HOUSE_INSIDE:int = 1;
      
      public static const FLYING_SHIP_INSIDE:int = 2;
      
      public static const TURNIP_GARDEN:int = 3;
      
      public static const RIVER:int = 4;
      
      public static const CITY_NIGHT:int = 5;
      
      public static const SEASIDE:int = 6;
      
      public static const WATER_CAVE:int = 7;
      
      public static const BOAT:int = 8;
      
      public static const DESERT:int = 9;
      
      public static const WASTELAND:int = 10;
      
      public static const CAVE:int = 11;
      
      public static const MOUNTAIN:int = 12;
      
      public static const MOUNTAIN_TRAIN:int = 13;
      
      public static const GRAVEYARD:int = 14;
      
      public static const MOUNTAIN_NIGHT:int = 15;
      
      public static const MOUNTAIN_SNOW_NIGHT:int = 16;
      
      public static const SNOW_PLAINS:int = 17;
      
      public static const ICY_CAVE:int = 18;
      
      public static const SNOW_STORM:int = 19;
      
      public static const FROZEN_LAKE:int = 20;
      
      public static const MINERAL_CAVE:int = 21;
      
      public static const RAIN_WOODS:int = 22;
      
      public static const STARRY_NIGHT:int = 23;
      
      public static const DAWN_WOODS:int = 24;
      
      public static const CANYON:int = 25;
      
      public static const WOOD_CASTLE_INSIDE:int = 26;
      
      public static const CANYON_YELLOW:int = 27;
      
      public static const TEMPLE:int = 28;
      
      public static const CANYON_AFTERNOON:int = 29;
      
      public static const SEASIDE_NIGHT:int = 30;
      
      public static const TURNIP_GARDEN_WITH_CLOUDS:int = 31;
      
      public static const UNDERWATER:int = 32;
      
      public static const CANYON_NO_CLOUDS:int = 33;
      
      public static const ICEBERG_NIGHT:int = 34;
      
      public static const ICEBERG_NIGHT_CASTLE:int = 35;
      
      public static const STARRY_NIGHT_NO_CLOUDS:int = 36;
      
      public static const CANYON_SCROLLING:int = 37;
      
      public static const TURNIP_GARDEN_WITH_CLOUDS_POLLEN:int = 38;
       
      
      public var level:Level;
      
      public var tiles:Tiles;
      
      public var background:Background;
      
      public function BackgroundsManager(_level:Level)
      {
         super();
         this.level = _level;
         this.tiles = new Tiles(this.level);
         var bg_id:int = this.level.getBackgroundId();
         if(bg_id == KITTY_HOUSE_ROOF)
         {
            this.background = new KittyHouseRoofBackground(this.level);
         }
         else if(bg_id == KITTY_HOUSE_INSIDE)
         {
            this.background = new KittyHouseInsideBackground(this.level);
         }
         else if(bg_id == WOOD_CASTLE_INSIDE)
         {
            this.background = new KittyHouseInsideBackground(this.level,1);
         }
         else if(bg_id == FLYING_SHIP_INSIDE)
         {
            this.background = new FlyingShipInsideBackground(this.level);
         }
         else if(bg_id == TURNIP_GARDEN)
         {
            this.background = new TurnipGardenBackground(this.level,0);
         }
         else if(bg_id == TURNIP_GARDEN_WITH_CLOUDS)
         {
            this.background = new TurnipGardenBackground(this.level,3);
         }
         else if(bg_id == TURNIP_GARDEN_WITH_CLOUDS_POLLEN)
         {
            this.background = new TurnipGardenBackground(this.level,4);
         }
         else if(bg_id == CITY_NIGHT)
         {
            this.background = new CityNightBackground(this.level);
         }
         else if(bg_id == SEASIDE)
         {
            this.background = new SeasideBackground(this.level);
         }
         else if(bg_id == WATER_CAVE)
         {
            this.background = new WatercaveBackground(this.level);
         }
         else if(bg_id == DESERT)
         {
            this.background = new DesertBackground(this.level);
         }
         else if(bg_id == CAVE)
         {
            this.background = new CaveBackground(this.level);
         }
         else if(bg_id == MOUNTAIN)
         {
            this.background = new MountainBackground(this.level);
         }
         else if(bg_id == MOUNTAIN_TRAIN)
         {
            this.background = new MountainTrainBackground(this.level);
         }
         else if(bg_id == MOUNTAIN_NIGHT)
         {
            this.background = new MountainNightBackground(this.level);
         }
         else if(bg_id == MOUNTAIN_SNOW_NIGHT)
         {
            this.background = new MountainSnowNightBackground(this.level);
         }
         else if(bg_id == SNOW_PLAINS)
         {
            this.background = new SnowPlainsBackground(this.level);
         }
         else if(bg_id == ICY_CAVE)
         {
            this.background = new IcyCaveBackground(this.level);
         }
         else if(bg_id == SNOW_STORM)
         {
            this.background = new SnowStormBackground(this.level);
         }
         else if(bg_id == FROZEN_LAKE)
         {
            this.background = new FrozenLakeBackground(this.level);
         }
         else if(bg_id == MINERAL_CAVE)
         {
            this.background = new MineralCaveBackground(this.level);
         }
         else if(bg_id == RAIN_WOODS)
         {
            this.background = new RainWoodsBackground(this.level);
         }
         else if(bg_id == STARRY_NIGHT)
         {
            this.background = new StarryNightBackground(this.level);
         }
         else if(bg_id == STARRY_NIGHT_NO_CLOUDS)
         {
            this.background = new StarryNightBackground(this.level,1);
         }
         else if(bg_id == DAWN_WOODS)
         {
            this.background = new TurnipGardenBackground(this.level,1);
         }
         else if(bg_id == CANYON)
         {
            this.background = new CanyonBackground(this.level);
         }
         else if(bg_id == CANYON_YELLOW)
         {
            this.background = new CanyonBackground(this.level,1);
         }
         else if(bg_id == CANYON_NO_CLOUDS)
         {
            this.background = new CanyonBackground(this.level,2);
         }
         else if(bg_id == TEMPLE)
         {
            this.background = new TurnipGardenBackground(this.level,2);
         }
         else if(bg_id == CANYON_AFTERNOON)
         {
            this.background = new KittyHouseRoofBackground(this.level,1);
         }
         else if(bg_id == SEASIDE_NIGHT)
         {
            this.background = new DesertBackground(this.level,1);
         }
         else if(bg_id == UNDERWATER)
         {
            this.background = new SeasideBackground(this.level,1);
         }
         else if(bg_id == ICEBERG_NIGHT)
         {
            this.background = new DesertBackground(this.level,2);
         }
         else if(bg_id == ICEBERG_NIGHT_CASTLE)
         {
            this.background = new DesertBackground(this.level,3);
         }
         else if(bg_id == CANYON_SCROLLING)
         {
            this.background = new CanyonBackground(this.level,3);
         }
         else
         {
            this.background = new WoodsBackground(this.level);
         }
      }
      
      public function destroy() : void
      {
         this.background.destroy();
         this.background = null;
         this.tiles.destroy();
         this.tiles = null;
         this.level = null;
      }
      
      public function update() : void
      {
         this.tiles.update();
         this.background.update();
      }
      
      public function updateFreeze() : void
      {
         this.tiles.update();
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         this.tiles.updateScreenPosition(camera);
         this.background.updateScreenPosition(camera);
      }
      
      public function shake() : void
      {
         this.background.shake();
      }
   }
}
