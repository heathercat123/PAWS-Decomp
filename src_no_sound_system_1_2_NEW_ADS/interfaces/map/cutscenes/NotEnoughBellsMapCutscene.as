package interfaces.map.cutscenes
{
   import game_utils.GameSlot;
   import interfaces.buttons.MapLevelButton;
   import interfaces.map.*;
   
   public class NotEnoughBellsMapCutscene extends MapCutscene
   {
       
      
      protected var levelButton:MapLevelButton;
      
      protected var originalXPos:Number;
      
      public function NotEnoughBellsMapCutscene(_worldMap:WorldMap, _levelButton:MapLevelButton)
      {
         super(_worldMap);
         this.levelButton = _levelButton;
         this.originalXPos = this.levelButton.xPos;
      }
      
      override public function destroy() : void
      {
         this.levelButton = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(PROGRESSION == 0)
         {
            ++counter1;
            if(counter1 > 3)
            {
               counter1 = 0;
               if(this.levelButton.xPos >= this.originalXPos)
               {
                  this.levelButton.xPos = this.originalXPos - 2;
               }
               else
               {
                  this.levelButton.xPos = this.originalXPos + 2;
               }
               ++counter2;
               if(counter2 > 8)
               {
                  this.levelButton.xPos = this.originalXPos;
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 1)
         {
            if(counter1++ > 15)
            {
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 2)
         {
            this.endCutscene();
            ++PROGRESSION;
         }
      }
      
      protected function endCutscene() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
         {
            Utils.GateUnlockOn = true;
         }
         dead = true;
      }
   }
}
