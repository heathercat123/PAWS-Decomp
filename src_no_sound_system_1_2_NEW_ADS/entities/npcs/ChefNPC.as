package entities.npcs
{
   import entities.*;
   import flash.geom.*;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.cutscenes.world2.ChefRewardCutscene;
   import sprites.npcs.*;
   
   public class ChefNPC extends NPC
   {
       
      
      protected var CUTSCENE_FLAG_1:Boolean;
      
      public function ChefNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0, _ai:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         sprite = new GenericNPCSprite(GenericNPC.NPC_TOMO_CHEF);
         Utils.world.addChild(sprite);
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
         this.CUTSCENE_FLAG_1 = false;
         if(Utils.Slot.gameProgression[16] == 0 || Utils.Slot.gameProgression[16] == 1)
         {
            stringId = 3;
         }
         else if(Utils.Slot.gameProgression[16] == 2 || Utils.Slot.gameProgression[16] == 3)
         {
            stringId = 4;
         }
         else if(Utils.Slot.gameProgression[16] == 4 || Utils.Slot.gameProgression[16] == 5)
         {
            stringId = 5;
         }
         else
         {
            stringId = 1;
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
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
         if(this.CUTSCENE_FLAG_1 == false)
         {
            if(Utils.Slot.gameProgression[16] % 2 != 0)
            {
               if(this.isRewardAllowed())
               {
                  if(level.hero.xPos >= 424)
                  {
                     this.CUTSCENE_FLAG_1 = true;
                     level.startCutscene(new ChefRewardCutscene(level));
                  }
               }
            }
         }
      }
      
      public function isRewardAllowed() : Boolean
      {
         if(Utils.Slot.gameProgression[16] == 1)
         {
            if(Utils.Slot.playerInventory[LevelItems.ITEM_FISH_RED_JUMPER] >= 1)
            {
               return true;
            }
         }
         else if(Utils.Slot.gameProgression[16] == 3)
         {
            if(Utils.Slot.playerInventory[LevelItems.ITEM_FISH_SQUID] >= 3)
            {
               return true;
            }
         }
         else if(Utils.Slot.gameProgression[16] == 5)
         {
            if(Utils.Slot.playerInventory[LevelItems.ITEM_FISH_OCTOPUS] >= 1)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function getBalloonYOffset() : int
      {
         return -24;
      }
      
      override protected function isInteractionAllowed() : Boolean
      {
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
         dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_tomo_chef_" + stringId),this);
      }
      
      override public function heroInteractionEnd() : void
      {
         super.heroInteractionEnd();
         dialog.endRendering();
         if(level.hero.xPos <= 440 && stringId != 1)
         {
            if(Utils.Slot.gameProgression[16] == 0 || Utils.Slot.gameProgression[16] == 2 || Utils.Slot.gameProgression[16] == 4)
            {
               ++Utils.Slot.gameProgression[16];
               SaveManager.SaveGameProgression();
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
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
