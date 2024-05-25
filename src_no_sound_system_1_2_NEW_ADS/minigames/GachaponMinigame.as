package minigames
{
   import game_utils.AchievementsManager;
   import game_utils.LevelItems;
   import interfaces.panels.LightSourceGacha;
   import sprites.minigames.GachaBallSprite;
   import sprites.minigames.GachaToySprite;
   import starling.display.BlendMode;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class GachaponMinigame extends Minigame
   {
       
      
      protected var backgroundContainer:Sprite;
      
      protected var backgroundImages:Vector.<Image>;
      
      protected var whiteFade:Image;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var counter_3:int;
      
      protected var bg_counter_1:int;
      
      protected var bounce_amoun:*;
      
      protected var toySprite:GachaToySprite;
      
      protected var bigBall:GachaBallSprite;
      
      protected var lightSource:LightSourceGacha;
      
      protected var bigBallLight:Image;
      
      protected var bigBall_xPos:Number;
      
      protected var bigBall_yPos:Number;
      
      protected var bigBall_xVel:Number;
      
      protected var bigBall_yVel:Number;
      
      protected var gravity:Number;
      
      protected var drop_ball_frame:Number;
      
      protected var drop_ball_speed:Number;
      
      protected var bounce_sin:Number;
      
      protected var scale_mult:Number;
      
      protected var bounce_amounts:int;
      
      protected var tap_amount:int;
      
      protected var tap_to_reach:int;
      
      protected var CURRENT_STATE:int;
      
      public function GachaponMinigame()
      {
         super();
         this.CURRENT_STATE = 0;
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.bg_counter_1 = 0;
         this.tap_to_reach = 5;
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.tapGachaHandler);
      }
      
      override public function init() : void
      {
         super.init();
         this.initGachaBackground();
         this.bounce_sin = this.gravity = this.tap_amount = this.bounce_amounts = this.drop_ball_speed = 0;
         this.scale_mult = 1;
         this.bigBall_xPos = Utils.WIDTH * 0.5;
         this.bigBall_yPos = -64;
         this.bigBall_xVel = this.bigBall_yVel = this.gravity = 0;
         this.drop_ball_frame = int(Math.random() * 64);
         this.bigBall = new GachaBallSprite(int(Math.random() * 4));
         this.bigBall.gfxHandleClip().gotoAndStop(this.drop_ball_frame + 1);
         this.bigBallLight = new Image(TextureManager.gacha1TextureAtlas.getTexture("light_1"));
         this.bigBallLight.touchable = false;
         this.bigBallLight.pivotX = this.bigBallLight.pivotY = 16;
         this.toySprite = new GachaToySprite(Utils.GACHA_INDEX);
         this.toySprite.x = int(Utils.WIDTH * 0.5);
         this.toySprite.y = int(Utils.HEIGHT * 0.5);
         this.toySprite.visible = false;
         this.lightSource = new LightSourceGacha(Utils.WIDTH * 0.5,Utils.HEIGHT * 0.5,Utils.WIDTH * 0.5);
         this.lightSource.x = int(Utils.WIDTH * 0.5);
         this.lightSource.y = int(Utils.HEIGHT * 0.5);
         this.lightSource.start();
         this.lightSource.visible = false;
         this.whiteFade = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.whiteFade.touchable = false;
         this.whiteFade.width = Utils.WIDTH;
         this.whiteFade.height = Utils.HEIGHT;
         this.whiteFade.visible = false;
         Utils.world.addChild(this.lightSource);
         Utils.world.addChild(this.bigBall);
         Utils.world.addChild(this.bigBallLight);
         Utils.world.addChild(this.toySprite);
         Utils.world.addChild(this.whiteFade);
         Utils.gameMovie.filter = new FragmentFilter();
         FragmentFilter(Utils.gameMovie.filter).resolution = Utils.GFX_INV_SCALE;
         FragmentFilter(Utils.gameMovie.filter).textureSmoothing = TextureSmoothing.NONE;
      }
      
      override public function update() : void
      {
         super.update();
         if(this.CURRENT_STATE == 0)
         {
            ++this.counter_1;
            if(this.counter_1 >= 2)
            {
               this.gravity = 0.5;
            }
         }
         else if(this.CURRENT_STATE == 1)
         {
            if(this.counter_1-- < 0)
            {
               this.bounce_sin += 0.5;
               this.bigBall.scaleX = 1 + Math.cos(this.bounce_sin + Math.PI * 0.5) * 0.05 * this.scale_mult;
               this.bigBall.scaleY = 1 + Math.sin(this.bounce_sin) * 0.05 * this.scale_mult;
               if(this.bounce_sin >= Math.PI * 2)
               {
                  this.counter_1 = (Math.random() * 2 + 2) * 30;
                  this.bounce_sin = 0;
                  this.bigBall.scaleX = this.bigBall.scaleY = 1;
               }
            }
            this.scale_mult *= 0.8;
            if(this.scale_mult <= 1)
            {
               this.scale_mult = 1;
            }
         }
         else if(this.CURRENT_STATE == 2 || this.CURRENT_STATE == 3)
         {
            this.bigBall.visible = false;
            this.bigBallLight.visible = false;
            this.toySprite.visible = true;
            this.lightSource.visible = true;
            if(this.whiteFade.visible)
            {
               if(this.counter_3++ > 8)
               {
                  if(this.counter_2++ > 0)
                  {
                     this.counter_2 = 0;
                     this.whiteFade.alpha -= 0.2;
                     if(this.whiteFade.alpha <= 0)
                     {
                        this.whiteFade.visible = false;
                        SoundSystem.PlaySound("item_appear");
                     }
                  }
               }
            }
            if(this.CURRENT_STATE == 2)
            {
               if(this.counter_1++ >= 60)
               {
                  this.CURRENT_STATE = 3;
               }
            }
         }
         if(this.CURRENT_STATE >= 2)
         {
            this.lightSource.visible = true;
         }
         else
         {
            this.lightSource.visible = false;
         }
         this.lightSource.update();
         this.lightSource.blendMode = BlendMode.ADD;
         this.lightSource.alpha = 0.25;
         if(this.bounce_amounts >= 4)
         {
            this.gravity = 0;
            this.bigBall_yVel = 0;
            if(this.CURRENT_STATE == 0)
            {
               this.CURRENT_STATE = 1;
               this.counter_1 = this.counter_2 = this.counter_3 = 0;
            }
         }
         this.bigBall_xPos += this.bigBall_xVel;
         this.bigBall_yPos += this.bigBall_yVel;
         this.bigBall_yVel += this.gravity;
         if(this.bigBall_yVel >= 16)
         {
            this.bigBall_yVel = 16;
         }
         if(this.bigBall_yPos >= int(Utils.HEIGHT * 0.5 + 44))
         {
            this.bigBall_yPos = int(Utils.HEIGHT * 0.5 + 44);
            this.bigBall_yVel *= -0.5;
            ++this.bounce_amounts;
            if(this.bounce_amounts <= 4)
            {
               SoundSystem.PlaySound("item_impact_water");
            }
         }
         this.drop_ball_speed += Math.abs(this.bigBall_yVel * 0.05);
         this.drop_ball_speed *= 0.9;
         this.drop_ball_frame += this.drop_ball_speed;
         if(this.drop_ball_frame >= 64)
         {
            this.drop_ball_frame -= 64;
         }
         this.updateScreenPositions();
      }
      
      protected function updateScreenPositions() : void
      {
         if(this.bg_counter_1++ > 0)
         {
            this.bg_counter_1 = 0;
            --this.backgroundContainer.x;
            --this.backgroundContainer.y;
            if(this.backgroundContainer.x <= -64)
            {
               this.backgroundContainer.x = this.backgroundContainer.y = 0;
            }
         }
         this.bigBall.x = int(this.bigBall_xPos);
         this.bigBall.y = int(this.bigBall_yPos);
         this.bigBallLight.x = this.bigBall.x + 24;
         this.bigBallLight.y = this.bigBall.y - 64;
         this.bigBall.gfxHandleClip().gotoAndStop(this.drop_ball_frame + 1);
         this.lightSource.x = int(Utils.WIDTH * 0.5);
         this.lightSource.y = int(Utils.HEIGHT * 0.5);
      }
      
      public function tapGachaHandler(event:TouchEvent) : void
      {
         var touches:Vector.<Touch> = null;
         if(this.CURRENT_STATE == 0 || this.CURRENT_STATE == 2 || this.CURRENT_STATE == 4)
         {
            return;
         }
         try
         {
            touches = event.getTouches(Utils.rootStage);
            if(touches[touches.length - 1].phase == "began")
            {
               this.tap();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      protected function tap() : void
      {
         if(this.CURRENT_STATE == 3)
         {
            SoundSystem.PlaySound("select");
            GET_OUT_FLAG = true;
            this.CURRENT_STATE = 4;
         }
         else
         {
            ++this.tap_amount;
            this.counter_1 = 0;
            this.scale_mult = 2 * this.tap_amount;
            this.bounce_sin = 0;
            if(Math.random() * 100 > 50)
            {
               this.drop_ball_speed = 0.1 + Math.random() * 0.25;
            }
            else
            {
               this.drop_ball_speed = -(0.1 + Math.random() * 0.25);
            }
            if(this.tap_amount >= this.tap_to_reach)
            {
               SoundSystem.PlaySound("pot_pop");
               this.whiteFade.visible = true;
               this.CURRENT_STATE = 2;
               this.counter_1 = this.counter_2 = this.counter_3 = 0;
               if(Utils.Slot.playerInventory[LevelItems.ITEM_GACHA_1] >= 1048575)
               {
                  AchievementsManager.SubmitAchievement("sctp_9");
               }
            }
            else
            {
               SoundSystem.PlaySound("enemy_water");
            }
         }
      }
      
      protected function initGachaBackground() : void
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         var amount_w:int = int(Utils.WIDTH / 64) + 2;
         var amount_h:int = int(Utils.HEIGHT / 64) + 2;
         this.backgroundContainer = new Sprite();
         this.backgroundImages = new Vector.<Image>();
         for(i = 0; i < amount_w; i++)
         {
            for(j = 0; j < amount_h; j++)
            {
               image = new Image(TextureManager.minigamesTextureAtlas.getTexture("gacha_bg"));
               image.touchable = false;
               this.backgroundContainer.addChild(image);
               image.x = i * 64;
               image.y = j * 64;
               this.backgroundImages.push(image);
            }
         }
         Utils.backWorld.addChild(this.backgroundContainer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.FORCE_NOTIFICATION = 1;
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.tapGachaHandler);
         Utils.gameMovie.filter.dispose();
         Utils.gameMovie.filter = null;
         Utils.world.removeChild(this.lightSource);
         Utils.world.removeChild(this.bigBall);
         Utils.world.removeChild(this.bigBallLight);
         Utils.world.removeChild(this.toySprite);
         Utils.world.removeChild(this.whiteFade);
         this.lightSource.destroy();
         this.lightSource.dispose();
         this.lightSource = null;
         this.bigBall.destroy();
         this.bigBall.dispose();
         this.bigBall = null;
         this.bigBallLight.dispose();
         this.bigBallLight = null;
         this.toySprite.destroy();
         this.toySprite.dispose();
         this.toySprite = null;
         this.whiteFade.dispose();
         this.whiteFade = null;
         for(i = 0; i < this.backgroundImages.length; i++)
         {
            this.backgroundContainer.removeChild(this.backgroundImages[i]);
            this.backgroundImages[i].dispose();
            this.backgroundImages[i] = null;
         }
         this.backgroundImages = null;
         Utils.backWorld.removeChild(this.backgroundContainer);
         this.backgroundContainer.dispose();
         this.backgroundContainer = null;
         super.destroy();
      }
   }
}
