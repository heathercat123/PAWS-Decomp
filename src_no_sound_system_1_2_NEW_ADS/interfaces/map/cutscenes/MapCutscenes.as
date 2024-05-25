package interfaces.map.cutscenes
{
   import game_utils.GameSlot;
   import interfaces.map.*;
   
   public class MapCutscenes
   {
       
      
      public var worldMap:WorldMap;
      
      public var cutscenes:Array;
      
      protected var CUTSCENE_STARTED:Boolean;
      
      public function MapCutscenes(_worldMap:WorldMap)
      {
         super();
         this.worldMap = _worldMap;
         this.cutscenes = new Array();
         this.CUTSCENE_STARTED = false;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].destroy();
               this.cutscenes[i] = null;
            }
         }
         this.cutscenes = null;
         this.worldMap = null;
      }
      
      public function init() : void
      {
         if(Utils.Slot.levelSeqUnlocked[0] == true && Utils.Slot.levelUnlocked[0] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,0));
         }
         else if(Utils.Slot.levelSeqUnlocked[1] == true && Utils.Slot.levelUnlocked[1] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,1));
         }
         else if(Utils.Slot.levelSeqUnlocked[2] == true && Utils.Slot.levelUnlocked[2] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,2));
         }
         else if(Utils.Slot.levelSeqUnlocked[3] == true && Utils.Slot.levelUnlocked[3] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,3));
         }
         else if(Utils.Slot.levelSeqUnlocked[4] == true && Utils.Slot.levelUnlocked[4] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,4));
         }
         else if(Utils.Slot.levelSeqUnlocked[5] == true && Utils.Slot.levelUnlocked[5] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,5));
         }
         else if(Utils.Slot.levelSeqUnlocked[6] == true && Utils.Slot.levelUnlocked[6] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,6));
         }
         else if(Utils.Slot.levelSeqUnlocked[7] == true && Utils.Slot.levelUnlocked[7] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,7));
         }
         else if(Utils.Slot.levelSeqUnlocked[8] == true && Utils.Slot.levelUnlocked[8] == false && (Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0 || Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1))
         {
            this.startCutscene(new World1MapCutscene(this.worldMap,8));
         }
         else if(Utils.Slot.levelSeqUnlocked[9] == true && Utils.Slot.levelUnlocked[9] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,9));
         }
         else if(Utils.Slot.levelSeqUnlocked[10] == true && Utils.Slot.levelUnlocked[10] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,10));
         }
         else if(Utils.Slot.levelSeqUnlocked[11] == true && Utils.Slot.levelUnlocked[11] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,11));
         }
         else if(Utils.Slot.levelSeqUnlocked[12] == true && Utils.Slot.levelUnlocked[12] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,12));
         }
         else if(Utils.Slot.levelSeqUnlocked[13] == true && Utils.Slot.levelUnlocked[13] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,13));
         }
         else if(Utils.Slot.levelSeqUnlocked[14] == true && Utils.Slot.levelUnlocked[14] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,14));
         }
         else if(Utils.Slot.levelSeqUnlocked[15] == true && Utils.Slot.levelUnlocked[15] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            this.startCutscene(new World2MapCutscene(this.worldMap,15));
         }
         if(!this.CUTSCENE_STARTED)
         {
            if(Utils.Slot.levelSeqUnlocked[250] == true && Utils.Slot.levelUnlocked[250] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
            {
               this.startCutscene(new World1MapCutscene(this.worldMap,250));
            }
            else if(Utils.Slot.levelSeqUnlocked[251] == true && Utils.Slot.levelUnlocked[251] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
            {
               this.startCutscene(new World2MapCutscene(this.worldMap,251));
            }
            else if(Utils.Slot.levelSeqUnlocked[801] == true && Utils.Slot.levelUnlocked[801] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
            {
               this.startCutscene(new World1MapCutscene(this.worldMap,801));
            }
            else if(Utils.Slot.levelSeqUnlocked[802] == true && Utils.Slot.levelUnlocked[802] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
            {
               this.startCutscene(new World2MapCutscene(this.worldMap,802));
            }
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].update();
               if(this.cutscenes[i].dead)
               {
                  this.cutscenes[i].destroy();
                  this.cutscenes[i] = null;
                  this.worldMap.endCutscene();
               }
            }
         }
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].updateScreenPosition(mapCamera);
            }
         }
      }
      
      public function startCutscene(cutscene:MapCutscene) : void
      {
         this.CUTSCENE_STARTED = true;
         this.cutscenes.push(cutscene);
         this.worldMap.stateMachine.performAction("START_CUTSCENE_ACTION");
      }
   }
}
