package entities.npcs
{
   import entities.*;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.hud.FreeCoinsBalloonSprite;
   import sprites.npcs.*;
   import sprites.particles.FiftyCoinsParticleSprite;
   
   public class BlackDuckNPC extends NPC
   {
       
      
      internal var freeCoinsImage:FreeCoinsBalloonSprite;
      
      public function BlackDuckNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         sprite = new GenericNPCSprite(GenericNPC.NPC_BLACK_DUCK);
         Utils.world.addChild(sprite);
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         this.freeCoinsImage = new FreeCoinsBalloonSprite();
         this.freeCoinsImage.touchable = false;
         this.freeCoinsImage.pivotX = int(this.freeCoinsImage.width * 0.5);
         this.freeCoinsImage.pivotY = int(this.freeCoinsImage.height);
         Utils.topWorld.addChild(this.freeCoinsImage);
         this.freeCoinsImage.visible = false;
         this.freeCoinsImage.alpha = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_GAME] == 0)
         {
            this.freeCoinsImage.visible = true;
            isRateMe = true;
         }
      }
      
      override public function destroy() : void
      {
         if(this.freeCoinsImage != null)
         {
            Utils.topWorld.removeChild(this.freeCoinsImage);
            this.freeCoinsImage.destroy();
            this.freeCoinsImage.dispose();
            this.freeCoinsImage = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         if(this.freeCoinsImage.visible)
         {
            this.freeCoinsImage.alpha += 0.1;
            if(this.freeCoinsImage.alpha >= 1)
            {
               this.freeCoinsImage.alpha = 1;
            }
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_GAME] == 1)
         {
            this.freeCoinsImage.visible = false;
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_REWARD] == 1)
         {
            this.freeCoinsImage.visible = false;
         }
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
            else if(counter1-- < 0)
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
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.freeCoinsImage.x = int(Math.floor(sprite.x + 8));
         this.freeCoinsImage.y = int(Math.floor(sprite.y - 16));
      }
      
      override public function heroInteractionStart() : void
      {
         super.heroInteractionStart();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_GAME] == 0)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_REWARD] == 1)
            {
               dialog = level.hud.dialogsManager.createQuestionBalloonOn(StringsManager.GetString("npc_rate"),this,null,0,this.rate);
            }
            else
            {
               dialog = level.hud.dialogsManager.createQuestionBalloonOn(StringsManager.GetString("rate_android_1"),this,null,0,this.rate);
            }
            this.freeCoinsImage.visible = false;
         }
         else
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_black_duck_" + stringId),this);
         }
      }
      
      public function rate(_result:int) : void
      {
         var pSprite:FiftyCoinsParticleSprite = null;
         Utils.RateOn = true;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_REWARD] == 0)
         {
            SoundSystem.PlaySound("item_appear");
         }
         else
         {
            SoundSystem.PlaySound("select");
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_REWARD] == 0)
         {
            Utils.Slot.playerInventory[LevelItems.ITEM_COIN] += 50;
            SaveManager.SaveInventory(true);
            pSprite = new FiftyCoinsParticleSprite();
            level.topParticlesManager.pushParticle(pSprite,level.hero.xPos + level.hero.WIDTH * 0.5,level.hero.yPos,0,0,0);
            Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_REWARD] = 1;
            SaveManager.SaveGameVariables();
         }
      }
      
      override public function heroInteractionEnd() : void
      {
         super.heroInteractionEnd();
         dialog.endRendering();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_GAME] == 0)
         {
            this.freeCoinsImage.visible = true;
            this.freeCoinsImage.alpha = 0;
         }
         else
         {
            this.freeCoinsImage.visible = false;
            this.freeCoinsImage.alpha = 0;
         }
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
