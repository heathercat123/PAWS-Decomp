package levels.items
{
   import entities.enemies.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.*;
   import sprites.items.GenericItemSprite;
   import sprites.particles.ItemExplosionParticleSprite;
   import states.LevelState;
   
   public class EggItem extends Item
   {
       
      
      protected var SHIFT_INDEX:int;
      
      public function EggItem(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos,0);
         sprite = new GenericItemSprite(GenericItemSprite.GENERIC_ITEM_EGG);
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         stateMachine.setState("IS_STANDING_STATE");
         this.SHIFT_INDEX = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_7_5)
         {
            this.SHIFT_INDEX = 1;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_9)
         {
            this.SHIFT_INDEX = 2;
         }
         if((Utils.Slot.gameProgression[17] >> this.SHIFT_INDEX & 1) == 1)
         {
            dead = true;
         }
      }
      
      override public function update() : void
      {
         if(stateMachine.currentState == "IS_COLLECTED_STATE")
         {
            stateMachine.performAction("END_ACTION");
            if(isInsideSoundScreen())
            {
               SoundSystem.PlaySound("item_pop");
            }
            level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos + WIDTH * 0.5,yPos + 5,0,0,0);
         }
      }
      
      override protected function collectedAnimation() : void
      {
         counter_1 = 0;
         counter_2 = 0;
         tick_1 = 0;
         SoundSystem.PlaySound("pot_collected");
         LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_EGG);
         Utils.Slot.gameProgression[17] |= 1 << this.SHIFT_INDEX;
         SaveManager.SaveGameProgression();
      }
   }
}
