package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.BigIcycleCollisionSprite;
   import sprites.particles.EnemyHurtParticleSprite;
   
   public class BigIcycleCollision extends Collision
   {
       
      
      protected var stateMachine:StateMachine;
      
      public function BigIcycleCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = new BigIcycleCollisionSprite();
         Utils.topWorld.addChild(sprite);
         WIDTH = 13;
         HEIGHT = 12;
         aabb = new Rectangle(0,0,WIDTH,HEIGHT);
         counter1 = counter2 = 0;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_STANDING_STATE","END_ACTION","IS_SHAKING_STATE");
         this.stateMachine.setRule("IS_SHAKING_STATE","END_ACTION","IS_FALLING_STATE");
         this.stateMachine.setRule("IS_FALLING_STATE","END_ACTION","IS_DESTROYED_STATE");
         this.stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         this.stateMachine.setFunctionToState("IS_SHAKING_STATE",this.shakingAnimation);
         this.stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         this.stateMachine.setFunctionToState("IS_DESTROYED_STATE",this.destroyedAnimation);
         this.stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         if(this.stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               sprite.gfxHandleClip().setFrameDuration(0,int(Math.round(Math.random() * 3 + 2)));
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(this.stateMachine.currentState == "IS_SHAKING_STATE")
         {
            ++counter1;
            if(counter1 > 2)
            {
               SoundSystem.PlaySound("ice_shake");
               counter1 = 0;
               ++counter2;
               if(xPos <= originalXPos)
               {
                  xPos = originalXPos + 1;
               }
               else
               {
                  xPos = originalXPos - 1;
               }
               if(counter2 >= 12)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_FALLING_STATE")
         {
            yPos += 4;
            x_t = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
            y_t = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) != 0)
            {
               this.impactParticles();
               if(isInsideScreen())
               {
                  SoundSystem.PlaySound("ice_impact");
               }
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_DESTROYED_STATE")
         {
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_mid_x:Number = NaN;
         var mid_x:Number = NaN;
         var wide:int = 0;
         var area:Rectangle = null;
         var hero_area:Rectangle = null;
         if(this.stateMachine.currentState == "IS_STANDING_STATE")
         {
            hero_mid_x = level.hero.xPos + level.hero.WIDTH * 0.5 + level.hero.xVel * 16;
            mid_x = xPos + WIDTH * 0.5;
            wide = 5;
            if(Utils.CurrentLevel == 32)
            {
               wide = 1;
            }
            if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * wide && level.hero.yPos > yPos && Math.abs(yPos - level.hero.yPos) < 128)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_FALLING_STATE")
         {
            area = getAABB();
            hero_area = level.hero.getAABB();
            if(area.intersects(hero_area))
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_SHIELD_ && this.isHeroFacingBullet())
               {
                  level.particlesManager.shieldItemParticle(level.hero,xPos,yPos);
               }
               else
               {
                  level.hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,null);
               }
               this.impactParticles();
               this.stateMachine.setState("IS_DESTROYED_STATE");
            }
         }
      }
      
      protected function isHeroFacingBullet() : Boolean
      {
         if(level.hero.DIRECTION == Entity.LEFT)
         {
            if(xPos + WIDTH * 0.5 > level.hero.getMidXPos())
            {
               return false;
            }
            return true;
         }
         if(xPos + WIDTH * 0.5 < level.hero.getMidXPos())
         {
            return false;
         }
         return true;
      }
      
      override public function reset() : void
      {
         xPos = originalXPos;
         yPos = originalYPos;
         this.stateMachine.setState("IS_STANDING_STATE");
      }
      
      protected function standingAnimation() : void
      {
         sprite.visible = true;
      }
      
      protected function shakingAnimation() : void
      {
         sprite.gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = 0;
      }
      
      protected function fallingAnimation() : void
      {
      }
      
      protected function destroyedAnimation() : void
      {
         sprite.visible = false;
      }
      
      protected function impactParticles() : void
      {
         level.particlesManager.pushParticle(new EnemyHurtParticleSprite(),xPos + 8,yPos - 4,0,0,0);
      }
   }
}
