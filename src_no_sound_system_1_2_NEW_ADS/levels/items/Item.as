package levels.items
{
   import entities.Easings;
   import entities.Entity;
   import entities.enemies.*;
   import flash.geom.Rectangle;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.particles.ItemExplosionParticleSprite;
   
   public class Item extends Entity
   {
       
      
      public var index:int;
      
      public var level_index:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var tick_1:Number;
      
      protected var got_already:Boolean;
      
      protected var first_bounce_flag:Boolean;
      
      protected var start_level_counter:int;
      
      protected var standing_sound_counter:int;
      
      protected var IS_INSIDE_BUBBLE:Boolean;
      
      protected var float_y_offset:Number;
      
      protected var float_sin:Number;
      
      protected var path_start_x:Number;
      
      protected var path_end_x:Number;
      
      protected var path_start_y:Number;
      
      protected var path_end_y:Number;
      
      protected var MOVEMENT_TYPE:int;
      
      protected var IS_A_TO_B:Boolean;
      
      protected var PROGRESSION:int;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var IS_TOP_WORLD:Boolean;
      
      public var entity:Entity;
      
      public function Item(_level:Level, _xPos:Number, _yPos:Number, _index:int = -1)
      {
         super(_level,_xPos,_yPos,0);
         this.IS_INSIDE_BUBBLE = false;
         this.t_tick = this.t_time = this.t_start = this.t_diff = 0;
         this.PROGRESSION = 0;
         this.index = _index;
         WIDTH = HEIGHT = 16;
         this.start_level_counter = 0;
         this.MOVEMENT_TYPE = 0;
         this.IS_A_TO_B = true;
         this.entity = null;
         this.IS_TOP_WORLD = false;
         this.path_start_x = this.path_end_x = this.path_start_y = this.path_end_y = 0;
         this.float_y_offset = 0;
         this.float_sin = Math.random() * Math.PI * 2;
         dead = false;
         this.got_already = LevelItems.HasLevelItemBeenGot(this.index);
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","COLLECTED_ACTION","IS_COLLECTED_STATE");
         stateMachine.setRule("IS_COLLECTED_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setRule("IS_BONUS_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_COLLECTED_STATE",this.collectedAnimation);
         stateMachine.setFunctionToState("IS_BONUS_STATE",this.bonusAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         this.counter_1 = 0;
         this.counter_2 = 0;
         this.standing_sound_counter = 0;
         this.tick_1 = 0;
         this.first_bounce_flag = false;
         aabb = new Rectangle(0,4,16,12);
      }
      
      override public function destroy() : void
      {
         this.entity = null;
         if(stateMachine != null)
         {
            stateMachine.destroy();
            stateMachine = null;
         }
         if(stunHandler != null)
         {
            stunHandler.destroy();
            stunHandler = null;
         }
         if(sprite != null)
         {
            if(IS_BACK_WORLD)
            {
               Utils.backWorld.removeChild(sprite);
            }
            else if(this.IS_TOP_WORLD)
            {
               Utils.topWorld.removeChild(sprite);
            }
            else
            {
               Utils.world.removeChild(sprite);
            }
            sprite.destroy();
            sprite.dispose();
            sprite = null;
         }
         colliding_platform = null;
         airCollision = null;
         aabb = aabbPhysics = aabbSpike = null;
         level = null;
      }
      
      public function postInit() : void
      {
      }
      
      override public function update() : void
      {
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               sprite.gfxHandleClip().setFrameDuration(0,int(Math.random() * 3 + 2));
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
            if(this.IS_INSIDE_BUBBLE == false)
            {
               if(level.core_tick >= 200)
               {
                  if(this.isInsideSoundScreen())
                  {
                     if(sprite.gfxHandleClip().currentFrame == 7 && this.standing_sound_counter == 0)
                     {
                        this.standing_sound_counter = 1;
                        if(Utils.SEA_LEVEL > 0)
                        {
                           if(yPos >= Utils.SEA_LEVEL)
                           {
                              SoundSystem.PlaySound("item_impact_water");
                           }
                           else
                           {
                              SoundSystem.PlaySound("item_impact");
                           }
                        }
                        else
                        {
                           SoundSystem.PlaySound("item_impact");
                        }
                     }
                     else if(sprite.gfxHandleClip().currentFrame == 11 && this.standing_sound_counter == 1)
                     {
                        this.standing_sound_counter = 0;
                        if(Utils.SEA_LEVEL > 0)
                        {
                           if(yPos >= Utils.SEA_LEVEL)
                           {
                              SoundSystem.PlaySound("item_impact_water");
                           }
                           else
                           {
                              SoundSystem.PlaySound("item_impact");
                           }
                        }
                        else
                        {
                           SoundSystem.PlaySound("item_impact");
                        }
                     }
                  }
               }
               this.adjustAABB();
               yVel += 0.2;
               yPos += yVel;
               originalYPos = yPos;
               level.levelPhysics.collisionDetectionMap(this);
            }
            else
            {
               sprite.gfxHandleClip().gotoAndStop(1);
               if(this.MOVEMENT_TYPE == 1)
               {
                  if(this.PROGRESSION == 0)
                  {
                     this.t_tick = 0;
                     this.t_time = Math.abs(this.path_end_y - this.path_start_y) / 32;
                     if(Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL)
                     {
                        this.t_time *= 2;
                     }
                     if(this.IS_A_TO_B)
                     {
                        this.t_start = this.path_start_y;
                        this.t_diff = this.path_end_y - this.path_start_y;
                     }
                     else
                     {
                        this.t_start = this.path_end_y;
                        this.t_diff = this.path_start_y - this.path_end_y;
                     }
                     this.PROGRESSION = 1;
                  }
                  else if(this.PROGRESSION == 1)
                  {
                     this.t_tick += 1 / 60;
                     if(this.t_tick >= this.t_time)
                     {
                        this.t_tick = this.t_time;
                        this.PROGRESSION = 0;
                        this.IS_A_TO_B = !this.IS_A_TO_B;
                     }
                     yPos = originalYPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
                  }
               }
               else if(this.MOVEMENT_TYPE == 2)
               {
                  if(this.PROGRESSION == 0)
                  {
                     this.t_tick = 0;
                     this.t_time = Math.abs(this.path_end_x - this.path_start_x) / 32;
                     if(Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL)
                     {
                        this.t_time *= 2;
                     }
                     if(this.IS_A_TO_B)
                     {
                        this.t_start = this.path_start_x;
                        this.t_diff = this.path_end_x - this.path_start_x;
                     }
                     else
                     {
                        this.t_start = this.path_end_x;
                        this.t_diff = this.path_start_x - this.path_end_x;
                     }
                     this.PROGRESSION = 1;
                  }
                  else if(this.PROGRESSION == 1)
                  {
                     this.t_tick += 1 / 60;
                     if(this.t_tick >= this.t_time)
                     {
                        this.t_tick = this.t_time;
                        this.PROGRESSION = 0;
                        this.IS_A_TO_B = !this.IS_A_TO_B;
                     }
                     xPos = originalXPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
                  }
               }
               this.float_sin += 0.05;
               if(this.float_sin > Math.PI * 2)
               {
                  this.float_sin -= Math.PI * 2;
               }
               this.float_y_offset = Math.sin(this.float_sin) * 4;
            }
         }
         else if(stateMachine.currentState == "IS_BONUS_STATE")
         {
            if(this.entity != null)
            {
               xPos = this.entity.xPos + this.entity.WIDTH * 0.5 - 8;
               yPos = this.entity.yPos - 32;
            }
            if(this.counter_1++ > 45)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_COLLECTED_STATE")
         {
            if(this.counter_1 == 0)
            {
               ++this.counter_2;
               if(this.counter_2 >= 6)
               {
                  ++this.counter_1;
                  this.counter_2 = 0;
                  sprite.gotoAndStop(3);
                  sprite.gfxHandleClip().gotoAndPlay(1);
                  yVel = -8;
               }
            }
            else if(this.counter_1 == 1)
            {
               yPos += yVel;
               if(yPos <= originalYPos - 8 && sprite.frame == 3)
               {
                  sprite.gotoAndStop(4);
                  sprite.gfxHandleClip().gotoAndPlay(1);
               }
               if(Math.abs(yPos - originalYPos) >= 12)
               {
                  ++this.counter_1;
                  this.counter_2 = 0;
                  yVel = 0;
                  yPos = originalYPos - 12;
                  this.tick_1 = 0;
               }
            }
            else if(this.counter_1 == 2)
            {
               this.tick_1 += 1 / 60;
               if(this.tick_1 >= 0.5)
               {
                  this.tick_1 = 0.5;
                  this.counter_1 = 3;
               }
               yPos = Easings.easeOutQuad(this.tick_1,originalYPos - 12,-12,0.5);
            }
            else if(this.counter_1 == 3)
            {
               ++this.counter_2;
               if(this.counter_2 >= 0)
               {
                  stateMachine.performAction("END_ACTION");
                  if(this.isInsideSoundScreen())
                  {
                     SoundSystem.PlaySound("item_pop");
                  }
                  level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos + WIDTH * 0.5,yPos + 5,0,0,0);
               }
            }
         }
      }
      
      public function updateFreeze() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.MOVEMENT_TYPE == 1)
         {
            sprite.x = int(Math.floor(xPos + this.float_y_offset - camera.xPos));
            sprite.y = int(Math.floor(yPos - camera.yPos));
         }
         else if(this.MOVEMENT_TYPE == 2)
         {
            sprite.x = int(Math.floor(xPos - camera.xPos));
            sprite.y = int(Math.floor(yPos + this.float_y_offset - camera.yPos));
         }
         else
         {
            sprite.x = int(Math.floor(xPos - camera.xPos));
            sprite.y = int(Math.floor(yPos + this.float_y_offset - camera.yPos));
         }
         sprite.updateScreenPosition();
      }
      
      public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABB();
         var this_aabb:Rectangle = getAABB();
         if(hero_aabb.intersects(this_aabb))
         {
            this.collected();
         }
      }
      
      public function collected() : void
      {
         stateMachine.performAction("COLLECTED_ACTION");
         Utils.LEVEL_ITEMS[this.level_index] = true;
      }
      
      protected function standingAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.counter_1 = this.counter_2 = 0;
      }
      
      protected function collectedAnimation() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 0;
         this.tick_1 = 0;
         SoundSystem.PlaySound("bell_collected");
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         Utils.world.removeChild(sprite);
         Utils.topWorld.addChild(sprite);
         this.IS_TOP_WORLD = true;
         Utils.ItemCollected(this.index);
      }
      
      protected function bonusAnimation() : void
      {
         this.counter_1 = 0;
         sprite.gotoAndStop(5);
         sprite.gfxHandleClip().gotoAndPlay(1);
         SoundSystem.PlaySound("item_appear");
         level.particlesManager.itemSparkles("yellow",8,8,WIDTH,this);
      }
      
      protected function deadAnimation() : void
      {
         dead = true;
      }
      
      override public function groundCollision() : void
      {
         if(!this.first_bounce_flag)
         {
            if(this.isInsideSoundScreen())
            {
               if(level.core_tick >= 200)
               {
                  if(Utils.SEA_LEVEL > 0)
                  {
                     if(yPos >= Utils.SEA_LEVEL)
                     {
                        SoundSystem.PlaySound("item_impact_water");
                     }
                     else
                     {
                        SoundSystem.PlaySound("item_impact");
                     }
                  }
                  else
                  {
                     SoundSystem.PlaySound("item_impact");
                  }
               }
            }
            yVel = -2;
         }
         this.first_bounce_flag = true;
      }
      
      protected function adjustAABB() : void
      {
         var frame:int = sprite.gfxHandleClip().currentFrame;
         if(frame == 1 || frame == 7)
         {
            aabb.y = 6;
         }
         else if(frame >= 2 && frame <= 6)
         {
            aabb.y = -2;
         }
         else
         {
            aabb.y = 4;
         }
      }
      
      protected function isInsideSoundScreen() : Boolean
      {
         if(level.stateMachine.currentState == "IS_INTRO_STATE")
         {
            return false;
         }
         return level.camera.getCameraRect().intersects(getAABB());
      }
   }
}
