package levels.collisions
{
   import entities.Easings;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class TreadmillCollision extends Collision
   {
       
      
      public var stateMachine:StateMachine;
      
      protected var IS_COLLIDING:Boolean;
      
      protected var ALLOW_RUN:Boolean;
      
      public var IS_LOCKED:Boolean;
      
      protected var x_diff_with_hero:Number;
      
      protected var frame_counter:Number;
      
      protected var speed_counter:Number;
      
      protected var t_tick:Number;
      
      protected var gearCollision:GearCollision;
      
      public var GEAR_ID:int;
      
      protected var sound_counter:Number;
      
      public function TreadmillCollision(_level:Level, _xPos:Number, _yPos:Number, _GEAR_ID:int)
      {
         super(_level,_xPos,_yPos);
         this.GEAR_ID = _GEAR_ID;
         sprite = new TreadmillCollisionSprite();
         Utils.world.addChild(sprite);
         this.gearCollision = null;
         aabb.x = 0;
         aabb.y = -4;
         aabb.width = 32;
         aabb.height = 20;
         this.x_diff_with_hero = 0;
         this.frame_counter = 0;
         this.speed_counter = 0;
         this.sound_counter = 0;
         this.t_tick = 0;
         this.IS_COLLIDING = this.ALLOW_RUN = this.IS_LOCKED = false;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","SWITCH_ACTION","IS_SWITCHING_RIGHT_STATE");
         this.stateMachine.setRule("IS_SWITCHING_RIGHT_STATE","END_ACTION","IS_RIGHT_STATE");
         this.stateMachine.setRule("IS_RIGHT_STATE","SWITCH_ACTION","IS_SWITCHING_LEFT_STATE");
         this.stateMachine.setRule("IS_SWITCHING_LEFT_STATE","END_ACTION","IS_LEFT_STATE");
         this.stateMachine.setFunctionToState("IS_LEFT_STATE",this.leftAnimation);
         this.stateMachine.setFunctionToState("IS_SWITCHING_RIGHT_STATE",this.switchRightAnimation);
         this.stateMachine.setFunctionToState("IS_RIGHT_STATE",this.rightAnimation);
         this.stateMachine.setFunctionToState("IS_SWITCHING_LEFT_STATE",this.switchLeftAnimation);
      }
      
      override public function postInit() : void
      {
         var i:int = 0;
         var gCollision:GearCollision = null;
         super.postInit();
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is GearCollision)
               {
                  gCollision = level.collisionsManager.collisions[i] as GearCollision;
                  if(gCollision.GEAR_ID == this.GEAR_ID)
                  {
                     this.gearCollision = level.collisionsManager.collisions[i];
                     return;
                  }
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         var t_tick_progress:Boolean = false;
         if(this.IS_COLLIDING)
         {
            if(this.ALLOW_RUN)
            {
               if(level.hero.stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  this.t_tick += 1 / 60;
                  if(this.t_tick >= 1)
                  {
                     this.t_tick = 1;
                  }
                  t_tick_progress = true;
                  level.hero.xPos = this.xPos + this.x_diff_with_hero;
               }
               else
               {
                  this.x_diff_with_hero = level.hero.xPos - this.xPos;
               }
            }
         }
         if(!t_tick_progress)
         {
            this.t_tick -= 1 / 30;
            if(this.t_tick <= 0)
            {
               this.t_tick = 0;
            }
            this.speed_counter = Easings.easeOutSine(this.t_tick,0,1,1);
         }
         else
         {
            this.speed_counter = Easings.easeInSine(this.t_tick,0,1,1);
         }
         if(this.gearCollision != null)
         {
            this.sound_counter += this.speed_counter * 0.5;
            if(this.sound_counter >= 2)
            {
               this.sound_counter = 0;
               SoundSystem.PlaySound("red_platform");
            }
            this.gearCollision.spin(this.speed_counter);
            if(this.gearCollision.IS_LOCKED)
            {
               if(!this.IS_LOCKED)
               {
                  this.IS_LOCKED = true;
                  if(this.IS_COLLIDING)
                  {
                     level.hero.stateMachine.performAction("ZERO_X_VEL_ACTION");
                  }
                  this.IS_COLLIDING = false;
                  this.ALLOW_RUN = false;
               }
            }
         }
         this.frame_counter += this.speed_counter * 0.75;
         if(this.frame_counter >= 7)
         {
            this.frame_counter -= 7;
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.IS_LOCKED)
         {
            return;
         }
         var mid_hero_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var mid_lever_x:Number = xPos + WIDTH * 0.5;
         var heroAABB:Rectangle = level.hero.getAABB();
         var aabb:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(heroAABB.intersects(aabb))
         {
            this.IS_COLLIDING = true;
            if(level.hero.stateMachine.currentState != "IS_RUNNING_STATE")
            {
               this.ALLOW_RUN = true;
            }
         }
         else
         {
            this.ALLOW_RUN = false;
            this.IS_COLLIDING = false;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         sprite.gfxHandleClip().gotoAndStop(int(this.frame_counter + 1));
      }
      
      protected function leftAnimation() : void
      {
      }
      
      protected function switchRightAnimation() : void
      {
      }
      
      protected function rightAnimation() : void
      {
      }
      
      protected function switchLeftAnimation() : void
      {
      }
      
      protected function setOn() : void
      {
      }
      
      protected function setOff() : void
      {
      }
   }
}
