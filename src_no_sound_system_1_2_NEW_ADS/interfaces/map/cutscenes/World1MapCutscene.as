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
   
   public class World1MapCutscene extends MapCutscene
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
      
      protected var sound_flag_1:Boolean;
      
      protected var sound_flag_2:Boolean;
      
      protected var road_index:int;
      
      protected var justOnce:Boolean;
      
      protected var WORLD_PAGE:int;
      
      public function World1MapCutscene(_worldMap:WorldMap, _index:int)
      {
         var i:int = 0;
         super(_worldMap,_index);
         this.justOnce = true;
         this.buttonSprite = null;
         this.genericSprite1 = null;
         this.genericSprite2 = null;
         this.sound_flag_1 = this.sound_flag_2 = false;
         this.WORLD_PAGE = Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID];
         this.roadImages = new Vector.<Image>();
         this.roadPositions = new Vector.<Point>();
         this.road_index = 0;
         this.gSprite1_xVel = this.gSprite1_yVel = 0;
         this.button_xPos = worldMap.mapLevels.getLevelButtonCoordinates(INDEX + 1).x;
         this.button_yPos = worldMap.mapLevels.getLevelButtonCoordinates(INDEX + 1).y;
         worldMap.mapCamera.xPos = this.button_xPos + 16 - worldMap.mapCamera.WIDTH * 0.5;
         if(INDEX == 0)
         {
            worldMap.mapCamera.xPos = worldMap.mapCamera.LEFT_MARGIN;
            this.genericSprite1 = new GenericMapSprite(MapDecorations.TRUCK);
            Utils.world.addChild(this.genericSprite1);
            this.gSprite1_xPos = 0;
            this.gSprite1_yPos = 125;
            t_start = t_tick = 0;
            t_diff = 91;
            t_time = 2;
         }
         else if(INDEX == 1)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.BEETLE);
            Utils.world.addChild(this.genericSprite1);
            this.gSprite1_xPos = 192 + 101;
            this.gSprite1_yPos = 135 - 8;
            this.genericSprite1.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadImages[0].width = this.roadImages[1].width = this.roadImages[2].width = 16;
            this.roadImages[3].width = 15;
            this.roadImages[0].height = this.roadImages[1].height = this.roadImages[2].height = this.roadImages[3].height = 10;
            this.roadPositions.push(new Point(192,135));
            this.roadPositions.push(new Point(192 + 16,135));
            this.roadPositions.push(new Point(225,111));
            this.roadPositions.push(new Point(225 + 16,111));
         }
         else if(INDEX == 2)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_4")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(265,147));
            this.roadPositions.push(new Point(265,158));
            this.roadPositions.push(new Point(265,166));
            this.roadPositions.push(new Point(261,174));
            this.roadPositions.push(new Point(265,182));
         }
         else if(INDEX == 3)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.BEE);
            this.genericSprite2 = new GenericMapSprite(MapDecorations.BEE);
            Utils.world.addChild(this.genericSprite1);
            Utils.world.addChild(this.genericSprite2);
            this.genericSprite2.scaleX = -1;
            this.gSprite1_xPos = 288 + 114;
            this.gSprite1_yPos = 215 - 33;
            this.gSprite2_xPos = 288 + 78;
            this.gSprite2_yPos = 215 - 51;
            this.genericSprite1.alpha = this.genericSprite2.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
               this.roadImages[i].width = 16;
               this.roadImages[i].height = 10;
            }
            this.roadPositions.push(new Point(288,215));
            this.roadPositions.push(new Point(304,215));
            this.roadPositions.push(new Point(320,215));
            this.roadPositions.push(new Point(336,215));
            this.roadPositions.push(new Point(352,215));
         }
         else if(INDEX == 4)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.OLLI);
            this.genericSprite2 = new GenericMapSprite(MapDecorations.VILLAGE_FLAG);
            Utils.world.addChild(this.genericSprite1);
            Utils.world.addChild(this.genericSprite2);
            this.gSprite1_xPos = 475 + 31;
            this.gSprite1_yPos = 161 - 34;
            this.gSprite2_xPos = 500;
            this.gSprite2_yPos = 83;
            this.genericSprite1.alpha = this.genericSprite2.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapBarrier_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
            Utils.world.addChild(this.roadImages[2]);
            this.roadImages[1].width = this.roadImages[2].width = 10;
            this.roadImages[1].height = 15;
            this.roadImages[2].height = 14;
            this.roadImages[1].visible = this.roadImages[2].visible = false;
            this.roadImages[1].alpha = this.roadImages[2].alpha = 0;
            this.roadPositions.push(new Point(468,152));
            this.roadPositions.push(new Point(475,161 - 15));
            this.roadPositions.push(new Point(475,161 - 29));
         }
         else if(INDEX == 5)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.MOLE);
            Utils.world.addChild(this.genericSprite1);
            this.gSprite1_xPos = 496 + 114;
            this.gSprite1_yPos = 111 + 6;
            this.genericSprite1.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapBarrier_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapBridge_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapBridge_1")));
            this.roadImages[0].height = 38;
            this.roadImages[1].width = this.roadImages[2].width = 20;
            this.roadImages[1].height = this.roadImages[2].height = 10;
            this.roadPositions.push(new Point(532,92));
            this.roadPositions.push(new Point(496,111));
            this.roadPositions.push(new Point(496 + 20,111));
            this.roadPositions.push(new Point(496 + 40,111 - 3));
            this.roadPositions.push(new Point(496 + 40 + 12,111 - 3));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               if(i > 0)
               {
                  this.roadImages[i].visible = false;
                  this.roadImages[i].alpha = 0;
               }
            }
         }
         else if(INDEX == 6)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages[0].width = 10;
            this.roadImages[0].height = 17;
            this.roadImages[2].width = 10;
            this.roadImages[2].height = 11;
            this.roadImages[3].width = 10;
            this.roadImages[3].height = 11;
            this.roadPositions.push(new Point(571 + 0,132 + 0));
            this.roadPositions.push(new Point(571 - 2,132 + 12));
            this.roadPositions.push(new Point(571 + 0,132 + 18));
            this.roadPositions.push(new Point(571 + 0,132 + 29));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
         }
         else if(INDEX == 7)
         {
            this.genericSprite1 = new GenericMapSprite(MapDecorations.LIZARD_BOSS);
            Utils.world.addChild(this.genericSprite1);
            this.gSprite1_xPos = 592 + 57 + 19;
            this.gSprite1_yPos = 183 - 19 + 16;
            this.genericSprite1.alpha = 0;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages[0].width = this.roadImages[1].width = this.roadImages[2].width = 16;
            this.roadImages[0].height = this.roadImages[1].height = this.roadImages[2].height = 10;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(592,183));
            this.roadPositions.push(new Point(592 + 16,183));
            this.roadPositions.push(new Point(592 + 32,183));
         }
         else if(INDEX == 8)
         {
            if(this.WORLD_PAGE == 0)
            {
               this.button_xPos = worldMap.mapLevels.getLevelButtonCoordinates(INDEX).x;
               this.button_yPos = worldMap.mapLevels.getLevelButtonCoordinates(INDEX).y;
               worldMap.mapCamera.xPos = this.button_xPos + 16 - worldMap.mapCamera.WIDTH * 0.5;
               this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLizardBossDefeatedAnim_a")));
               Utils.world.addChild(this.roadImages[0]);
               this.roadPositions.push(new Point(668,180));
            }
            else if(this.WORLD_PAGE == 1)
            {
               this.genericSprite1 = new GenericMapSprite(MapDecorations.SQUID);
               Utils.world.addChild(this.genericSprite1);
               this.gSprite1_xPos = 104 + 91;
               this.gSprite1_yPos = 135 - 30;
               this.genericSprite1.alpha = 0;
               this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_1")));
               this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_1")));
               for(i = 0; i < this.roadImages.length; i++)
               {
                  Utils.world.addChild(this.roadImages[i]);
                  this.roadImages[i].visible = false;
                  this.roadImages[i].alpha = 0;
               }
               this.roadPositions.push(new Point(104 + 12,135 + 2));
               this.roadPositions.push(new Point(104 + 36,135 + 2));
            }
         }
         else if(INDEX == 250)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapSecretArea1")));
            this.roadPositions.push(new Point(74,188));
            Utils.world.addChild(this.roadImages[0]);
         }
         else if(INDEX == 801)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_bridge_tile_3")));
            this.roadImages[0].width = this.roadImages[1].width = 14;
            this.roadImages[0].height = this.roadImages[1].height = 10;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
               this.roadImages[i].visible = false;
               this.roadImages[i].alpha = 0;
            }
            this.roadPositions.push(new Point(546,183));
            this.roadPositions.push(new Point(532,183));
            this.roadPositions.push(new Point(507,211));
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
         var pSprite:MapSmallWhiteExplosionParticleSprite = null;
         var angle:Number = NaN;
         var radius:Number = NaN;
         var pWaveSprite:WaveMapParticleSprite = null;
         if(INDEX == 0)
         {
            if(PROGRESSION == 0)
            {
               if(counter1++ >= Utils.CutsceneDelayTime)
               {
                  SoundSystem.PlaySound("wroom");
                  this.sound_flag_1 = false;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 1)
            {
               t_tick += 1 / 60;
               if(t_tick >= 1 && this.sound_flag_1 == false)
               {
                  this.sound_flag_1 = true;
                  SoundSystem.PlaySound("skid");
               }
               if(t_tick >= t_time)
               {
                  t_tick = t_time;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               this.gSprite1_xPos = Easings.easeOutQuart(t_tick,t_start,t_diff,t_time);
            }
            else if(PROGRESSION == 2)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               counter1 = 0;
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
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_1_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 1)
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
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[0].alpha += 0.3;
                  if(this.roadImages[0].alpha >= 1)
                  {
                     ++PROGRESSION;
                     SoundSystem.PlaySound("map_advance");
                     this.roadImages[0].alpha = 1;
                     this.roadImages[1].visible = true;
                     this.genericSprite1.alpha = 0;
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[1].alpha += 0.3;
                  if(this.roadImages[1].alpha >= 1)
                  {
                     ++PROGRESSION;
                     SoundSystem.PlaySound("map_advance");
                     this.roadImages[1].alpha = 1;
                     this.roadImages[2].visible = true;
                     this.genericSprite1.alpha = 0.3;
                  }
               }
            }
            else if(PROGRESSION == 3)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[2].alpha += 0.3;
                  if(this.roadImages[2].alpha >= 1)
                  {
                     ++PROGRESSION;
                     SoundSystem.PlaySound("map_advance");
                     this.roadImages[2].alpha = 1;
                     this.roadImages[3].visible = true;
                     this.genericSprite1.alpha = 0.6;
                  }
               }
            }
            else if(PROGRESSION == 4)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[3].alpha += 0.3;
                  if(this.roadImages[3].alpha >= 1)
                  {
                     ++PROGRESSION;
                     this.roadImages[3].alpha = 1;
                     this.genericSprite1.alpha = 1;
                  }
               }
            }
            else if(PROGRESSION == 5)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 6)
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
            else if(PROGRESSION == 7)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_2_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 2)
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
                     if(this.road_index < 5)
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
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_3_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 3)
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
                     if(this.road_index < 5)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                        if(this.road_index == 1)
                        {
                           this.genericSprite2.alpha = 0.3;
                        }
                        else if(this.road_index == 2)
                        {
                           this.genericSprite1.alpha = 0.3;
                           this.genericSprite2.alpha = 0.6;
                        }
                        else if(this.road_index == 3)
                        {
                           this.genericSprite1.alpha = 0.6;
                           this.genericSprite2.alpha = 1;
                        }
                        else if(this.road_index == 4)
                        {
                           this.genericSprite1.alpha = 1;
                           this.genericSprite2.alpha = 1;
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
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_4_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 4)
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
                  this.roadImages[0].alpha = 1;
                  this.genericSprite1.alpha = this.genericSprite2.alpha = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[0].alpha -= 0.3;
                  if(this.roadImages[0].alpha <= 0)
                  {
                     ++PROGRESSION;
                     SoundSystem.PlaySound("map_advance");
                     this.roadImages[0].visible = false;
                     this.roadImages[1].visible = true;
                     this.genericSprite1.alpha = this.genericSprite2.alpha = 0.3;
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[1].alpha += 0.3;
                  if(this.roadImages[1].alpha >= 1)
                  {
                     ++PROGRESSION;
                     SoundSystem.PlaySound("map_advance");
                     this.roadImages[1].alpha = 1;
                     this.roadImages[2].visible = true;
                     this.genericSprite1.alpha = this.genericSprite2.alpha = 0.6;
                  }
               }
            }
            else if(PROGRESSION == 3)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[2].alpha += 0.3;
                  if(this.roadImages[2].alpha >= 1)
                  {
                     ++PROGRESSION;
                     this.roadImages[2].alpha = 1;
                     this.genericSprite1.alpha = this.genericSprite2.alpha = 1;
                  }
               }
            }
            else if(PROGRESSION == 4)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
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
            else if(PROGRESSION == 6)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_5_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 5)
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
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 3)
               {
                  counter1 = 0;
                  this.roadImages[0].alpha -= 0.3;
                  if(this.roadImages[0].alpha <= 0)
                  {
                     ++PROGRESSION;
                     SoundSystem.PlaySound("map_advance");
                     this.roadImages[0].visible = false;
                     this.roadImages[1].visible = true;
                     this.road_index = 1;
                  }
               }
            }
            else if(PROGRESSION == 2)
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
                     if(this.road_index < 5)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                        if(this.road_index == 2)
                        {
                           this.genericSprite1.alpha = 0.3;
                        }
                        else if(this.road_index == 3)
                        {
                           this.genericSprite1.alpha = 0.6;
                        }
                        else if(this.road_index == 4)
                        {
                           this.genericSprite1.alpha = 1;
                        }
                     }
                     else
                     {
                        ++PROGRESSION;
                     }
                  }
               }
            }
            else if(PROGRESSION == 3)
            {
               SoundSystem.PlaySound("map_appear");
               this.createButton();
               ++PROGRESSION;
            }
            else if(PROGRESSION == 4)
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
            else if(PROGRESSION == 5)
            {
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_6_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 6)
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
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_7_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 7)
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
                     if(this.road_index < 3)
                     {
                        SoundSystem.PlaySound("map_advance");
                        this.roadImages[this.road_index].visible = true;
                        if(this.road_index == 1)
                        {
                           this.genericSprite1.alpha = 0.3;
                        }
                        else if(this.road_index == 2)
                        {
                           this.genericSprite1.alpha = 0.6;
                        }
                     }
                     else
                     {
                        this.genericSprite1.alpha = 1;
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
               worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_1_8_DECORATION,true);
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 8)
         {
            if(this.WORLD_PAGE == 0)
            {
               if(PROGRESSION == 0)
               {
                  ++counter1;
                  if(counter1 >= Utils.CutsceneDelayTime)
                  {
                     ++PROGRESSION;
                     counter1 = 0;
                  }
               }
               else if(PROGRESSION == 1)
               {
                  if(counter1++ > 10)
                  {
                     counter1 = 0;
                     ++counter2;
                     SoundSystem.PlaySound("explosion");
                     pSprite = new MapSmallWhiteExplosionParticleSprite();
                     angle = Math.random() * Math.PI * 2;
                     radius = 32 + Math.random() * 16;
                     worldMap.mapCamera.shake(3);
                     worldMap.mapParticlesManager.pushParticle(pSprite,688 + Math.sin(angle) * radius,156 + Math.cos(angle) * radius,0,0,0);
                     if(counter2 > 7)
                     {
                        counter1 = counter2 = 0;
                        ++PROGRESSION;
                     }
                  }
               }
               else if(PROGRESSION == 2)
               {
                  if(counter1++ > 60)
                  {
                     SoundSystem.PlaySound("explosion_big");
                     worldMap.mapCamera.shake(6,true);
                     worldMap.mapParticlesManager.pushParticle(new MapExplosionParticleSprite(),int(this.roadPositions[0].x + this.roadImages[0].width * 0.5),int(this.roadPositions[0].y + this.roadImages[0].height * 0.5),0,0,0);
                     this.gSprite1_yVel = -2;
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 3)
               {
                  if(counter1++ > 15)
                  {
                     this.roadPositions[0].y += this.gSprite1_yVel;
                     this.gSprite1_yVel += 0.1;
                     if(this.gSprite1_yVel >= 4)
                     {
                        this.gSprite1_yVel = 4;
                     }
                     if(this.roadPositions[0].y >= worldMap.mapCamera.y + Utils.HEIGHT + 32)
                     {
                        counter1 = 0;
                        ++PROGRESSION;
                        SoundSystem.PlaySound("big_impact");
                        worldMap.mapCamera.shake(6);
                     }
                  }
               }
               else if(PROGRESSION == 4)
               {
                  if(counter1++ >= 40)
                  {
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else if(PROGRESSION == 5)
               {
                  SoundSystem.PlaySound("select");
                  ++Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID];
                  worldMap.pageSelected(false);
                  ++PROGRESSION;
               }
            }
            else if(this.WORLD_PAGE == 1)
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
                        if(this.road_index < 2)
                        {
                           SoundSystem.PlaySound("map_advance");
                           this.roadImages[this.road_index].visible = true;
                           if(this.road_index == 1)
                           {
                              this.genericSprite1.alpha = 0.6;
                           }
                        }
                        else
                        {
                           this.genericSprite1.alpha = 1;
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
                  worldMap.mapDecorations.createDecoration(MapDecorations.LEVEL_2_1_DECORATION,true);
                  this.endCutscene();
                  ++PROGRESSION;
               }
            }
         }
         else if(INDEX == 250)
         {
            if(PROGRESSION == 0)
            {
               ++counter1;
               if(counter1 >= Utils.CutsceneDelayTime)
               {
                  ++PROGRESSION;
                  counter1 = 0;
                  this.road_index = 0;
                  SoundSystem.PlaySound("map_advance");
               }
            }
            else if(PROGRESSION == 1)
            {
               ++counter1;
               if(counter1 > 15)
               {
                  counter1 = 0;
                  this.roadImages[this.road_index].alpha -= 0.3;
                  if(this.roadImages[this.road_index].alpha <= 0)
                  {
                     this.roadImages[this.road_index].alpha = 0;
                     this.roadImages[this.road_index].visible = false;
                     ++PROGRESSION;
                  }
                  else
                  {
                     SoundSystem.PlaySound("map_advance");
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
               this.endCutscene();
               ++PROGRESSION;
            }
         }
         else if(INDEX == 801)
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
                     if(this.road_index < 3)
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
               this.createButton(1);
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
               worldMap.mapDecorations.createDecoration(MapDecorations.FISHING_SPOT_1_DECORATION,true);
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
         if(INDEX == 0)
         {
            Utils.Slot.levelUnlocked[0] = true;
         }
         else if(INDEX == 1)
         {
            Utils.Slot.levelUnlocked[1] = true;
         }
         else if(INDEX == 2)
         {
            Utils.Slot.levelUnlocked[2] = true;
         }
         else if(INDEX == 3)
         {
            Utils.Slot.levelUnlocked[3] = true;
         }
         else if(INDEX == 4)
         {
            Utils.Slot.levelUnlocked[4] = true;
         }
         else if(INDEX == 5)
         {
            Utils.QuestOn = true;
            Utils.Slot.levelUnlocked[5] = true;
         }
         else if(INDEX == 6)
         {
            Utils.Slot.levelUnlocked[6] = true;
         }
         else if(INDEX == 7)
         {
            Utils.Slot.levelUnlocked[7] = true;
         }
         else if(INDEX == 8)
         {
            Utils.Slot.levelUnlocked[8] = true;
         }
         else if(INDEX == 801)
         {
            Utils.Slot.levelUnlocked[801] = true;
         }
         else if(INDEX == 250)
         {
            Utils.Slot.levelUnlocked[250] = true;
         }
         SaveManager.SaveSlot();
         dead = true;
      }
   }
}
