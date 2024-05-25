package levels.collisions
{
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.BigLeverCollisionSprite;
   import sprites.collisions.LeverBigKnobCollisionSprite;
   
   public class BigLeverCollision extends Collision
   {
      
      public static var knobAnimCounter:int = 0;
      
      public static var updateOnce:Boolean = true;
       
      
      public var IS_HERO_RIGHT:Boolean;
      
      public var IS_LEFT_HANDLED:Boolean;
      
      public var IS_ON:Boolean;
      
      protected var IS_PUSHING:Boolean;
      
      public var stateMachine:StateMachine;
      
      protected var aabb_left:Rectangle;
      
      protected var aabb_right:Rectangle;
      
      protected var aabb_out_left:Rectangle;
      
      protected var aabb_out_right:Rectangle;
      
      protected var leverKnobSprite:LeverBigKnobCollisionSprite;
      
      public var ID:int;
      
      public function BigLeverCollision(_level:Level, _xPos:Number, _yPos:Number, _isLeft:int, _id:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new BigLeverCollisionSprite();
         Utils.world.addChild(sprite);
         this.ID = _id;
         this.IS_HERO_RIGHT = false;
         WIDTH = 42;
         HEIGHT = 20;
         this.IS_PUSHING = false;
         aabb.x = 0;
         aabb.y = -2;
         aabb.width = 32;
         aabb.height = 20;
         this.aabb_left = new Rectangle(-8,0,8,20);
         this.aabb_right = new Rectangle(32,0,8,20);
         this.aabb_out_left = new Rectangle(-10,0,2,20);
         this.aabb_out_right = new Rectangle(40,0,2,20);
         this.IS_ON = false;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_LEFT_STATE","SWITCH_ACTION","IS_SWITCHING_RIGHT_STATE");
         this.stateMachine.setRule("IS_SWITCHING_RIGHT_STATE","END_ACTION","IS_RIGHT_STATE");
         this.stateMachine.setRule("IS_RIGHT_STATE","SWITCH_ACTION","IS_SWITCHING_LEFT_STATE");
         this.stateMachine.setRule("IS_SWITCHING_LEFT_STATE","END_ACTION","IS_LEFT_STATE");
         this.stateMachine.setFunctionToState("IS_LEFT_STATE",this.leftAnimation);
         this.stateMachine.setFunctionToState("IS_SWITCHING_RIGHT_STATE",this.switchRightAnimation);
         this.stateMachine.setFunctionToState("IS_RIGHT_STATE",this.rightAnimation);
         this.stateMachine.setFunctionToState("IS_SWITCHING_LEFT_STATE",this.switchLeftAnimation);
         if(_isLeft == 0)
         {
            this.IS_LEFT_HANDLED = false;
            this.stateMachine.setState("IS_LEFT_STATE");
         }
         else
         {
            this.IS_LEFT_HANDLED = true;
            this.stateMachine.setState("IS_RIGHT_STATE");
         }
         this.leverKnobSprite = new LeverBigKnobCollisionSprite();
         Utils.world.addChild(this.leverKnobSprite);
         this.leverKnobSprite.visible = false;
      }
      
      override public function destroy() : void
      {
         this.aabb_left = null;
         this.aabb_right = null;
         this.aabb_out_left = null;
         this.aabb_out_right = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.world.removeChild(this.leverKnobSprite);
         this.leverKnobSprite.destroy();
         this.leverKnobSprite.dispose();
         this.leverKnobSprite = null;
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         if(this.stateMachine.currentState == "IS_SWITCHING_RIGHT_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_SWITCHING_LEFT_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         if(updateOnce)
         {
            updateOnce = false;
            ++knobAnimCounter;
            if(knobAnimCounter > 36)
            {
               knobAnimCounter = 0;
            }
         }
         if(knobAnimCounter <= 24)
         {
            this.leverKnobSprite.gfxHandleClip().gotoAndStop(1);
         }
         else if(knobAnimCounter > 24 && knobAnimCounter <= 30)
         {
            this.leverKnobSprite.gfxHandleClip().gotoAndStop(2);
         }
         else if(knobAnimCounter > 30 && knobAnimCounter <= 36)
         {
            this.leverKnobSprite.gfxHandleClip().gotoAndStop(3);
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var mid_hero_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var mid_lever_x:Number = xPos + WIDTH * 0.5;
         var heroAABB:Rectangle = level.hero.getAABB();
         var aabb:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(heroAABB.intersects(aabb))
         {
            if(this.stateMachine.currentState == "IS_LEFT_STATE" || this.stateMachine.currentState == "IS_SWITCHING_LEFT_STATE")
            {
               if(mid_hero_x > mid_lever_x && this.IS_HERO_RIGHT == false)
               {
                  this.stateMachine.setState("IS_SWITCHING_RIGHT_STATE");
                  if(this.IS_LEFT_HANDLED)
                  {
                     this.setOff();
                  }
                  else
                  {
                     this.setOn();
                  }
               }
            }
            else if(mid_hero_x <= mid_lever_x && this.IS_HERO_RIGHT == true)
            {
               this.stateMachine.setState("IS_SWITCHING_LEFT_STATE");
               if(this.IS_LEFT_HANDLED)
               {
                  this.setOn();
               }
               else
               {
                  this.setOff();
               }
            }
         }
         if(mid_hero_x > mid_lever_x)
         {
            this.IS_HERO_RIGHT = true;
         }
         else
         {
            this.IS_HERO_RIGHT = false;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         sprite.updateScreenPosition();
         if(this.IS_ON && (this.stateMachine.currentState == "IS_LEFT_STATE" || this.stateMachine.currentState == "IS_RIGHT_STATE"))
         {
            this.leverKnobSprite.visible = true;
            if(this.stateMachine.currentState == "IS_LEFT_STATE")
            {
               this.leverKnobSprite.x = int(Math.floor(xPos + 0 - camera.xPos));
               this.leverKnobSprite.y = int(Math.floor(yPos + 4 + 1 - camera.yPos));
            }
            else
            {
               this.leverKnobSprite.x = int(Math.floor(xPos + 23 + 7 - camera.xPos));
               this.leverKnobSprite.y = int(Math.floor(yPos + 4 + 1 - camera.yPos));
            }
         }
         else
         {
            this.leverKnobSprite.visible = false;
         }
         updateOnce = true;
      }
      
      protected function leftAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
         this.IS_PUSHING = false;
      }
      
      protected function switchRightAnimation() : void
      {
         SoundSystem.PlaySound("lever");
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function rightAnimation() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndStop(1);
         this.IS_PUSHING = false;
      }
      
      protected function switchLeftAnimation() : void
      {
         SoundSystem.PlaySound("lever");
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      public function setOn() : void
      {
         this.IS_ON = true;
         level.collisionsManager.openGate(this.ID);
      }
      
      public function setOff() : void
      {
         this.IS_ON = false;
         level.collisionsManager.closeGate(this.ID);
      }
   }
}
