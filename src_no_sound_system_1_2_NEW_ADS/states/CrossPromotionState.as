package states
{
   import flash.desktop.NativeApplication;
   import flash.events.KeyboardEvent;
   import flash.net.*;
   import flash.ui.Keyboard;
   import game_utils.GameSlot;
   import interfaces.panels.CrossPromotionPanel;
   import levels.*;
   import levels.backgrounds.*;
   import neutronized.NeutronizedServices;
   import starling.display.Sprite;
   
   public class CrossPromotionState implements IState
   {
      
      protected static var checkCrossPromotion:Boolean = true;
       
      
      public var menuBackground:MenuBackground;
      
      public var GET_OUT_FLAG:Boolean;
      
      protected var justOnce:Boolean;
      
      public var choice:int;
      
      public var container:Sprite;
      
      public var crossPromotionPanel:CrossPromotionPanel;
      
      public function CrossPromotionState()
      {
         super();
      }
      
      public static function IsTimeForCrossPromotion() : Boolean
      {
         var internetAvailable:Boolean = true;
         if(NeutronizedServices.getInstance().crossPromotionXML != null)
         {
            if(NeutronizedServices.getInstance().crossPromotionXML.slot[0].__message != "")
            {
               Utils.AIR_MESSAGE = NeutronizedServices.getInstance().crossPromotionXML.slot[0].__message;
            }
         }
         if(CrossPromotionPanel.IMAGE_LOADED == false)
         {
            return false;
         }
         if(checkCrossPromotion && internetAvailable)
         {
            checkCrossPromotion = false;
            if(!Utils.CROSS_PROMOTION_SHOWN)
            {
               if(NeutronizedServices.getInstance().IsCrossPromotionAvailable())
               {
                  if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GAME_SESSIONS] > NeutronizedServices.getInstance().crossPromotionXML.startCrossPromotion)
                  {
                     ++Utils.Slot.gameVariables[GameSlot.VARIABLE_FREQ_CROSS_PROMOTION];
                     if(NeutronizedServices.getInstance().crossPromotionXML.frequencyCrossPromotion >= Utils.Slot.gameVariables[GameSlot.VARIABLE_FREQ_CROSS_PROMOTION])
                     {
                        Utils.CROSS_PROMOTION_SHOWN = true;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_FREQ_CROSS_PROMOTION] = 0;
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function enterState(game:Game) : void
      {
         game.enterCrossPromotionState();
         this.menuBackground = new MenuBackground();
         this.menuBackground.endIntro();
         this.crossPromotionPanel = new CrossPromotionPanel();
         this.crossPromotionPanel.popUp();
         this.GET_OUT_FLAG = false;
         this.justOnce = true;
         this.choice = -1;
         this.container = new Sprite();
         this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
         this.container.x = this.container.y = 0;
         Utils.rootMovie.addChild(this.container);
         this.container.addChild(this.crossPromotionPanel);
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
      }
      
      protected function onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == Keyboard.BACK)
         {
            event.preventDefault();
            event.stopImmediatePropagation();
            this.justOnce = false;
            this.GET_OUT_FLAG = true;
         }
      }
      
      public function updateState(game:Game) : void
      {
         this.menuBackground.update();
         this.crossPromotionPanel.update();
         if(this.crossPromotionPanel.GET_OUT_FLAG || this.crossPromotionPanel.CONTINUE_FLAG)
         {
            if(this.justOnce)
            {
               this.justOnce = false;
               this.GET_OUT_FLAG = true;
            }
         }
         game.updateCrossPromotionState();
      }
      
      public function exitState(game:Game) : void
      {
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         this.menuBackground.destroy();
         this.menuBackground = null;
         this.container.removeChild(this.crossPromotionPanel);
         this.crossPromotionPanel.destroy();
         this.crossPromotionPanel.dispose();
         this.crossPromotionPanel = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         game.exitCrossPromotionState();
      }
   }
}
