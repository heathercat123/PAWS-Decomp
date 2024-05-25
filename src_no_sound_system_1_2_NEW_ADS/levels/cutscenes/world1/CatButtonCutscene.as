package levels.cutscenes.world1
{
   import game_utils.AchievementsManager;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.collisions.TutorialCollision;
   import levels.cutscenes.*;
   import sprites.hud.DarkCircleSprite;
   import starling.display.Image;
   import starling.display.Quad;
   
   public class CatButtonCutscene extends Cutscene
   {
       
      
      protected var darkCircleSprite:DarkCircleSprite;
      
      protected var darkPanel1:Image;
      
      protected var darkPanel2:Image;
      
      protected var alpha_counter1:int;
      
      protected var alpha_value:Number;
      
      protected var tCollision:TutorialCollision;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var condition_1:Boolean;
      
      protected var condition_2:Boolean;
      
      protected var quad:Quad;
      
      public function CatButtonCutscene(_level:Level)
      {
         super(_level);
         IS_BLACK_BANDS = false;
      }
      
      override public function destroy() : void
      {
         this.tCollision = null;
         Utils.rootMovie.removeChild(this.quad);
         this.quad.dispose();
         this.quad = null;
         Utils.gameMovie.removeChild(this.darkCircleSprite);
         Utils.gameMovie.removeChild(this.darkPanel1);
         Utils.gameMovie.removeChild(this.darkPanel2);
         this.darkCircleSprite.destroy();
         this.darkCircleSprite.dispose();
         this.darkCircleSprite = null;
         this.darkPanel1.dispose();
         this.darkPanel2.dispose();
         this.darkPanel1 = this.darkPanel2 = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         ++counter1;
         if(PROGRESSION == 0)
         {
            ++PROGRESSION;
         }
         else if(PROGRESSION == 1)
         {
            if(counter1 >= 15)
            {
               if(Utils.IS_IPHONE_X)
               {
                  this.darkCircleSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  this.darkCircleSprite.gfxHandleClip().gotoAndStop(2);
               }
               this.condition_1 = true;
               ++PROGRESSION;
               counter1 = 0;
            }
         }
         else if(PROGRESSION == 2)
         {
            if(counter1 > 10)
            {
               counter1 = 0;
               level.soundHud.catButtonPanel.catButton.visible = !level.soundHud.catButtonPanel.catButton.visible;
               if(level.soundHud.catButtonPanel.catButton.visible)
               {
                  SoundSystem.PlaySound("blip");
               }
               ++this.counter_2;
               if(this.counter_2 >= 8)
               {
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 3)
         {
            if(counter1 > 60)
            {
               this.condition_2 = true;
               this.alpha_counter1 = 0;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 4)
         {
            if(counter1 > 30)
            {
               ++PROGRESSION;
               stateMachine.performAction("END_ACTION");
            }
         }
         if(this.condition_1)
         {
            ++this.alpha_counter1;
            if(this.alpha_counter1 > 2)
            {
               this.alpha_counter1 = 0;
               this.alpha_value += 0.2;
               if(this.alpha_value >= 0.75)
               {
                  this.alpha_value = 0.75;
                  this.condition_1 = false;
               }
               this.darkCircleSprite.alpha = this.darkPanel1.alpha = this.darkPanel2.alpha = this.alpha_value;
            }
         }
         if(this.condition_2)
         {
            ++this.alpha_counter1;
            if(this.alpha_counter1 > 2)
            {
               this.alpha_counter1 = 0;
               this.alpha_value -= 0.2;
               if(this.alpha_value <= 0)
               {
                  this.alpha_value = 0;
                  this.condition_2 = false;
               }
               this.darkCircleSprite.alpha = this.darkPanel1.alpha = this.darkPanel2.alpha = this.alpha_value;
            }
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
         this.counter_1 = this.counter_2 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         super.initState();
         this.darkCircleSprite = new DarkCircleSprite();
         Utils.gameMovie.addChild(this.darkCircleSprite);
         this.darkCircleSprite.x = this.darkCircleSprite.y = 0;
         this.darkPanel1 = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         Utils.gameMovie.addChild(this.darkPanel1);
         this.darkPanel1.x = this.darkCircleSprite.x + this.darkCircleSprite.width;
         this.darkPanel1.y = 0;
         this.darkPanel1.width = Utils.SCREEN_WIDTH;
         this.darkPanel1.height = Utils.SCREEN_HEIGHT + 2;
         this.darkPanel2 = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         Utils.gameMovie.addChild(this.darkPanel2);
         this.darkPanel2.x = 0;
         this.darkPanel2.y = this.darkCircleSprite.y + this.darkCircleSprite.height;
         this.darkPanel2.width = this.darkCircleSprite.width;
         this.darkPanel2.height = Utils.SCREEN_HEIGHT;
         this.darkCircleSprite.alpha = this.darkPanel1.alpha = this.darkPanel2.alpha = 0;
         this.alpha_counter1 = this.alpha_value = 0;
         this.quad = new Quad(32 * Utils.GFX_SCALE,32 * Utils.GFX_SCALE,16711680);
         Utils.rootMovie.addChild(this.quad);
         this.quad.alpha = 0;
         level.soundHud.showCatButton();
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] is TutorialCollision)
            {
               if(level.collisionsManager.collisions[i].xPos < 240)
               {
                  this.tCollision = level.collisionsManager.collisions[i];
               }
            }
         }
         this.tCollision.aabb.width = this.tCollision.aabb.height = 0;
         this.condition_1 = false;
         this.condition_2 = false;
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         AchievementsManager.SubmitAchievement("CAT_1");
         SoundSystem.PlayMusic("woods");
         this.tCollision.aabb.width = 80;
         this.tCollision.aabb.height = 24;
         Utils.Slot.gameProgression[4] = 1;
         SaveManager.SaveGameProgression();
      }
   }
}
