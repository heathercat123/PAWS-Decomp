package interfaces.map.cutscenes
{
   import entities.Easings;
   import flash.geom.Point;
   import game_utils.GameSlot;
   import game_utils.SaveManager;
   import interfaces.map.*;
   import interfaces.map.decorations.MapDecorations;
   import interfaces.map.particles.*;
   import sprites.map.*;
   import starling.display.Image;
   
   public class World2MapCutscene extends MapCutscene
   {
       
      
      protected var buttonSprite:MapButtonAppearingParticleSprite;
      
      protected var button_xPos:Number;
      
      protected var button_yPos:Number;
      
      protected var genericSprite1:GenericMapSprite;
      
      protected var genericSprite2:GenericMapSprite;
      
      protected var gSprite1_xPos:Number;
      
      protected var gSprite1_yPos:Number;
      
      protected var gSprite2_xPos:Number;
      
      protected var gSprite2_yPos:Number;
      
      protected var gSprite1_xVel:Number;
      
      protected var gSprite1_yVel:Number;
      
      protected var roadImages:Vector.<Image>;
      
      protected var roadPositions:Vector.<Point>;
      
      protected var road_index:int;
      
      protected var justOnce:Boolean;
      
      protected var WORLD_PAGE:int;
      
      public function World2MapCutscene(_worldMap:WorldMap, _index:int)
      {
         var i:int = 0;
         super(_worldMap,_index);
         this.justOnce = true;
         this.buttonSprite = null;
         this.genericSprite1 = null;
         this.genericSprite2 = null;
         this.WORLD_PAGE = Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID];
         this.roadImages = new Vector.<Image>();
         this.roadPositions = new Vector.<Point>();
         this.road_index = 0;
         this.gSprite1_xVel = this.gSprite1_yVel = 0;
         this.button_xPos = worldMap.mapLevels.getLevelButtonCoordinates(INDEX + 1).x;
         this.button_yPos = worldMap.mapLevels.getLevelButtonCoordinates(INDEX + 1).y;
         worldMap.mapCamera.xPos = this.button_xPos + 16 - worldMap.mapCamera.WIDTH * 0.5;
         if(INDEX == 9)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadImages[0].width = this.roadImages[1].width = this.roadImages[3].width = 10;
            this.roadImages[0].height = this.roadImages[1].height = 12;
            this.roadImages[3].height = 15;
            this.roadPositions.push(new Point(171,156));
            this.roadPositions.push(new Point(171,156 + 12));
            this.roadPositions.push(new Point(171 - 2,156 + 19));
            this.roadPositions.push(new Point(171,156 + 25));
         }
         else if(INDEX == 10)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.MONKEY);
            this.genericSprite2 = new GenericMapSprite(MapDecorations.MONKEY);
            Utils.world.addChild(this.genericSprite1);
            Utils.world.addChild(this.genericSprite2);
            this.genericSprite1.scaleX = -1;
            this.gSprite1_xPos = 192 + 60;
            this.gSprite1_yPos = 207 - 22 + 1;
            this.gSprite2_xPos = 192 + 109 + 5;
            this.gSprite2_yPos = 207 + 8;
            this.genericSprite1.alpha = this.genericSprite2.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_14")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages[0].width = 23;
            this.roadImages[1].width = 18;
            this.roadImages[3].width = 10;
            this.roadImages[0].height = 10;
            this.roadImages[1].height = 10;
            this.roadImages[3].height = 20;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(192,207));
            this.roadPositions.push(new Point(192 + 56,207 + 28));
            this.roadPositions.push(new Point(192 + 74,207 + 27));
            this.roadPositions.push(new Point(192 + 82,207 + 8));
         }
         else if(INDEX == 11)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(274 + 2,156 + 23));
            this.roadPositions.push(new Point(274 + 2,156 + 7));
         }
         else if(INDEX == 12)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.LOBSTER);
            this.genericSprite2 = new GenericMapSprite(MapDecorations.VILLAGE_FLAG);
            Utils.world.addChild(this.genericSprite1);
            Utils.world.addChild(this.genericSprite2);
            this.gSprite1_xPos = 353 + 84 + 3 + 17;
            this.gSprite1_yPos = 146 - 37 - 2 + 6;
            this.gSprite2_xPos = 436;
            this.gSprite2_yPos = 124 - 17;
            this.genericSprite1.alpha = 0;
            this.genericSprite2.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_6")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages[0].width = 27;
            this.roadImages[1].width = 19;
            this.roadImages[0].height = this.roadImages[1].height = 10;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(353,146));
            this.roadPositions.push(new Point(354 + 27,146 - 11));
         }
         else if(INDEX == 13)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_15")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages[0].width = this.roadImages[1].width = 15;
            this.roadImages[0].height = this.roadImages[1].height = 10;
            this.roadImages[3].width = 10;
            this.roadImages[3].height = 13;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(432 + 0,135 + 0));
            this.roadPositions.push(new Point(432 + 15,135 + 0));
            this.roadPositions.push(new Point(432 + 29,135 + 0));
            this.roadPositions.push(new Point(432 + 30,135 + 10));
         }
         else if(INDEX == 14)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(528 + 9,171 + 2));
            this.roadPositions.push(new Point(528 + 25,171 + 2));
         }
         else if(INDEX == 15)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.FISH_BOSS);
            Utils.world.addChild(this.genericSprite1);
            this.gSprite1_xPos = 600 + 64;
            this.gSprite1_yPos = 171 + 25;
            this.genericSprite1.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_7")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_7")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(600 + 9,171 + 2));
            this.roadPositions.push(new Point(600 + 25,171 + 2));
         }
         else if(INDEX == 251)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(295 + 10,192 + 13));
            this.roadPositions.push(new Point(295 + 33,192 + 13));
         }
         else if(INDEX == 802)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.SMALL_BOAT_1);
            Utils.world.addChild(this.genericSprite1);
            this.gSprite1_xPos = t_start = 458;
            this.gSprite1_yPos = t_start_y = 183;
            t_diff = 499 - t_start;
            t_diff_y = 222 - t_start_y;
            t_tick = 0;
            t_time = 1.5;
         }
         if(worldMap.mapCamera.xPos < worldMap.mapCamera.LEFT_MARGIN)
         {
            worldMap.mapCamera.xPos = worldMap.mapCamera.LEFT_MARGIN;
         }
         else if(worldMap.mapCamera.xPos + Utils.WIDTH > worldMap.mapCamera.RIGHT_MARGIN)
         {
            worldMap.mapCamera.xPos = worldMap.mapCamera.RIGHT_MARGIN - Utils.WIDTH;
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pWaveSprite:WaveMapParticleSprite = null;
         if(INDEX == 9)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 4)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  SoundSystem.PlaySound("map_stomp");
                  worldMap.mapLevels.getShadow(INDEX + 1).visible = false;
               }
               else
               {
                  worldMap.mapLevels.getShadow(INDEX + 1).visible = true;
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.getShadow(INDEX + 1).visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_2_DECORATION,true);
               worldMap.mapLevels.setOnTop();
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 10)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
                  this.genericSprite1.visible = true;
                  this.genericSprite1.alpha = 0.3;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 4)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                        if(this.road_index == 1)
                        {
                           this.genericSprite1.alpha = 0.6;
                           this.genericSprite2.alpha = 0.3;
                        }
                        else if(this.road_index == 2)
                        {
                           this.genericSprite1.alpha = 1;
                           this.genericSprite2.alpha = 0.6;
                        }
                        else if(this.road_index == 3)
                        {
                           this.genericSprite2.alpha = 1;
                        }
                     }
                     else
                     {
                        this.genericSprite1.alpha = 1;
                        this.genericSprite2.alpha = 1;
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  SoundSystem.PlaySound("map_stomp");
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_3_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 11)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 2)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  if(this.buttonSprite.gfxHandleClip().currentFrame == 5 && this.justOnce)
                  {
                     SoundSystem.PlaySound("water");
                     this.justOnce = false;
                     pWaveSprite = new WaveMapParticleSprite();
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos + 32,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos + 32,0,0,0);
                     Utils.topWorld.setChildIndex(this.buttonSprite,Utils.topWorld.numChildren - 1);
                  }
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_4_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 12)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
                  this.genericSprite1.alpha = this.genericSprite2.alpha = 0.5;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 2)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                        if(this.road_index == 1)
                        {
                           this.genericSprite1.alpha = this.genericSprite2.alpha = 1;
                        }
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  SoundSystem.PlaySound("map_stomp");
                  worldMap.mapLevels.getShadow(INDEX + 1).visible = false;
               }
               else
               {
                  worldMap.mapLevels.getShadow(INDEX + 1).visible = true;
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.getShadow(INDEX + 1).visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_5_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 13)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 4)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  if(this.buttonSprite.gfxHandleClip().currentFrame == 5 && this.justOnce)
                  {
                     SoundSystem.PlaySound("water");
                     this.justOnce = false;
                     pWaveSprite = new WaveMapParticleSprite();
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos + 32,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos + 32,0,0,0);
                     Utils.topWorld.setChildIndex(this.buttonSprite,Utils.topWorld.numChildren - 1);
                  }
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_6_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 14)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 2)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  if(this.buttonSprite.gfxHandleClip().currentFrame == 5 && this.justOnce)
                  {
                     SoundSystem.PlaySound("water");
                     this.justOnce = false;
                     pWaveSprite = new WaveMapParticleSprite();
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos + 32,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos + 32,0,0,0);
                     Utils.topWorld.setChildIndex(this.buttonSprite,Utils.topWorld.numChildren - 1);
                  }
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_7_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 15)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
                  this.genericSprite1.visible = true;
                  this.genericSprite1.alpha = 0.5;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 2)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                        this.genericSprite1.alpha = 1;
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  SoundSystem.PlaySound("map_stomp");
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_8_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 251)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("map_advance");
                  this.roadImages[0].visible = true;
                  this.road_index = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha += 0.3;
                  if(this.roadImages[this.road_index].alpha >= 1)
                  {
                     this.roadImages[this.road_index].alpha = 1;
                     ++this.road_index;
                     if(this.road_index < 2)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 3)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  SoundSystem.PlaySound("map_stomp");
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 4)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_SECRET_2_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 802)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  SoundSystem.PlaySound("boat_horn");
               }
            }
            else if(PROGRESSION == 1)
            {
               t_tick += 1 / 60;
               if(t_tick >= t_time)
               {
                  t_tick = t_time;
                  ++PROGRESSION;
                  counter1 = 0;
               }
               this.gSprite1_xPos = int(Easings.linear(t_tick,t_start,t_diff,t_time));
               this.gSprite1_yPos = int(Easings.linear(t_tick,t_start_y,t_diff_y,t_time));
            }
            else if(PROGRESSION == 2)
            {
               ++counter1;
               if(counter1 > 2)
               {
                  counter1 = 0;
                  this.genericSprite1.alpha -= 0.3;
                  if(this.genericSprite1.alpha <= 0)
                  {
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 3)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton(1);
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
            {
               if(this.buttonSprite.gfxHandleClip().currentFrame == 5 || this.buttonSprite.gfxHandleClip().currentFrame == 9)
               {
                  if(this.buttonSprite.gfxHandleClip().currentFrame == 5 && this.justOnce)
                  {
                     SoundSystem.PlaySound("water");
                     this.justOnce = false;
                     pWaveSprite = new WaveMapParticleSprite();
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos + 32,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos + 32,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = pWaveSprite.scaleY = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos,0,0,0);
                     pWaveSprite = new WaveMapParticleSprite();
                     pWaveSprite.scaleX = -1;
                     worldMap.mapParticlesManager.pushParticle(pWaveSprite,this.button_xPos,this.button_yPos + 32,0,0,0);
                     Utils.topWorld.setChildIndex(this.buttonSprite,Utils.topWorld.numChildren - 1);
                  }
               }
               if(this.buttonSprite.gfxHandleClip().isComplete)
               {
                  ++PROGRESSION;
                  this.buttonSprite.visible = false;
                  worldMap.mapLevels.setLevelButtonVisible(INDEX + 1);
               }
            }
            else if(PROGRESSION == 5)
            {
               this.endCutscene();
               ++PROGRESSION;
            }
         }
      }
      
      override public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         if(this.genericSprite1 != null)
         {
            this.genericSprite1.x = int(Math.floor(this.gSprite1_xPos - mapCamera.xPos));
            this.genericSprite1.y = int(Math.floor(this.gSprite1_yPos - mapCamera.yPos));
         }
         if(this.genericSprite2 != null)
         {
            this.genericSprite2.x = int(Math.floor(this.gSprite2_xPos - mapCamera.xPos));
            this.genericSprite2.y = int(Math.floor(this.gSprite2_yPos - mapCamera.yPos));
         }
         if(this.buttonSprite != null)
         {
            this.buttonSprite.x = int(Math.floor(this.button_xPos - mapCamera.xPos));
            this.buttonSprite.y = int(Math.floor(this.button_yPos - mapCamera.yPos));
         }
         for(i = 0; i < this.roadImages.length; i++)
         {
            this.roadImages[i].x = int(Math.floor(this.roadPositions[i].x - mapCamera.xPos));
            this.roadImages[i].y = int(Math.floor(this.roadPositions[i].y - mapCamera.yPos));
         }
      }
      
      protected function createButton(_button_type:int = 0) : void
      {
         var pCoord:Point = worldMap.mapLevels.getLevelButtonCoordinates(INDEX + 1);
         this.buttonSprite = new MapButtonAppearingParticleSprite(_button_type);
         Utils.topWorld.addChild(this.buttonSprite);
         this.button_xPos = pCoord.x;
         this.button_yPos = pCoord.y;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.buttonSprite != null)
         {
            Utils.world.removeChild(this.buttonSprite);
            this.buttonSprite.destroy();
            this.buttonSprite.dispose();
            this.buttonSprite = null;
         }
         if(this.genericSprite1 != null)
         {
            Utils.world.removeChild(this.genericSprite1);
            this.genericSprite1.destroy();
            this.genericSprite1.dispose();
            this.genericSprite1 = null;
         }
         if(this.genericSprite2 != null)
         {
            Utils.world.removeChild(this.genericSprite2);
            this.genericSprite2.destroy();
            this.genericSprite2.dispose();
            this.genericSprite2 = null;
         }
         for(i = 0; i < this.roadImages.length; i++)
         {
            Utils.world.removeChild(this.roadImages[i]);
            this.roadImages[i].dispose();
            this.roadImages[i] = null;
            this.roadPositions[i] = null;
         }
         this.roadImages = null;
         this.roadPositions = null;
         super.destroy();
      }
      
      protected function endCutscene() : void
      {
         if(INDEX == 9)
         {
            Utils.Slot.levelUnlocked[9] = true;
         }
         else if(INDEX == 10)
         {
            Utils.Slot.levelUnlocked[10] = true;
         }
         else if(INDEX == 11)
         {
            Utils.Slot.levelUnlocked[11] = true;
         }
         else if(INDEX == 12)
         {
            Utils.Slot.levelUnlocked[12] = true;
         }
         else if(INDEX == 13)
         {
            Utils.Slot.levelUnlocked[13] = true;
         }
         else if(INDEX == 14)
         {
            Utils.Slot.levelUnlocked[14] = true;
         }
         else if(INDEX == 15)
         {
            Utils.Slot.levelUnlocked[15] = true;
         }
         else if(INDEX == 802)
         {
            Utils.Slot.levelUnlocked[802] = true;
         }
         else if(INDEX == 251)
         {
            Utils.Slot.levelUnlocked[251] = true;
         }
         SaveManager.SaveSlot();
         dead = true;
      }
   }
}
