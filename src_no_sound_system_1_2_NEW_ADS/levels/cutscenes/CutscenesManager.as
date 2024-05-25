package levels.cutscenes
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   
   public class CutscenesManager
   {
       
      
      public var level:Level;
      
      public var cutscenes:Array;
      
      public function CutscenesManager(_level:Level)
      {
         super();
         this.level = _level;
         this.cutscenes = new Array();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].destroy();
               this.cutscenes[i] = null;
            }
         }
         this.cutscenes = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var doNotEndCutscene:Boolean = false;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].update();
               if(this.cutscenes[i].dead)
               {
                  if(!doNotEndCutscene)
                  {
                     this.level.endCutscene(this.cutscenes[i]);
                  }
                  this.cutscenes[i].destroy();
                  this.cutscenes[i] = null;
               }
            }
         }
      }
      
      public function postUpdate() : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].postUpdate();
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].updateScreenPosition(camera);
            }
         }
      }
      
      public function addCutscene(cutscene:Cutscene) : void
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               this.cutscenes[i].destroy();
               this.cutscenes[i] = null;
            }
         }
         this.cutscenes.push(cutscene);
      }
      
      public function getCurrentCutscene() : Cutscene
      {
         var i:int = 0;
         for(i = 0; i < this.cutscenes.length; i++)
         {
            if(this.cutscenes[i] != null)
            {
               return this.cutscenes[i];
            }
         }
         return null;
      }
   }
}
