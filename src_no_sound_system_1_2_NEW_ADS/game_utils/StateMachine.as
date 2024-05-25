package game_utils
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class StateMachine
   {
       
      
      public var statesDictionary:Dictionary;
      
      public var actionsDictionary:Dictionary;
      
      public var functionsDictionary:Dictionary;
      
      public var timeStampsDictionary:Dictionary;
      
      public var states:Array;
      
      public var currentState:String;
      
      public var lastState:String;
      
      public var statesCounter:int;
      
      public var actionsCounter:int;
      
      public var stateTimeCounter:uint;
      
      public function StateMachine(statesSize:int = 20, actionsSize:int = 20)
      {
         var i:* = undefined;
         var j:int = 0;
         super();
         this.statesDictionary = new Dictionary();
         this.actionsDictionary = new Dictionary();
         this.functionsDictionary = new Dictionary();
         this.timeStampsDictionary = new Dictionary();
         this.currentState = "";
         this.lastState = "";
         this.statesCounter = 0;
         this.actionsCounter = 0;
         this.stateTimeCounter = 0;
         this.states = new Array();
         for(i = 0; i < statesSize; i++)
         {
            this.states.push(new Array());
            for(j = 0; j < actionsSize; j++)
            {
               this.states[i].push("NONE");
            }
         }
      }
      
      public function destroy() : void
      {
         var i:* = undefined;
         var j:int = 0;
         for(i = 0; i < this.states.length; i++)
         {
            for(j = 0; j < this.states[i].length; j++)
            {
               this.states[i][j] = null;
            }
            this.states[i] = null;
         }
         this.states = null;
         this.currentState = null;
         this.lastState = null;
         this.functionsDictionary = null;
         this.actionsDictionary = null;
         this.statesDictionary = null;
         this.timeStampsDictionary = null;
      }
      
      public function setRule(initialState:String, action:String, resultingState:String) : void
      {
         if(this.statesDictionary[initialState] == null)
         {
            this.statesDictionary[initialState] = this.statesCounter++;
         }
         if(this.statesDictionary[resultingState] == null)
         {
            this.statesDictionary[resultingState] = this.statesCounter++;
         }
         if(this.actionsDictionary[action] == null)
         {
            this.actionsDictionary[action] = this.actionsCounter++;
         }
         this.states[this.statesDictionary[initialState]][this.actionsDictionary[action]] = resultingState;
      }
      
      public function setFunctionToState(stateToSet:String, functionName:Function) : void
      {
         if(this.functionsDictionary[stateToSet] == null)
         {
            this.functionsDictionary[stateToSet] = functionName;
            this.timeStampsDictionary[stateToSet] = 0;
         }
      }
      
      public function performAction(action:String) : void
      {
         if(this.actionsDictionary[action] == null)
         {
            trace("WARNING! Wrong action typed");
         }
         var resultingState:String = String(this.states[this.statesDictionary[this.currentState]][this.actionsDictionary[action]]);
         if(resultingState != "NONE")
         {
            this.lastState = this.currentState;
            this.currentState = resultingState;
            this.functionsDictionary[resultingState]();
            this.timeStampsDictionary[resultingState] = getTimer();
            this.stateTimeCounter = getTimer();
         }
      }
      
      public function getTimeSinceState(stateName:String) : uint
      {
         return getTimer() - this.timeStampsDictionary[stateName];
      }
      
      public function getCurrentStateTime() : int
      {
         return getTimer() - this.stateTimeCounter;
      }
      
      public function setState(initialState:String) : void
      {
         this.lastState = this.currentState;
         this.currentState = initialState;
         this.functionsDictionary[this.currentState]();
      }
   }
}
