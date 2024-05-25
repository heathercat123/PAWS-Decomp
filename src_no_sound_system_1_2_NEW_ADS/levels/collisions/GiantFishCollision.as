package levels.collisions
{
   import entities.Easings;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.particles.*;
   import sprites.tutorials.*;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class GiantFishCollision extends Collision
   {
       
      
      protected var container:Sprite;
      
      protected var body:Image;
      
      protected var stateMachine:StateMachine;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var sin_counter_1:Number;
      
      protected var HAS_EXITED_THE_AREA:Boolean;
      
      protected var JUST_ONCE:Boolean;
      
      protected var bite_sound_counter:int;
      
      public function GiantFishCollision(_level:Level, _xPos:Number, _yPos:Number, _isOnTopOfOtherCrates:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.sin_counter_1 = 0;
         this.bite_sound_counter = 0;
         this.HAS_EXITED_THE_AREA = true;
         this.JUST_ONCE = true;
         this.container = new Sprite();
         Utils.backWorld.addChild(this.container);
         this.body = new Image(TextureManager.GetBackgroundTexture().getTexture("giantFishBodyCollisionSpriteAnim_a"));
         this.body.pivotX = 30;
         this.body.pivotY = 32;
         this.body.touchable = false;
         this.container.addChild(this.body);
         sprite = new GenericCollisionSprite(7);
         this.container.addChild(sprite);
         this.container.filter = new FragmentFilter();
         FragmentFilter(this.container.filter).resolution = Utils.GFX_INV_SCALE;
         FragmentFilter(this.container.filter).textureSmoothing = TextureSmoothing.NONE;
         aabb.x = -16;
         aabb.y = -16;
         aabb.width = 32;
         aabb.height = 32;
         WIDTH = HEIGHT = 32;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         counter1 = 0;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_GONE_STATE","END_ACTION","IS_CHARGING_STATE");
         this.stateMachine.setRule("IS_CHARGING_STATE","END_ACTION","IS_ATTACKING_STATE");
         this.stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_LEAVING_STATE");
         this.stateMachine.setRule("IS_LEAVING_STATE","END_ACTION","IS_GONE_STATE");
         this.stateMachine.setFunctionToState("IS_GONE_STATE",this.goneAnimation);
         this.stateMachine.setFunctionToState("IS_CHARGING_STATE",this.chargingAnimation);
         this.stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         this.stateMachine.setFunctionToState("IS_LEAVING_STATE",this.leavingAnimation);
         this.stateMachine.setState("IS_GONE_STATE");
      }
      
      override public function destroy() : void
      {
         this.container.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         this.container.removeChild(this.body);
         this.body.dispose();
         this.body = null;
         this.container.filter.dispose();
         Utils.backWorld.removeChild(this.container);
         this.container.filter = null;
         this.container = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var diff_x:Number = level.hero.getMidXPos() - xPos;
         var diff_y:Number = level.hero.getMidYPos() - yPos;
         var distance:* = diff_x * diff_x + diff_y * diff_y;
         if(distance >= 104 * 104)
         {
            this.HAS_EXITED_THE_AREA = true;
         }
         if(this.stateMachine.currentState == "IS_GONE_STATE")
         {
            if(distance <= 80 * 80 && this.HAS_EXITED_THE_AREA && this.JUST_ONCE)
            {
               this.JUST_ONCE = false;
               this.HAS_EXITED_THE_AREA = false;
               this.bite_sound_counter = 0;
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_CHARGING_STATE")
         {
            if(this.bite_sound_counter++ == 30)
            {
               SoundSystem.PlaySound("giant_fish_swoosh");
            }
            this.sin_counter_1 += 0.2;
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.stateMachine.performAction("END_ACTION");
            }
            this.container.scaleX = this.container.scaleY = Easings.easeInExpo(this.t_tick,this.t_start,this.t_diff,this.t_time);
            this.container.alpha = (Easings.easeInCubic(this.t_tick,this.t_start,this.t_diff,this.t_time) - 0.5) * 2;
         }
         else if(this.stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            if(this.bite_sound_counter++ == 5)
            {
               SoundSystem.PlaySound("giant_fish_roar");
            }
            if(counter1++ >= 120)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_LEAVING_STATE")
         {
            this.sin_counter_1 += 0.2;
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.stateMachine.performAction("END_ACTION");
            }
            this.container.scaleX = this.container.scaleY = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
            if(counter1++ > 6)
            {
               counter1 = 0;
               this.container.alpha -= 0.2;
               if(this.container.alpha <= 0)
               {
                  this.container.alpha = 0;
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = null;
         if(this.stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            hero_aabb = level.hero.getAABB();
            if(Utils.CircleRectHitTest(xPos,yPos,16,hero_aabb.x,hero_aabb.y,hero_aabb.x + hero_aabb.width,hero_aabb.y + hero_aabb.height))
            {
               level.hero.hurt(xPos,yPos,null);
            }
         }
      }
      
      protected function goneAnimation() : void
      {
         counter1 = 0;
         this.container.visible = false;
      }
      
      protected function chargingAnimation() : void
      {
         counter1 = 0;
         this.container.visible = true;
         this.container.alpha = 0;
         this.container.scaleX = this.container.scaleY = 0.5;
         sprite.gfxHandleClip().gotoAndStop(1);
         this.t_start = 0.5;
         this.t_diff = 0.5;
         this.t_time = 2;
         this.t_tick = 0;
      }
      
      protected function attackingAnimation() : void
      {
         this.bite_sound_counter = 0;
         SoundSystem.PlaySound("ground_stomp");
         level.camera.verShake();
         this.sin_counter_1 = 0;
         counter1 = 0;
         level.particlesManager.createClusterBubbles(xPos,yPos);
         level.backgroundsManager.background.shake();
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function leavingAnimation() : void
      {
         sprite.gfxHandleClip().gotoAndStop(1);
         this.t_start = 1;
         this.t_diff = -0.5;
         this.t_time = 1;
         this.t_tick = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos + Math.sin(this.sin_counter_1) * 2 - camera.yPos));
         sprite.y = int(Math.sin(this.sin_counter_1) * 4);
         Utils.backWorld.setChildIndex(this.container,0);
      }
   }
}
