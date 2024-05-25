package levels.collisions
{
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.GameSprite;
   import sprites.particles.SteamParticleSprite;
   
   public class SteamCollision extends AirCollision
   {
       
      
      protected var stateMachine:StateMachine;
      
      protected var multiplier:Number;
      
      protected var ai_index:int;
      
      public function SteamCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _ground_t_level:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_width,_height,_ground_t_level);
         this.multiplier = 0;
         this.ai_index = _ai;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","ON_ACTION","IS_ON_STATE");
         this.stateMachine.setRule("IS_ON_STATE","OFF_ACTION","IS_OFF_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.isOffState);
         this.stateMachine.setFunctionToState("IS_ON_STATE",this.isOnState);
         if(_ai > 0)
         {
            this.stateMachine.setState("IS_ON_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_OFF_STATE");
         }
      }
      
      override public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         super.destroy();
      }
      
      override public function checkEntitiesCollision() : void
      {
         var power:Number = NaN;
         var hero_aabb:Rectangle = level.hero.getAABB();
         if(!level.hero.IS_IN_AIR)
         {
            if(hero_aabb.intersects(aabb) && this.stateMachine.currentState == "IS_ON_STATE")
            {
               level.hero.setInsideAir(this);
            }
         }
         else if(level.hero.airCollision == this)
         {
            if(!hero_aabb.intersects(outer_aabb) || this.stateMachine.currentState == "IS_OFF_STATE" && this.multiplier <= 0)
            {
               level.hero.setOutsideAir();
               intersection_counter = 0;
               additional_power = 0;
            }
            else
            {
               power = evaluateCenterDistance(level.hero);
               intersection_counter += 0.01;
               if(intersection_counter >= 1)
               {
                  intersection_counter = 1;
               }
               if(level.hero.yPos >= ground_level)
               {
                  additional_power += 0.1;
               }
               if(level.hero.stateMachine.currentState != "IS_CLIMBING_STATE" && level.hero.stateMachine.currentState != "IS_DRIFTING_STATE")
               {
                  level.hero.yVel -= (power * 0.3 + additional_power) * this.multiplier;
                  SoundSystem.PlaySound("wind_breeze");
               }
            }
         }
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         var pBackSprite:GameSprite = null;
         var _xPos:Number = NaN;
         var _yVel:Number = NaN;
         if(this.stateMachine.currentState == "IS_OFF_STATE")
         {
            ++counter2;
            if(counter2 > 240)
            {
               this.stateMachine.performAction("ON_ACTION");
            }
            this.multiplier -= 0.01;
            if(this.multiplier < 0)
            {
               this.multiplier = 0;
            }
         }
         else if(this.stateMachine.currentState == "IS_ON_STATE")
         {
            if(this.ai_index != 2)
            {
               ++counter2;
            }
            if(counter2 > 240)
            {
               this.stateMachine.performAction("OFF_ACTION");
            }
            this.multiplier += 0.01;
            if(this.multiplier > 1)
            {
               this.multiplier = 1;
            }
            --counter1;
            if(counter1 < 0)
            {
               counter1 = Math.random() * 10 + 5;
               if(DIRECTION < 0)
               {
                  pSprite = new SteamParticleSprite();
                  pBackSprite = new SteamParticleSprite();
                  _xPos = aabb.x + 16 + Math.random() * (aabb.width - 32);
                  _yVel = -(Math.random() * 1 + 3);
                  if(Math.random() * 100 > 50)
                  {
                     pSprite.gfxHandleClip().gotoAndStop(1);
                     pBackSprite.gfxHandleClip().gotoAndStop(3);
                  }
                  else
                  {
                     pSprite.gfxHandleClip().gotoAndStop(2);
                     pBackSprite.gfxHandleClip().gotoAndStop(4);
                  }
                  level.particlesManager.pushParticle(pSprite,_xPos,aabb.y + aabb.height,0,_yVel,1,aabb.y,-1);
                  level.particlesManager.pushBackParticle(pBackSprite,_xPos,aabb.y + aabb.height,0,_yVel,1,aabb.y,-1);
               }
            }
         }
      }
      
      protected function isOnState() : void
      {
         counter1 = counter2 = 0;
         this.multiplier = 0;
      }
      
      protected function isOffState() : void
      {
         counter1 = counter2 = 0;
         this.multiplier = 1;
      }
   }
}
