package entities.npcs
{
   import levels.GenericScript;
   import levels.Level;
   import levels.cameras.*;
   
   public class NPCsManager
   {
       
      
      public var level:Level;
      
      public var npcs:Array;
      
      public function NPCsManager(_level:Level)
      {
         var gScript:GenericScript = null;
         var npc:NPC = null;
         var i:int = 0;
         super();
         this.level = _level;
         this.npcs = new Array();
         for(i = 0; i < this.level.scriptsManager.levelNPCs.length; i++)
         {
            gScript = this.level.scriptsManager.levelNPCs[i];
            if(gScript.type == 56)
            {
               npc = new GenericNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
            }
            else if(gScript.type == 25)
            {
               npc = new ShopNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 57)
            {
               npc = new TwelveNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 58)
            {
               npc = new CatNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height,CatNPC.OLLI);
            }
            else if(gScript.type == 59)
            {
               npc = new FishermanNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 22)
            {
               npc = new ScientistNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 31)
            {
               npc = new BlackDuckNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 32)
            {
               npc = new HelperNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 33)
            {
               npc = new ChefNPC(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            this.npcs.push(npc);
         }
      }
      
      public function getRateMeNPC() : NPC
      {
         var i:int = 0;
         var npc:NPC = null;
         for(i = 0; i < this.npcs.length; i++)
         {
            if(this.npcs[i] != null)
            {
               if(this.npcs[i].isRateMe)
               {
                  npc = this.npcs[i];
               }
            }
         }
         return npc;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.npcs.length; i++)
         {
            if(this.npcs[i] != null)
            {
               this.npcs[i].destroy();
               this.npcs[i] = null;
            }
         }
         this.npcs = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.npcs.length; i++)
         {
            if(this.npcs[i] != null)
            {
               this.npcs[i].update();
               this.npcs[i].checkHeroCollisionDetection(this.level.hero);
               if(this.npcs[i].dead)
               {
                  this.npcs[i].destroy();
                  this.npcs[i] = null;
               }
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.npcs.length; i++)
         {
            if(this.npcs[i] != null)
            {
               this.npcs[i].updateScreenPosition(camera);
            }
         }
      }
   }
}
