package interfaces.map.decorations
{
   import flash.geom.Point;
   import interfaces.map.*;
   import sprites.map.GenericMapSprite;
   import starling.display.*;
   
   public class World2MapDecoration extends Decoration
   {
       
      
      public var INDEX:int;
      
      protected var gSprite1:GenericMapSprite;
      
      protected var gSprite2:GenericMapSprite;
      
      protected var gSprite1_xPos:Number;
      
      protected var gSprite1_yPos:Number;
      
      protected var gSprite2_xPos:Number;
      
      protected var gSprite2_yPos:Number;
      
      protected var sin_counter1:Number;
      
      protected var roadImages:Vector.<Image>;
      
      protected var roadPositions:Vector.<Point>;
      
      public function World2MapDecoration(_worldMap:WorldMap, _index:int)
      {
         var i:int = 0;
         this.INDEX = _index;
         super(_worldMap);
         this.gSprite1 = null;
         this.gSprite2 = null;
         this.roadImages = new Vector.<Image>();
         this.roadPositions = new Vector.<Point>();
         if(this.INDEX == MapDecorations.LEVEL_2_1_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.SQUID);
            this.gSprite1_xPos = 104 + 91;
            this.gSprite1_yPos = 135 - 30;
            Utils.world.addChild(this.gSprite1);
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_1")));
            this.roadImages[0].touchable = this.roadImages[1].touchable = false;
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
            this.roadPositions.push(new Point(104 + 12,135 + 2));
            this.roadPositions.push(new Point(104 + 36,135 + 2));
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_2_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages[0].width = this.roadImages[2].width = 10;
            this.roadImages[0].height = 24;
            this.roadImages[2].height = 21;
            this.roadImages[0].touchable = this.roadImages[1].touchable = this.roadImages[2].touchable = false;
            this.roadPositions.push(new Point(171,156));
            this.roadPositions.push(new Point(171 - 2,156 + 19));
            this.roadPositions.push(new Point(171,156 + 25));
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
            Utils.world.addChild(this.roadImages[2]);
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_3_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.MONKEY);
            this.gSprite2 = new GenericMapSprite(MapDecorations.MONKEY);
            Utils.world.addChild(this.gSprite1);
            Utils.world.addChild(this.gSprite2);
            this.gSprite1.scaleX = -1;
            this.gSprite1_xPos = 192 + 60;
            this.gSprite1_yPos = 207 - 22 + 1;
            this.gSprite2_xPos = 192 + 109 + 5;
            this.gSprite2_yPos = 207 + 8;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_14")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_snow_tile_2")));
            this.roadImages[0].width = 23;
            this.roadImages[1].width = 18;
            this.roadImages[3].width = 10;
            this.roadImages[0].height = 10;
            this.roadImages[1].height = 10;
            this.roadImages[3].height = 20 - 9;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(192,207));
            this.roadPositions.push(new Point(192 + 56,207 + 28));
            this.roadPositions.push(new Point(192 + 74,207 + 27));
            this.roadPositions.push(new Point(192 + 82,207 + 8 + 9));
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_4_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            this.roadImages[0].touchable = this.roadImages[1].touchable = false;
            this.roadPositions.push(new Point(274 + 2,156 + 23));
            this.roadPositions.push(new Point(274 + 2,156 + 7));
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_5_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.LOBSTER);
            this.gSprite2 = new GenericMapSprite(MapDecorations.VILLAGE_FLAG);
            Utils.world.addChild(this.gSprite1);
            Utils.world.addChild(this.gSprite2);
            this.gSprite1_xPos = 353 + 84 + 3 + 17;
            this.gSprite1_yPos = 146 - 37 - 2 + 6;
            this.gSprite2_xPos = 436;
            this.gSprite2_yPos = 124 - 17;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_6")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages[0].width = 27;
            this.roadImages[1].width = 19;
            this.roadImages[0].height = this.roadImages[1].height = 10;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(353,146));
            this.roadPositions.push(new Point(354 + 27,146 - 11));
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_6_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_15")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_17")));
            this.roadImages[0].width = 30;
            this.roadImages[0].height = 10;
            this.roadImages[2].width = 10;
            this.roadImages[2].height = 13;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(432 + 0,135 + 0));
            this.roadPositions.push(new Point(432 + 29,135 + 0));
            this.roadPositions.push(new Point(432 + 30,135 + 10));
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_7_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(528 + 9,171 + 2));
            this.roadPositions.push(new Point(528 + 25,171 + 2));
         }
         else if(this.INDEX == MapDecorations.LEVEL_SECRET_2_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_3")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(295 + 10,192 + 13));
            this.roadPositions.push(new Point(295 + 33,192 + 13));
         }
         else if(this.INDEX == MapDecorations.LEVEL_2_8_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.FISH_BOSS);
            Utils.world.addChild(this.gSprite1);
            this.gSprite1_xPos = 600 + 64;
            this.gSprite1_yPos = 171 + 25;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_7")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_dot_7")));
            if(Utils.Slot.levelSeqUnlocked[16])
            {
               this.gSprite1.visible = false;
            }
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(600 + 9,171 + 2));
            this.roadPositions.push(new Point(600 + 25,171 + 2));
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.roadImages.length; i++)
         {
            Utils.world.removeChild(this.roadImages[i]);
            this.roadImages[i].dispose();
            this.roadImages[i] = null;
            this.roadPositions[i] = null;
         }
         this.roadImages = null;
         this.roadPositions = null;
         if(this.gSprite1 != null)
         {
            Utils.world.removeChild(this.gSprite1);
            this.gSprite1.destroy();
            this.gSprite1.dispose();
            this.gSprite1 = null;
         }
         if(this.gSprite2 != null)
         {
            Utils.world.removeChild(this.gSprite2);
            this.gSprite2.destroy();
            this.gSprite2.dispose();
            this.gSprite2 = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
      }
      
      override public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.roadImages.length; i++)
         {
            this.roadImages[i].x = int(Math.floor(this.roadPositions[i].x - mapCamera.xPos));
            this.roadImages[i].y = int(Math.floor(this.roadPositions[i].y - mapCamera.yPos));
         }
         if(this.gSprite1 != null)
         {
            this.gSprite1.x = int(Math.floor(this.gSprite1_xPos - mapCamera.xPos));
            this.gSprite1.y = int(Math.floor(this.gSprite1_yPos - mapCamera.yPos));
         }
         if(this.gSprite2 != null)
         {
            this.gSprite2.x = int(Math.floor(this.gSprite2_xPos - mapCamera.xPos));
            this.gSprite2.y = int(Math.floor(this.gSprite2_yPos - mapCamera.yPos));
         }
      }
   }
}
