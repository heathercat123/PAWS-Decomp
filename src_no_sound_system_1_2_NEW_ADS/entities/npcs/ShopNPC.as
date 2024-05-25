package entities.npcs
{
   import entities.*;
   import flash.geom.*;
   import game_utils.CoinPrices;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.cutscenes.MoneyQuestionCutscene;
   import sprites.npcs.*;
   
   public class ShopNPC extends NPC
   {
       
      
      protected var IS_FIRST_CUTSCENE_DONE:Boolean;
      
      protected var TYPE:int;
      
      protected var PRICE:int;
      
      public function ShopNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.TYPE = _type;
         this.PRICE = 0;
         sprite = new ShopNPCSprite(_type);
         Utils.world.addChild(sprite);
         if(this.TYPE == 5)
         {
            sprite.visible = false;
         }
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         if(Utils.Slot.gameProgression[22] == 0)
         {
            this.IS_FIRST_CUTSCENE_DONE = false;
         }
         else
         {
            this.IS_FIRST_CUTSCENE_DONE = true;
         }
         if(this.TYPE == 3)
         {
            if(Utils.LEVEL_LOCAL_PROGRESSION_1 > 0)
            {
               stringId = 2;
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
         gravity_friction = 0;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 5 + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(isHeroClose())
            {
               if(DIRECTION == LEFT)
               {
                  if(level.hero.xPos + level.hero.WIDTH * 0.5 > xPos + WIDTH * 0.5 + WIDTH)
                  {
                     stateMachine.performAction("CHANGE_DIR_ACTION");
                  }
               }
               else if(level.hero.xPos + level.hero.WIDTH * 0.5 < xPos + WIDTH * 0.5 - WIDTH)
               {
                  stateMachine.performAction("CHANGE_DIR_ACTION");
               }
            }
            else if(counter1-- < 0 && level.stateMachine.currentState == "IS_PLAYING_STATE")
            {
               stateMachine.performAction("CHANGE_DIR_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         if(this.IS_FIRST_CUTSCENE_DONE == false)
         {
            if(Utils.Slot.gameProgression[22] == 1)
            {
               if(level.hero.xPos > 688)
               {
                  this.IS_FIRST_CUTSCENE_DONE = true;
               }
            }
         }
         if(!IS_INTERACTING)
         {
            if(level.hero.getAABB().intersects(getAABB()))
            {
               IS_INTERACTING = true;
               this.heroInteractionStart();
            }
         }
         else if(level.hero.getAABB().intersects(getOuterAABB()) == false)
         {
            IS_INTERACTING = false;
            this.heroInteractionEnd();
         }
      }
      
      protected function questionHandler(_result:int) : void
      {
         if(this.TYPE == 4)
         {
            SoundSystem.PlaySound("purchase");
            LevelItems.RemoveAllFishFromInventory();
            LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,this.PRICE);
            this.PRICE = 0;
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_shop_fish_3"),this);
         }
         else if(this.TYPE == 5)
         {
            if(_result > 0)
            {
               SoundSystem.PlaySound("purchase");
               LevelItems.AddCoinsAndSave(-CoinPrices.GetPrice(CoinPrices.VENDING_MACHINE_CANDY));
               LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_CANDY_1,1);
               dialog.endRendering();
            }
            else
            {
               level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.VENDING_MACHINE_CANDY,false,CoinPrices.GetPrice(CoinPrices.VENDING_MACHINE_CANDY)));
            }
         }
         else if(this.TYPE == 3)
         {
            if(_result > 0)
            {
               level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.PORTOBELLO_INN,true,CoinPrices.GetPrice(CoinPrices.PORTOBELLO_INN)));
            }
            else
            {
               level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.PORTOBELLO_INN,false,CoinPrices.GetPrice(CoinPrices.PORTOBELLO_INN)));
            }
         }
         else if(this.TYPE == 2)
         {
            if(_result > 0)
            {
               SoundSystem.PlaySound("purchase");
               LevelItems.AddCoinsAndSave(-CoinPrices.GetPrice(CoinPrices.ICECREAM));
               LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_ICE_CREAM_1,1);
               dialog.endRendering();
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_9"),this);
            }
            else
            {
               level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.ICECREAM,false,CoinPrices.GetPrice(CoinPrices.ICECREAM)));
            }
         }
      }
      
      override public function heroInteractionStart() : void
      {
         super.heroInteractionStart();
         if(this.TYPE == 4)
         {
            if(LevelItems.HasFish())
            {
               this.PRICE = CoinPrices.GetFishTotalSellPrice();
               dialog = level.hud.dialogsManager.createQuestionBalloonOn(StringsManager.GetString("npc_shop_fish_2") + " " + this.PRICE + " $?",this,null,0,this.questionHandler);
            }
            else
            {
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_shop_fish_1"),this);
            }
         }
         else if(this.TYPE == 5)
         {
            dialog = level.hud.dialogsManager.createMoneyQuestionBalloonOn(StringsManager.GetString("npc_vending_1"),this,null,0,this.questionHandler,CoinPrices.GetPrice(CoinPrices.VENDING_MACHINE_CANDY));
         }
         else if(this.TYPE == 3)
         {
            if(stringId == 2)
            {
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_shop_inn_" + stringId),this);
            }
            else
            {
               dialog = level.hud.dialogsManager.createMoneyQuestionBalloonOn(StringsManager.GetString("npc_shop_inn_1"),this,null,0,this.questionHandler,CoinPrices.GetPrice(CoinPrices.PORTOBELLO_INN));
            }
         }
         else if(this.TYPE == 2)
         {
            dialog = level.hud.dialogsManager.createMoneyQuestionBalloonOn(StringsManager.GetString("npc_icecream_1"),this,null,0,this.questionHandler,CoinPrices.GetPrice(CoinPrices.ICECREAM));
         }
         else if(this.IS_FIRST_CUTSCENE_DONE)
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("shop_cutscene1_8"),this);
         }
      }
      
      override public function heroInteractionEnd() : void
      {
         super.heroInteractionEnd();
         if(this.TYPE == 4 || this.TYPE == 3 || this.TYPE == 2 || this.TYPE == 5)
         {
            dialog.endRendering();
         }
         else if(this.IS_FIRST_CUTSCENE_DONE)
         {
            dialog.endRendering();
         }
      }
      
      override public function getBalloonYOffset() : int
      {
         if(this.TYPE == 4)
         {
            return -36;
         }
         if(this.TYPE == 3)
         {
            return -36;
         }
         return -56;
      }
      
      protected function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = int(Math.random() * 5 + 6) * 60;
      }
      
      protected function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
   }
}
