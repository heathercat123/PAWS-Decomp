package interfaces.map
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.ButtonCluster;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import interfaces.buttons.MapLevelButton;
   import interfaces.map.cutscenes.EnoughBellsMapCutscene;
   import interfaces.map.cutscenes.NotEnoughBellsMapCutscene;
   import starling.display.Button;
   import starling.display.Image;
   import starling.events.Event;
   
   public class MapLevels
   {
       
      
      public var worldMap:WorldMap;
      
      protected var buttons:Vector.<MapLevelButton>;
      
      protected var buttonsData:Array;
      
      protected var shadows:Array;
      
      protected var shadowsData:Array;
      
      protected var levelSelection:int;
      
      protected var buttonClusters:Vector.<ButtonCluster>;
      
      protected var pageButtons:Vector.<Button>;
      
      protected var pageButtonsData:Array;
      
      public function MapLevels(_worldMap:WorldMap)
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         var button:Button = null;
         var mapLevelButton:MapLevelButton = null;
         var found:Boolean = false;
         super();
         this.worldMap = _worldMap;
         this.levelSelection = 0;
         this.buttons = new Vector.<MapLevelButton>();
         this.buttonsData = new Array();
         this.shadows = new Array();
         this.shadowsData = new Array();
         this.buttonClusters = new Vector.<ButtonCluster>();
         this.pageButtons = new Vector.<Button>();
         this.pageButtonsData = new Array();
         for(i = 0; i < this.worldMap.mapLoader.mapLevels.length; i++)
         {
            if(this.worldMap.mapLoader.mapLevels[i].type == 0)
            {
               if(Utils.Slot.levelPerfect[this.worldMap.mapLoader.mapLevels[i].width - 1])
               {
                  mapLevelButton = new MapLevelButton(TextureManager.hudTextureAtlas.getTexture("mapLevelCompleteButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapLevelCompleteButton2"),this.worldMap.mapLoader.mapLevels[i].width,this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y);
               }
               else
               {
                  mapLevelButton = new MapLevelButton(TextureManager.hudTextureAtlas.getTexture("mapLevelButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapLevelButton2"),this.worldMap.mapLoader.mapLevels[i].width,this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y);
               }
               this.buttonsData.push(new Rectangle(this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y,this.worldMap.mapLoader.mapLevels[i].width,0));
               this.buttons.push(mapLevelButton);
               mapLevelButton.name = "" + this.worldMap.mapLoader.mapLevels[i].width;
               mapLevelButton.addEventListener(Event.TRIGGERED,this.clickHandler);
               if(Utils.Slot.levelUnlocked[this.worldMap.mapLoader.mapLevels[i].width - 1] == false)
               {
                  mapLevelButton.visible = false;
               }
               else
               {
                  found = false;
                  for(j = 0; j < LevelItems.Items[this.worldMap.mapLoader.mapLevels[i].width - 1].length; j++)
                  {
                     if(!found)
                     {
                        this.buttonClusters.push(new ButtonCluster(mapLevelButton,this.worldMap.mapLoader.mapLevels[i].width - 1));
                        found = true;
                     }
                  }
               }
               Utils.world.addChild(mapLevelButton);
            }
            else if(this.worldMap.mapLoader.mapLevels[i].type == 100)
            {
               mapLevelButton = new MapLevelButton(TextureManager.hudTextureAtlas.getTexture("mapFishingSpotButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapFishingSpotButton2"),this.worldMap.mapLoader.mapLevels[i].width,this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y);
               this.buttonsData.push(new Rectangle(this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y,this.worldMap.mapLoader.mapLevels[i].width,0));
               this.buttons.push(mapLevelButton);
               mapLevelButton.name = "" + this.worldMap.mapLoader.mapLevels[i].width;
               mapLevelButton.addEventListener(Event.TRIGGERED,this.clickHandler);
               if(Utils.Slot.levelUnlocked[this.worldMap.mapLoader.mapLevels[i].width - 1] == false)
               {
                  mapLevelButton.visible = false;
               }
               Utils.world.addChild(mapLevelButton);
            }
            else if(this.worldMap.mapLoader.mapLevels[i].type == 13)
            {
               button = new Button(TextureManager.hudTextureAtlas.getTexture("sxMapButton_1"),"",TextureManager.hudTextureAtlas.getTexture("sxMapButton_2"));
               this.pageButtonsData.push(new Point(this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y));
               this.pageButtons.push(button);
               button.name = "sx";
               button.addEventListener(Event.TRIGGERED,this.pageClickHandler);
               Utils.world.addChild(button);
            }
            else if(this.worldMap.mapLoader.mapLevels[i].type == 14)
            {
               button = new Button(TextureManager.hudTextureAtlas.getTexture("dxMapButton_1"),"",TextureManager.hudTextureAtlas.getTexture("dxMapButton_2"));
               this.pageButtonsData.push(new Point(this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y));
               this.pageButtons.push(button);
               if(this.worldMap.mapLoader.mapLevels[i].width == 0)
               {
                  if(Utils.Slot.levelSeqUnlocked[8] == false)
                  {
                     button.visible = false;
                  }
               }
               else
               {
                  button.visible = false;
               }
               button.name = "dx";
               button.addEventListener(Event.TRIGGERED,this.pageClickHandler);
               Utils.world.addChild(button);
            }
            else if(this.worldMap.mapLoader.mapLevels[i].type == 1 || this.worldMap.mapLoader.mapLevels[i].type == 2 || this.worldMap.mapLoader.mapLevels[i].type == 3 || this.worldMap.mapLoader.mapLevels[i].type == 4 || this.worldMap.mapLoader.mapLevels[i].type == 5 || this.worldMap.mapLoader.mapLevels[i].type == 6 || this.worldMap.mapLoader.mapLevels[i].type == 7 || this.worldMap.mapLoader.mapLevels[i].type == 8 || this.worldMap.mapLoader.mapLevels[i].type == 9 || this.worldMap.mapLoader.mapLevels[i].type == 10 || this.worldMap.mapLoader.mapLevels[i].type == 11 || this.worldMap.mapLoader.mapLevels[i].type == 12 || this.worldMap.mapLoader.mapLevels[i].type == 15)
            {
               if(this.worldMap.mapLoader.mapLevels[i].type == 1)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_1"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 2)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_2"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 3)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_3"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 4)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_4"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 5)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_5"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 6)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_6"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 7)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_7"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 8)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_8"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 9)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_9"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 10)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_10"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 11)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_11"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 12)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_12"));
               }
               else if(this.worldMap.mapLoader.mapLevels[i].type == 15)
               {
                  image = new Image(TextureManager.hudTextureAtlas.getTexture("button_shadow_tile_13"));
               }
               this.shadowsData.push(new Rectangle(this.worldMap.mapLoader.mapLevels[i].x,this.worldMap.mapLoader.mapLevels[i].y,this.worldMap.mapLoader.mapLevels[i].width,0));
               this.shadows.push(image);
               if(Utils.Slot.levelUnlocked[this.worldMap.mapLoader.mapLevels[i].width - 1] == true)
               {
                  image.visible = false;
               }
               Utils.world.addChild(image);
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.pageButtons.length; i++)
         {
            if(this.pageButtons[i] != null)
            {
               this.pageButtons[i].removeEventListener(Event.TRIGGERED,this.pageClickHandler);
               this.pageButtons[i].dispose();
               this.pageButtons[i] = null;
            }
         }
         this.pageButtons = null;
         for(i = 0; i < this.buttonClusters.length; i++)
         {
            if(this.buttonClusters[i] != null)
            {
               this.buttonClusters[i].destroy();
               this.buttonClusters[i] = null;
            }
         }
         this.buttonClusters = null;
         for(i = 0; i < this.buttons.length; i++)
         {
            Utils.world.removeChild(this.buttons[i]);
            this.buttons[i].removeEventListener(Event.TRIGGERED,this.clickHandler);
            this.buttons[i].destroy();
            this.buttons[i].dispose();
            this.buttons[i] = null;
            this.buttonsData[i] = null;
         }
         this.buttons = null;
         this.buttonsData = null;
         for(i = 0; i < this.shadows.length; i++)
         {
            Utils.world.removeChild(this.shadows[i]);
            this.shadows[i].dispose();
            this.shadows[i] = null;
            this.shadowsData[i] = null;
         }
         this.shadows = null;
         this.shadowsData = null;
         this.worldMap = null;
      }
      
      protected function clickHandler(event:Event) : void
      {
         var selection_result:int = 0;
         var button:MapLevelButton = MapLevelButton(event.target);
         this.levelSelection = int(button.name);
         selection_result = button.getSelectionResult();
         if(selection_result == 0)
         {
            SoundSystem.PlaySound("error");
            this.worldMap.buttonToUnlock = button;
            this.worldMap.mapCutscenes.startCutscene(new NotEnoughBellsMapCutscene(this.worldMap,button));
         }
         else if(selection_result == 1)
         {
            SoundSystem.PlaySound("select");
            this.worldMap.levelSelected(this.levelSelection);
         }
         else if(selection_result == 2)
         {
            SoundSystem.PlaySound("select");
            this.worldMap.mapCutscenes.startCutscene(new EnoughBellsMapCutscene(this.worldMap,button));
         }
      }
      
      protected function pageClickHandler(event:Event) : void
      {
         var button:Button = Button(event.target);
         if(button.name == "sx")
         {
            --Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID];
         }
         else
         {
            ++Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID];
         }
         SoundSystem.PlaySound("select");
         if(button.name == "sx")
         {
            this.worldMap.pageSelected(true);
         }
         else
         {
            this.worldMap.pageSelected(false);
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttonClusters.length; i++)
         {
            if(this.buttonClusters[i] != null)
            {
               this.buttonClusters[i].update();
            }
         }
         for(i = 0; i < this.buttons.length; i++)
         {
            if(this.buttons[i] != null)
            {
               this.buttons[i].update();
            }
         }
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttonsData.length; i++)
         {
            this.buttons[i].x = int(Math.floor(this.buttons[i].xPos - mapCamera.xPos));
            this.buttons[i].y = int(Math.floor(this.buttons[i].yPos - mapCamera.yPos));
         }
         for(i = 0; i < this.shadowsData.length; i++)
         {
            this.shadows[i].x = int(Math.floor(this.shadowsData[i].x - mapCamera.xPos));
            this.shadows[i].y = int(Math.floor(this.shadowsData[i].y - mapCamera.yPos));
         }
         for(i = 0; i < this.pageButtonsData.length; i++)
         {
            this.pageButtons[i].x = int(Math.floor(this.pageButtonsData[i].x - mapCamera.xPos));
            this.pageButtons[i].y = int(Math.floor(this.pageButtonsData[i].y - mapCamera.yPos));
         }
      }
      
      public function setOnTop() : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttons.length; i++)
         {
            Utils.world.setChildIndex(this.buttons[i],Utils.world.numChildren - 1);
         }
      }
      
      public function getLevelButtonCoordinates(level:int) : Point
      {
         var i:int = 0;
         var point:Point = new Point();
         for(i = 0; i < this.buttonsData.length; i++)
         {
            if(this.buttonsData[i].width == level)
            {
               point.x = this.buttonsData[i].x;
               point.y = this.buttonsData[i].y;
            }
         }
         return point;
      }
      
      public function setLevelButtonVisible(level:int) : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttonsData.length; i++)
         {
            if(this.buttonsData[i].width == level)
            {
               this.buttons[i].visible = true;
               Utils.world.setChildIndex(this.buttons[i],Utils.world.numChildren - 1);
            }
         }
      }
      
      public function getShadow(level:int) : Image
      {
         var i:int = 0;
         var image:Image = null;
         for(i = 0; i < this.shadowsData.length; i++)
         {
            if(this.shadowsData[i].width == level)
            {
               image = this.shadows[i];
            }
         }
         return image;
      }
      
      public function disableButtons() : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttons.length; i++)
         {
            this.buttons[i].touchable = false;
         }
         for(i = 0; i < this.pageButtons.length; i++)
         {
            this.pageButtons[i].touchable = false;
         }
      }
      
      public function enableButtons() : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttons.length; i++)
         {
            this.buttons[i].touchable = true;
         }
         for(i = 0; i < this.pageButtons.length; i++)
         {
            this.pageButtons[i].touchable = true;
         }
      }
   }
}
