package levels.decorations
{
   import levels.GenericScript;
   import levels.Level;
   import levels.cameras.*;
   
   public class DecorationsManager
   {
      
      public static var start_index:int = 0;
       
      
      public var level:Level;
      
      public var decorations:Array;
      
      public function DecorationsManager(_level:Level)
      {
         var i:int = 0;
         var decoration:Decoration = null;
         var gScript:GenericScript = null;
         super();
         this.level = _level;
         this.decorations = new Array();
         start_index = Utils.CurrentSubLevel * Utils.ITEMS_PER_LEVEL;
         for(i = 0; i < this.level.scriptsManager.levelDecorations.length; i++)
         {
            gScript = this.level.scriptsManager.levelDecorations[i] as GenericScript;
            if(gScript.type == 7)
            {
               decoration = new DandelionFlowerDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
               decoration.level_index = start_index++;
            }
            else if(gScript.type == 10)
            {
               decoration = new DewDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 17)
            {
               decoration = new SeaLightDecoration(this.level,gScript.x,gScript.y,gScript.ai);
            }
            else if(gScript.type == 19)
            {
               decoration = new SandCastleDecoration(this.level,gScript.x,gScript.y,gScript.width);
               decoration.level_index = start_index++;
            }
            else if(gScript.type == 21)
            {
               decoration = new ChimneyDecoration(this.level,gScript.x,gScript.y,gScript.width,0);
            }
            else if(gScript.type == 28)
            {
               decoration = new OutsideBoneDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
               decoration.level_index = start_index++;
            }
            else if(gScript.type == 29)
            {
               decoration = new MinecartDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 31)
            {
               decoration = new SnowmanDecoration(this.level,gScript.x,gScript.y,gScript.width);
               decoration.level_index = start_index++;
            }
            else if(gScript.type == 34)
            {
               decoration = new SmallIcycleDecoration(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 38)
            {
               decoration = new TorchStandDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 43)
            {
               decoration = new AshFlowerDecoration(this.level,gScript.x,gScript.y,gScript.width);
               decoration.level_index = start_index++;
            }
            else if(gScript.type == 50)
            {
               decoration = new CandleDecoration(this.level,gScript.x,gScript.y + 8);
            }
            else if(gScript.type == 53)
            {
               decoration = new ShopLightDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 55)
            {
               decoration = new SnowmanMinigameDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 56)
            {
               decoration = new WoodVeinDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.value1,gScript.value2);
            }
            else if(gScript.type == 58)
            {
               decoration = new CarpetDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 59)
            {
               decoration = new CageDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 60)
            {
               decoration = new MetalDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.value1,gScript.value2);
            }
            else if(gScript.type == 62)
            {
               decoration = new SprinklerDecoration(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 65)
            {
               decoration = new VineDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.value1,gScript.value2);
            }
            else if(gScript.type == 68)
            {
               decoration = new CaneFlowerDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 69)
            {
               decoration = new CondenseDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 76)
            {
               decoration = new FountainDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 77)
            {
               decoration = new CupboardDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
            }
            else if(gScript.type == 83)
            {
               decoration = new ChimneyDecoration(this.level,gScript.x,gScript.y,gScript.width,1,gScript.height);
            }
            else if(gScript.type == 84)
            {
               decoration = new DoorExitDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 92)
            {
               decoration = new FoodDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 99)
            {
               decoration = new StreetLampDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 106)
            {
               decoration = new IceLightDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 107)
            {
               decoration = new CircusBalloonDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 108)
            {
               decoration = new DiamondRockDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 110)
            {
               decoration = new MugDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 111)
            {
               decoration = new GenericDecoration(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
            }
            else if(gScript.type == 112)
            {
               decoration = new HoneyDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 113)
            {
               decoration = new NeonDecoration(this.level,gScript.x,gScript.y,gScript.width);
            }
            this.decorations.push(decoration);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].destroy();
               this.decorations[i] = null;
            }
         }
         this.decorations = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].update();
               if(this.decorations[i].dead)
               {
                  this.decorations[i].destroy();
                  this.decorations[i] = null;
               }
            }
         }
      }
      
      public function shake() : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].shake();
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.decorations.length; i++)
         {
            if(this.decorations[i] != null)
            {
               this.decorations[i].updateScreenPosition(camera);
            }
         }
      }
   }
}
