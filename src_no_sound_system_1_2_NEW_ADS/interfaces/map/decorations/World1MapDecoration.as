package interfaces.map.decorations
{
   import flash.geom.Point;
   import interfaces.map.*;
   import sprites.map.GenericMapSprite;
   import starling.display.*;
   
   public class World1MapDecoration extends Decoration
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
      
      public function World1MapDecoration(_worldMap:WorldMap, _index:int)
      {
         var i:int = 0;
         this.INDEX = _index;
         super(_worldMap);
         this.gSprite1 = null;
         this.gSprite2 = null;
         this.roadImages = new Vector.<Image>();
         this.roadPositions = new Vector.<Point>();
         if(this.INDEX == MapDecorations.LEVEL_1_1_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.TRUCK);
            this.gSprite1_xPos = 91;
            this.gSprite1_yPos = 125;
            Utils.world.addChild(this.gSprite1);
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_2_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.BEETLE);
            this.gSprite1_xPos = 192 + 101;
            this.gSprite1_yPos = 135 - 8;
            Utils.world.addChild(this.gSprite1);
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages[0].touchable = this.roadImages[1].touchable = false;
            this.roadImages[0].width = 32;
            this.roadImages[1].width = 31;
            this.roadImages[0].height = this.roadImages[1].height = 10;
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
            this.roadPositions.push(new Point(192,135));
            this.roadPositions.push(new Point(225,111));
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_3_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_2")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_3")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapLadder_4")));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(265,147));
            this.roadPositions.push(new Point(265,158));
            this.roadPositions.push(new Point(265,166));
            this.roadPositions.push(new Point(261,174));
            this.roadPositions.push(new Point(265,182));
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_4_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_1")));
            this.roadImages[0].width = 80;
            this.roadImages[0].height = 10;
            Utils.world.addChild(this.roadImages[0]);
            this.roadPositions.push(new Point(288,215));
            this.gSprite1 = new GenericMapSprite(MapDecorations.BEE);
            this.gSprite2 = new GenericMapSprite(MapDecorations.BEE);
            Utils.world.addChild(this.gSprite1);
            Utils.world.addChild(this.gSprite2);
            this.gSprite2.scaleX = -1;
            this.gSprite1_xPos = 288 + 114;
            this.gSprite1_yPos = 215 - 33;
            this.gSprite2_xPos = 288 + 78;
            this.gSprite2_yPos = 215 - 51;
            this.sin_counter1 = 0;
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_5_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.OLLI);
            this.gSprite2 = new GenericMapSprite(MapDecorations.VILLAGE_FLAG);
            this.gSprite1_xPos = 475 + 31;
            this.gSprite1_yPos = 161 - 34;
            this.gSprite2_xPos = 500;
            this.gSprite2_yPos = 83;
            Utils.world.addChild(this.gSprite1);
            Utils.world.addChild(this.gSprite2);
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
            this.roadImages[0].width = this.roadImages[1].width = 10;
            this.roadImages[0].height = 15;
            this.roadImages[1].height = 14;
            this.roadPositions.push(new Point(475,161 - 15));
            this.roadPositions.push(new Point(475,161 - 29));
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_6_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.MOLE);
            Utils.world.addChild(this.gSprite1);
            this.gSprite1_xPos = 496 + 114;
            this.gSprite1_yPos = 111 + 6;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_4")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapBridge_1")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapBridge_1")));
            this.roadImages[0].width = 40;
            this.roadImages[0].height = 10;
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            this.roadPositions.push(new Point(496,111));
            this.roadPositions.push(new Point(496 + 40,111 - 3));
            this.roadPositions.push(new Point(496 + 40 + 12,111 - 3));
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_7_DECORATION)
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
            this.roadImages[3].height = 16;
            this.roadPositions.push(new Point(571 + 0,132 + 0));
            this.roadPositions.push(new Point(571 - 2,132 + 12));
            this.roadPositions.push(new Point(571 + 0,132 + 18));
            this.roadPositions.push(new Point(571 + 0,132 + 29));
            for(i = 0; i < this.roadImages.length; i++)
            {
               Utils.world.addChild(this.roadImages[i]);
            }
            Utils.world.setChildIndex(this.roadImages[3],0);
         }
         else if(this.INDEX == MapDecorations.LEVEL_1_8_DECORATION)
         {
            this.gSprite1 = new GenericMapSprite(MapDecorations.LIZARD_BOSS);
            Utils.world.addChild(this.gSprite1);
            this.gSprite1_xPos = 592 + 57 + 19;
            this.gSprite1_yPos = 183 - 19 + 16;
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages[0].width = 48;
            this.roadImages[0].height = 10;
            this.roadPositions.push(new Point(592,183));
            Utils.world.addChild(this.roadImages[0]);
            if(Boolean(Utils.Slot.levelSeqUnlocked[8]) || Boolean(Utils.Slot.levelUnlocked[8]))
            {
               this.gSprite1.visible = false;
            }
         }
         else if(this.INDEX == MapDecorations.FISHING_SPOT_1_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_road_tile_5")));
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("map_bridge_tile_3")));
            this.roadImages[0].width = 28;
            this.roadImages[0].height = 10;
            this.roadPositions.push(new Point(532,183));
            this.roadPositions.push(new Point(507,211));
            Utils.world.addChild(this.roadImages[0]);
            Utils.world.addChild(this.roadImages[1]);
         }
         else if(this.INDEX == MapDecorations.LEVEL_SECRET_1_DECORATION)
         {
            this.roadImages.push(new Image(TextureManager.hudTextureAtlas.getTexture("mapSecretArea1")));
            this.roadPositions.push(new Point(74,188));
            Utils.world.addChild(this.roadImages[0]);
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
         if(this.INDEX == MapDecorations.LEVEL_1_4_DECORATION)
         {
            this.sin_counter1 += 0.05;
            if(this.sin_counter1 >= Math.PI * 2)
            {
               this.sin_counter1 -= Math.PI * 2;
            }
            this.gSprite1_yPos = 215 - 33 + Math.sin(this.sin_counter1) * 2;
            this.gSprite2_yPos = 215 - 51 + Math.sin(this.sin_counter1 + Math.PI) * 2;
         }
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
