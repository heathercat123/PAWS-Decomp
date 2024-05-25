package entities
{
   import entities.particles.Particle;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.StunStarsSprite;
   import sprites.particles.ItemHeroParticleSprite;
   
   public class StunHandler
   {
       
      
      public var level:Level;
      
      public var entity:Entity;
      
      public var stun_percent:Number;
      
      public var IS_STUNNED:Boolean;
      
      public var sprite:StunStarsSprite;
      
      public var stun_counter_1:int;
      
      public var stun_counter_2:int;
      
      public var stun_x_offset:int;
      
      public var stun_y_offset:int;
      
      public var frame_counter:Number;
      
      public var frame_speed:Number;
      
      public var UPDATE_GAME_OVER_FLAG:Boolean;
      
      protected var STUN_TIME_CAT:int;
      
      protected var STUN_TIME_VEHICLE:int;
      
      protected var BAND_AID_JUST_ONCE:Boolean;
      
      public function StunHandler(_level:Level, _entity:Entity, _stunTime:int = 420)
      {
         super();
         this.level = _level;
         this.entity = _entity;
         this.IS_STUNNED = false;
         this.UPDATE_GAME_OVER_FLAG = false;
         this.BAND_AID_JUST_ONCE = false;
         this.stun_percent = 0;
         this.sprite = new StunStarsSprite();
         Utils.topWorld.addChild(this.sprite);
         this.sprite.gotoAndStop(1);
         this.sprite.visible = false;
         this.stun_x_offset = 1;
         this.stun_y_offset = -8;
         this.stun_counter_1 = this.stun_counter_2 = 0;
         this.frame_counter = 0;
         this.frame_speed = 0.2;
         this.STUN_TIME_CAT = _stunTime;
         this.STUN_TIME_VEHICLE = 360;
      }
      
      public function destroy() : void
      {
         Utils.topWorld.removeChild(this.sprite);
         this.sprite.destroy();
         this.sprite.dispose();
         this.sprite = null;
         this.level = null;
         this.entity = null;
      }
      
      public function setStunTime(new_time:int) : void
      {
         this.STUN_TIME_CAT = new_time;
      }
      
      public function update() : void
      {
         var stun_multiplier:Number = 1;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_BAND_AID && this.entity is Hero)
         {
            stun_multiplier = 0.75;
         }
         if(this.IS_STUNNED)
         {
            ++this.stun_counter_1;
            this.stun_percent = 100 - this.stun_counter_1 * 100 / this.STUN_TIME_CAT;
            if(this.entity.isInsideVehicle())
            {
               if(this.stun_counter_1 > this.STUN_TIME_VEHICLE * stun_multiplier - 45)
               {
                  if(stun_multiplier < 1)
                  {
                     if(this.BAND_AID_JUST_ONCE)
                     {
                        this.BAND_AID_JUST_ONCE = false;
                        this.createBandAidParticleSprite();
                     }
                  }
                  ++this.stun_counter_2;
                  if(this.stun_counter_2 > 2)
                  {
                     this.stun_counter_2 = 0;
                     this.sprite.visible = !this.sprite.visible;
                  }
                  if(this.stun_counter_1 > this.STUN_TIME_VEHICLE * stun_multiplier)
                  {
                     this.unstun();
                  }
               }
            }
            else if(this.stun_counter_1 > this.STUN_TIME_CAT * stun_multiplier - 45)
            {
               if(stun_multiplier < 1)
               {
                  if(this.BAND_AID_JUST_ONCE)
                  {
                     this.BAND_AID_JUST_ONCE = false;
                     this.createBandAidParticleSprite();
                  }
               }
               ++this.stun_counter_2;
               if(this.stun_counter_2 > 2)
               {
                  this.stun_counter_2 = 0;
                  this.sprite.visible = !this.sprite.visible;
               }
               if(this.stun_counter_1 > this.STUN_TIME_CAT * stun_multiplier)
               {
                  this.unstun();
               }
            }
            this.updateFrames();
         }
      }
      
      public function createBandAidParticleSprite() : void
      {
         var particle:Particle = null;
         var pSprite:GameSprite = new ItemHeroParticleSprite();
         pSprite.gfxHandleClip().gotoAndStop(1);
         particle = this.level.particlesManager.pushParticle(pSprite,this.entity.WIDTH * 0.5,this.entity.HEIGHT * 0.5,0,0,0);
         particle.setEntity(this.level.hero);
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var mult:Number = NaN;
         if(this.UPDATE_GAME_OVER_FLAG)
         {
            return;
         }
         if(this.IS_STUNNED)
         {
            if(this.entity.stateMachine.currentState == "IS_CLIMBING_STATE" || this.entity.stateMachine.currentState == "IS_DRIFTING_STATE" || this.entity.stateMachine.currentState == "IS_SLIDING_STATE")
            {
               mult = 1;
               if(this.entity.DIRECTION == Entity.LEFT)
               {
                  mult = -1;
               }
               this.sprite.x = int(Math.floor(this.entity.xPos + this.entity.WIDTH * 0.5 - camera.xPos)) + (this.entity.WIDTH + 4) * -mult;
               this.sprite.y = int(Math.floor(this.entity.yPos + this.entity.HEIGHT * 0.5 - camera.yPos + this.stun_x_offset * -mult));
               if(this.entity.DIRECTION == Entity.RIGHT)
               {
                  this.sprite.rotation = 1.5 * Math.PI * mult;
               }
               else
               {
                  this.sprite.rotation = 1.5 * Math.PI * mult;
               }
            }
            else
            {
               this.sprite.x = int(Math.floor(this.entity.xPos + this.stun_x_offset + this.entity.WIDTH * 0.5 - camera.xPos));
               this.sprite.y = int(Math.floor(this.entity.yPos + this.stun_y_offset - camera.yPos));
               this.sprite.rotation = 0;
            }
            this.sprite.updateScreenPosition();
         }
      }
      
      public function onTop() : void
      {
         Utils.topWorld.setChildIndex(this.sprite,Utils.topWorld.numChildren - 1);
      }
      
      public function updateGameOver(gSprite:GameSprite, _yPos:Number) : void
      {
         this.sprite.rotation = 0;
         this.sprite.visible = true;
         this.sprite.x = gSprite.x;
         this.sprite.y = int(Math.floor(_yPos - this.entity.HEIGHT - this.level.camera.yPos));
         this.sprite.gotoAndStop(1);
         Utils.topWorld.setChildIndex(this.sprite,Utils.topWorld.numChildren - 1);
         this.UPDATE_GAME_OVER_FLAG = true;
         this.sprite.updateScreenPosition();
         this.updateFrames();
      }
      
      protected function updateFrames() : void
      {
         this.frame_counter += this.frame_speed;
         if(this.frame_counter >= 5)
         {
            this.frame_counter -= 5;
         }
         this.sprite.gfxHandleClip().gotoAndStop(this.frame_counter + 1);
      }
      
      public function stun() : void
      {
         this.stun_percent = 100;
         this.IS_STUNNED = this.BAND_AID_JUST_ONCE = true;
         this.stun_counter_1 = this.stun_counter_2 = 0;
         this.sprite.visible = true;
         Utils.topWorld.setChildIndex(this.sprite,Utils.world.numChildren - 1);
         if(this.entity.isInsideVehicle())
         {
            this.sprite.gotoAndStop(2);
         }
         else
         {
            this.sprite.gotoAndStop(1);
         }
      }
      
      public function unstun() : void
      {
         this.IS_STUNNED = false;
         this.sprite.visible = false;
      }
   }
}
