package entities
{
   import levels.Level;
   import sprites.GameSprite;
   import sprites.cats.McMeowHeroSprite;
   
   public class BigCatHero extends Hero
   {
       
      
      protected var victory_counter_1:int;
      
      public function BigCatHero(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
         aabbPhysics.x = 2;
         aabbPhysics.y = 0;
         aabbPhysics.width = 12;
         aabbPhysics.height = 16;
         this.victory_counter_1 = 0;
         stunHandler.stun_y_offset = -10;
      }
      
      override protected function getHeroSprite() : GameSprite
      {
         return new McMeowHeroSprite();
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
         {
            if(this.victory_counter_1 == 0)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
               {
                  ++this.victory_counter_1;
                  level.camera.shake(3);
                  SoundSystem.PlaySound("ground_stomp");
               }
            }
            else if(this.victory_counter_1 == 1)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 7)
               {
                  ++this.victory_counter_1;
                  level.camera.shake(3);
                  SoundSystem.PlaySound("ground_stomp");
               }
            }
         }
      }
      
      override public function groundCollision() : void
      {
         var jump_diff:Number = Math.abs(jumped_at_y - getMidYPos());
         if(stateMachine.currentState == "IS_FALLING_RUNNING_STATE")
         {
            if(jump_diff > 28)
            {
               level.camera.shake(1);
               xVel *= 0.25;
               level.freezeAction(5);
               SoundSystem.PlaySound("cat_ground_impact");
            }
         }
         super.groundCollision();
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "jump")
         {
            SoundSystem.PlaySound("cat_jump_low");
         }
         else if(sfx_name == "super_jump")
         {
            SoundSystem.PlaySound("cat_super_jump_low");
         }
         else if(sfx_name == "falls_ground")
         {
            SoundSystem.PlaySound("cat_falls_ground_low");
         }
         else if(sfx_name == "hop")
         {
            SoundSystem.PlaySound("cat_hop_low");
         }
         else if(sfx_name == "cat_attack")
         {
            SoundSystem.PlaySound("enemy_hit");
         }
         else if(sfx_name == "brake")
         {
            SoundSystem.PlaySound("cat_brake_low");
         }
         else if(sfx_name == "run")
         {
            SoundSystem.PlaySound("cat_run_low");
         }
      }
      
      override protected function updateAABB() : void
      {
         aabb.x = 0;
         aabb.y = -2;
         aabb.width = 16;
         aabb.height = 18;
         if(AABB_TYPE == 1)
         {
            aabb.x = 0;
            aabb.y = -4;
            aabb.width = 16;
            aabb.height = 16;
         }
         else if(AABB_TYPE == 2)
         {
            if(DIRECTION == RIGHT)
            {
               aabb.x = -2;
               aabb.y = -4;
               aabb.width = 15;
               aabb.height = 17;
            }
            else
            {
               aabb.x = 3;
               aabb.y = -4;
               aabb.width = 15;
               aabb.height = 17;
            }
         }
      }
      
      override protected function getMaxXVel(state:String) : Number
      {
         if(state == "IS_RUNNING_STATE")
         {
            return 2.8;
         }
         return 1.7;
      }
      
      override protected function getGroundFrictionTime() : Number
      {
         return 0.4;
      }
      
      override public function levelStartAnimation() : void
      {
         super.levelStartAnimation();
         if(!level.hud.IS_DARK_FADE_ON)
         {
            SoundSystem.PlaySound("cat_red");
         }
      }
      
      override public function ropeClimbingAnimation() : void
      {
         super.ropeClimbingAnimation();
         sprite.gfxHandle().gotoAndStop(16);
      }
      
      override public function ropeTurningAnimation() : void
      {
         super.ropeTurningAnimation();
         sprite.gfxHandle().gotoAndStop(17);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
   }
}
