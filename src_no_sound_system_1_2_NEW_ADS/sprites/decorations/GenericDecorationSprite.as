package sprites.decorations
{
   import levels.backgrounds.BackgroundsManager;
   import levels.decorations.GenericDecoration;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericDecorationSprite extends GameSprite
   {
       
      
      protected var INDEX:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var background_id:int;
      
      public function GenericDecorationSprite(_index:int = 0, _background_id:int = 0)
      {
         super();
         this.INDEX = _index;
         this.background_id = _background_id;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         var i:int = 0;
         if(this.INDEX == GenericDecoration.RED_FLOWER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redFlowerDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.CLOVER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cloverLeafDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.PINE_NEEDLE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pineNeedleDecoration_a"),12);
         }
         else if(this.INDEX == GenericDecoration.PINE_NEEDLE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pineNeedleDecoration_b"),12);
         }
         else if(this.INDEX == GenericDecoration.PINE_NEEDLE_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pineNeedleDecoration_c"),12);
         }
         else if(this.INDEX == GenericDecoration.PINE_NEEDLE_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pineNeedleDecoration_d"),12);
         }
         else if(this.INDEX == GenericDecoration.PINE_NEEDLE_5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pineNeedleDecoration_e"),12);
         }
         else if(this.INDEX == GenericDecoration.BUILDING_LIGHT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("buildingLightDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.NEST)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nestDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.EGG_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("eggDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.EGG_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("eggDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grass_rock_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grass_rock_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grass_rock_3"),12);
         }
         else if(this.INDEX == GenericDecoration.NUT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nutDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.NUT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nutDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.NUT_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nutDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_DAY_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenGrassDecorationSpriteAnim1_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_DAY_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenGrassDecorationSpriteAnim2_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_DUSK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenGrassDuskDecorationSpriteAnim1_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_DUSK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenGrassDuskDecorationSpriteAnim2_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_DARK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkGreenGrassDecorationSpriteAnim1_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_DARK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkGreenGrassDecorationSpriteAnim2_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_NIGHT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenGrassNightDecorationSpriteAnim1_"),12);
         }
         else if(this.INDEX == GenericDecoration.GRASS_NIGHT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenGrassNightDecorationSpriteAnim2_"),12);
         }
         else if(this.INDEX == GenericDecoration.FENCE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grassFenceDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.FENCE_GRAVEYARD)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grassFenceDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.FLOWER_BASE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flowerBaseDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.FLOWER_BASE_DUSK)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flowerBaseDuskDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.FLOWER_BASE_SNOW)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowFlowerBaseDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.FLOWER_BASE_GREY)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("burnedFlowerBaseDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.ROCK_SPIKE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grass_spike_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_SPIKE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grass_spike_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_SNOW_SPIKE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snow_spike_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_SNOW_SPIKE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snow_spike_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_LAVA_SPIKE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lava_spike_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_LAVA_SPIKE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lava_spike_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_TEMPLE_SPIKE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("temple_spike_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_TEMPLE_SPIKE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("temple_spike_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROOT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("grass_root_"),12);
            this.standAnimation.y = -1;
         }
         else if(this.INDEX == GenericDecoration.WOOD_LEAF_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("woodLeafDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.WOOD_LEAF_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("woodLeafDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.WOOD_LEAF_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("woodLeafDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.WOOD_LEAF_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("woodLeafDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.DEW)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("dewDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.GREEN_POT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenPotDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.GREEN_POT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenPotDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.YELLOW_POT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowPotDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.YELLOW_POT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowPotDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.BLUE_POT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bluePotDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.BLUE_POT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bluePotDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.WATER_PLANT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterPlantDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.WATER_PLANT_SLOPE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterPlantSlopeDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 0;
         }
         else if(this.INDEX == GenericDecoration.WATER_PLANT_SLOPE_DUSK)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterPlantSlopeSunsetDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 0;
         }
         else if(this.INDEX == GenericDecoration.WATER_PLANT_DUSK)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterPlantSunsetDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_LIGHT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaLightDecorationSpriteAnim_"),12);
            for(i = 0; i < this.standAnimation.numFrames; i++)
            {
               this.standAnimation.setFrameDuration(i,0.2);
            }
         }
         else if(this.INDEX == GenericDecoration.SEA_LIGHT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaLightShortDecorationSpriteAnim_"),12);
            for(i = 0; i < this.standAnimation.numFrames; i++)
            {
               this.standAnimation.setFrameDuration(i,0.2);
            }
         }
         else if(this.INDEX == GenericDecoration.SEA_LIGHT_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaLightDecorationSprite3Anim_"),12);
            for(i = 0; i < this.standAnimation.numFrames; i++)
            {
               this.standAnimation.setFrameDuration(i,0.2);
            }
         }
         else if(this.INDEX == GenericDecoration.SEA_LIGHT_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaLightShortDecorationSprite3Anim_"),12);
            for(i = 0; i < this.standAnimation.numFrames; i++)
            {
               this.standAnimation.setFrameDuration(i,0.2);
            }
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_OUTSIDE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellOutsideDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_OUTSIDE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellOutsideDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_OUTSIDE_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellOutsideDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.SEA_SHELL_OUTSIDE_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaShellOutsideDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.NUGGET_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nuggetDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.NUGGET_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nuggetDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.NUGGET_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nuggetDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.NUGGET_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nuggetDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.NUGGET_5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nuggetDecorationSpriteAnim_e"),12);
         }
         else if(this.INDEX == GenericDecoration.NUGGET_6)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("nuggetDecorationSpriteAnim_f"),12);
         }
         else if(this.INDEX == GenericDecoration.CACTUS_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCactusDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.CACTUS_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mediumCactusDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.CACTUS_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bigCactusDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 11;
         }
         else if(this.INDEX == GenericDecoration.CANYON_ROCK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonRockDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.CANYON_ROCK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonRockDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.CANYON_ROCK_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonRockDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.CANYON_ROCK_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonRockDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.WALL_TORCH)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("torchDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.CANYON_BONE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonBoneDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.CANYON_BONE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonBoneDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.SKULL)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("skullDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.ICE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.ICE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.ICE_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.ICICLE_SMALL)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallIcycleDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
         }
         else if(this.INDEX == GenericDecoration.GRASS_SNOW_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowGrassDecorationSpriteAnim1_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.GRASS_SNOW_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowGrassDecorationSpriteAnim2_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.ROCK_LAVA_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lavaRockDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_LAVA_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lavaRockDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_LAVA_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lavaRockDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.ASH_FLOWER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ashFlowerDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.CASTLE_BRICK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("castleBrickDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.CASTLE_BRICK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("castleBrickDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.CASTLE_BRICK_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("castleBrickDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.CASTLE_BRICK_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("castleBrickDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.ICICLE_ROCK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockIcicleDecorationAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.ICICLE_ROCK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockIcicleDecorationAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.JUNGLE_LEAF_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("jungleLeafDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.JUNGLE_LEAF_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("jungleLeafDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.JUNGLE_LEAF_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("jungleLeafDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.JUNGLE_LEAF_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("jungleLeafDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.COMPUTER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("computerDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.TEMPLE_SHELL_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("templeShellOutsideDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.TEMPLE_SHELL_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("templeShellOutsideDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.TEMPLE_SHELL_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("templeShellOutsideDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.TEMPLE_SHELL_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("templeShellOutsideDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.CANDLE_DECORATION)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("candleDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.CANDLE_OFF)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("candleOffDecorationSpriteAnim_"),12);
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.ICICLE_ROCK_SMALL)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockSmallIcycleDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.SHOP_LIGHT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("shopLightDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.PATCH_1)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_1b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_1"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_2)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_2b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_2"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_3)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_3b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_3"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_4)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_4b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_4"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_5)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_5b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_5"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_6)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_6b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_6"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_7)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_7b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_7"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_8)
         {
            if(this.background_id == BackgroundsManager.TURNIP_GARDEN)
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_8b"),12);
            }
            else
            {
               this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_8"),12);
            }
         }
         else if(this.INDEX == GenericDecoration.PATCH_9)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("patch_decoration_9b"),12);
         }
         else if(this.INDEX == GenericDecoration.CAGE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cageDecorationSpriteAnim_"),12);
            this.standAnimation.x = -20;
         }
         else if(this.INDEX == GenericDecoration.FLYINGSHIP_WINDUP)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spaceshipWindDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.25);
            this.standAnimation.setFrameDuration(1,0.25);
            this.standAnimation.setFrameDuration(2,0.25);
            this.standAnimation.setFrameDuration(3,0.25);
         }
         else if(this.INDEX == GenericDecoration.SPRINKLER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sprinklerDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.FRUIT_GARDEN_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("gardenFruitsDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.FRUIT_GARDEN_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("gardenFruitsDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.LEAF_GARDEN_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("gardenLeavesDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.LEAF_GARDEN_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("gardenLeavesDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.LEAF_GARDEN_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("gardenLeavesDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.PLANT_POT_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("plantPotDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.PLANT_POT_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("plantPotDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.BENCH)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("benchDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.HYDRANT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hydrantDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.BUS_SIGN)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("signDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.BANNER_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("banner1DecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.BANNER_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("banner2DecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.FAN)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fanDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.BANNER_ARCADE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("arcade_banner_anim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.BRICK_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blueBrickDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blueBrickDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blueBrickDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blueBrickDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blueBrickDecorationSpriteAnim_e"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_6)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blueBrickDecorationSpriteAnim_f"),12);
         }
         else if(this.INDEX == GenericDecoration.FOUNTAIN_WATER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fountainDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.x = -8;
         }
         else if(this.INDEX == GenericDecoration.CUPBOARD_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cupboardDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.CUPBOARD_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cupboardDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.CUPBOARD_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cupboardDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.TABLE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tableDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.TABLE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tableDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.RED_GOO_SPILL)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooBarrelDecorationSpriteAnim_"),12);
            for(i = 0; i < this.standAnimation.numFrames; i++)
            {
               this.standAnimation.setFrameDuration(i,0.075);
            }
         }
         else if(this.INDEX == GenericDecoration.FACTORY_HANDLE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("factoryHandleDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.FACTORY_HANDLE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("factoryHandleDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.FACTORY_NEON_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("factoryNeonDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.TIRE_BOAT)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tireDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_c"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_d"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_e"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_6)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_f"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_7)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_g"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_8)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_i"),12);
         }
         else if(this.INDEX == GenericDecoration.SAND_9)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandDecorationSpriteAnim_j"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_7)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pinkBrickDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_8)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pinkBrickDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_9)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkPinkBrickDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.BRICK_10)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkPinkBrickDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.FISH_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fishDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.OIL_LAMP)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("oilLampDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.FOOD_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("foodDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.FOOD_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("foodDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_MOUNTAIN_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountain_rock_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_MOUNTAIN_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountain_rock_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_MOUNTAIN_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountain_rock_3"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_WATER_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("water_rock_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_WATER_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("water_rock_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_WATER_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("water_rock_3"),12);
         }
         else if(this.INDEX == GenericDecoration.GRAVE_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cemeteryGraveDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.GRAVE_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cemeteryGraveDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.CANDLE_LAMP)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("candleLampDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.STREET_LAMP_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("streetLampDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.STREET_LAMP_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("streetLampSnowDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.BARRIER)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("barrierDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.ROCK_SNOW_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snow_rock_1"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_SNOW_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snow_rock_2"),12);
         }
         else if(this.INDEX == GenericDecoration.ROCK_SNOW_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snow_rock_3"),12);
         }
         else if(this.INDEX == GenericDecoration.BOOMBOX)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boomboxDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.25);
            this.standAnimation.setFrameDuration(1,0.25);
         }
         else if(this.INDEX == GenericDecoration.MUG_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mugDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.MUG_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mugDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.PARASOL)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("parasolDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.BANNER_3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("banner3DecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.BANNER_4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("banner4DecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.FOG_PURPLE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fogPurpleDecorationSpriteAnim_"),12);
         }
         else if(this.INDEX == GenericDecoration.CHAIN_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("chainDecorationSpriteAnim_a"),12);
         }
         else if(this.INDEX == GenericDecoration.CHAIN_2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("chainDecorationSpriteAnim_b"),12);
         }
         else if(this.INDEX == GenericDecoration.FISHING_FLAG)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fishingFlagDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.FLAME_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flameDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX == GenericDecoration.NEON_RED)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("neonDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.5);
            this.standAnimation.setFrameDuration(1,0.5);
         }
         else if(this.INDEX == GenericDecoration.NEON_BLUE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("neonDecorationSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.5);
            this.standAnimation.setFrameDuration(1,0.5);
         }
         else if(this.INDEX == GenericDecoration.GIANT_SPIDER_TONGUE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spiderTongueStandAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.15);
            this.standAnimation.setFrameDuration(3,0.1);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
            this.standAnimation.setFrameDuration(6,0.15);
            this.standAnimation.setFrameDuration(7,0.1);
         }
         this.standAnimation.touchable = false;
         if(this.INDEX == GenericDecoration.RED_FLOWER || this.INDEX == GenericDecoration.CLOVER)
         {
            this.standAnimation.x = 0;
            this.standAnimation.y = 1;
         }
         else if(this.INDEX == GenericDecoration.PARASOL)
         {
            this.standAnimation.x = this.standAnimation.y = -12;
            this.standAnimation.setFrameDuration(0,0.25);
            this.standAnimation.setFrameDuration(1,0.25);
            this.standAnimation.setFrameDuration(2,0.25);
            this.standAnimation.setFrameDuration(3,0.25);
         }
         else if(this.INDEX >= GenericDecoration.GRASS_DAY_1 && this.INDEX <= GenericDecoration.GRASS_NIGHT_2)
         {
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         else if(this.INDEX >= GenericDecoration.TEMPLE_SHELL_1 && this.INDEX <= GenericDecoration.TEMPLE_SHELL_4)
         {
            this.standAnimation.x = this.standAnimation.y = -8;
         }
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
