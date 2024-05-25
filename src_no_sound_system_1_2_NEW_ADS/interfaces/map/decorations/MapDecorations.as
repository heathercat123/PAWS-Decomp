package interfaces.map.decorations
{
   import interfaces.map.*;
   import levels.GenericScript;
   
   public class MapDecorations
   {
      
      public static var TRUCK:int = 0;
      
      public static var GRASS_1:int = 1;
      
      public static var GRASS_2:int = 2;
      
      public static var RAIN_DROP:int = 3;
      
      public static var CLOUD_1:int = 4;
      
      public static var CLOUD_2:int = 5;
      
      public static var DANDELION:int = 6;
      
      public static var BEETLE:int = 7;
      
      public static var RED_FLOWER:int = 8;
      
      public static var BEE:int = 9;
      
      public static var EGG_1:int = 10;
      
      public static var WAVE_1:int = 11;
      
      public static var REED_PLANT_1:int = 12;
      
      public static var BARRIER_1:int = 13;
      
      public static var OLLI:int = 14;
      
      public static var MOLE:int = 15;
      
      public static var LIZARD_BOSS:int = 16;
      
      public static var BARRIER_2:int = 17;
      
      public static var MAP_2_SHORE_1:int = 18;
      
      public static var MAP_2_SHORE_2:int = 19;
      
      public static var MAP_2_SHORE_3:int = 20;
      
      public static var MAP_2_SHORE_4:int = 21;
      
      public static var MAP_2_SHORE_5:int = 22;
      
      public static var SQUID:int = 23;
      
      public static var MONKEY:int = 24;
      
      public static var LOBSTER:int = 25;
      
      public static var FISH_BOSS:int = 26;
      
      public static var PARASOL:int = 27;
      
      public static var WATERFALL_1:int = 28;
      
      public static var SMALL_BOAT_1:int = 29;
      
      public static var VILLAGE_FLAG:int = 30;
      
      public static var PUMPKIN:int = 31;
      
      public static var LEVEL_1_1_DECORATION:int = 1000000;
      
      public static var LEVEL_1_2_DECORATION:int = 1000001;
      
      public static var LEVEL_1_3_DECORATION:int = 1000002;
      
      public static var LEVEL_1_4_DECORATION:int = 1000003;
      
      public static var LEVEL_1_5_DECORATION:int = 1000004;
      
      public static var LEVEL_1_6_DECORATION:int = 1000005;
      
      public static var LEVEL_1_7_DECORATION:int = 1000006;
      
      public static var LEVEL_1_8_DECORATION:int = 1000007;
      
      public static var LEVEL_2_1_DECORATION:int = 1000008;
      
      public static var LEVEL_2_2_DECORATION:int = 1000009;
      
      public static var LEVEL_2_3_DECORATION:int = 1000010;
      
      public static var LEVEL_2_4_DECORATION:int = 1000011;
      
      public static var LEVEL_2_5_DECORATION:int = 1000012;
      
      public static var LEVEL_2_6_DECORATION:int = 1000013;
      
      public static var LEVEL_2_7_DECORATION:int = 1000014;
      
      public static var LEVEL_2_8_DECORATION:int = 1000015;
      
      public static var LEVEL_SECRET_1_DECORATION:int = 5000000;
      
      public static var LEVEL_SECRET_2_DECORATION:int = 5000001;
      
      public static var FISHING_SPOT_1_DECORATION:int = 2000000;
       
      
      public var worldMap:WorldMap;
      
      public var decorations:Array;
      
      public function MapDecorations(_worldMap:WorldMap)
      {
         var i:int = 0;
         var decoration:Decoration = null;
         super();
         this.worldMap = _worldMap;
         this.decorations = new Array();
         for(i = 0; i < this.worldMap.mapLoader.mapDecorations.length; i++)
         {
            this.createDecorationScript(this.worldMap.mapLoader.mapDecorations[i].type,this.worldMap.mapLoader.mapDecorations[i]);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].destroy();
               this.decorations[i] = null;
            }
         }
         this.decorations = null;
         this.worldMap = null;
      }
      
      public function createDecorationScript(index:int, gScript:GenericScript) : void
      {
         if(!this.isDecorationAllowed(index,gScript.width))
         {
            return;
         }
         var decoration:Decoration = null;
         if(index == MapDecorations.LEVEL_1_1_DECORATION || index == MapDecorations.LEVEL_1_2_DECORATION || index == MapDecorations.LEVEL_1_3_DECORATION || index == MapDecorations.LEVEL_1_4_DECORATION || index == MapDecorations.LEVEL_1_5_DECORATION || index == MapDecorations.LEVEL_1_6_DECORATION || index == MapDecorations.LEVEL_1_7_DECORATION || index == MapDecorations.LEVEL_1_8_DECORATION || index == MapDecorations.FISHING_SPOT_1_DECORATION || index == MapDecorations.LEVEL_SECRET_1_DECORATION)
         {
            decoration = new World1MapDecoration(this.worldMap,index);
         }
         else if(index == MapDecorations.LEVEL_2_1_DECORATION || index == MapDecorations.LEVEL_2_2_DECORATION || index == MapDecorations.LEVEL_2_3_DECORATION || index == MapDecorations.LEVEL_2_4_DECORATION || index == MapDecorations.LEVEL_2_5_DECORATION || index == MapDecorations.LEVEL_2_6_DECORATION || index == MapDecorations.LEVEL_2_7_DECORATION || index == MapDecorations.LEVEL_2_8_DECORATION || index == MapDecorations.LEVEL_SECRET_2_DECORATION)
         {
            decoration = new World2MapDecoration(this.worldMap,index);
         }
         else
         {
            decoration = new GenericMapDecoration(this.worldMap,index,gScript.x,gScript.y,gScript.height,gScript.rotation,gScript.value1,gScript.value2);
         }
         this.decorations.push(decoration);
      }
      
      public function createDecoration(index:int, isForced:Boolean = false) : void
      {
         if(!this.isDecorationAllowed(index) && !isForced)
         {
            return;
         }
         var decoration:Decoration = null;
         if(index == MapDecorations.LEVEL_1_1_DECORATION || index == MapDecorations.LEVEL_1_2_DECORATION || index == MapDecorations.LEVEL_1_3_DECORATION || index == MapDecorations.LEVEL_1_4_DECORATION || index == MapDecorations.LEVEL_1_5_DECORATION || index == MapDecorations.LEVEL_1_6_DECORATION || index == MapDecorations.LEVEL_1_7_DECORATION || index == MapDecorations.LEVEL_1_8_DECORATION || index == MapDecorations.FISHING_SPOT_1_DECORATION || index == MapDecorations.LEVEL_SECRET_1_DECORATION)
         {
            decoration = new World1MapDecoration(this.worldMap,index);
         }
         else if(index == MapDecorations.LEVEL_2_1_DECORATION || index == MapDecorations.LEVEL_2_2_DECORATION || index == MapDecorations.LEVEL_2_3_DECORATION || index == MapDecorations.LEVEL_2_4_DECORATION || index == MapDecorations.LEVEL_2_5_DECORATION || index == MapDecorations.LEVEL_2_6_DECORATION || index == MapDecorations.LEVEL_2_7_DECORATION || index == MapDecorations.LEVEL_2_8_DECORATION || index == MapDecorations.LEVEL_SECRET_2_DECORATION)
         {
            decoration = new World2MapDecoration(this.worldMap,index);
         }
         this.decorations.push(decoration);
      }
      
      protected function isDecorationAllowed(index:int, param:int = 0) : Boolean
      {
         if(index == MapDecorations.LEVEL_1_1_DECORATION && Utils.Slot.levelUnlocked[0] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_2_DECORATION && Utils.Slot.levelUnlocked[1] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_3_DECORATION && Utils.Slot.levelUnlocked[2] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_4_DECORATION && Utils.Slot.levelUnlocked[3] == false)
         {
            return false;
         }
         if(index == MapDecorations.BARRIER_1 && Utils.Slot.levelSeqUnlocked[4] == true)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_5_DECORATION && Utils.Slot.levelUnlocked[4] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_6_DECORATION && Utils.Slot.levelUnlocked[5] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_7_DECORATION && Utils.Slot.levelUnlocked[6] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_1_8_DECORATION && Utils.Slot.levelUnlocked[7] == false)
         {
            return false;
         }
         if(index == MapDecorations.BARRIER_2 && Utils.Slot.levelSeqUnlocked[5] == true)
         {
            return false;
         }
         if(index == MapDecorations.FISHING_SPOT_1_DECORATION && Utils.Slot.levelUnlocked[801] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_1_DECORATION && Utils.Slot.levelUnlocked[8] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_2_DECORATION && Utils.Slot.levelUnlocked[9] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_3_DECORATION && Utils.Slot.levelUnlocked[10] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_4_DECORATION && Utils.Slot.levelUnlocked[11] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_5_DECORATION && Utils.Slot.levelUnlocked[12] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_6_DECORATION && Utils.Slot.levelUnlocked[13] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_7_DECORATION && Utils.Slot.levelUnlocked[14] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_2_8_DECORATION && Utils.Slot.levelUnlocked[15] == false)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_SECRET_1_DECORATION && Utils.Slot.levelSeqUnlocked[250] == true)
         {
            return false;
         }
         if(index == MapDecorations.LEVEL_SECRET_2_DECORATION && Utils.Slot.levelUnlocked[251] == false)
         {
            return false;
         }
         return true;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].update();
            }
         }
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].updateScreenPosition(mapCamera);
            }
         }
      }
   }
}
