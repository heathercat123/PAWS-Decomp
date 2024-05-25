package levels.cutscenes.world1
{
   import entities.*;
   import entities.npcs.*;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cutscenes.*;
   import sprites.GameSprite;
   import sprites.hud.BigDarkCircleSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ShopIntroCutscene extends Cutscene
   {
       
      
      protected var darkCircleSprite:BigDarkCircleSprite;
      
      protected var darkPanel1:Image;
      
      protected var darkPanel2:Image;
      
      protected var container:Sprite;
      
      protected var hero:Hero;
      
      protected var redTomo:ShopNPC;
      
      protected var visible_counter_1:int;
      
      protected var alpha_counter1:int;
      
      protected var alpha_value:Number;
      
      protected var counter_2:int;
      
      protected var condition_1:Boolean;
      
      protected var condition_2:Boolean;
      
      public function ShopIntroCutscene(_level:Level)
      {
         super(_level);
         counter1 = counter2 = counter3 = this.counter_2 = 0;
         this.visible_counter_1 = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.hero = null;
         this.redTomo = null;
         this.container.removeChild(this.darkCircleSprite);
         this.container.removeChild(this.darkPanel1);
         this.container.removeChild(this.darkPanel2);
         this.darkCircleSprite.destroy();
         this.darkCircleSprite.dispose();
         this.darkCircleSprite = null;
         this.darkPanel1.dispose();
         this.darkPanel2.dispose();
         this.darkPanel1 = this.darkPanel2 = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         ++counter1;
         this.hero.xVel = 0;
         this.hero.xPos = 792;
         if(PROGRESSION == 0)
         {
            if(counter1 > 15)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_0"),this.redTomo,this.advance,15);
               this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 2)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_2"),this.redTomo,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 4)
         {
            this.hero.setEmotionParticle(Entity.EMOTION_QUESTION);
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_3"),this.hero,this.advance,40);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 6)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_4"),this.redTomo,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 8)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_5"),this.redTomo,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 10)
         {
            level.hud.endCutscene();
            level.soundHud.HAS_SLOT = true;
            level.soundHud.catButtonPanel.showSlotButton();
            level.soundHud.showCatButton();
            level.soundHud.catButtonPanel.slotButton.visible = true;
            counter1 = 0;
            counter3 = 0;
            ++PROGRESSION;
            this.condition_1 = true;
            this.container.touchable = true;
         }
         else if(PROGRESSION == 11)
         {
            ++counter3;
            if(counter1 > 10 && this.counter_2 < 8)
            {
               counter1 = 0;
               level.soundHud.catButtonPanel.slotButton.visible = !level.soundHud.catButtonPanel.slotButton.visible;
               if(level.soundHud.catButtonPanel.slotButton.visible)
               {
                  SoundSystem.PlaySound("blip");
               }
               ++this.counter_2;
               if(this.counter_2 >= 8)
               {
               }
            }
            if(counter3 > 180)
            {
               level.hud.startCutscene();
               level.soundHud.hideCatButton();
               this.condition_2 = true;
               this.container.touchable = false;
               this.alpha_counter1 = 0;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 12)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_6"),this.redTomo,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 14)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_7"),this.redTomo,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 16)
         {
            Utils.ShopIndex = -1;
            Utils.LAST_SHOP_MENU = 0;
            Utils.ShopOn = true;
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 17)
         {
            if(Utils.ShopOn == false)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_8"),this.redTomo,this.advance,20);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 19)
         {
            stateMachine.performAction("END_ACTION");
            counter1 = 0;
            ++PROGRESSION;
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
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.initState();
         this.container = new Sprite();
         Utils.rootMovie.addChild(this.container);
         this.container.touchable = false;
         this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
         this.darkCircleSprite = new BigDarkCircleSprite();
         if(Utils.IS_IPHONE_X)
         {
            this.darkCircleSprite.gfxHandleClip().gotoAndStop(2);
         }
         else
         {
            this.darkCircleSprite.gfxHandleClip().gotoAndStop(1);
         }
         this.container.addChild(this.darkCircleSprite);
         this.darkCircleSprite.x = this.darkCircleSprite.y = 0;
         this.darkPanel1 = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         this.container.addChild(this.darkPanel1);
         this.darkPanel1.x = this.darkCircleSprite.x + this.darkCircleSprite.width;
         this.darkPanel1.y = 0;
         this.darkPanel1.width = Utils.SCREEN_WIDTH;
         this.darkPanel1.height = Utils.SCREEN_HEIGHT + 2;
         this.darkPanel2 = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         this.container.addChild(this.darkPanel2);
         this.darkPanel2.x = 0;
         this.darkPanel2.y = this.darkCircleSprite.y + this.darkCircleSprite.height;
         this.darkPanel2.width = this.darkCircleSprite.width;
         this.darkPanel2.height = Utils.SCREEN_HEIGHT;
         this.darkCircleSprite.alpha = this.darkPanel1.alpha = this.darkPanel2.alpha = 0;
         this.alpha_counter1 = this.alpha_value = 0;
         this.hero = level.hero;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is ShopNPC)
               {
                  this.redTomo = level.npcsManager.npcs[i] as ShopNPC;
               }
            }
         }
         this.condition_1 = false;
         this.condition_2 = false;
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         Utils.Slot.gameProgression[2] = 1;
         SaveManager.SaveGameProgression();
      }
   }
}
