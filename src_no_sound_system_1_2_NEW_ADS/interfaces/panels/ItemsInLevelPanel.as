package interfaces.panels
{
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import sprites.GameSprite;
   import starling.display.Sprite;
   
   public class ItemsInLevelPanel extends Sprite
   {
       
      
      protected var mid_x:int;
      
      protected var bottom_mid_y:int;
      
      protected var top_mid_y:int;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var item_container:Sprite;
      
      protected var itemsSprite:Array;
      
      protected var itemAnimations:Array;
      
      protected var animation_index:int;
      
      public var stateMachine:StateMachine;
      
      protected var IS_FISHING_LEVEL:Boolean;
      
      public function ItemsInLevelPanel(_width:int, _height:int)
      {
         super();
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.IS_FISHING_LEVEL = false;
         if(Utils.CurrentLevel >= 10000)
         {
            this.IS_FISHING_LEVEL = true;
         }
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.75);
         this.top_mid_y = int(this.HEIGHT * 0.25);
         this.initItems();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_PAUSE_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         this.stateMachine.setRule("IS_LEVEL_COMPLETE_STATE","END_ACTION","IS_ANIMATION_OVER_STATE");
         this.stateMachine.setFunctionToState("IS_PAUSE_STATE",this.pauseState);
         this.stateMachine.setFunctionToState("IS_LEVEL_COMPLETE_STATE",this.levelCompleteState);
         this.stateMachine.setFunctionToState("IS_ANIMATION_OVER_STATE",this.animationOverState);
         this.stateMachine.setState("IS_PAUSE_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.itemsSprite.length; i++)
         {
            this.item_container.removeChild(this.itemsSprite[i]);
            this.itemsSprite[i].destroy();
            this.itemsSprite[i].dispose();
            this.itemsSprite[i] = null;
         }
         this.itemsSprite = null;
         removeChild(this.item_container);
         this.item_container.dispose();
         this.item_container = null;
         this.itemAnimations = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.itemsSprite.length; i++)
         {
            this.itemsSprite[i].updateScreenPosition();
         }
      }
      
      public function gottenAnimation(_index:int) : void
      {
         SoundSystem.PlaySound("hud_item_collected");
         this.itemsSprite[_index].gotoAndStop(2);
         this.itemsSprite[_index].gfxHandleClip().gotoAndPlay(1);
      }
      
      public function levelComplete() : void
      {
         this.stateMachine.performAction("LEVEL_COMPLETE_ACTION");
      }
      
      protected function initItems() : void
      {
         var pSprite:GameSprite = null;
         var i:int = 0;
         var step:int = Math.round(this.WIDTH * 0.144);
         this.itemAnimations = new Array();
         this.item_container = new Sprite();
         addChild(this.item_container);
         this.item_container.x = 0;
         this.item_container.y = 0;
         this.itemsSprite = new Array();
         var index:int = Utils.CurrentLevel - 1;
         if(this.IS_FISHING_LEVEL)
         {
            index = 0;
         }
         var items_amount:int = int(LevelItems.Items[index].length);
         for(i = 0; i < items_amount; i++)
         {
            pSprite = LevelItems.GetItemSprite(LevelItems.Items[index][i]);
            pSprite.gotoAndStop(1);
            pSprite.updateScreenPosition();
            this.item_container.addChild(pSprite);
            pSprite.x = i * step;
            this.itemsSprite.push(pSprite);
            if(LevelItems.HasLevelItemBeenGot(i) || Boolean(Utils.PlayerItems & this.getMaskValue(i)))
            {
               pSprite.gotoAndStop(3);
               pSprite.updateScreenPosition();
            }
         }
         if(items_amount > 1)
         {
            this.item_container.x -= int(step * 0.5) * (items_amount - 1);
         }
         for(i = 0; i < 3; i++)
         {
            if(Boolean(Utils.PlayerItems >> i & 1) && LevelItems.HasLevelItemBeenGot(i) == false)
            {
               this.itemAnimations.push(i);
            }
         }
      }
      
      protected function getMaskValue(index:int) : int
      {
         if(index == 0)
         {
            return 1;
         }
         if(index == 1)
         {
            return 2;
         }
         return 4;
      }
      
      public function updateItems() : void
      {
         if(Utils.PlayerItems & 1)
         {
            this.itemsSprite[0].gotoAndStop(4);
         }
         if(Utils.PlayerItems & 2)
         {
            this.itemsSprite[1].gotoAndStop(4);
         }
         if(Utils.PlayerItems & 4)
         {
            this.itemsSprite[2].gotoAndStop(4);
         }
      }
      
      protected function pauseState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 0;
      }
      
      protected function levelCompleteState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 20;
         this.animation_index = 0;
      }
      
      protected function animationOverState() : void
      {
      }
   }
}
