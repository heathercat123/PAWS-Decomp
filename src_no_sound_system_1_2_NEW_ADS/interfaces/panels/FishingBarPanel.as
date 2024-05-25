package interfaces.panels
{
   import entities.Easings;
   import game_utils.ColorUtil;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.*;
   import starling.display.*;
   
   public class FishingBarPanel extends Sprite
   {
       
      
      protected var level:Level;
      
      protected var innerContainer:Sprite;
      
      protected var barImage1:Image;
      
      protected var quad:Quad;
      
      public var WIDTH:Number;
      
      public var HEIGHT:Number;
      
      public var stateMachine:StateMachine;
      
      protected var xPos:Number;
      
      protected var yPos:Number;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      public var CASTING_POWER:Number;
      
      protected var sin_counter:Number;
      
      public function FishingBarPanel(_level:Level)
      {
         super();
         this.level = _level;
         this.counter_1 = this.counter_2 = 0;
         this.t_start = this.t_diff = this.t_tick = this.t_time = 0;
         this.sin_counter = 0;
         this.CASTING_POWER = 0;
         this.initImages();
         this.WIDTH = this.barImage1.width;
         this.HEIGHT = this.barImage1.height;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_GONE_STATE","START_ACTION","IS_CAST_APPEARING_STATE");
         this.stateMachine.setRule("IS_CAST_APPEARING_STATE","END_ACTION","IS_CASTING_STATE");
         this.stateMachine.setRule("IS_CASTING_STATE","END_ACTION","IS_CAST_DISAPPEARING_STATE");
         this.stateMachine.setFunctionToState("IS_GONE_STATE",this.goneState);
         this.stateMachine.setFunctionToState("IS_CAST_APPEARING_STATE",this.castAppearingState);
         this.stateMachine.setFunctionToState("IS_CASTING_STATE",this.castingState);
         this.stateMachine.setFunctionToState("IS_CAST_DISAPPEARING_STATE",this.castDisappearingState);
         this.stateMachine.setState("IS_GONE_STATE");
      }
      
      protected function initImages() : void
      {
         this.innerContainer = new Sprite();
         addChild(this.innerContainer);
         this.barImage1 = new Image(TextureManager.hudTextureAtlas.getTexture("fishing_bar_1"));
         this.barImage1.touchable = false;
         this.innerContainer.addChild(this.barImage1);
         this.quad = new Quad(16,10,16711680);
         this.innerContainer.addChild(this.quad);
         this.quad.x = this.quad.y = 6;
         this.xPos = int((Utils.WIDTH - this.barImage1.width) * 0.5);
         this.yPos = int(Utils.HEIGHT * 0.2);
      }
      
      public function destroy() : void
      {
         this.level = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.innerContainer.removeChild(this.quad);
         this.quad.dispose();
         this.quad = null;
         this.innerContainer.removeChild(this.barImage1);
         this.barImage1.dispose();
         this.barImage1 = null;
         removeChild(this.innerContainer);
         this.innerContainer.dispose();
         this.innerContainer = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         if(this.stateMachine.currentState != "IS_GONE_STATE")
         {
            if(this.stateMachine.currentState == "IS_CAST_APPEARING_STATE")
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
               }
               this.yPos = Easings.easeOutQuad(this.t_tick,this.t_start,this.t_diff,this.t_time);
               ++this.counter_1;
               if(this.counter_1 > 3)
               {
                  this.counter_1 = 0;
                  this.innerContainer.alpha += 0.25;
                  if(this.innerContainer.alpha >= 1)
                  {
                     this.innerContainer.alpha = 1;
                  }
               }
               if(this.t_tick >= this.t_time && this.innerContainer.alpha >= 1)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_CASTING_STATE")
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
               }
               this.CASTING_POWER = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
               if(this.t_tick >= this.t_time)
               {
                  if(this.CASTING_POWER > 0.5)
                  {
                     this.setCastBar(false);
                  }
                  else
                  {
                     this.setCastBar(true);
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_CAST_DISAPPEARING_STATE")
            {
               ++this.counter_2;
               if(this.counter_1++ > 1)
               {
                  this.counter_1 = 0;
                  this.innerContainer.alpha -= 0.25;
                  if(this.innerContainer.alpha < 0)
                  {
                     this.innerContainer.alpha = 0;
                  }
               }
            }
         }
         this.updateScreenPositions();
      }
      
      protected function updateScreenPositions() : void
      {
         this.innerContainer.x = int(this.xPos);
         this.innerContainer.y = int(this.yPos);
         this.quad.width = int(132 * this.CASTING_POWER);
         if(132 * this.CASTING_POWER < 1)
         {
            this.quad.width = 1;
         }
         if(this.CASTING_POWER < 0.25)
         {
            this.quad.color = ColorUtil.getGradientColor(16711757,16279552,this.CASTING_POWER / 0.25);
         }
         else if(this.CASTING_POWER < 0.5)
         {
            this.quad.color = ColorUtil.getGradientColor(16279552,16753408,(this.CASTING_POWER - 0.25) / 0.25);
         }
         else if(this.CASTING_POWER < 0.75)
         {
            this.quad.color = ColorUtil.getGradientColor(16753408,16639552,(this.CASTING_POWER - 0.5) / 0.25);
         }
         else
         {
            this.quad.color = ColorUtil.getGradientColor(16639552,16773608,(this.CASTING_POWER - 0.75) / 0.25);
         }
      }
      
      protected function goneState() : void
      {
         this.innerContainer.visible = false;
      }
      
      protected function castAppearingState() : void
      {
         this.t_start = int(Utils.HEIGHT * 0.2) - 8;
         this.t_diff = 8;
         this.t_tick = 0;
         this.t_time = 0.5;
         this.innerContainer.visible = true;
         this.innerContainer.alpha = 0;
         this.quad.visible = false;
         this.counter_1 = 0;
      }
      
      protected function castingState() : void
      {
         this.quad.visible = true;
         this.quad.width = 1;
         this.sin_counter = -Math.PI;
         this.setCastBar(true);
      }
      
      protected function castDisappearingState() : void
      {
         this.t_start = int(Utils.HEIGHT * 0.2);
         this.t_diff = -8;
         this.t_tick = 0;
         this.t_time = 0.5;
         this.counter_1 = this.counter_2 = 0;
      }
      
      protected function setCastBar(_going_up:Boolean = true) : void
      {
         this.t_tick = 0;
         var ROD_LEVEL:Number = Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1] - 1;
         this.t_time = 1 - ROD_LEVEL * 0.1;
         if(_going_up)
         {
            this.t_start = 0;
            this.t_diff = 1;
            this.quad.width = 1;
            this.CASTING_POWER = 0;
         }
         else
         {
            this.t_start = 1;
            this.t_diff = -1;
            this.quad.width = 123;
            this.CASTING_POWER = 1;
         }
      }
   }
}
