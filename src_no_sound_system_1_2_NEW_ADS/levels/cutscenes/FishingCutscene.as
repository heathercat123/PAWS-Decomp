package levels.cutscenes
{
   import entities.Hero;
   import levels.Level;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   
   public class FishingCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var INDEX:int;
      
      protected var cameraTween1:HorTweenShiftBehaviour;
      
      public function FishingCutscene(_level:Level, _index:int = 0)
      {
         this.INDEX = _index;
         super(_level);
         IS_BLACK_BANDS = false;
         level.hud.hideHud();
      }
      
      override public function destroy() : void
      {
         this.hero = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         ++counter1;
         if(this.INDEX == 0)
         {
            if(PROGRESSION == 0)
            {
               this.cameraTween1 = new HorTweenShiftBehaviour(level);
               this.cameraTween1.x_start = level.camera.x;
               this.cameraTween1.x_end = 192;
               this.cameraTween1.time = 1;
               this.cameraTween1.tick = 0;
               level.camera.changeHorBehaviour(this.cameraTween1);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(PROGRESSION == 1)
            {
               level.rightPressed = true;
               level.leftPressed = false;
               if(this.hero.xPos >= 272)
               {
                  level.rightPressed = level.leftPressed = false;
                  this.hero.xPos = 272;
                  this.hero.xVel = 0;
                  this.hero.stateMachine.setState("IS_FISHING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(this.INDEX == 1)
         {
            if(PROGRESSION == 0)
            {
               level.camera.LEFT_MARGIN = level.levelData.LEFT_MARGIN;
               level.camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(level));
               this.hero.stateMachine.setState("IS_WALKING_STATE");
               counter1 = 0;
               ++PROGRESSION;
               SoundSystem.PlaySound("cat_run");
               level.playMusic();
            }
            else if(PROGRESSION == 1)
            {
               level.rightPressed = false;
               level.leftPressed = true;
               if(this.hero.xPos <= 176)
               {
                  level.rightPressed = level.leftPressed = false;
                  this.hero.xPos = 176;
                  this.hero.xVel = 0;
                  this.hero.stateMachine.setState("IS_STANDING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 2)
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
         this.hero = level.hero;
         counter1 = counter2 = counter3 = PROGRESSION = 0;
         if(this.INDEX == 0)
         {
            if(isShowHideCatButtonCutscene())
            {
               level.soundHud.hideCatButton();
            }
         }
         stateMachine.performAction("START_ACTION");
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         if(this.INDEX == 1)
         {
            if(isShowHideCatButtonCutscene())
            {
               level.soundHud.showCatButton();
            }
         }
         dead = true;
         level.endCutscene(this);
      }
   }
}
