package levels.collisions
{
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.collisions.*;
   import sprites.particles.SmokeParticleSprite;
   import sprites.tutorials.*;
   
   public class CannonHeroCollision extends Collision
   {
       
      
      protected var cannonBase:CannonHeroBaseCollisionSprite;
      
      protected var DIRECTION_UP:int = 1;
      
      protected var DIRECTION_DX:int = 2;
      
      protected var DIRECTION_DOWN:int = 3;
      
      protected var DIRECTION_SX:int = 4;
      
      protected var directions:Array;
      
      protected var direction_index:int;
      
      protected var next_direction_index:int;
      
      public var cannon_frame:int;
      
      protected var animation_sequence:Array;
      
      protected var animation_index:int;
      
      protected var stateMachine:StateMachine;
      
      protected var SHOOT_ASAP:Boolean;
      
      public function CannonHeroCollision(_level:Level, _xPos:Number, _yPos:Number, _value_0:int = 0, _value_1:int = 0, _value_2:int = 0, _value_3:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.cannonBase = new CannonHeroBaseCollisionSprite();
         Utils.topWorld.addChild(this.cannonBase);
         this.directions = new Array();
         this.directions.push(_value_0);
         this.directions.push(_value_1);
         this.directions.push(_value_2);
         this.directions.push(_value_3);
         this.direction_index = this.next_direction_index = 0;
         this.cannon_frame = 0;
         this.animation_sequence = null;
         this.animation_index = 0;
         this.SHOOT_ASAP = false;
         sprite = new CannonHeroCollisionSprite();
         Utils.topWorld.addChild(sprite);
         aabb.x = -12;
         aabb.y = -12;
         aabb.width = 24;
         aabb.height = 24;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","HERO_INSIDE_ACTION","IS_BIGGER_STATE");
         this.stateMachine.setRule("IS_BIGGER_STATE","END_ACTION","IS_PRE_SPIN_STATE");
         this.stateMachine.setRule("IS_PRE_SPIN_STATE","END_ACTION","IS_SPINNING_STATE");
         this.stateMachine.setRule("IS_SPINNING_STATE","END_ACTION","IS_POST_SPIN_STATE");
         this.stateMachine.setRule("IS_POST_SPIN_STATE","END_ACTION","IS_SPIN_WAIT_STATE");
         this.stateMachine.setRule("IS_SPIN_WAIT_STATE","END_ACTION","IS_PRE_SPIN_STATE");
         this.stateMachine.setRule("IS_SHOOTING_STATE","END_ACTION","IS_WAITING_STATE");
         this.stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingAnimation);
         this.stateMachine.setFunctionToState("IS_BIGGER_STATE",this.biggerAnimation);
         this.stateMachine.setFunctionToState("IS_PRE_SPIN_STATE",this.preSpinningAnimation);
         this.stateMachine.setFunctionToState("IS_SPINNING_STATE",this.spinningAnimation);
         this.stateMachine.setFunctionToState("IS_POST_SPIN_STATE",this.postSpinningAnimation);
         this.stateMachine.setFunctionToState("IS_SPIN_WAIT_STATE",this.spinWaitAnimation);
         this.stateMachine.setFunctionToState("IS_SHOOTING_STATE",this.shootingAnimation);
         this.stateMachine.setState("IS_WAITING_STATE");
      }
      
      override public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.animation_sequence = null;
         Utils.topWorld.removeChild(sprite);
         Utils.topWorld.removeChild(this.cannonBase);
         this.cannonBase.destroy();
         this.cannonBase.dispose();
         this.cannonBase = null;
         this.directions = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_WAITING_STATE")
         {
            if(this.directions[this.direction_index] == this.DIRECTION_UP)
            {
               this.cannon_frame = 0;
            }
            else if(this.directions[this.direction_index] == this.DIRECTION_DX)
            {
               this.cannon_frame = 2;
            }
            else if(this.directions[this.direction_index] == this.DIRECTION_DOWN)
            {
               this.cannon_frame = 4;
            }
            else if(this.directions[this.direction_index] == this.DIRECTION_SX)
            {
               this.cannon_frame = 6;
            }
         }
         else if(this.stateMachine.currentState == "IS_BIGGER_STATE")
         {
            if(this.cannonBase.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_SPINNING_STATE")
         {
            if(counter1++ > 2)
            {
               counter1 = 0;
               if(this.animation_index >= this.animation_sequence.length)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
               else
               {
                  this.cannon_frame = this.animation_sequence[this.animation_index];
                  ++this.animation_index;
               }
            }
         }
         else if(this.stateMachine.currentState != "IS_POST_SPIN_STATE")
         {
            if(this.stateMachine.currentState == "IS_SPIN_WAIT_STATE")
            {
               if(this.SHOOT_ASAP)
               {
                  this.stateMachine.setState("IS_SHOOTING_STATE");
               }
               else if(counter1++ > 60)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_SHOOTING_STATE")
            {
               if(this.cannonBase.gfxHandleClip().isComplete)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      public function heroInput() : void
      {
         if(this.stateMachine.currentState == "IS_WAITING_STATE" || this.stateMachine.currentState == "IS_BIGGER_STATE")
         {
            return;
         }
         this.SHOOT_ASAP = true;
      }
      
      public function setHeroInside(_value:Boolean) : void
      {
         if(_value)
         {
            this.stateMachine.performAction("HERO_INSIDE_ACTION");
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABB();
         var cannon_aabb:Rectangle = getAABB();
         if(hero_aabb.intersects(cannon_aabb))
         {
            level.hero.setInsideCannon(this);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.cannonBase.x = int(Math.floor(xPos - camera.xPos));
         this.cannonBase.y = int(Math.floor(yPos - camera.yPos));
         this.cannonBase.updateScreenPosition();
         sprite.gfxHandleClip().gotoAndStop(this.cannon_frame + 1);
      }
      
      protected function waitingAnimation() : void
      {
         this.cannonBase.gotoAndStop(1);
      }
      
      protected function biggerAnimation() : void
      {
         this.cannonBase.gotoAndStop(2);
         this.cannonBase.gfxHandleClip().gotoAndPlay(1);
         this.SHOOT_ASAP = false;
      }
      
      protected function preSpinningAnimation() : void
      {
         this.cannonBase.gotoAndStop(1);
         SoundSystem.PlaySound("red_platform");
         this.next_direction_index = this.direction_index + 1;
         if(this.next_direction_index >= this.directions.length)
         {
            this.next_direction_index = 0;
         }
         if(this.directions[this.next_direction_index] == 0)
         {
            this.next_direction_index = 0;
         }
         this.animation_sequence = new Array();
         this.animation_index = 0;
         if(this.directions[this.direction_index] == this.DIRECTION_UP)
         {
            if(this.directions[this.next_direction_index] == this.DIRECTION_DX)
            {
               this.animation_sequence.push(1);
               this.animation_sequence.push(2);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_DOWN)
            {
               this.animation_sequence.push(1);
               this.animation_sequence.push(2);
               this.animation_sequence.push(3);
               this.animation_sequence.push(4);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_SX)
            {
               this.animation_sequence.push(7);
               this.animation_sequence.push(6);
            }
         }
         else if(this.directions[this.direction_index] == this.DIRECTION_DX)
         {
            if(this.directions[this.next_direction_index] == this.DIRECTION_UP)
            {
               this.animation_sequence.push(1);
               this.animation_sequence.push(0);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_DOWN)
            {
               this.animation_sequence.push(3);
               this.animation_sequence.push(4);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_SX)
            {
               this.animation_sequence.push(3);
               this.animation_sequence.push(4);
               this.animation_sequence.push(5);
               this.animation_sequence.push(6);
            }
         }
         else if(this.directions[this.direction_index] == this.DIRECTION_DOWN)
         {
            if(this.directions[this.next_direction_index] == this.DIRECTION_UP)
            {
               this.animation_sequence.push(5);
               this.animation_sequence.push(6);
               this.animation_sequence.push(7);
               this.animation_sequence.push(0);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_DX)
            {
               this.animation_sequence.push(3);
               this.animation_sequence.push(2);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_SX)
            {
               this.animation_sequence.push(5);
               this.animation_sequence.push(6);
            }
         }
         else if(this.directions[this.direction_index] == this.DIRECTION_SX)
         {
            if(this.directions[this.next_direction_index] == this.DIRECTION_UP)
            {
               this.animation_sequence.push(7);
               this.animation_sequence.push(0);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_DX)
            {
               this.animation_sequence.push(7);
               this.animation_sequence.push(0);
               this.animation_sequence.push(1);
               this.animation_sequence.push(2);
            }
            else if(this.directions[this.next_direction_index] == this.DIRECTION_DOWN)
            {
               this.animation_sequence.push(5);
               this.animation_sequence.push(4);
            }
         }
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function spinningAnimation() : void
      {
         counter1 = 0;
      }
      
      protected function postSpinningAnimation() : void
      {
         this.direction_index = this.next_direction_index;
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function spinWaitAnimation() : void
      {
         counter1 = 0;
      }
      
      protected function shootingAnimation() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         var ref_angle:Number = NaN;
         SoundSystem.PlaySound("hero_cannon");
         this.cannonBase.gotoAndStop(3);
         this.cannonBase.gfxHandleClip().gotoAndPlay(1);
         if(this.cannon_frame == 0)
         {
            level.particlesManager.itemSparkles("yellow",xPos + 0,yPos - 32,16,null);
         }
         else if(this.cannon_frame == 2)
         {
            level.particlesManager.itemSparkles("yellow",xPos + 32,yPos + 0,16,null);
         }
         else if(this.cannon_frame == 4)
         {
            level.particlesManager.itemSparkles("yellow",xPos + 0,yPos + 32,16,null);
         }
         else if(this.cannon_frame == 6)
         {
            level.particlesManager.itemSparkles("yellow",xPos - 32,yPos + 0,16,null);
         }
         var amount:int = int(Math.round(2 + Math.random() * 2));
         for(i = 0; i < amount; i++)
         {
            pSprite = new SmokeParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(int(Math.random() * 3) + 1);
            if(this.cannon_frame == 0)
            {
               ref_angle = Math.PI + (Math.PI * 0.25 - Math.random() * Math.PI * 0.5);
               level.particlesManager.pushParticle(pSprite,xPos - 8 + Math.random() * 16,yPos - 16 - Math.random() * 8,Math.sin(ref_angle) * 4,Math.cos(ref_angle) * 4,0.8,0,0,2);
            }
            else if(this.cannon_frame == 2)
            {
               ref_angle = Math.PI * 0.5 + (Math.PI * 0.25 - Math.random() * Math.PI * 0.5);
               level.particlesManager.pushParticle(pSprite,xPos + 16 + Math.random() * 8,yPos - 8 + Math.random() * 16,Math.sin(ref_angle) * 4,Math.cos(ref_angle) * 4,0.8,0,0,2);
            }
            else if(this.cannon_frame == 4)
            {
               ref_angle = Math.PI * 0.25 - Math.random() * Math.PI * 0.5;
               level.particlesManager.pushParticle(pSprite,xPos - 8 + Math.random() * 16,yPos + 16 + Math.random() * 8,Math.sin(ref_angle) * 4,Math.cos(ref_angle) * 4,0.8,0,0,2);
            }
            else if(this.cannon_frame == 6)
            {
               ref_angle = -Math.PI * 0.5 + (Math.PI * 0.25 - Math.random() * Math.PI * 0.5);
               level.particlesManager.pushParticle(pSprite,xPos - 16 - Math.random() * 8,yPos - 8 + Math.random() * 16,Math.sin(ref_angle) * 4,Math.cos(ref_angle) * 4,0.8,0,0,2);
            }
         }
         level.hero.setCannonShoot();
      }
   }
}
