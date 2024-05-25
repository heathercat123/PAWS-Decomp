package entities.npcs
{
   import entities.*;
   import flash.geom.*;
   import game_utils.CoinPrices;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.cutscenes.MoneyQuestionCutscene;
   import sprites.npcs.*;
   import starling.display.Image;
   import states.LevelState;
   
   public class FishermanNPC extends NPC
   {
       
      
      protected var tick:int;
      
      protected var UPGRADE_AVAILABLE:Boolean;
      
      protected var coin_price:int;
      
      protected var wire_images:Vector.<Image>;
      
      protected var wire_positions:Vector.<Point>;
      
      public function FishermanNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0, _ai:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         sprite = new FishermanNPCSprite();
         Utils.world.addChild(sprite);
         this.coin_price = 100;
         this.wire_images = null;
         this.wire_positions = null;
         this.UPGRADE_AVAILABLE = false;
         this.tick = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_FISHING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","FISH_ACTION","IS_FISHING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_FISHING_STATE",this.fishingAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_2)
         {
            if(Utils.Slot.gameProgression[15] == 0)
            {
               dead = true;
            }
            else
            {
               this.checkFishingRodUpgrade();
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_FISHING)
         {
            this.initFishingWire();
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.wire_images != null)
         {
            for(i = 0; i < this.wire_images.length; i++)
            {
               Utils.world.removeChild(this.wire_images[i]);
               this.wire_images[i].dispose();
               this.wire_images[i] = null;
               this.wire_positions[i] = null;
            }
            this.wire_images = null;
            this.wire_positions = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         ++this.tick;
         if(this.tick > 60)
         {
            this.tick = 60;
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
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel -= speed;
            }
            else
            {
               xVel += speed;
            }
         }
         yVel += 0.4;
         xVel *= x_friction;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      public function checkFishingRodUpgrade() : void
      {
         var fishing_rod_level:int = int(Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1]);
         stringId = 2;
         this.UPGRADE_AVAILABLE = false;
         if(fishing_rod_level == 1)
         {
            if(Utils.Slot.levelUnlocked[802])
            {
               this.coin_price = CoinPrices.GetPrice(CoinPrices.FISHING_ROD_UPGRADE_1);
               this.UPGRADE_AVAILABLE = true;
               stringId = 1;
            }
         }
         else if(fishing_rod_level == 2)
         {
         }
      }
      
      override public function getBalloonYOffset() : int
      {
         return -24;
      }
      
      override protected function isInteractionAllowed() : Boolean
      {
         if(this.tick < 60)
         {
            return false;
         }
         if(level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            return false;
         }
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            return true;
         }
         return false;
      }
      
      override public function heroInteractionStart() : void
      {
         super.heroInteractionStart();
         if(this.UPGRADE_AVAILABLE)
         {
            dialog = level.hud.dialogsManager.createMoneyQuestionBalloonOn(StringsManager.GetString("npc_fisherman_" + stringId),this,null,0,this.questionHandler,this.coin_price);
         }
         else
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_fisherman_" + stringId),this);
         }
      }
      
      protected function questionHandler(_result:int) : void
      {
         if(_result > 0)
         {
            level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.FISHING_ROD_UPGRADE,true,this.coin_price));
         }
         else
         {
            level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.FISHING_ROD_UPGRADE,false,this.coin_price));
         }
      }
      
      override public function heroInteractionEnd() : void
      {
         super.heroInteractionEnd();
         dialog.endRendering();
      }
      
      protected function initFishingWire() : void
      {
         var i:int = 0;
         var image:Image = null;
         this.wire_images = new Vector.<Image>();
         this.wire_positions = new Vector.<Point>();
         var amount:int = 6;
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("fishing_wire"));
            image.pivotX = image.pivotY = 3;
            Utils.world.addChild(image);
            this.wire_images.push(image);
            this.wire_positions.push(new Point(xPos + 44 + i * 24,yPos + 4 + i * 8));
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         if(this.wire_images != null)
         {
            for(i = 0; i < this.wire_images.length; i++)
            {
               this.wire_images[i].x = int(Math.floor(this.wire_positions[i].x - camera.xPos));
               this.wire_images[i].y = int(Math.floor(this.wire_positions[i].y - camera.yPos));
            }
         }
      }
      
      protected function standingAnimation() : void
      {
         var i:int = 0;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = int(Math.random() * 5 + 6) * 60;
         if(this.wire_images != null)
         {
            for(i = 0; i < this.wire_images.length; this.wire_images[i].visible = false,i++)
            {
            }
         }
      }
      
      protected function turningAnimation() : void
      {
         var i:int = 0;
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.wire_images != null)
         {
            for(i = 0; i < this.wire_images.length; this.wire_images[i].visible = false,i++)
            {
            }
         }
      }
      
      protected function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         speed = 0.25;
         x_friction = 0.8;
      }
      
      protected function fishingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
      }
   }
}
