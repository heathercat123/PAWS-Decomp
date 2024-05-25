package levels.cutscenes.world2
{
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.ChefNPC;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cutscenes.Cutscene;
   import levels.items.BellItem;
   
   public class ChefRewardCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var chefNPC:ChefNPC;
      
      public function ChefRewardCutscene(_level:Level)
      {
         super(_level);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         ++counter1;
         this.hero.xVel = 0;
         this.hero.DIRECTION = Entity.RIGHT;
         this.hero.xPos = 424;
         if(PROGRESSION == 0)
         {
            if(counter1 >= 20)
            {
               counter1 = 0;
               ++PROGRESSION;
               this.chefNPC.setEmotionParticle(Entity.EMOTION_LOVE);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_tomo_chef_2"),this.chefNPC,this.advance);
            }
         }
         else if(PROGRESSION == 2)
         {
            this.chefNPC.stringId = 1;
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.initState();
         this.hero = level.hero;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is ChefNPC)
               {
                  this.chefNPC = level.npcsManager.npcs[i];
                  if(this.chefNPC.DIRECTION == Entity.RIGHT)
                  {
                     this.chefNPC.stateMachine.performAction("CHANGE_DIR_ACTION");
                  }
               }
            }
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         var item:BellItem = null;
         var l_index:int = 0;
         if(Utils.Slot.gameProgression[16] == 1)
         {
            item = new BellItem(level,376,128 - 24,1);
            l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
            item.level_index = l_index;
            item.stateMachine.setState("IS_BONUS_STATE");
            item.updateScreenPosition(level.camera);
            level.itemsManager.items.push(item);
            LevelItems.RemoveItem(LevelItems.ITEM_FISH_RED_JUMPER,1);
            SaveManager.SaveInventory();
         }
         else if(Utils.Slot.gameProgression[16] == 3)
         {
            LevelItems.RemoveItem(LevelItems.ITEM_FISH_SQUID,3);
            LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,100);
         }
         else if(Utils.Slot.gameProgression[16] == 5)
         {
            LevelItems.RemoveItem(LevelItems.ITEM_FISH_OCTOPUS,1);
            LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,200);
         }
         ++Utils.Slot.gameProgression[16];
         SaveManager.SaveGameProgression();
         super.overState();
      }
   }
}
