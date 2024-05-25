package levels.cutscenes.world2
{
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.CatNPC;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cutscenes.Cutscene;
   
   public class MaraJoinsTeamCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var cat1:CatNPC;
      
      protected var cameraTween1:HorTweenShiftBehaviour;
      
      protected var cutscene_y_offset:Number;
      
      protected var tile_sin_counter:Number;
      
      protected var tile_sin_radius:Number;
      
      public function MaraJoinsTeamCutscene(_level:Level)
      {
         super(_level);
         this.cutscene_y_offset = 0;
         counter1 = counter2 = counter3 = 0;
         this.tile_sin_counter = this.tile_sin_radius = 0;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         ++counter1;
         this.hero.xVel = 0;
         this.hero.DIRECTION = Entity.LEFT;
         this.hero.xPos = 256;
         if(PROGRESSION == 0)
         {
            if(counter1 >= 50)
            {
               counter1 = 0;
               ++PROGRESSION;
               if(this.cat1.DIRECTION == Entity.LEFT)
               {
                  this.cat1.stateMachine.performAction("CHANGE_DIR_ACTION");
               }
            }
            else if(counter1 == 2)
            {
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 232 - Utils.WIDTH * 0.5;
               this.cameraTween1.time = 1;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
            }
         }
         else if(PROGRESSION == 1)
         {
            if(this.cat1.stateMachine.currentState == "IS_STANDING_STATE")
            {
               counter1 = 0;
               PROGRESSION = 3;
            }
         }
         else if(PROGRESSION == 3)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene3_1"),this.cat1,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 5)
         {
            if(Hero.GetCurrentCat() == Hero.CAT_ROSE)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene3_2_1"),this.hero,this.advance);
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene3_2_2"),this.hero,this.advance);
            }
            else
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene3_2_0"),this.hero,this.advance);
            }
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 7)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene3_3"),this.cat1,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 9)
         {
            level.hud.catUnlockManager.showUnlockScene(3);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 10)
         {
            if(level.hud.catUnlockManager.unlockScene == null)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 11)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_2_cutscene3_4"),this.cat1,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 13)
         {
            this.cat1.DIRECTION = Entity.RIGHT;
            this.cat1.stateMachine.setState("IS_WALKING_STATE");
            SoundSystem.PlaySound("cat_run");
            this.hero.onTop();
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 14)
         {
            if(this.cat1.xPos >= this.hero.xPos)
            {
               this.cat1.sprite.visible = false;
               this.cat1.stateMachine.setState("IS_STANDING_STATE");
               this.cat1.xVel = 0;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 15)
         {
            if(counter1 > 15)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.initState();
         SoundSystem.PlayMusic("cutscene_cats");
         this.hero = level.hero;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is CatNPC)
               {
                  this.cat1 = level.npcsManager.npcs[i];
               }
            }
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
         level.playMusic();
         super.overState();
         this.cat1.dead = true;
         Utils.Slot.playerInventory[LevelItems.ITEM_WATER_CAT] = 1;
         SaveManager.SaveInventory();
         Utils.Slot.gameProgression[12] = 3;
         SaveManager.SaveGameProgression();
      }
   }
}
