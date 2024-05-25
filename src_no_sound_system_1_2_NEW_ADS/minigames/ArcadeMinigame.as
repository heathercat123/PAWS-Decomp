package minigames
{
   import game_utils.GameSlot;
   import sprites.minigames.GenericMinigameSprite;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.KeyboardEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class ArcadeMinigame extends Minigame
   {
       
      
      protected var background_image:Image;
      
      protected var cabinet_panel:Sprite;
      
      protected var cabinet_image_1:Image;
      
      protected var cabinet_image_2:Image;
      
      protected var cabinet_image_3:Image;
      
      protected var cabinet_image_4:Image;
      
      protected var cabinet_decorations:Vector.<Image>;
      
      protected var scanlines:Image;
      
      protected var BLOCK_INPUT:Boolean;
      
      protected var leftPressed:Boolean;
      
      protected var rightPressed:Boolean;
      
      protected var POINTS:int;
      
      protected var pointsImages:Vector.<GenericMinigameSprite>;
      
      protected var recordImages:Vector.<GenericMinigameSprite>;
      
      protected var leftArrow:GenericMinigameSprite;
      
      protected var rightArrow:GenericMinigameSprite;
      
      protected var fireButton:Button;
      
      public var touches:Vector.<Touch>;
      
      public var wasLastLeft:Boolean;
      
      public var wasLastRight:Boolean;
      
      protected var input_center:Number;
      
      public function ArcadeMinigame()
      {
         super();
         Utils.world.x = int((Utils.WIDTH - 192) * 0.5);
         this.POINTS = 0;
         this.BLOCK_INPUT = true;
         this.leftPressed = this.rightPressed = false;
         this.wasLastLeft = this.wasLastRight = false;
         this.touches = null;
         if(Utils.IS_ON_WINDOWS)
         {
            Utils.rootStage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
            Utils.rootStage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpListener);
         }
         else
         {
            Starling.current.touchProcessor.cancelTouches();
            Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
         }
      }
      
      protected function initControllers() : void
      {
         if(Utils.IS_IPHONE_X)
         {
            additional_x_margin = 16;
            additional_y_margin = -2;
         }
         else
         {
            additional_x_margin = -4;
            additional_y_margin = -3;
         }
         this.fireButton = new Button(TextureManager.minigamesTextureAtlas.getTexture("action_button_up"),"",TextureManager.minigamesTextureAtlas.getTexture("action_button_down"));
         Image(Sprite(this.fireButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.fireButton.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - (this.fireButton.width + additional_x_margin + 2)) + 16 + 32;
         this.fireButton.y = int(Utils.SCREEN_HEIGHT * Utils.GFX_INV_SCALE - (this.fireButton.height + additional_y_margin + 4)) + 16 + 32;
         Utils.gameMovie.addChild(this.fireButton);
         this.fireButton.addEventListener(TouchEvent.TOUCH,this.fireButtonClickHandler);
         this.leftArrow = new GenericMinigameSprite(GenericMinigameSprite.SPRITE_HUD_ARROW);
         this.rightArrow = new GenericMinigameSprite(GenericMinigameSprite.SPRITE_HUD_ARROW);
         this.rightArrow.scaleX = -1;
         this.leftArrow.gotoAndStop(1);
         this.leftArrow.gfxHandleClip().gotoAndStop(1);
         this.rightArrow.gotoAndStop(1);
         this.rightArrow.gfxHandleClip().gotoAndStop(1);
         this.leftArrow.touchable = false;
         this.rightArrow.touchable = false;
         this.leftArrow.alpha = 0.5;
         this.rightArrow.alpha = 0.5;
         this.fireButton.alpha = 0.5;
         this.leftArrow.x = additional_x_margin + this.leftArrow.width * 0.5 - 8;
         this.rightArrow.x = this.leftArrow.x + 48;
         this.leftArrow.y = this.rightArrow.y = this.fireButton.y + 40 + 32;
         this.input_center = (this.rightArrow.x + this.leftArrow.x) * 0.5 * Utils.GFX_SCALE;
         Utils.gameMovie.addChild(this.leftArrow);
         Utils.gameMovie.addChild(this.rightArrow);
         this.leftArrow.updateScreenPosition();
         this.rightArrow.updateScreenPosition();
         pauseButtonOnTop();
      }
      
      override public function init() : void
      {
         var i:int = 0;
         var image:Image = null;
         var genericSprite:GenericMinigameSprite = null;
         super.init();
         this.background_image = new Image(TextureManager.minigamesTextureAtlas.getTexture("pitch_black_quad"));
         this.background_image.width = Utils.WIDTH + 1;
         this.background_image.height = Utils.HEIGHT + 1;
         Utils.gameMovie.addChild(this.background_image);
         this.scanlines = new Image(TextureManager.minigamesTextureAtlas.getTexture("scanlines"));
         this.scanlines.width = Utils.WIDTH + 1;
         Utils.gameMovie.addChild(this.scanlines);
         this.scanlines.alpha = 0.25;
         this.cabinet_panel = new Sprite();
         Utils.gameMovie.addChild(this.cabinet_panel);
         this.cabinet_image_1 = new Image(TextureManager.minigamesTextureAtlas.getTexture("cabinet_image_2"));
         this.cabinet_image_2 = new Image(TextureManager.minigamesTextureAtlas.getTexture("cabinet_image_1"));
         this.cabinet_image_3 = new Image(TextureManager.minigamesTextureAtlas.getTexture("cabinet_image_1"));
         this.cabinet_image_4 = new Image(TextureManager.minigamesTextureAtlas.getTexture("cabinet_image_2"));
         this.cabinet_image_1.touchable = this.cabinet_image_2.touchable = this.cabinet_image_3.touchable = this.cabinet_image_4.touchable = false;
         this.cabinet_image_1.width = this.cabinet_image_4.width = 248;
         this.cabinet_image_1.height = this.cabinet_image_2.height = this.cabinet_image_3.height = this.cabinet_image_4.height = Utils.HEIGHT + 8;
         this.cabinet_panel.addChild(this.cabinet_image_1);
         this.cabinet_panel.addChild(this.cabinet_image_2);
         this.cabinet_panel.addChild(this.cabinet_image_3);
         this.cabinet_panel.addChild(this.cabinet_image_4);
         this.cabinet_image_2.x = 248;
         this.cabinet_image_3.scaleX = -1;
         this.cabinet_image_3.x = 256 + 192 + 8;
         this.cabinet_image_4.x = 256 + 192 + 8;
         this.cabinet_panel.pivotX = int(this.cabinet_panel.width * 0.5);
         this.cabinet_panel.x = int(Utils.WIDTH * 0.5);
         this.cabinet_decorations = new Vector.<Image>();
         for(i = 0; i < 5; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("cabinet_decoration_1"));
            image.touchable = false;
            image.pivotX = int(image.width * 0.5);
            image.x = 256 - 40;
            image.y = 48 + i * 8;
            this.cabinet_panel.addChild(image);
            this.cabinet_decorations.push(image);
         }
         for(i = 0; i < 5; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("cabinet_decoration_1"));
            image.touchable = false;
            image.pivotX = int(image.width * 0.5);
            image.x = 256 + 192 + 40;
            image.y = 48 + i * 8;
            this.cabinet_panel.addChild(image);
            this.cabinet_decorations.push(image);
         }
         this.pointsImages = new Vector.<GenericMinigameSprite>();
         for(i = 0; i < 6; i++)
         {
            genericSprite = new GenericMinigameSprite(GenericMinigameSprite.SPRITE_DIGITS);
            genericSprite.gotoAndStop(1);
            genericSprite.gfxHandleClip().gotoAndStop(0);
            this.pointsImages.push(genericSprite);
            Utils.topWorld.addChild(genericSprite);
            genericSprite.x = Utils.world.x + i * 8;
            genericSprite.y = 0;
            genericSprite.updateScreenPosition();
         }
         this.recordImages = new Vector.<GenericMinigameSprite>();
         for(i = 0; i < 6; i++)
         {
            genericSprite = new GenericMinigameSprite(GenericMinigameSprite.SPRITE_DIGITS);
            genericSprite.gotoAndStop(1);
            genericSprite.gfxHandleClip().gotoAndStop(0);
            this.recordImages.push(genericSprite);
            Utils.topWorld.addChild(genericSprite);
            genericSprite.x = Utils.world.x + i * 8 + 192 - 48;
            genericSprite.y = 0;
            genericSprite.updateScreenPosition();
         }
         this.initControllers();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
         Utils.gameMovie.setChildIndex(this.background_image,0);
         if(this.POINTS >= 999999)
         {
            this.POINTS = 999999;
         }
         var current_points:String = "" + this.POINTS;
         var formatted_string:* = "";
         for(i = 0; i < 6 - current_points.length; i++)
         {
            formatted_string += "0";
         }
         formatted_string += current_points;
         for(i = 0; i < this.pointsImages.length; i++)
         {
            this.pointsImages[i].gfxHandleClip().gotoAndStop(formatted_string.charCodeAt(i) - 48 + 1);
         }
         var current_record:String = "" + Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_1_RECORD];
         if(Utils.MINIGAME_ID == 2)
         {
            current_record = "" + Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_2_RECORD];
         }
         formatted_string = "";
         for(i = 0; i < 6 - current_record.length; i++)
         {
            formatted_string += "0";
         }
         formatted_string += current_record;
         for(i = 0; i < this.recordImages.length; i++)
         {
            this.recordImages[i].gfxHandleClip().gotoAndStop(formatted_string.charCodeAt(i) - 48 + 1);
         }
      }
      
      protected function processInput() : void
      {
         var i:int = 0;
         if(Utils.IS_ON_WINDOWS)
         {
            return;
         }
         this.rightPressed = this.leftPressed = false;
         if(this.BLOCK_INPUT)
         {
            return;
         }
         var isLastLeft:Boolean = false;
         var isLastRight:Boolean = false;
         if(this.touches != null)
         {
            for(i = 0; i < this.touches.length; i++)
            {
               if(this.touches[i] != null)
               {
                  if(this.touches[i].phase != "ended")
                  {
                     if(this.touches[i].globalX <= this.input_center)
                     {
                        isLastRight = false;
                        isLastLeft = true;
                     }
                     else if(this.touches[i].globalX <= Utils.SCREEN_WIDTH * 0.65)
                     {
                        isLastRight = true;
                        isLastLeft = false;
                     }
                  }
               }
            }
         }
         this.leftArrow.gfxHandleClip().gotoAndStop(1);
         this.rightArrow.gfxHandleClip().gotoAndStop(1);
         if(isLastRight)
         {
            this.rightArrow.gfxHandleClip().gotoAndStop(2);
            this.leftArrow.gfxHandleClip().gotoAndStop(1);
            this.rightPressed = true;
            if(!this.wasLastRight)
            {
               this.rightKeyPressed();
            }
         }
         if(isLastLeft)
         {
            this.rightArrow.gfxHandleClip().gotoAndStop(1);
            this.leftArrow.gfxHandleClip().gotoAndStop(2);
            this.leftPressed = true;
            if(!this.wasLastLeft)
            {
               this.leftKeyPressed();
            }
         }
         this.wasLastLeft = this.leftPressed;
         this.wasLastRight = this.rightPressed;
      }
      
      protected function fireButtonClickHandler(event:TouchEvent) : void
      {
         if(this.BLOCK_INPUT)
         {
            return;
         }
         var touch:Touch = event.getTouch(this.fireButton,TouchPhase.BEGAN);
         if(touch)
         {
            this.spaceKeyPressed();
         }
      }
      
      public function onClick(event:TouchEvent) : void
      {
         if(this.BLOCK_INPUT)
         {
            return;
         }
         this.touches = event.getTouches(Utils.rootStage);
      }
      
      protected function keyDownListener(event:KeyboardEvent) : void
      {
         if(this.BLOCK_INPUT)
         {
            return;
         }
         switch(event.keyCode)
         {
            case Utils.KEY_LEFT:
            case 65:
            case 97:
               if(!this.leftPressed)
               {
                  this.leftPressed = true;
                  this.leftKeyPressed();
               }
               break;
            case Utils.KEY_RIGHT:
            case 68:
            case 100:
               if(!this.rightPressed)
               {
                  this.rightPressed = true;
                  this.rightKeyPressed();
               }
               break;
            case Utils.KEY_SPACE:
               this.spaceKeyPressed();
         }
      }
      
      protected function keyUpListener(event:KeyboardEvent) : void
      {
         if(this.BLOCK_INPUT)
         {
            return;
         }
         switch(event.keyCode)
         {
            case Utils.KEY_LEFT:
            case 65:
            case 97:
               this.leftPressed = false;
               this.leftKeyReleased();
               break;
            case Utils.KEY_RIGHT:
            case 68:
            case 100:
               this.rightPressed = false;
               this.rightKeyReleased();
               break;
            case Utils.KEY_SPACE:
               this.spaceKeyReleased();
         }
      }
      
      protected function leftKeyPressed() : void
      {
      }
      
      protected function leftKeyReleased() : void
      {
      }
      
      protected function rightKeyPressed() : void
      {
      }
      
      protected function rightKeyReleased() : void
      {
      }
      
      protected function spaceKeyPressed() : void
      {
      }
      
      protected function spaceKeyReleased() : void
      {
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(Utils.IS_ON_WINDOWS)
         {
            Utils.rootStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
            Utils.rootStage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpListener);
         }
         else
         {
            Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         }
         this.touches = null;
         Utils.gameMovie.removeChild(this.leftArrow);
         Utils.gameMovie.removeChild(this.rightArrow);
         this.leftArrow.destroy();
         this.rightArrow.destroy();
         this.leftArrow.dispose();
         this.rightArrow.dispose();
         this.leftArrow = null;
         this.rightArrow = null;
         Utils.gameMovie.removeChild(this.fireButton);
         this.fireButton.dispose();
         this.fireButton.removeEventListener(TouchEvent.TOUCH,this.fireButtonClickHandler);
         for(i = 0; i < this.cabinet_decorations.length; i++)
         {
            this.cabinet_panel.removeChild(this.cabinet_decorations[i]);
            this.cabinet_decorations[i].dispose();
            this.cabinet_decorations[i] = null;
         }
         this.cabinet_decorations = null;
         for(i = 0; i < this.recordImages.length; i++)
         {
            Utils.topWorld.removeChild(this.recordImages[i]);
            this.recordImages[i].destroy();
            this.recordImages[i].dispose();
            this.recordImages[i] = null;
         }
         this.recordImages = null;
         for(i = 0; i < this.pointsImages.length; i++)
         {
            Utils.topWorld.removeChild(this.pointsImages[i]);
            this.pointsImages[i].destroy();
            this.pointsImages[i].dispose();
            this.pointsImages[i] = null;
         }
         this.pointsImages = null;
         this.cabinet_panel.removeChild(this.cabinet_image_4);
         this.cabinet_panel.removeChild(this.cabinet_image_3);
         this.cabinet_panel.removeChild(this.cabinet_image_2);
         this.cabinet_panel.removeChild(this.cabinet_image_1);
         this.cabinet_image_4.dispose();
         this.cabinet_image_3.dispose();
         this.cabinet_image_2.dispose();
         this.cabinet_image_1.dispose();
         this.cabinet_image_4 = this.cabinet_image_3 = this.cabinet_image_2 = this.cabinet_image_1 = null;
         Utils.gameMovie.removeChild(this.cabinet_panel);
         this.cabinet_panel = null;
         Utils.gameMovie.removeChild(this.background_image);
         this.background_image.dispose();
         this.background_image = null;
         super.destroy();
      }
   }
}
