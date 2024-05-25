package states
{
   public interface IState
   {
       
      
      function enterState(param1:Game) : void;
      
      function updateState(param1:Game) : void;
      
      function exitState(param1:Game) : void;
   }
}
