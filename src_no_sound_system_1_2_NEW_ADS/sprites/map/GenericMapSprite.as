package sprites.map
{
   import interfaces.map.decorations.MapDecorations;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericMapSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnimation1:GameMovieClip;
      
      public function GenericMapSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.initAnims1();
         addChild(this.standAnimation1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         this.standAnimation1.dispose();
         this.standAnimation1 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         var i:int = 0;
         if(this.TYPE == MapDecorations.GRASS_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapGrassSpriteAnim1_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.GRASS_2)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapGrassSpriteAnim2_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.RAIN_DROP)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapRainDropSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,0.5 + Math.random() * 0.5);
            this.standAnimation1.setFrameDuration(1,0.1);
            this.standAnimation1.setFrameDuration(2,0.1);
         }
         else if(this.TYPE == MapDecorations.CLOUD_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapCloudSprite1Anim_a"),12);
         }
         else if(this.TYPE == MapDecorations.CLOUD_2)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapCloudSprite1Anim_b"),12);
         }
         else if(this.TYPE == MapDecorations.DANDELION)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapDandelionWhiteSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.RED_FLOWER)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapFlowerStandAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.BEETLE)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapBeetleSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.SQUID)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapSquidSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.MONKEY)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapMonkeySpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.BEE)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapBeeSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,0.1);
            this.standAnimation1.setFrameDuration(1,0.1);
         }
         else if(this.TYPE == MapDecorations.EGG_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapEgg1DecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.WAVE_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("map_wave_tile_1"),12);
         }
         else if(this.TYPE == MapDecorations.REED_PLANT_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapReed1DecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.BARRIER_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapBarrier_1"),12);
         }
         else if(this.TYPE == MapDecorations.OLLI)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapOlliDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.VILLAGE_FLAG)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapCityFlagSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.LOBSTER)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapLobsterDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.SMALL_BOAT_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapSmallBoatDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.PARASOL)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapParasolDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.PUMPKIN)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapPumpkinDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.WATERFALL_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapWaterfall1DecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.MOLE)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapMoleDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.LIZARD_BOSS)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapLizardBossDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.FISH_BOSS)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapFishBossDecorationSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,1);
            this.standAnimation1.setFrameDuration(1,1);
         }
         else if(this.TYPE == MapDecorations.BARRIER_2)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapBarrier_2"),12);
         }
         else if(this.TYPE == MapDecorations.MAP_2_SHORE_1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.map1TextureAtlas.getTextures("map2Element1SpriteAnim_"),12);
         }
         else if(this.TYPE == MapDecorations.MAP_2_SHORE_2)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.map1TextureAtlas.getTextures("map2Element2SpriteAnim_"),12);
         }
         else if(this.TYPE == MapDecorations.MAP_2_SHORE_3)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.map1TextureAtlas.getTextures("map2Element3SpriteAnim_"),12);
         }
         else if(this.TYPE == MapDecorations.MAP_2_SHORE_4)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.map1TextureAtlas.getTextures("map2Element4SpriteAnim_"),12);
         }
         else if(this.TYPE == MapDecorations.MAP_2_SHORE_5)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.map1TextureAtlas.getTextures("map2Element5SpriteAnim_"),12);
         }
         else
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapTruckSpriteAnim_"),12);
            this.standAnimation1.setFrameDuration(0,0.5);
            this.standAnimation1.setFrameDuration(1,0.5);
         }
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
