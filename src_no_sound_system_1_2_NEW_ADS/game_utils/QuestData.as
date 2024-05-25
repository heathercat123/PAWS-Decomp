package game_utils
{
   public class QuestData
   {
       
      
      public var description:String;
      
      public var amount:int;
      
      public var action:int;
      
      public function QuestData(_description:String, _amount:int, _action:int)
      {
         super();
         this.description = _description;
         this.amount = _amount;
         this.action = _action;
      }
   }
}
