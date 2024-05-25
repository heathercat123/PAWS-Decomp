package interfaces.panels.fading
{
   import game_utils.StateMachine;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class RedPanel extends Sprite
   {
      
      public static const LEFT_RIGHT:int = 2;
      
      public static const RIGHT_LEFT:int = 3;
      
      public static const FADE_OUT:String = "IS_FADE_OUT_STATE";
      
      public static const FADE_IN:String = "IS_FADE_IN_STATE";
       
      
      public var SIDE:int;
      
      public var STATE:String;
      
      private var INIT:Boolean;
      
      private var TWEEN_COMPLETE:Boolean;
      
      private var container:Sprite;
      
      private var images:Array;
      
      private var full:Image;
      
      private var ver_steps:int;
      
      private var tick_time_in:Number;
      
      private var tick_time_out:Number;
      
      public var stateMachine:StateMachine;
      
      public function RedPanel(_SIDE:int, _STATE:String, _time_out:Number, _time_in:Number)
      {
         super();
         this.SIDE = _SIDE;
         this.STATE = _STATE;
         this.INIT = false;
         this.TWEEN_COMPLETE = false;
         this.tick_time_in = _time_in;
         this.tick_time_out = _time_out;
         this.init();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_FADE_OUT_STATE","START_ACTION","IS_ENTERING_STATE");
         this.stateMachine.setRule("IS_ENTERING_STATE","END_ACTION","IS_FADE_IN_STATE");
         this.stateMachine.setRule("IS_FADE_IN_STATE","START_ACTION","IS_EXITING_STATE");
         this.stateMachine.setRule("IS_EXITING_STATE","END_ACTION","IS_FADE_OUT_STATE");
         this.stateMachine.setFunctionToState("IS_FADE_OUT_STATE",this.fadeOutState);
         this.stateMachine.setFunctionToState("IS_ENTERING_STATE",this.enterState);
         this.stateMachine.setFunctionToState("IS_FADE_IN_STATE",this.fadeInState);
         this.stateMachine.setFunctionToState("IS_EXITING_STATE",this.exitState);
         this.stateMachine.setState(this.STATE);
      }
      
      public function startAnimation() : void
      {
         this.stateMachine.performAction("START_ACTION");
         if(this.stateMachine.currentState == "IS_ENTERING_STATE")
         {
            this.fadeOutTweens();
         }
         else if(this.stateMachine.currentState == "IS_EXITING_STATE")
         {
            this.fadeInTweens();
         }
      }
      
      public function update() : void
      {
         if(this.stateMachine.currentState != "IS_FADE_OUT_STATE")
         {
            if(this.stateMachine.currentState == "IS_ENTERING_STATE")
            {
               if(this.TWEEN_COMPLETE)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState != "IS_FADE_IN_STATE")
            {
               if(this.stateMachine.currentState == "IS_EXITING_STATE")
               {
                  if(this.TWEEN_COMPLETE)
                  {
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
      }
      
      protected function updateVertical() : void
      {
      }
      
      protected function updateHorizontal() : void
      {
      }
      
      protected function fadeOutState() : void
      {
         if(this.SIDE == RIGHT_LEFT)
         {
            this.container.scaleX = -1;
            this.container.x = Utils.WIDTH;
         }
         else
         {
            this.container.scaleX = 1;
            this.container.x = 0;
         }
      }
      
      protected function fadeOutTweens() : void
      {
         var tween:Tween = null;
         this.TWEEN_COMPLETE = false;
         if(this.SIDE == RIGHT_LEFT)
         {
            tween = new Tween(this.container,this.tick_time_out,Transitions.LINEAR);
            tween.moveTo(-16,this.container.y);
            tween.roundToInt = true;
            tween.onComplete = this.tweenCompleted;
            Starling.juggler.add(tween);
         }
         else
         {
            tween = new Tween(this.container,this.tick_time_out,Transitions.LINEAR);
            tween.moveTo(Utils.WIDTH + 16,this.container.y);
            tween.roundToInt = true;
            tween.onComplete = this.tweenCompleted;
            Starling.juggler.add(tween);
         }
      }
      
      protected function enterState() : void
      {
      }
      
      protected function fadeInState() : void
      {
         if(this.SIDE == RIGHT_LEFT)
         {
            this.container.scaleX = 1;
            this.container.x = Utils.WIDTH + 16;
         }
         else
         {
            this.container.scaleX = -1;
            this.container.x = -16;
         }
      }
      
      protected function fadeInTweens() : void
      {
         var tween:Tween = null;
         this.TWEEN_COMPLETE = false;
         if(this.SIDE == RIGHT_LEFT)
         {
            tween = new Tween(this.container,this.tick_time_in,Transitions.LINEAR);
            tween.moveTo(0,this.container.y);
            tween.roundToInt = true;
            tween.onComplete = this.tweenCompleted;
            Starling.juggler.add(tween);
         }
         else
         {
            tween = new Tween(this.container,this.tick_time_in,Transitions.LINEAR);
            tween.moveTo(Utils.WIDTH,this.container.y);
            tween.roundToInt = true;
            tween.onComplete = this.tweenCompleted;
            Starling.juggler.add(tween);
         }
      }
      
      protected function exitState() : void
      {
      }
      
      protected function tweenCompleted() : void
      {
         this.TWEEN_COMPLETE = true;
      }
      
      protected function init() : void
      {
         var i:int = 0;
         var image:Image = null;
         this.container = new Sprite();
         addChild(this.container);
         this.container.x = this.container.y = 0;
         this.ver_steps = int(Utils.HEIGHT / 24) + 1;
         this.images = new Array();
         for(i = 0; i < this.ver_steps; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("faderElement1"));
            this.container.addChild(image);
            image.x = -image.width;
            image.y = i * image.height;
            this.images.push(image);
         }
         var diff:Number = this.container.height - Utils.HEIGHT;
         this.container.y -= int(diff * 0.5);
         this.full = new Image(TextureManager.hudTextureAtlas.getTexture("redQuad"));
         this.full.width = Utils.WIDTH;
         this.full.height = Utils.HEIGHT + diff;
         this.full.x = -(this.full.width + image.width);
         this.full.y = 0;
         this.container.addChild(this.full);
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.container.removeChild(this.full);
         this.full.dispose();
         this.full = null;
         for(i = 0; i < this.images.length; i++)
         {
            this.container.removeChild(this.images[i]);
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.images = null;
         removeChild(this.container);
         this.container.dispose();
         this.container = null;
      }
   }
}
