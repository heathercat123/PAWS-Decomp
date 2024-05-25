package levels.worlds.fishing
{
   import entities.Entity;
   import entities.npcs.*;
   import flash.geom.*;
   import game_utils.SaveManager;
   import interfaces.dialogs.Dialog;
   import levels.cutscenes.FishermanTutorialCutscene;
   
   public class Level_1_Fishing extends LevelFishing
   {
       
      
      protected var TUTORIAL_CUTSCENE_FLAG_1:Boolean;
      
      protected var cutscene_counter:int;
      
      protected var dialog:Dialog;
      
      protected var DIALOG_PROGRESSION:int;
      
      protected var FORCE_SPAWN_FISH_AFTER_TUTORIAL:Boolean;
      
      public function Level_1_Fishing(_sub_level:int)
      {
         super(_sub_level);
         this.TUTORIAL_CUTSCENE_FLAG_1 = this.FORCE_SPAWN_FISH_AFTER_TUTORIAL = false;
         this.cutscene_counter = 0;
         this.DIALOG_PROGRESSION = 0;
         this.dialog = null;
      }
      
      override public function init() : void
      {
         var fisherman:FishermanNPC = null;
         super.init();
         if(Utils.Slot.gameProgression[15] == 0)
         {
            fisherman = new FishermanNPC(this,272,144,Entity.RIGHT,0);
            fisherman.stateMachine.setState("IS_FISHING_STATE");
            npcsManager.npcs.push(fisherman);
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(Utils.Slot.gameProgression[15] == 0)
         {
            if(hero.xPos >= 176)
            {
               if(!this.TUTORIAL_CUTSCENE_FLAG_1)
               {
                  this.TUTORIAL_CUTSCENE_FLAG_1 = true;
                  startCutscene(new FishermanTutorialCutscene(this,this.cutscene_counter));
                  ++this.cutscene_counter;
               }
            }
            else if(hero.xPos <= 160)
            {
               this.TUTORIAL_CUTSCENE_FLAG_1 = false;
            }
         }
         if(Utils.Slot.gameProgression[15] != 2)
         {
            if(fStateMachine.currentState == "IS_REELING_STATE")
            {
               if(this.DIALOG_PROGRESSION == 0)
               {
                  if(lure.xPos <= 688)
                  {
                     if(this.dialog != null)
                     {
                        this.DIALOG_PROGRESSION = 1;
                        this.dialog.dead = true;
                        this.dialog = null;
                     }
                  }
               }
               else if(this.DIALOG_PROGRESSION == 1)
               {
                  if(lure.xPos <= 640)
                  {
                     this.DIALOG_PROGRESSION = 2;
                     this.dialog = hud.dialogsManager.createCaptionNoCameraAt(StringsManager.GetString("tutorial_fishing_3"),Utils.WIDTH * 0.5,Utils.HEIGHT * 0.25,null,0,true);
                  }
               }
            }
         }
      }
      
      override protected function castingState() : void
      {
         super.castingState();
         if(Utils.Slot.gameProgression[15] != 2)
         {
            this.DIALOG_PROGRESSION = 0;
            this.dialog = hud.dialogsManager.createCaptionNoCameraAt(StringsManager.GetString("tutorial_fishing_1"),Utils.WIDTH * 0.5,Utils.HEIGHT * 0.25,null,0,true);
            fishingBarPanel.visible = false;
         }
      }
      
      override protected function lureFlyingState() : void
      {
         if(Utils.Slot.gameProgression[15] != 2)
         {
            fishingBarPanel.CASTING_POWER = 0.9;
         }
         super.lureFlyingState();
         if(Utils.Slot.gameProgression[15] != 2)
         {
            if(this.dialog != null)
            {
               this.dialog.dead = true;
               this.dialog = null;
            }
         }
      }
      
      override protected function reelingState() : void
      {
         super.reelingState();
         if(Utils.Slot.gameProgression[15] != 2)
         {
            this.dialog = hud.dialogsManager.createCaptionNoCameraAt(StringsManager.GetString("tutorial_fishing_2"),Utils.WIDTH * 0.5,Utils.HEIGHT * 0.25,null,0,true);
         }
      }
      
      override protected function fightingState() : void
      {
         super.fightingState();
         if(Utils.Slot.gameProgression[15] != 2)
         {
            if(this.dialog != null)
            {
               this.dialog.dead = true;
               this.dialog = hud.dialogsManager.createCaptionNoCameraAt(StringsManager.GetString("tutorial_fishing_4"),Utils.WIDTH * 0.5,Utils.HEIGHT * 0.25,null,15,true);
            }
         }
      }
      
      override protected function fishCaughtState() : void
      {
         super.fishCaughtState();
         if(Utils.Slot.gameProgression[15] != 2)
         {
            if(this.dialog != null)
            {
               this.dialog.dead = true;
               this.dialog = null;
               fishingBarPanel.visible = true;
               Utils.Slot.gameProgression[15] = 2;
               SaveManager.SaveGameProgression();
               this.FORCE_SPAWN_FISH_AFTER_TUTORIAL = true;
            }
         }
      }
      
      override protected function endFishingState() : void
      {
         super.endFishingState();
         if(Utils.Slot.gameProgression[15] != 2)
         {
            if(this.dialog != null)
            {
               this.dialog.dead = true;
               this.dialog = null;
            }
         }
         if(this.FORCE_SPAWN_FISH_AFTER_TUTORIAL)
         {
            this.FORCE_SPAWN_FISH_AFTER_TUTORIAL = false;
            fishManager.spawnFish();
         }
      }
   }
}
