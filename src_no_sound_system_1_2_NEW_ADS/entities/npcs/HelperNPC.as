package entities.npcs
{
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.helpers.SeedHelperSprite;
   
   public class HelperNPC extends NPC
   {
       
      
      protected var float_y:Number;
      
      protected var offset_y:Number;
      
      public function HelperNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.float_y = Math.random() * Math.PI * 2;
         this.offset_y = 0;
         if(_type == 0)
         {
            sprite = new SeedHelperSprite();
         }
         else
         {
            sprite = new SeedHelperSprite();
         }
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
         this.float_y += 0.05;
         if(this.float_y >= Math.PI * 2)
         {
            this.float_y -= Math.PI * 2;
         }
         this.offset_y = Math.sin(this.float_y) * 4;
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 5 + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
      }
      
      override public function heroInteractionStart() : void
      {
      }
      
      override public function heroInteractionEnd() : void
      {
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
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos + this.offset_y - camera.yPos));
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               sprite.gfxHandle().scaleX = -1;
            }
         }
         sprite.updateScreenPosition();
      }
   }
}
