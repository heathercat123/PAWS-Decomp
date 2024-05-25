package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.DarkSmallSpotCollisionSprite;
   import sprites.decorations.GenericDecorationSprite;
   
   public class GenericDecoration extends Decoration
   {
      
      public static var RED_FLOWER:int = 0;
      
      public static var CLOVER:int = 1;
      
      public static var PINE_NEEDLE_1:int = 2;
      
      public static var PINE_NEEDLE_2:int = 3;
      
      public static var PINE_NEEDLE_3:int = 4;
      
      public static var PINE_NEEDLE_4:int = 5;
      
      public static var PINE_NEEDLE_5:int = 6;
      
      public static var BUILDING_LIGHT:int = 7;
      
      public static var NEST:int = 8;
      
      public static var EGG_1:int = 9;
      
      public static var EGG_2:int = 10;
      
      public static var ROCK_1:int = 11;
      
      public static var ROCK_2:int = 12;
      
      public static var ROCK_3:int = 13;
      
      public static var NUT_1:int = 14;
      
      public static var NUT_2:int = 15;
      
      public static var NUT_3:int = 16;
      
      public static var GRASS_DAY_1:int = 17;
      
      public static var GRASS_DAY_2:int = 18;
      
      public static var GRASS_DUSK_1:int = 19;
      
      public static var GRASS_DUSK_2:int = 20;
      
      public static var GRASS_DARK_1:int = 21;
      
      public static var GRASS_DARK_2:int = 22;
      
      public static var GRASS_NIGHT_1:int = 23;
      
      public static var GRASS_NIGHT_2:int = 24;
      
      public static var FENCE:int = 25;
      
      public static var FENCE_GRAVEYARD:int = 26;
      
      public static var FLOWER_BASE:int = 27;
      
      public static var FLOWER_BASE_DUSK:int = 28;
      
      public static var FLOWER_BASE_SNOW:int = 29;
      
      public static var FLOWER_BASE_GREY:int = 30;
      
      public static var ROCK_SPIKE_1:int = 31;
      
      public static var ROCK_SPIKE_2:int = 32;
      
      public static var ROCK_SNOW_SPIKE_1:int = 33;
      
      public static var ROCK_SNOW_SPIKE_2:int = 34;
      
      public static var ROCK_LAVA_SPIKE_1:int = 35;
      
      public static var ROCK_LAVA_SPIKE_2:int = 36;
      
      public static var ROCK_TEMPLE_SPIKE_1:int = 37;
      
      public static var ROCK_TEMPLE_SPIKE_2:int = 38;
      
      public static var ROOT:int = 39;
      
      public static var WOOD_LEAF_1:int = 40;
      
      public static var WOOD_LEAF_2:int = 41;
      
      public static var WOOD_LEAF_3:int = 42;
      
      public static var WOOD_LEAF_4:int = 43;
      
      public static var DEW:int = 44;
      
      public static var GREEN_POT_1:int = 45;
      
      public static var GREEN_POT_2:int = 46;
      
      public static var BLUE_POT_1:int = 47;
      
      public static var BLUE_POT_2:int = 48;
      
      public static var YELLOW_POT_1:int = 49;
      
      public static var YELLOW_POT_2:int = 50;
      
      public static var WATER_PLANT:int = 51;
      
      public static var WATER_PLANT_DUSK:int = 52;
      
      public static var SEA_SHELL_1:int = 53;
      
      public static var SEA_SHELL_2:int = 54;
      
      public static var SEA_SHELL_3:int = 55;
      
      public static var SEA_SHELL_4:int = 56;
      
      public static var SEA_LIGHT_1:int = 57;
      
      public static var SEA_LIGHT_2:int = 58;
      
      public static var SEA_SHELL_OUTSIDE_1:int = 59;
      
      public static var SEA_SHELL_OUTSIDE_2:int = 60;
      
      public static var SEA_SHELL_OUTSIDE_3:int = 61;
      
      public static var SEA_SHELL_OUTSIDE_4:int = 62;
      
      public static var NUGGET_1:int = 63;
      
      public static var NUGGET_2:int = 64;
      
      public static var NUGGET_3:int = 65;
      
      public static var NUGGET_4:int = 66;
      
      public static var NUGGET_5:int = 67;
      
      public static var NUGGET_6:int = 68;
      
      public static var CACTUS_1:int = 69;
      
      public static var CACTUS_2:int = 70;
      
      public static var CACTUS_3:int = 71;
      
      public static var CANYON_ROCK_1:int = 72;
      
      public static var CANYON_ROCK_2:int = 73;
      
      public static var WALL_TORCH:int = 74;
      
      public static var CANYON_BONE_1:int = 75;
      
      public static var CANYON_BONE_2:int = 76;
      
      public static var SKULL:int = 77;
      
      public static var ICE_1:int = 78;
      
      public static var ICE_2:int = 79;
      
      public static var ICE_3:int = 80;
      
      public static var ICICLE_SMALL:int = 81;
      
      public static var GRASS_SNOW_1:int = 82;
      
      public static var GRASS_SNOW_2:int = 83;
      
      public static var ROCK_LAVA_1:int = 84;
      
      public static var ROCK_LAVA_2:int = 85;
      
      public static var ROCK_LAVA_3:int = 86;
      
      public static var ASH_FLOWER:int = 87;
      
      public static var CASTLE_BRICK_1:int = 88;
      
      public static var CASTLE_BRICK_2:int = 89;
      
      public static var ICICLE_ROCK_1:int = 90;
      
      public static var ICICLE_ROCK_2:int = 91;
      
      public static var JUNGLE_LEAF_1:int = 92;
      
      public static var JUNGLE_LEAF_2:int = 93;
      
      public static var JUNGLE_LEAF_3:int = 94;
      
      public static var JUNGLE_LEAF_4:int = 95;
      
      public static var COMPUTER:int = 96;
      
      public static var TEMPLE_SHELL_1:int = 97;
      
      public static var TEMPLE_SHELL_2:int = 98;
      
      public static var TEMPLE_SHELL_3:int = 99;
      
      public static var TEMPLE_SHELL_4:int = 100;
      
      public static var CANDLE_DECORATION:int = 101;
      
      public static var CANDLE_OFF:int = 102;
      
      public static var ICICLE_ROCK_SMALL:int = 103;
      
      public static var SHOP_LIGHT:int = 104;
      
      public static var PATCH_1:int = 105;
      
      public static var PATCH_2:int = 106;
      
      public static var PATCH_3:int = 107;
      
      public static var PATCH_4:int = 108;
      
      public static var PATCH_5:int = 109;
      
      public static var PATCH_6:int = 110;
      
      public static var PATCH_7:int = 111;
      
      public static var PATCH_8:int = 112;
      
      public static var CAGE:int = 113;
      
      public static var FLYINGSHIP_WINDUP:int = 114;
      
      public static var SPRINKLER:int = 115;
      
      public static var FRUIT_GARDEN_1:int = 116;
      
      public static var FRUIT_GARDEN_2:int = 117;
      
      public static var LEAF_GARDEN_1:int = 118;
      
      public static var LEAF_GARDEN_2:int = 119;
      
      public static var LEAF_GARDEN_3:int = 120;
      
      public static var PLANT_POT_1:int = 121;
      
      public static var PLANT_POT_2:int = 122;
      
      public static var BENCH:int = 123;
      
      public static var HYDRANT:int = 124;
      
      public static var BUS_SIGN:int = 125;
      
      public static var BANNER_1:int = 126;
      
      public static var BANNER_2:int = 127;
      
      public static var FAN:int = 128;
      
      public static var BRICK_1:int = 129;
      
      public static var BRICK_2:int = 130;
      
      public static var BRICK_3:int = 131;
      
      public static var BRICK_4:int = 132;
      
      public static var BRICK_5:int = 133;
      
      public static var BRICK_6:int = 134;
      
      public static var FOUNTAIN_WATER:int = 135;
      
      public static var CUPBOARD_1:int = 136;
      
      public static var CUPBOARD_2:int = 137;
      
      public static var CUPBOARD_3:int = 138;
      
      public static var TABLE_1:int = 139;
      
      public static var TABLE_2:int = 140;
      
      public static var RED_GOO_SPILL:int = 141;
      
      public static var FACTORY_HANDLE_1:int = 142;
      
      public static var FACTORY_HANDLE_2:int = 143;
      
      public static var FACTORY_NEON_1:int = 144;
      
      public static var TIRE_BOAT:int = 145;
      
      public static var SAND_1:int = 146;
      
      public static var SAND_2:int = 147;
      
      public static var SAND_3:int = 148;
      
      public static var SAND_4:int = 149;
      
      public static var SAND_5:int = 150;
      
      public static var SAND_6:int = 151;
      
      public static var SAND_7:int = 152;
      
      public static var BRICK_7:int = 153;
      
      public static var BRICK_8:int = 154;
      
      public static var BRICK_9:int = 155;
      
      public static var BRICK_10:int = 156;
      
      public static var FISH_1:int = 157;
      
      public static var OIL_LAMP:int = 158;
      
      public static var FOOD_1:int = 159;
      
      public static var FOOD_2:int = 160;
      
      public static var ROCK_MOUNTAIN_1:int = 161;
      
      public static var ROCK_MOUNTAIN_2:int = 162;
      
      public static var ROCK_MOUNTAIN_3:int = 163;
      
      public static var ROCK_WATER_1:int = 164;
      
      public static var ROCK_WATER_2:int = 165;
      
      public static var ROCK_WATER_3:int = 166;
      
      public static var GRAVE_1:int = 167;
      
      public static var GRAVE_2:int = 168;
      
      public static var CANDLE_LAMP:int = 169;
      
      public static var STREET_LAMP_1:int = 170;
      
      public static var STREET_LAMP_2:int = 171;
      
      public static var BARRIER:int = 172;
      
      public static var ROCK_SNOW_1:int = 173;
      
      public static var ROCK_SNOW_2:int = 174;
      
      public static var ROCK_SNOW_3:int = 175;
      
      public static var BOOMBOX:int = 176;
      
      public static var MUG_1:int = 177;
      
      public static var MUG_2:int = 178;
      
      public static var PARASOL:int = 179;
      
      public static var WATER_PLANT_SLOPE:int = 180;
      
      public static var PATCH_9:int = 181;
      
      public static var BANNER_3:int = 182;
      
      public static var WATER_PLANT_SLOPE_DUSK:int = 183;
      
      public static var SEA_LIGHT_3:int = 184;
      
      public static var SEA_LIGHT_4:int = 185;
      
      public static var SAND_8:int = 186;
      
      public static var FOG_PURPLE:int = 187;
      
      public static var CHAIN_1:int = 188;
      
      public static var CHAIN_2:int = 189;
      
      public static var FISHING_FLAG:int = 190;
      
      public static var CASTLE_BRICK_3:int = 191;
      
      public static var CASTLE_BRICK_4:int = 192;
      
      public static var BANNER_4:int = 193;
      
      public static var FLAME_1:int = 194;
      
      public static var SAND_9:int = 195;
      
      public static var BANNER_ARCADE:int = 196;
      
      public static var NEON_RED:int = 197;
      
      public static var NEON_BLUE:int = 198;
      
      public static var CANYON_ROCK_3:int = 199;
      
      public static var CANYON_ROCK_4:int = 200;
      
      public static var GIANT_SPIDER_TONGUE:int = 201;
       
      
      protected var isBack:Boolean;
      
      protected var isWorld:Boolean;
      
      public var DECORATION_TYPE:int;
      
      protected var light:DarkSmallSpotCollisionSprite;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var flag_1:Boolean;
      
      public function GenericDecoration(_level:Level, _xPos:Number, _yPos:Number, _flip_x:int, _flip_y:int, _index:int)
      {
         super(_level,_xPos,_yPos);
         this.DECORATION_TYPE = _index;
         this.isBack = this.isBackDecoration();
         this.isWorld = this.isWorldDecoration();
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.counter_1 = this.counter_2 = 0;
         this.flag_1 = false;
         sprite = new GenericDecorationSprite(this.DECORATION_TYPE,level.getBackgroundId());
         if(this.isBack)
         {
            Utils.backWorld.addChild(sprite);
         }
         else if(this.isWorld)
         {
            Utils.world.addChild(sprite);
         }
         else
         {
            Utils.topWorld.addChild(sprite);
         }
         if(_flip_x > 0)
         {
            sprite.scaleX = -1;
         }
         if(_flip_y > 0)
         {
            sprite.scaleY = -1;
         }
         var x_t:int = int(xPos / Utils.TILE_WIDTH);
         if(this.DECORATION_TYPE == GenericDecoration.RED_FLOWER || this.DECORATION_TYPE == GenericDecoration.CLOVER || this.DECORATION_TYPE == GenericDecoration.CACTUS_1 || this.DECORATION_TYPE == GenericDecoration.CACTUS_2 || this.DECORATION_TYPE == GenericDecoration.CACTUS_3)
         {
            if(x_t % 2 == 0)
            {
               sprite.gfxHandleClip().gotoAndPlay(2);
            }
         }
         else if(this.DECORATION_TYPE >= GenericDecoration.GRASS_DAY_1 && this.DECORATION_TYPE <= GenericDecoration.GRASS_NIGHT_2)
         {
            if(xPos % 2 == 0)
            {
               sprite.gfxHandleClip().gotoAndPlay(2);
            }
            else
            {
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(this.DECORATION_TYPE == GenericDecoration.GRASS_SNOW_1 || this.DECORATION_TYPE == GenericDecoration.GRASS_SNOW_2)
         {
            if(xPos % 2 == 0)
            {
               sprite.gfxHandleClip().gotoAndPlay(2);
            }
            else
            {
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         if(this.DECORATION_TYPE == GenericDecoration.NUGGET_1 || this.DECORATION_TYPE == GenericDecoration.NUGGET_2 || this.DECORATION_TYPE == GenericDecoration.NUGGET_3 || this.DECORATION_TYPE == GenericDecoration.NUGGET_4 || this.DECORATION_TYPE == GenericDecoration.NUGGET_5 || this.DECORATION_TYPE == GenericDecoration.NUGGET_6)
         {
            this.light = new DarkSmallSpotCollisionSprite();
            this.light.gotoAndStop(4);
            level.darkManager.maskContainer.addChild(this.light);
         }
         else
         {
            this.light = null;
         }
      }
      
      override public function onTop() : void
      {
         if(this.isBack)
         {
            Utils.backWorld.setChildIndex(sprite,Utils.backWorld.numChildren - 1);
         }
         else if(this.isWorld)
         {
            Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
         }
         else
         {
            Utils.topWorld.setChildIndex(sprite,Utils.topWorld.numChildren - 1);
         }
      }
      
      public function setToBack() : void
      {
         if(this.isBack)
         {
            Utils.backWorld.setChildIndex(sprite,0);
         }
         else if(this.isWorld)
         {
            Utils.world.setChildIndex(sprite,0);
         }
         else
         {
            Utils.topWorld.setChildIndex(sprite,0);
         }
      }
      
      override public function update() : void
      {
         if(this.DECORATION_TYPE == GenericDecoration.FOG_PURPLE)
         {
            this.sin_counter_1 += 0.01;
            if(this.sin_counter_1 > Math.PI * 2)
            {
               this.sin_counter_1 -= Math.PI * 2;
            }
            this.sin_counter_2 += 0.025;
            if(this.sin_counter_2 > Math.PI * 2)
            {
               this.sin_counter_2 -= Math.PI * 2;
            }
            xPos = originalXPos + Math.sin(this.sin_counter_1) * 16;
            sprite.alpha = Math.sin(this.sin_counter_2) * 0.25 + 0.25;
            if(this.flag_1)
            {
               sprite.alpha -= 0.1;
            }
            ++this.counter_1;
            if(this.counter_1 >= 2)
            {
               this.counter_1 = 0;
               this.flag_1 = !this.flag_1;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         sprite.updateScreenPosition();
         if(this.light != null)
         {
            this.sin_counter_1 += 0.1;
            this.light.x = sprite.x + 6;
            this.light.y = sprite.y + 6;
            this.light.updateScreenPosition();
            this.light.scaleX = this.light.scaleY = 1 + Math.sin(this.sin_counter_1) * 0.5;
         }
      }
      
      override public function destroy() : void
      {
         if(this.isBack)
         {
            Utils.backWorld.removeChild(sprite);
         }
         else if(this.isWorld)
         {
            Utils.world.removeChild(sprite);
         }
         else
         {
            Utils.topWorld.removeChild(sprite);
         }
         super.destroy();
      }
      
      protected function isWorldDecoration() : Boolean
      {
         if(this.DECORATION_TYPE == GenericDecoration.COMPUTER || this.DECORATION_TYPE == GenericDecoration.PLANT_POT_1 || this.DECORATION_TYPE == GenericDecoration.PLANT_POT_2)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.BENCH || this.DECORATION_TYPE == GenericDecoration.HYDRANT || this.DECORATION_TYPE == GenericDecoration.BUS_SIGN)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.TABLE_1 || this.DECORATION_TYPE == GenericDecoration.TABLE_2 || this.DECORATION_TYPE == GenericDecoration.TABLE_2)
         {
            return true;
         }
         return false;
      }
      
      protected function isBackDecoration() : Boolean
      {
         if(this.DECORATION_TYPE == GenericDecoration.FENCE || this.DECORATION_TYPE == GenericDecoration.FENCE_GRAVEYARD)
         {
            return true;
         }
         if(this.DECORATION_TYPE >= GenericDecoration.ROCK_SPIKE_1 && this.DECORATION_TYPE <= GenericDecoration.ROCK_TEMPLE_SPIKE_2)
         {
            return true;
         }
         if(this.DECORATION_TYPE >= GenericDecoration.GREEN_POT_1 && this.DECORATION_TYPE <= GenericDecoration.YELLOW_POT_2)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.CANYON_ROCK_1 || this.DECORATION_TYPE == GenericDecoration.CANYON_ROCK_2 || this.DECORATION_TYPE == GenericDecoration.WALL_TORCH)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.CANYON_ROCK_3 || this.DECORATION_TYPE == GenericDecoration.CANYON_ROCK_4)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.BRICK_9 || this.DECORATION_TYPE == GenericDecoration.BRICK_10)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.GRAVE_1 || this.DECORATION_TYPE == GenericDecoration.GRAVE_2)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.FOG_PURPLE || this.DECORATION_TYPE == GenericDecoration.FISHING_FLAG)
         {
            return true;
         }
         if(this.DECORATION_TYPE == GenericDecoration.FLAME_1)
         {
            return true;
         }
         return false;
      }
   }
}
