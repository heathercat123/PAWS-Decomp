package entities.npcs
{
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.npcs.ScientistNPCSprite;
   
   public class ScientistNPC extends NPC
   {
       
      
      public function ScientistNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         sprite = new ScientistNPCSprite();
         Utils.world.addChild(sprite);
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
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
      
      override public function heroInteractionStart() : void
      {
         super.heroInteractionStart();
         dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_scientist_" + stringId),this);
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
   }
}
