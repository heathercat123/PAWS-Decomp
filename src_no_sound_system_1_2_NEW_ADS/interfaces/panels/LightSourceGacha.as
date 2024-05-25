package interfaces.panels
{
   import game_utils.StateMachine;
   import levels.cameras.ScreenCamera;
   import starling.display.Raylight;
   import starling.display.Sprite;
   
   public class LightSourceGacha extends Sprite
   {
       
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      protected var stateMachine:StateMachine;
      
      protected var raylights:Vector.<Raylight>;
      
      protected var radius:Number;
      
      protected var speed:Number;
      
      public var IS_SPINNING:Boolean;
      
      public function LightSourceGacha(_xPos:Number, _yPos:Number, _radius:Number)
      {
         super();
         this.xPos = 0;
         this.yPos = 0;
         this.radius = _radius;
         this.speed = 0;
         this.IS_SPINNING = false;
         this.initRaylights();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","ON_ACTION","IS_GROWING_STATE");
         this.stateMachine.setRule("IS_GROWING_STATE","END_ACTION","IS_SPINNING_STATE");
         this.stateMachine.setRule("IS_SPINNING_STATE","OFF_ACTION","IS_VANISHING_STATE");
         this.stateMachine.setRule("IS_VANISHING_STATE","END_ACTION","IS_OFF_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offState);
         this.stateMachine.setFunctionToState("IS_GROWING_STATE",this.growState);
         this.stateMachine.setFunctionToState("IS_SPINNING_STATE",this.spinState);
         this.stateMachine.setFunctionToState("IS_VANISHING_STATE",this.vanishState);
         this.stateMachine.setState("IS_OFF_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine = null;
         for(i = 0; i < this.raylights.length; i++)
         {
            removeChild(this.raylights[i]);
            this.raylights[i].dispose();
            this.raylights[i] = null;
         }
         this.raylights = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < this.raylights.length; i++)
         {
            this.raylights[i].update();
         }
         if(this.stateMachine.currentState == "IS_GROWING_STATE")
         {
            j = 0;
            for(i = 0; i < this.raylights.length; i++)
            {
               if(this.raylights[i].IS_DONE)
               {
                  j++;
               }
            }
            if(j >= this.raylights.length)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState != "IS_SPINNING_STATE")
         {
            if(this.stateMachine.currentState == "IS_VANISHING_STATE")
            {
               j = 0;
               for(i = 0; i < this.raylights.length; i++)
               {
                  if(this.raylights[i].IS_DONE)
                  {
                     j++;
                  }
               }
               if(j >= this.raylights.length)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         x = int(Math.floor(this.xPos - camera.xPos));
         y = int(Math.floor(this.yPos - camera.yPos));
      }
      
      protected function offState() : void
      {
         visible = false;
      }
      
      protected function growState() : void
      {
         var i:int = 0;
         for(i = 0; i < this.raylights.length; i++)
         {
            this.raylights[i].grow();
         }
      }
      
      protected function spinState() : void
      {
         var i:int = 0;
         this.IS_SPINNING = true;
         for(i = 0; i < this.raylights.length; i++)
         {
            this.raylights[i].spin();
         }
      }
      
      protected function vanishState() : void
      {
         var i:int = 0;
         for(i = 0; i < this.raylights.length; i++)
         {
            this.raylights[i].vanish();
         }
      }
      
      private function initRaylights() : void
      {
         var i:int = 0;
         var amount:int = 0;
         var size:Number = NaN;
         var age:Number = NaN;
         var angle:Number = NaN;
         var raylight:Raylight = null;
         var minAge:Number = 10000;
         var maxAge:Number = -10000;
         this.raylights = new Vector.<Raylight>();
         amount = 6;
         for(i = 0; i < amount; i++)
         {
            angle = Math.random() * Math.PI * 2;
            size = Math.random() * this.radius * 0.5 + this.radius * 0.5;
            age = size * 100 / this.radius;
            if(age < minAge)
            {
               minAge = age;
            }
            if(age > maxAge)
            {
               maxAge = age;
            }
            raylight = new Raylight(age,size,angle);
            this.raylights.push(raylight);
            addChild(raylight);
         }
         for(i = 0; i < this.raylights.length; i++)
         {
            this.raylights[i].setMinMaxAge(minAge,maxAge);
         }
      }
      
      public function start() : void
      {
         this.stateMachine.performAction("ON_ACTION");
      }
      
      public function end() : void
      {
         this.stateMachine.performAction("OFF_ACTION");
      }
   }
}
