package levels.backgrounds
{
   import entities.Entity;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.DarkSmallSpotCollisionSprite;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.extensions.pixelmask.PixelMaskDisplayObject;
   
   public class DarkManager
   {
       
      
      public var level:Level;
      
      public var stateMachine:StateMachine;
      
      public var topSpotlightImage:Image;
      
      public var maskContainer:Sprite;
      
      public var spotlightImage:DarkSmallSpotCollisionSprite;
      
      public var topLeft:Image;
      
      public var bottomRight:Image;
      
      public var pixelMaskObject:PixelMaskDisplayObject;
      
      public var topDarkImage:Image;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var sin_counter_3:Number;
      
      protected var sin_counter_4:Number;
      
      protected var sin_speed_1:Number;
      
      protected var sin_speed_2:Number;
      
      protected var sin_speed_3:Number;
      
      protected var sin_speed_4:Number;
      
      public var backgroundQuad:Quad;
      
      public var bottomShadowQuad:Quad;
      
      public var sxShadowQuad:Quad;
      
      public var dxShadowQuad:Quad;
      
      protected var counter1:int;
      
      protected var offset_x:Number;
      
      protected var IS_CHILD_ADDED:Boolean;
      
      protected var scaleSin:Number;
      
      public function DarkManager(_level:Level)
      {
         super();
         this.level = _level;
         this.offset_x = 0;
         this.scaleSin = 0;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.sin_counter_3 = Math.random() * Math.PI * 2;
         this.sin_counter_4 = Math.random() * Math.PI * 2;
         this.sin_speed_1 = Math.random() * 0.025 + 0.025;
         this.sin_speed_2 = Math.random() * 0.025 + 0.025;
         this.sin_speed_3 = Math.random() * 0.025 + 0.025;
         this.sin_speed_4 = Math.random() * 0.025 + 0.025;
         this.initImages();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","FADE_IN_ACTION","IS_FADING_IN_STATE");
         this.stateMachine.setRule("IS_FADING_IN_STATE","END_ACTION","IS_ON_STATE");
         this.stateMachine.setRule("IS_ON_STATE","FADE_OUT_ACTION","IS_FADING_OUT_STATE");
         this.stateMachine.setRule("IS_FADING_OUT_STATE","END_ACTION","IS_OFF_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offAnimation);
         this.stateMachine.setFunctionToState("IS_FADING_IN_STATE",this.fadingInAnimation);
         this.stateMachine.setFunctionToState("IS_ON_STATE",this.onAnimation);
         this.stateMachine.setFunctionToState("IS_FADING_OUT_STATE",this.fadingOutAnimation);
         if(Utils.IS_DARK)
         {
            this.stateMachine.setState("IS_ON_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_OFF_STATE");
         }
      }
      
      public function destroy() : void
      {
         this.pixelMaskObject.removeChild(this.topDarkImage);
         if(this.IS_CHILD_ADDED)
         {
            Utils.darkWorld.removeChild(this.pixelMaskObject);
         }
         this.pixelMaskObject = null;
         this.maskContainer.removeChild(this.bottomRight);
         this.maskContainer.removeChild(this.topLeft);
         this.bottomRight.dispose();
         this.topLeft.dispose();
         this.bottomRight = null;
         this.topLeft = null;
         this.maskContainer.removeChild(this.spotlightImage);
         this.spotlightImage.destroy();
         this.spotlightImage.dispose();
         this.spotlightImage = null;
         this.maskContainer = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var isHeroTurning:Boolean = false;
         if(this.level.hero.stateMachine.currentState == "IS_TURNING_STATE" || this.level.hero.stateMachine.currentState == "IS_TURNING_WALKING_STATE")
         {
            isHeroTurning = true;
         }
         if(this.level.hero.stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
         {
            if(this.offset_x > 0)
            {
               this.offset_x -= 2;
            }
            else if(this.offset_x < 0)
            {
               this.offset_x += 2;
            }
         }
         else if(this.level.hero.DIRECTION == Entity.RIGHT || isHeroTurning && this.level.hero.DIRECTION == Entity.LEFT)
         {
            this.offset_x += 6;
            if(this.offset_x >= 32)
            {
               this.offset_x = 32;
            }
         }
         else if(this.level.hero.DIRECTION == Entity.LEFT || isHeroTurning && this.level.hero.DIRECTION == Entity.RIGHT)
         {
            this.offset_x -= 6;
            if(this.offset_x <= -32)
            {
               this.offset_x = -32;
            }
         }
         if(this.stateMachine.currentState == "IS_FADING_OUT_STATE")
         {
            this.pixelMaskObject.pixelMask = this.maskContainer;
            ++this.counter1;
            if(this.counter1 > 10)
            {
               this.counter1 = 0;
               this.pixelMaskObject.alpha -= 0.5;
               if(this.pixelMaskObject.alpha <= 0)
               {
                  this.pixelMaskObject.alpha = 0;
                  this.pixelMaskObject.visible = false;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_FADING_IN_STATE")
         {
            this.pixelMaskObject.pixelMask = this.maskContainer;
            ++this.counter1;
            if(this.counter1 > 2)
            {
               this.counter1 = 0;
               this.pixelMaskObject.alpha += 0.5;
               if(this.pixelMaskObject.alpha >= 1)
               {
                  this.pixelMaskObject.alpha = 1;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_ON_STATE")
         {
            this.pixelMaskObject.pixelMask = this.maskContainer;
         }
         this.scaleSin += 0.1;
         if(this.scaleSin > Math.PI * 2)
         {
            this.scaleSin -= Math.PI * 2;
         }
         this.spotlightImage.scaleX = this.spotlightImage.scaleY = 1 + Math.sin(this.scaleSin) * 0.02;
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         this.spotlightImage.y = int(Math.floor(this.level.hero.getMidYPos() - camera.yPos));
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 71)
         {
            this.spotlightImage.gotoAndStop(2);
            this.spotlightImage.x = int(Math.floor(this.level.hero.getMidXPos() + this.offset_x - camera.xPos));
         }
         else
         {
            this.spotlightImage.x = int(Math.floor(this.level.hero.getMidXPos() - camera.xPos));
            this.spotlightImage.gotoAndStop(3);
         }
         this.spotlightImage.updateScreenPosition();
         this.topDarkImage.x = this.topDarkImage.y = 0;
         this.topDarkImage.width = Utils.WIDTH;
         this.topDarkImage.height = Utils.HEIGHT;
         this.topLeft.x = -1;
         this.topLeft.y = -1;
         this.bottomRight.x = Utils.WIDTH + 1;
         this.bottomRight.y = Utils.HEIGHT + 1;
      }
      
      public function turnOn() : void
      {
         SoundSystem.PlaySound("dark");
         this.stateMachine.performAction("FADE_IN_ACTION");
         this.backgroundQuad.visible = true;
         this.bottomShadowQuad.visible = true;
         this.sxShadowQuad.visible = true;
         this.dxShadowQuad.visible = true;
         if(!this.IS_CHILD_ADDED)
         {
            Utils.darkWorld.addChild(this.pixelMaskObject);
            this.IS_CHILD_ADDED = true;
         }
      }
      
      public function turnOff() : void
      {
         SoundSystem.PlaySound("dark");
         this.stateMachine.performAction("FADE_OUT_ACTION");
      }
      
      public function offAnimation() : void
      {
         this.counter1 = 0;
         this.pixelMaskObject.alpha = 0;
         this.pixelMaskObject.visible = false;
         if(this.IS_CHILD_ADDED)
         {
            Utils.darkWorld.removeChild(this.pixelMaskObject);
            this.IS_CHILD_ADDED = false;
         }
      }
      
      public function fadingInAnimation() : void
      {
         this.counter1 = 0;
         this.pixelMaskObject.alpha = 0;
         this.pixelMaskObject.visible = true;
      }
      
      public function onAnimation() : void
      {
         this.counter1 = 0;
         this.pixelMaskObject.alpha = 1;
         this.pixelMaskObject.visible = true;
         if(!this.IS_CHILD_ADDED)
         {
            Utils.darkWorld.addChild(this.pixelMaskObject);
            this.IS_CHILD_ADDED = true;
         }
      }
      
      public function fadingOutAnimation() : void
      {
         this.counter1 = 0;
         this.pixelMaskObject.alpha = 1;
         this.pixelMaskObject.visible = true;
      }
      
      protected function initImages() : void
      {
         this.IS_CHILD_ADDED = false;
         this.spotlightImage = new DarkSmallSpotCollisionSprite();
         this.maskContainer = new Sprite();
         this.maskContainer.addChild(this.spotlightImage);
         this.topDarkImage = new Image(TextureManager.sTextureAtlas.getTexture("dark_shade_1"));
         this.topLeft = new Image(TextureManager.sTextureAtlas.getTexture("dark_shade_1"));
         this.bottomRight = new Image(TextureManager.sTextureAtlas.getTexture("dark_shade_1"));
         this.topLeft.width = this.bottomRight.width = this.topLeft.height = this.bottomRight.height = 1;
         this.topDarkImage.touchable = this.topLeft.touchable = this.bottomRight.touchable = false;
         this.maskContainer.addChild(this.topLeft);
         this.maskContainer.addChild(this.bottomRight);
         this.pixelMaskObject = new PixelMaskDisplayObject();
         this.pixelMaskObject.addChild(this.topDarkImage);
         this.pixelMaskObject.pixelMask = this.maskContainer;
         this.pixelMaskObject.inverted = true;
         var SIZE:Number = 0.25;
      }
   }
}
