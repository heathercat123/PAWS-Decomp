package levels.collisions
{
   import entities.Easings;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.collisions.*;
   import sprites.particles.GreySmokeParticleSprite;
   import sprites.tutorials.*;
   
   public class FlameThrowerCollision extends Collision
   {
       
      
      public var stateMachine:StateMachine;
      
      protected var SIDE:int;
      
      protected var flameSprite:FlameCollisionSprite;
      
      protected var stateMachine2:StateMachine;
      
      protected var IS_A_TO_B:Boolean;
      
      protected var ORIGINAL_IS_A_TO_B:Boolean;
      
      protected var IS_HORIZONTAL:Boolean;
      
      protected var IS_STILL:Boolean;
      
      protected var path_start_x:int;
      
      protected var path_end_x:int;
      
      protected var path_start_y:int;
      
      protected var path_end_y:int;
      
      protected var time:Number;
      
      protected var time_tick:Number;
      
      protected var time_start:Number;
      
      protected var time_diff:Number;
      
      protected var gearsSprite:Array;
      
      protected var gearsData:Array;
      
      protected var _start:Number;
      
      protected var _diff:Number;
      
      protected var _tick:Number;
      
      protected var _time:Number;
      
      protected var counter2_1:int;
      
      protected var isOn:int;
      
      public function FlameThrowerCollision(_level:Level, _xPos:Number, _yPos:Number, _side:int, _isOn:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.isOn = _isOn;
         this.counter2_1 = 0;
         sprite = new FlameThrowerCollisionSprite();
         Utils.topWorld.addChild(sprite);
         this.flameSprite = new FlameCollisionSprite();
         Utils.topWorld.addChild(this.flameSprite);
         WIDTH = HEIGHT = 16;
         this.path_start_x = this.path_end_x = this.path_start_y = this.path_end_y = 0;
         this.time = this.time_tick = this.time_start = this.time_diff = 0;
         this.gearsData = this.gearsSprite = null;
         this.SIDE = _side;
         this._start = this._diff = this._tick = this._time = 0;
         this.ORIGINAL_IS_A_TO_B = this.IS_A_TO_B = true;
         this.IS_STILL = false;
         if(this.SIDE == 0)
         {
            sprite.rotation = this.flameSprite.rotation = -Math.PI * 0.5;
            this.flameSprite.rotation = -Math.PI * 0.5;
            aabb.x = -6;
            aabb.y = -56;
            aabb.width = 12;
            aabb.height = 56;
         }
         else if(this.SIDE == 1)
         {
            aabb.x = 0;
            aabb.y = -6;
            aabb.width = 56;
            aabb.height = 12;
         }
         else if(this.SIDE == 2)
         {
            sprite.rotation = this.flameSprite.rotation = Math.PI * 0.5;
            this.flameSprite.rotation = Math.PI * 0.5;
            aabb.x = -6;
            aabb.y = 0;
            aabb.width = 12;
            aabb.height = 56;
         }
         else if(this.SIDE == 3)
         {
            aabb.x = -56;
            aabb.y = -6;
            aabb.width = 56;
            aabb.height = 12;
            sprite.scaleX = -1;
            this.flameSprite.scaleX = -1;
         }
         this.fetchScripts();
         if(this.IS_STILL == false)
         {
            this.initGears();
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","ON_ACTION","IS_TURNING_ON_STATE");
         this.stateMachine.setRule("IS_TURNING_ON_STATE","END_ACTION","IS_ON_STATE");
         this.stateMachine.setRule("IS_ON_STATE","OFF_ACTION","IS_TURNING_OFF_STATE");
         this.stateMachine.setRule("IS_TURNING_OFF_STATE","END_ACTION","IS_OFF_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offState);
         this.stateMachine.setFunctionToState("IS_TURNING_ON_STATE",this.turningOnState);
         this.stateMachine.setFunctionToState("IS_ON_STATE",this.onState);
         this.stateMachine.setFunctionToState("IS_TURNING_OFF_STATE",this.turningOffState);
         this.stateMachine2 = new StateMachine();
         this.stateMachine2.setRule("IS_WAITING_STATE","MOVE_ACTION","IS_MOVING_STATE");
         this.stateMachine2.setRule("IS_MOVING_STATE","STOP_ACTION","IS_WAITING_STATE");
         this.stateMachine2.setRule("IS_STILL_STATE","END_ACTION","IS_WAITING_STATE");
         this.stateMachine2.setFunctionToState("IS_WAITING_STATE",this.waitingState);
         this.stateMachine2.setFunctionToState("IS_MOVING_STATE",this.movingState);
         this.stateMachine2.setFunctionToState("IS_STILL_STATE",this.stillState);
         if(this.IS_STILL)
         {
            this.stateMachine2.setState("IS_STILL_STATE");
         }
         else
         {
            this.stateMachine2.setState("IS_WAITING_STATE");
         }
      }
      
      override public function postInit() : void
      {
         if(this.isOn == 1)
         {
            this.stateMachine.setState("IS_ON_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_OFF_STATE");
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this.isOn == 1)
         {
            this.stateMachine.setState("IS_ON_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_OFF_STATE");
         }
         counter1 = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.gearsData != null)
         {
            for(i = 0; i < this.gearsData.length; i++)
            {
               Utils.world.removeChild(this.gearsSprite[i]);
               this.gearsSprite[i].destroy();
               this.gearsSprite[i].dispose();
               this.gearsSprite[i] = null;
               this.gearsData[i] = null;
            }
            this.gearsSprite = null;
            this.gearsData = null;
         }
         this.stateMachine2.destroy();
         this.stateMachine2 = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_ON_STATE")
         {
            if(this.IS_STILL)
            {
               if(counter1++ >= 120)
               {
                  this.stateMachine.performAction("OFF_ACTION");
               }
            }
            else if(counter1++ >= 120)
            {
               this.stateMachine.performAction("OFF_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_TURNING_OFF_STATE")
         {
            this.stateMachine.performAction("END_ACTION");
         }
         else if(this.stateMachine.currentState == "IS_OFF_STATE")
         {
            if(this.IS_STILL)
            {
               if(counter1++ > 60)
               {
                  this.stateMachine.performAction("ON_ACTION");
               }
            }
            else if(counter1++ > 60)
            {
               this.stateMachine.performAction("ON_ACTION");
            }
            if(this.flameSprite.gfxHandleClip().isComplete)
            {
               this.flameSprite.visible = false;
            }
         }
         else if(this.stateMachine.currentState == "IS_TURNING_ON_STATE")
         {
            if(sprite.frame == 2)
            {
               if(sprite.gfxHandleClip().isComplete)
               {
                  sprite.gotoAndStop(1);
                  sprite.gfxHandleClip().gotoAndStop(1);
               }
            }
            if(this.flameSprite.gfxHandleClip().isComplete)
            {
               this.flameSprite.visible = false;
            }
            if(counter1++ > 60)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         if(this.stateMachine2.currentState == "IS_WAITING_STATE")
         {
            ++this.counter2_1;
            if(this.counter2_1 >= 120)
            {
               this.stateMachine2.performAction("MOVE_ACTION");
            }
         }
         else if(this.stateMachine2.currentState == "IS_MOVING_STATE")
         {
            this.time_tick += 1 / 60;
            if(this.time_tick >= this.time)
            {
               this.time_tick = this.time;
               this.IS_A_TO_B = !this.IS_A_TO_B;
               this.stateMachine2.performAction("STOP_ACTION");
            }
            if(this.IS_HORIZONTAL)
            {
               xPos = Math.round(Easings.linear(this.time_tick,this.time_start,this.time_diff,this.time));
            }
            else
            {
               yPos = Math.round(Easings.linear(this.time_tick,this.time_start,this.time_diff,this.time));
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         if(this.SIDE == 0)
         {
            this.flameSprite.x = int(Math.round(xPos + 0 - camera.xPos));
            this.flameSprite.y = int(Math.round(yPos - 11 - camera.yPos));
         }
         else if(this.SIDE == 1)
         {
            this.flameSprite.x = int(Math.round(xPos + 11 - camera.xPos));
            this.flameSprite.y = int(Math.round(yPos - 0 - camera.yPos));
         }
         else if(this.SIDE == 2)
         {
            this.flameSprite.x = int(Math.round(xPos + 0 - camera.xPos));
            this.flameSprite.y = int(Math.round(yPos + 11 - camera.yPos));
         }
         else if(this.SIDE == 3)
         {
            this.flameSprite.x = int(Math.round(xPos - 11 - camera.xPos));
            this.flameSprite.y = int(Math.round(yPos - 0 - camera.yPos));
         }
         this.flameSprite.updateScreenPosition();
         if(this.gearsData != null)
         {
            for(i = 0; i < this.gearsData.length; i++)
            {
               this.gearsSprite[i].x = int(Math.floor(this.gearsData[i].x - camera.xPos));
               this.gearsSprite[i].y = int(Math.floor(this.gearsData[i].y - camera.yPos));
               Utils.world.setChildIndex(this.gearsSprite[i],0);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.stateMachine.currentState == "IS_ON_STATE")
         {
            if(level.hero.getAABB().intersects(getAABB()))
            {
               level.hero.hurt(xPos,yPos,null);
            }
         }
      }
      
      protected function offState() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.flameSprite.visible = false;
         counter1 = 0;
      }
      
      protected function turningOnState() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.flameSprite.visible = true;
         this.flameSprite.gotoAndStop(2);
         this.flameSprite.gfxHandleClip().gotoAndPlay(1);
         this.smokeParticles();
         counter1 = 0;
      }
      
      protected function onState() : void
      {
         if(isInsideInnerScreen())
         {
            SoundSystem.PlaySound("fire");
         }
         this.flameSprite.visible = true;
         this.flameSprite.gotoAndStop(1);
         this.flameSprite.gfxHandleClip().gotoAndPlay(1);
         this._start = 8;
         this._diff = 10;
         this._tick = 0;
         this._time = 0.125;
         this.smokeParticles();
      }
      
      protected function turningOffState() : void
      {
         this._start = 18;
         this._diff = -18;
         this._tick = 0;
         this._time = 0.125;
         this.flameSprite.visible = true;
         this.flameSprite.gotoAndStop(2);
         this.flameSprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function smokeParticles() : void
      {
         var i:int = 0;
         var amount:int = 0;
         var pSprite:GameSprite = null;
         if(Math.random() * 100 > 50)
         {
            amount = 3;
         }
         else
         {
            amount = 2;
         }
         for(i = 0; i < amount; i++)
         {
            pSprite = new GreySmokeParticleSprite();
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            if(this.SIDE == 0)
            {
               level.particlesManager.pushBackParticle(pSprite,xPos + (Math.random() * 4 - 2),yPos + (Math.random() * 4 - 2) - 16,Math.random() * 0.2 + 0.1,0,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80,1 + Math.random() * 1);
            }
            else if(this.SIDE == 1)
            {
               level.particlesManager.pushBackParticle(pSprite,xPos + (Math.random() * 4 - 2) + 16,yPos + (Math.random() * 4 - 2),Math.random() * 0.2 + 0.1,0,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80,1 + Math.random() * 1);
            }
            else if(this.SIDE == 2)
            {
               level.particlesManager.pushBackParticle(pSprite,xPos + (Math.random() * 4 - 2),yPos + (Math.random() * 4 - 2) + 16,Math.random() * 0.2 + 0.1,0,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80,1 + Math.random() * 1);
            }
            else
            {
               level.particlesManager.pushBackParticle(pSprite,xPos + (Math.random() * 4 - 2) - 16,yPos + (Math.random() * 4 - 2),Math.random() * 0.2 + 0.1,0,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80,1 + Math.random() * 1);
            }
         }
      }
      
      protected function initGears() : void
      {
         var i:int = 0;
         var _length:Number = NaN;
         var _amount:int = 0;
         var _step:int = 0;
         var sprite:PlatformGearCollisionSprite = null;
         this.gearsSprite = new Array();
         this.gearsData = new Array();
         if(this.IS_HORIZONTAL)
         {
            _length = this.path_end_x - this.path_start_x;
            _amount = int(_length / 32) + 1;
            if(this.IS_STILL)
            {
               _amount = 0;
            }
            _step = int(_length / (_amount - 1));
            for(i = 0; i < _amount; i++)
            {
               sprite = new PlatformGearCollisionSprite();
               Utils.world.addChild(sprite);
               this.gearsSprite.push(sprite);
               if(i == _amount - 1)
               {
                  this.gearsData.push(new Point(this.path_start_x + _length,yPos + 0));
               }
               else
               {
                  this.gearsData.push(new Point(this.path_start_x + i * _step,yPos + 0));
               }
            }
         }
         else
         {
            _length = this.path_end_y - this.path_start_y;
            _amount = int(_length / 32) + 1;
            if(this.IS_STILL)
            {
               _amount = 0;
            }
            for(i = 0; i < _amount; i++)
            {
               sprite = new PlatformGearCollisionSprite();
               Utils.world.addChild(sprite);
               this.gearsSprite.push(sprite);
               this.gearsData.push(new Point(xPos + WIDTH * 0.5,this.path_start_y + i * 32 + 4));
            }
         }
      }
      
      protected function waitingState() : void
      {
         this.counter2_1 = 0;
      }
      
      protected function movingState() : void
      {
         this.time_tick = 0;
         if(this.IS_HORIZONTAL)
         {
            if(this.IS_A_TO_B)
            {
               this.time_start = this.path_start_x;
               this.time_diff = this.path_end_x - this.path_start_x;
            }
            else
            {
               this.time_start = this.path_end_x;
               this.time_diff = this.path_start_x - this.path_end_x;
            }
         }
         else if(this.IS_A_TO_B)
         {
            this.time_start = this.path_start_y;
            this.time_diff = this.path_end_y - this.path_start_y;
         }
         else
         {
            this.time_start = this.path_end_y;
            this.time_diff = this.path_start_y - this.path_end_y;
         }
      }
      
      protected function stillState() : void
      {
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var area_enemy:Rectangle = new Rectangle(xPos - 8,yPos - 8,Utils.TILE_WIDTH,Utils.TILE_HEIGHT);
         this.IS_STILL = true;
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               if(level.scriptsManager.verPathScripts[i].intersects(area_enemy))
               {
                  this.IS_STILL = false;
                  this.IS_HORIZONTAL = false;
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = level.scriptsManager.verPathScripts[i].y + level.scriptsManager.verPathScripts[i].height;
                  if(Math.abs(yPos - this.path_start_y) < Math.abs(yPos - this.path_end_y))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                  }
                  this.time = int((this.path_end_y - this.path_start_y) / 32) * 0.5;
                  if(this.time < 1)
                  {
                     this.time = 1;
                  }
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               if(level.scriptsManager.horPathScripts[i].intersects(area_enemy))
               {
                  this.IS_STILL = false;
                  this.IS_HORIZONTAL = true;
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = level.scriptsManager.horPathScripts[i].x + level.scriptsManager.horPathScripts[i].width;
                  if(Math.abs(xPos + WIDTH * 0.5 - this.path_start_x) < Math.abs(xPos + WIDTH * 0.5 - this.path_end_x))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                     xPos = originalXPos = this.path_end_x;
                  }
                  this.time = int((this.path_end_x - this.path_start_x) / 32) * 0.5;
                  if(this.time < 1)
                  {
                     this.time = 1;
                  }
               }
            }
         }
      }
   }
}
