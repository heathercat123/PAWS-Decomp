package levels.groups
{
   import levels.Level;
   import levels.cameras.*;
   
   public class GroupsManager
   {
       
      
      public var level:Level;
      
      public var groups:Array;
      
      public function GroupsManager(_level:Level)
      {
         var group:Group = null;
         var i:int = 0;
         super();
         this.level = _level;
         this.groups = new Array();
         for(i = 0; i < this.level.scriptsManager.levelGroups.length; i++)
         {
            if(this.level.scriptsManager.levelGroups[i].type == 0)
            {
               group = new Group(this.level,this.level.scriptsManager.levelGroups[i].x,this.level.scriptsManager.levelGroups[i].y,this.level.scriptsManager.levelGroups[i].width,this.level.scriptsManager.levelGroups[i].height,0);
            }
            else if(this.level.scriptsManager.levelGroups[i].type == 1)
            {
               group = new Group(this.level,this.level.scriptsManager.levelGroups[i].x,this.level.scriptsManager.levelGroups[i].y,this.level.scriptsManager.levelGroups[i].width,this.level.scriptsManager.levelGroups[i].height,1);
            }
            else
            {
               group = new Group(this.level,this.level.scriptsManager.levelGroups[i].x,this.level.scriptsManager.levelGroups[i].y,this.level.scriptsManager.levelGroups[i].width,this.level.scriptsManager.levelGroups[i].height,2);
            }
            this.groups.push(group);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.groups.length; i++)
         {
            if(this.groups[i] != null)
            {
               this.groups[i].destroy();
               this.groups[i] = null;
            }
         }
         this.groups = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.groups.length; i++)
         {
            if(this.groups[i] != null)
            {
               this.groups[i].update();
            }
         }
      }
   }
}
