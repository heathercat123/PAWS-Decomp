package states
{
   public class GameEntryState implements IState
   {
       
      
      public function GameEntryState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         game.enterGameEntryState();
      }
      
      public function updateState(game:Game) : void
      {
         game.updateGameEntryState();
      }
      
      public function exitState(game:Game) : void
      {
         game.exitGameEntryState();
      }
   }
}
