package entities.npcs
{
   import entities.Entity;
   import entities.Hero;
   import flash.geom.*;
   import interfaces.dialogs.Dialog;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.hud.QuestBalloonSprite;
   import sprites.particles.WaterDropParticleSprite;
   
   public class NPC extends Entity
   {
       
      
      protected var IS_INTERACTING:Boolean;
      
      public var dialog:Dialog;
      
      public var stringId:int;
      
      protected var outerAABB:Rectangle;
      
      protected var questBalloon:QuestBalloonSprite;
      
      protected var questBalloon_yOffset:Number;
      
      protected var IS_QUEST_BALLOON_FADING:Boolean;
      
      protected var IS_QUEST_BALLOON_APPEARING:Boolean;
      
      protected var fade_counter_1:int;
      
      protected var fade_counter_2:int;
      
      protected var path_start_y:Number;
      
      protected var path_end_y:Number;
      
      protected var path_start_x:Number;
      
      protected var path_end_x:Number;
      
      public var isRateMe:Boolean;
      
      public var allowTurn:Boolean;
      
      public var IS_WET:Boolean;
      
      protected var wet_counter1:int;
      
      protected var wet_counter2:int;
      
      public function NPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0)
      {
         super(_level,_xPos,_yPos,_direction);
         this.IS_INTERACTING = false;
         this.dialog = null;
         this.questBalloon = null;
         this.isRateMe = false;
         this.allowTurn = true;
         this.IS_WET = false;
         this.wet_counter1 = this.wet_counter2 = 0;
         this.path_start_y = this.path_end_y = this.path_start_x = this.path_start_y = 0;
         WIDTH = HEIGHT = 16;
         this.stringId = _string_id;
         aabb = new Rectangle(-24,0,64,16);
         this.outerAABB = new Rectangle(-40,-16,96,32);
         this.questBalloon_yOffset = -16;
         this.IS_QUEST_BALLOON_FADING = this.IS_QUEST_BALLOON_APPEARING = false;
         this.fade_counter_1 = this.fade_counter_2 = 0;
      }
      
      override public function destroy() : void
      {
         this.dialog = null;
         this.outerAABB = null;
         if(this.questBalloon)
         {
            Utils.gameMovie.removeChild(this.questBalloon);
            this.questBalloon.destroy();
            this.questBalloon.dispose();
            this.questBalloon = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         super.update();
         if(this.IS_QUEST_BALLOON_FADING)
         {
            ++this.fade_counter_1;
            if(this.fade_counter_1 > 3)
            {
               this.fade_counter_1 = 0;
               this.questBalloon.alpha -= 0.3;
               if(this.questBalloon.alpha <= 0)
               {
                  this.questBalloon.alpha = 0;
                  this.questBalloon.visible = false;
                  this.IS_QUEST_BALLOON_FADING = false;
               }
            }
         }
         else if(this.IS_QUEST_BALLOON_APPEARING)
         {
            ++this.fade_counter_1;
            if(this.fade_counter_1 > 3)
            {
               this.fade_counter_1 = 0;
               this.questBalloon.alpha += 0.3;
               if(this.questBalloon.alpha >= 1)
               {
                  this.questBalloon.alpha = 1;
                  this.IS_QUEST_BALLOON_APPEARING = false;
               }
            }
         }
         if(this.IS_WET)
         {
            if(this.wet_counter1++ >= 10)
            {
               this.wet_counter1 = -Math.random() * 25;
               pSprite = new WaterDropParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.particlesManager.pushParticle(pSprite,xPos + Math.random() * WIDTH,yPos + Math.random() * HEIGHT * 0.5,0,0,0.9);
            }
         }
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         var area_enemy:Rectangle = new Rectangle(xPos - 24,yPos - 24,WIDTH + 48,HEIGHT + 48);
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               if(level.scriptsManager.verPathScripts[i].intersects(area_enemy))
               {
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = level.scriptsManager.verPathScripts[i].y + level.scriptsManager.verPathScripts[i].height;
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               if(level.scriptsManager.horPathScripts[i].intersects(area_enemy))
               {
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = level.scriptsManager.horPathScripts[i].x + level.scriptsManager.horPathScripts[i].width;
               }
            }
         }
      }
      
      protected function integratePositionAndCollisionDetection() : void
      {
         yVel += 0.4 * gravity_friction;
         xVel *= x_friction;
         if(xVel >= MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel <= -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel >= MAX_Y_VEL)
         {
            yVel = MAX_Y_VEL;
         }
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.questBalloon)
         {
            this.questBalloon.x = int(Math.floor(xPos + WIDTH * 0.5 - camera.xPos));
            this.questBalloon.y = int(Math.floor(yPos + this.questBalloon_yOffset - camera.yPos));
         }
      }
      
      public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(this.stringId <= 0)
         {
            return;
         }
         if(!this.IS_INTERACTING)
         {
            if(hero.getAABB().intersects(getAABB()) && this.isInteractionAllowed())
            {
               this.IS_INTERACTING = true;
               this.heroInteractionStart();
            }
         }
         else if(hero.getAABB().intersects(this.getOuterAABB()) == false)
         {
            this.IS_INTERACTING = false;
            if(this.dialog != null)
            {
               this.heroInteractionEnd();
            }
         }
      }
      
      protected function isInteractionAllowed() : Boolean
      {
         return true;
      }
      
      public function rateThanks() : void
      {
         if(this.dialog != null)
         {
            this.dialog.dead = true;
         }
         this.dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("rate_thanks"),this);
      }
      
      public function heroInteractionStart() : void
      {
      }
      
      public function heroInteractionEnd() : void
      {
      }
      
      protected function getOuterAABB() : Rectangle
      {
         return new Rectangle(xPos + this.outerAABB.x,yPos + this.outerAABB.y,this.outerAABB.width,this.outerAABB.height);
      }
      
      public function isHeroClose() : Boolean
      {
         if(Math.abs(level.hero.yPos + level.hero.HEIGHT * 0.5 - (yPos + WIDTH * 0.5)) < 16)
         {
            if(Math.abs(level.hero.xPos + level.hero.WIDTH * 0.5 - (xPos + WIDTH * 0.5)) < 64)
            {
               return true;
            }
         }
         return false;
      }
      
      public function fadeQuestBalloon() : void
      {
         if(!this.IS_QUEST_BALLOON_FADING)
         {
            this.IS_QUEST_BALLOON_FADING = true;
            this.fade_counter_1 = this.fade_counter_2 = 0;
            this.questBalloon.visible = true;
            this.questBalloon.alpha = 1;
         }
      }
      
      public function appearQuestBalloon() : void
      {
         if(!this.IS_QUEST_BALLOON_APPEARING)
         {
            this.IS_QUEST_BALLOON_APPEARING = true;
            this.fade_counter_1 = this.fade_counter_2 = 0;
            this.questBalloon.visible = true;
            this.questBalloon.alpha = 0;
         }
      }
      
      public function setWet(value:Boolean) : void
      {
         this.IS_WET = value;
         this.wet_counter1 = this.wet_counter2 = 0;
      }
   }
}
