package levels.items
{
   import entities.enemies.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.*;
   import sprites.items.KeyItemSprite;
   import states.LevelState;
   
   public class KeyItem extends Item
   {
       
      
      public var TYPE:int;
      
      public function KeyItem(_level:Level, _xPos:Number, _yPos:Number, _index:int, _type:int = 0)
      {
         super(_level,_xPos,_yPos,_index);
         this.TYPE = _type;
         sprite = new KeyItemSprite(_type);
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override protected function collectedAnimation() : void
      {
         counter_1 = 0;
         counter_2 = 0;
         tick_1 = 0;
         SoundSystem.PlaySound("pot_collected");
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         if(this.TYPE == 0)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_6)
            {
               Utils.Slot.gameProgression[6] = 3;
               SaveManager.SaveGameProgression();
            }
            LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_KEY);
         }
         else if(this.TYPE == 2)
         {
            LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_KEY_CLUB);
         }
      }
   }
}
