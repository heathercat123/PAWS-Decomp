package levels.cutscenes.world1
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
   import sprites.cats.CatSprite;
   import sprites.cats.SmallCatSprite;
   
   public class RoseJoinsTeamCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var rose:CatNPC;
      
      protected var pascal:CatNPC;
      
      protected var cameraTween1:HorTweenShiftBehaviour;
      
      protected var cutscene_y_offset:Number;
      
      protected var tile_sin_counter:Number;
      
      protected var tile_sin_radius:Number;
      
      public function RoseJoinsTeamCutscene(_level:Level)
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
         if(PROGRESSION == 0)
         {
            if(counter1 >= 120)
            {
               counter1 = 0;
               ++PROGRESSION;
               this.pascal.stateMachine.setState("IS_WALKING_STATE");
            }
            if(counter1 == 90)
            {
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 272 - Utils.WIDTH * 0.5;
               this.cameraTween1.time = 2;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
            }
         }
         else if(PROGRESSION == 1)
         {
            if(this.pascal.xPos >= 224)
            {
               this.pascal.stateMachine.setState("IS_STANDING_STATE");
               this.pascal.xPos = 224;
               this.pascal.xVel = 0;
               counter1 = 0;
               ++PROGRESSION;
            }
            if(counter1 == 60)
            {
               this.rose.stateMachine.setState("IS_STANDING_STATE");
               this.rose.changeDirection();
               this.rose.setEmotionParticle(Entity.EMOTION_SHOCKED);
            }
         }
         else if(PROGRESSION == 2)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene2_1"),this.rose,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 4)
         {
            this.pascal.setEmotionParticle(Entity.EMOTION_WORRIED);
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene2_2"),this.pascal,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 6)
         {
            SmallCatSprite(this.rose.sprite).playSpecialAnim(CatSprite.SHOCKED);
            this.rose.setEmotionParticle(Entity.EMOTION_WORRIED);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 7)
         {
            if(counter1 == 60)
            {
               this.rose.stateMachine.setState("IS_STANDING_STATE");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene2_3"),this.rose,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 9)
         {
            level.hud.catUnlockManager.showUnlockScene(6);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 10)
         {
            if(level.hud.catUnlockManager.unlockScene == null)
            {
               SoundSystem.PlayMusic("outside_background",-1,false,true);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 11)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene2_4"),this.rose,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 13)
         {
            level.hero.xPos = this.rose.xPos;
            level.hero.yPos = this.rose.yPos;
            level.hero.DIRECTION = Entity.LEFT;
            level.changeCat(4,false,true);
            level.hero.sprite.visible = true;
            this.rose.sprite.visible = false;
            this.pascal.onTop();
            SoundSystem.PlaySound("cat_run");
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 14)
         {
            level.leftPressed = true;
            if(level.hero.xPos <= this.pascal.xPos)
            {
               level.leftPressed = false;
               level.hero.xPos = this.pascal.xPos;
               level.hero.xVel = 0;
               level.hero.stateMachine.setState("IS_STANDING_STATE");
               level.hero.sprite.visible = false;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 15)
         {
            level.hero.DIRECTION = Entity.RIGHT;
            level.changeCat(0,false);
            this.pascal.sprite.visible = false;
            level.hero.sprite.visible = true;
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 16)
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
         this.hero = level.hero;
         level.hero.sprite.visible = false;
         this.rose = new CatNPC(level,304,128,Entity.RIGHT,0,CatNPC.ROSE);
         this.rose.sprite.gfxHandle().gotoAndStop(19);
         this.rose.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.pascal = new CatNPC(level,16,144,Entity.RIGHT,0,CatNPC.PASCAL);
         level.npcsManager.npcs.push(this.rose);
         level.npcsManager.npcs.push(this.pascal);
         this.rose.updateScreenPosition(level.camera);
         this.pascal.updateScreenPosition(level.camera);
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
         super.overState();
         level.changeCat(0,false);
         level.hero.xPos = this.pascal.xPos;
         level.hero.sprite.visible = true;
         level.hero.DIRECTION = Entity.RIGHT;
         level.soundHud.showCatButton();
         this.pascal.dead = true;
         this.rose.dead = true;
         Utils.Slot.playerInventory[LevelItems.ITEM_SMALL_CAT] = 1;
         level.soundHud.HAS_CAT = true;
         SaveManager.SaveInventory();
         Utils.Slot.gameProgression[3] = 1;
         SaveManager.SaveGameProgression();
         level.levelStart();
      }
   }
}
