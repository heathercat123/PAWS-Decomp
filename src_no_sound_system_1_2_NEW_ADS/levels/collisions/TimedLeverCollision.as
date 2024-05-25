package levels.collisions
{
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import starling.display.Image;
   
   public class TimedLeverCollision extends Collision
   {
      
      public static var knobAnimCounter:int = 0;
      
      public static var updateOnce:Boolean = true;
      
      public static var shake_counter1:int = 0;
      
      public static var shake_counter2:int = 0;
       
      
      public var IS_HERO_RIGHT:Boolean;
      
      public var IS_LEFT_HANDLED:Boolean;
      
      public var IS_ON:Boolean;
      
      protected var IS_PUSHING:Boolean;
      
      public var stateMachine:StateMachine;
      
      protected var aabb_left:Rectangle;
      
      protected var aabb_right:Rectangle;
      
      protected var aabb_out_left:Rectangle;
      
      protected var aabb_out_right:Rectangle;
      
      protected var leverKnobSprite:LeverTimedKnobCollisionSprite;
      
      public var ID:int;
      
      protected var time:int;
      
      protected var max_time:int;
      
      protected var IS_SHAKING:Boolean;
      
      protected var knobOffImage:Image;
      
      public function TimedLeverCollision(_level:Level, _xPos:Number, _yPos:Number, _isLeft:int, _id:int, _max_time:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new LeverTimedCollisionSprite();
         Utils.world.addChild(sprite);
         this.ID = _id;
         this.IS_HERO_RIGHT = false;
         this.time = 0;
         this.max_time = _max_time;
         this.IS_SHAKING = false;
         WIDTH = 32;
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
         this.stateMachine.setRule("IS_LEFT_STATE","LOCK_ACTION","IS_LOCKED_STATE");
         this.stateMachine.setFunctionToState("IS_LEFT_STATE",this.leftAnimation);
         this.stateMachine.setFunctionToState("IS_SWITCHING_RIGHT_STATE",this.switchRightAnimation);
         this.stateMachine.setFunctionToState("IS_RIGHT_STATE",this.rightAnimation);
         this.stateMachine.setFunctionToState("IS_SWITCHING_LEFT_STATE",this.switchLeftAnimation);
         this.stateMachine.setFunctionToState("IS_LOCKED_STATE",this.lockedAnimation);
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
         this.leverKnobSprite = new LeverTimedKnobCollisionSprite();
         Utils.world.addChild(this.leverKnobSprite);
         this.leverKnobSprite.visible = false;
         this.knobOffImage = new Image(TextureManager.sTextureAtlas.getTexture("leverKnobOffAnim_a"));
         Utils.world.addChild(this.knobOffImage);
         this.knobOffImage.visible = false;
      }
      
      override public function postInit() : void
      {
         super.postInit();
         if(Utils.LEVEL_LEVER[this.ID])
         {
            if(this.stateMachine.currentState == "IS_LEFT_STATE")
            {
               this.stateMachine.setState("IS_RIGHT_STATE");
            }
            else
            {
               this.stateMachine.setState("IS_LEFT_STATE");
            }
            this.setOn();
         }
      }
      
      override public function destroy() : void
      {
         this.aabb_left = null;
         this.aabb_right = null;
         this.aabb_out_left = null;
         this.aabb_out_right = null;
         Utils.world.removeChild(this.knobOffImage);
         this.knobOffImage.dispose();
         this.knobOffImage = null;
         Utils.world.removeChild(this.leverKnobSprite);
         this.leverKnobSprite.destroy();
         this.leverKnobSprite.dispose();
         this.leverKnobSprite = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
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
         else if(this.stateMachine.currentState != "IS_LOCKED_STATE")
         {
            if(this.IS_ON)
            {
               ++this.time;
               if(this.time >= this.max_time - 60)
               {
                  this.IS_SHAKING = true;
                  if(this.time >= this.max_time)
                  {
                     this.stateMachine.performAction("SWITCH_ACTION");
                     this.setOff();
                  }
               }
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
            ++shake_counter1;
            if(shake_counter1 >= 3)
            {
               shake_counter1 = 0;
               if(shake_counter2 == 0)
               {
                  if(this.IS_SHAKING)
                  {
                     if(isInsideInnerScreen())
                     {
                        SoundSystem.PlaySound("blue_platform");
                     }
                  }
                  shake_counter2 = 2;
               }
               else
               {
                  shake_counter2 = 0;
               }
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
         if(this.stateMachine.currentState == "IS_LOCKED_STATE")
         {
            return;
         }
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
         if(sprite != null)
         {
            if(this.IS_SHAKING)
            {
               sprite.x = int(Math.floor(xPos + shake_counter2 - camera.xPos));
            }
            else
            {
               sprite.x = int(Math.floor(xPos - camera.xPos));
            }
            sprite.y = int(Math.floor(yPos - camera.yPos));
         }
         sprite.updateScreenPosition();
         if(this.IS_ON && (this.stateMachine.currentState == "IS_LEFT_STATE" || this.stateMachine.currentState == "IS_RIGHT_STATE"))
         {
            this.leverKnobSprite.visible = true;
            if(this.stateMachine.currentState == "IS_LEFT_STATE")
            {
               if(this.IS_SHAKING)
               {
                  this.leverKnobSprite.x = int(Math.floor(xPos + shake_counter2 - camera.xPos));
               }
               else
               {
                  this.leverKnobSprite.x = int(Math.floor(xPos + 0 - camera.xPos));
               }
               this.leverKnobSprite.y = int(Math.floor(yPos + 4 - camera.yPos));
            }
            else
            {
               if(this.IS_SHAKING)
               {
                  this.leverKnobSprite.x = int(Math.floor(xPos + 23 + shake_counter2 - camera.xPos));
               }
               else
               {
                  this.leverKnobSprite.x = int(Math.floor(xPos + 23 - camera.xPos));
               }
               this.leverKnobSprite.y = int(Math.floor(yPos + 4 - camera.yPos));
            }
         }
         else
         {
            this.leverKnobSprite.visible = false;
         }
         if(this.knobOffImage.visible)
         {
            if(!this.IS_LEFT_HANDLED)
            {
               this.knobOffImage.x = int(Math.floor(xPos + 23 - camera.xPos));
            }
            else
            {
               this.knobOffImage.x = int(Math.floor(xPos + 0 - camera.xPos));
            }
            this.knobOffImage.y = int(Math.floor(yPos + 4 - camera.yPos));
         }
         updateOnce = true;
      }
      
      protected function leftAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
         this.IS_PUSHING = false;
         this.time = 0;
         this.IS_SHAKING = false;
      }
      
      protected function switchRightAnimation() : void
      {
         SoundSystem.PlaySound("lever");
         sprite.gotoAndStop(1);
         if(this.IS_SHAKING)
         {
            sprite.gfxHandleClip().gotoAndPlay(3);
         }
         else
         {
            sprite.gfxHandleClip().gotoAndPlay(1);
         }
         this.IS_SHAKING = false;
         this.time = 0;
      }
      
      protected function rightAnimation() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndStop(1);
         this.IS_PUSHING = false;
         this.time = 0;
         this.IS_SHAKING = false;
      }
      
      protected function switchLeftAnimation() : void
      {
         SoundSystem.PlaySound("lever");
         sprite.gotoAndStop(2);
         if(this.IS_SHAKING)
         {
            sprite.gfxHandleClip().gotoAndPlay(3);
         }
         else
         {
            sprite.gfxHandleClip().gotoAndPlay(1);
         }
         this.IS_SHAKING = false;
         this.time = 0;
      }
      
      protected function setOn() : void
      {
         this.IS_ON = true;
         Utils.LEVEL_LEVER[this.ID] = true;
         level.collisionsManager.openGate(this.ID);
      }
      
      protected function setOff() : void
      {
         this.IS_ON = false;
         Utils.LEVEL_LEVER[this.ID] = false;
         level.collisionsManager.closeGate(this.ID);
      }
      
      public function lockLever() : void
      {
         this.stateMachine.setState("IS_LOCKED_STATE");
      }
      
      protected function lockedAnimation() : void
      {
         this.IS_SHAKING = false;
         this.time = 0;
         this.knobOffImage.visible = true;
      }
   }
}
