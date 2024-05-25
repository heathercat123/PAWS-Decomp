package levels.decorations
{
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.decorations.HoneyDecorationSprite;
   import sprites.particles.DewParticleSprite;
   
   public class HoneyDecoration extends Decoration
   {
       
      
      public var stateMachine:StateMachine;
      
      protected var counter1:int;
      
      public function HoneyDecoration(_level:Level, _xPos:Number, _yPos:Number, _type:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new HoneyDecorationSprite();
         Utils.topWorld.addChild(sprite);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_NOT_FORMED_STATE","END_ACTION","IS_FORMING_STATE");
         this.stateMachine.setRule("IS_FORMING_STATE","END_ACTION","IS_FORMED_STATE");
         this.stateMachine.setRule("IS_FORMED_STATE","END_ACTION","IS_TENSION_STATE");
         this.stateMachine.setRule("IS_TENSION_STATE","END_ACTION","IS_NOT_FORMED_STATE");
         this.stateMachine.setFunctionToState("IS_NOT_FORMED_STATE",this.notFormedState);
         this.stateMachine.setFunctionToState("IS_FORMING_STATE",this.formingState);
         this.stateMachine.setFunctionToState("IS_FORMED_STATE",this.formedState);
         this.stateMachine.setFunctionToState("IS_TENSION_STATE",this.tensionState);
         if(Math.random() * 100 > 50)
         {
            this.stateMachine.setState("IS_NOT_FORMED_STATE");
            this.counter1 = Math.random() * 60 + 30;
         }
         else
         {
            this.stateMachine.setState("IS_FORMED_STATE");
         }
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_NOT_FORMED_STATE")
         {
            --this.counter1;
            if(this.counter1 <= 0)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_FORMING_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_FORMED_STATE")
         {
            --this.counter1;
            if(this.counter1 <= 0)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_TENSION_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               level.particlesManager.pushParticle(new DewParticleSprite(1),xPos + 8,yPos + 4,0,0,1);
               this.stateMachine.performAction("END_ACTION");
            }
         }
      }
      
      override public function shake() : void
      {
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         this.stateMachine.destroy();
         this.stateMachine = null;
         super.destroy();
      }
      
      protected function notFormedState() : void
      {
         sprite.visible = false;
         this.counter1 = 150;
      }
      
      protected function formingState() : void
      {
         sprite.visible = true;
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function formedState() : void
      {
         this.counter1 = int((Math.random() * 2 + 1) * 30);
      }
      
      protected function tensionState() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
   }
}
