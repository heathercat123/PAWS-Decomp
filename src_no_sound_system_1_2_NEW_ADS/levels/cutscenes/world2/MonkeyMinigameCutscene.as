package levels.cutscenes.world2
{
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.GenericNPC;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.cutscenes.*;
   import levels.worlds.world2.Level_2_Secret;
   import starling.display.Image;
   
   public class MonkeyMinigameCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var npc:GenericNPC;
      
      protected var condition_1:Boolean;
      
      protected var condition_2:Boolean;
      
      protected var level_2_secret:Level_2_Secret;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var t_start_2:Number;
      
      protected var t_diff_2:Number;
      
      protected var t_time_2:Number;
      
      protected var t_tick_2:Number;
      
      protected var SUB_LEVEL:int;
      
      protected var sxBalloon:Image;
      
      protected var dxBalloon:Image;
      
      public function MonkeyMinigameCutscene(_level:Level)
      {
         this.SUB_LEVEL = 0;
         this.sxBalloon = null;
         this.dxBalloon = null;
         super(_level);
         this.condition_1 = this.condition_2 = false;
         counter1 = counter2 = counter3 = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = this.t_start_2 = this.t_diff_2 = this.t_time_2 = this.t_tick_2 = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.level_2_secret = null;
         if(level.hud != null)
         {
            if(level.hud.top_container != null)
            {
               level.hud.top_container.removeChild(this.dxBalloon);
            }
         }
         this.dxBalloon.dispose();
         this.dxBalloon = null;
         if(level.hud != null)
         {
            if(level.hud.top_container != null)
            {
               level.hud.top_container.removeChild(this.sxBalloon);
            }
         }
         this.sxBalloon.dispose();
         this.sxBalloon = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var amount:int = 0;
         ++counter1;
         if(PROGRESSION == 0)
         {
            if(this.hero.xPos <= 488 - 8)
            {
               level.rightPressed = true;
               level.leftPressed = false;
            }
            else
            {
               this.hero.xPos = 480;
               level.rightPressed = level.leftPressed = false;
               this.hero.xVel = 0;
               this.hero.stateMachine.setState("IS_STANDING_STATE");
               PROGRESSION = 1;
               counter1 = 0;
            }
         }
         else if(PROGRESSION == 1)
         {
            if(counter1 >= 60)
            {
               ++PROGRESSION;
               counter1 = counter2 = 0;
            }
         }
         else if(PROGRESSION == 2)
         {
            ++counter2;
            if(Math.random() * 100 > 50)
            {
               this.level_2_secret.directions[counter2 - 1] = -1;
               this.sxBalloon.visible = true;
               this.sxBalloon.alpha = 0;
               PROGRESSION = 3;
               counter3 = 0;
               SoundSystem.PlaySound("red_platform");
            }
            else
            {
               this.level_2_secret.directions[counter2 - 1] = 1;
               SoundSystem.PlaySound("red_platform");
               this.dxBalloon.visible = true;
               this.dxBalloon.alpha = 0;
               PROGRESSION = 4;
               counter3 = 0;
            }
         }
         else if(PROGRESSION == 3)
         {
            ++counter3;
            if(counter3 >= 2)
            {
               counter3 = 0;
               this.sxBalloon.alpha += 0.3;
               if(this.sxBalloon.alpha >= 1)
               {
                  counter1 = 0;
                  PROGRESSION = 5;
               }
            }
         }
         else if(PROGRESSION == 4)
         {
            ++counter3;
            if(counter3 >= 2)
            {
               counter3 = 0;
               this.dxBalloon.alpha += 0.3;
               if(this.dxBalloon.alpha >= 1)
               {
                  counter1 = 0;
                  PROGRESSION = 5;
               }
            }
         }
         else if(PROGRESSION == 5)
         {
            if(counter1 >= 35)
            {
               if(this.sxBalloon.visible)
               {
                  ++counter3;
                  if(counter3 >= 2)
                  {
                     counter3 = 0;
                     this.sxBalloon.alpha -= 0.5;
                     if(this.sxBalloon.alpha <= 0)
                     {
                        this.sxBalloon.alpha = 0;
                        this.sxBalloon.visible = false;
                        PROGRESSION = 6;
                        counter1 = 0;
                     }
                  }
               }
               if(this.dxBalloon.visible)
               {
                  ++counter3;
                  if(counter3 >= 2)
                  {
                     counter3 = 0;
                     this.dxBalloon.alpha -= 0.5;
                     if(this.dxBalloon.alpha <= 0)
                     {
                        this.dxBalloon.alpha = 0;
                        this.dxBalloon.visible = false;
                        PROGRESSION = 6;
                        counter1 = 0;
                     }
                  }
               }
            }
         }
         else if(PROGRESSION == 6)
         {
            amount = 3;
            if(this.SUB_LEVEL == 2)
            {
               amount = 4;
            }
            else if(this.SUB_LEVEL == 3)
            {
               amount = 5;
            }
            if(counter2 == amount)
            {
               ++PROGRESSION;
            }
            else if(counter1 >= 15)
            {
               PROGRESSION = 2;
            }
         }
         else if(PROGRESSION == 7)
         {
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
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
         this.SUB_LEVEL = level.SUB_LEVEL;
         this.level_2_secret = level as Level_2_Secret;
         this.sxBalloon = new Image(TextureManager.hudTextureAtlas.getTexture("balloonLeft"));
         level.hud.top_container.addChild(this.sxBalloon);
         this.sxBalloon.visible = false;
         this.dxBalloon = new Image(TextureManager.hudTextureAtlas.getTexture("balloonRight"));
         level.hud.top_container.addChild(this.dxBalloon);
         this.dxBalloon.visible = false;
         this.sxBalloon.pivotX = this.dxBalloon.pivotX = int(this.sxBalloon.width * 0.5);
         this.sxBalloon.pivotY = this.dxBalloon.pivotY = int(this.sxBalloon.height);
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is GenericNPC)
               {
                  this.npc = level.npcsManager.npcs[i];
                  this.npc.IS_TURN_ALLOWED = false;
                  this.npc.DIRECTION = Entity.RIGHT;
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.dxBalloon.x = this.sxBalloon.x = int(Math.floor(488 - camera.xPos));
         this.dxBalloon.y = this.sxBalloon.y = int(Math.floor(80 - camera.yPos));
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
      }
   }
}
