package interfaces.map.cutscenes
{
   import entities.Easings;
   import game_utils.SaveManager;
   import interfaces.buttons.MapLevelButton;
   import interfaces.map.*;
   import sprites.items.BellItemSprite;
   
   public class EnoughBellsMapCutscene extends MapCutscene
   {
       
      
      protected var levelButton:MapLevelButton;
      
      protected var originalXPos:Number;
      
      protected var bellXPos:Number;
      
      protected var bellYPos:Number;
      
      protected var bellSprite:BellItemSprite;
      
      public function EnoughBellsMapCutscene(_worldMap:WorldMap, _levelButton:MapLevelButton)
      {
         super(_worldMap);
         this.levelButton = _levelButton;
         this.originalXPos = this.levelButton.xPos;
         this.bellXPos = this.levelButton.xPos + 8;
         this.bellYPos = this.levelButton.yPos + 1;
         t_start_y = this.bellYPos;
         t_diff_y = 4;
         t_time = 0.25;
         t_tick = 0;
         this.levelButton.setImagesVisible(false);
         this.bellSprite = new BellItemSprite();
         this.bellSprite.gotoAndStop(4);
         this.bellSprite.gfxHandleClip().gotoAndPlay(1);
         SoundSystem.PlaySound("item_appear");
         Utils.world.addChild(this.bellSprite);
      }
      
      override public function destroy() : void
      {
         this.levelButton = null;
         Utils.world.removeChild(this.bellSprite);
         this.bellSprite.destroy();
         this.bellSprite.dispose();
         this.bellSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(PROGRESSION == 0)
         {
            t_tick += 1 / 60;
            if(t_tick >= t_time)
            {
               t_tick = t_time;
               counter1 = 0;
               ++PROGRESSION;
            }
            this.bellYPos = Easings.easeOutSine(t_tick,t_start_y,t_diff_y,t_time);
         }
         else if(PROGRESSION == 1)
         {
            ++counter1;
            if(counter1 > 30)
            {
               counter1 = 0;
               this.bellSprite.visible = false;
               worldMap.mapCamera.shake(3);
               SoundSystem.PlaySound("map_explosion");
               worldMap.mapParticlesManager.itemSparkles("yellow",this.levelButton.xPos + 16,this.levelButton.yPos + 12,25);
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 2)
         {
            ++counter1;
            if(counter1 > 5)
            {
               this.endCutscene();
               ++PROGRESSION;
            }
         }
      }
      
      override public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         super.updateScreenPosition(mapCamera);
         this.bellSprite.x = int(Math.floor(this.bellXPos - worldMap.mapCamera.xPos));
         this.bellSprite.y = int(Math.floor(this.bellYPos - worldMap.mapCamera.yPos));
         this.bellSprite.updateScreenPosition();
      }
      
      protected function endCutscene() : void
      {
         if(this.levelButton.index == 8)
         {
            Utils.Slot.worldUnlocked[0] = true;
         }
         else if(this.levelButton.index == 16)
         {
            Utils.Slot.worldUnlocked[1] = true;
         }
         else if(this.levelButton.index == 24)
         {
            Utils.Slot.worldUnlocked[2] = true;
         }
         SaveManager.SaveWorlds();
         dead = true;
      }
   }
}
