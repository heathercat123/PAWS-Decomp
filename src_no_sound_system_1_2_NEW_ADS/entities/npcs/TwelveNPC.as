package entities.npcs
{
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.npcs.TwelveNPCSprite;
   
   public class TwelveNPC extends NPC
   {
       
      
      protected var tick:int;
      
      public function TwelveNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0, _ai:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         sprite = new TwelveNPCSprite();
         Utils.world.addChild(sprite);
         this.tick = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         ++this.tick;
         if(this.tick > 60)
         {
            this.tick = 60;
         }
         if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState == "IS_TURNING_STATE")
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
         }
         yVel += 0.4;
         xVel *= x_friction;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
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
         dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_laal_" + stringId),this);
      }
      
      override public function heroInteractionEnd() : void
      {
         super.heroInteractionEnd();
         dialog.endRendering();
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
   }
}
