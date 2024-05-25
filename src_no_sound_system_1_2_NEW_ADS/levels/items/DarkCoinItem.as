package levels.items
{
   import entities.Easings;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.items.DarkCoinItemSprite;
   import sprites.particles.ItemExplosionParticleSprite;
   
   public class DarkCoinItem extends Item
   {
      
      public static var CAUGHT_COUNTER:int;
       
      
      public var IS_FROZEN:Boolean;
      
      protected var MULTIPLIER:Number;
      
      public function DarkCoinItem(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos,-1);
         CAUGHT_COUNTER = 0;
         this.MULTIPLIER = 1;
         sprite = new DarkCoinItemSprite();
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         stateMachine.setState("IS_STANDING_STATE");
         counter3 = 0;
         aabb.x = 3;
         aabb.y = 2;
         aabb.width = 10;
         aabb.height = 17;
         this.IS_FROZEN = false;
      }
      
      override public function update() : void
      {
         if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState != "IS_BONUS_STATE")
            {
               if(stateMachine.currentState == "IS_COLLECTED_STATE")
               {
                  if(counter_1 == 0)
                  {
                     ++counter_2;
                     if(counter_2 >= 6)
                     {
                        ++counter_1;
                        counter_2 = 0;
                        sprite.gotoAndStop(4);
                        sprite.gfxHandleClip().gotoAndPlay(1);
                        yVel = -8;
                     }
                  }
                  else if(counter_1 == 1)
                  {
                     yPos += yVel;
                     if(yPos <= originalYPos - 8 && sprite.frame == 3)
                     {
                        sprite.gotoAndStop(4);
                        sprite.gfxHandleClip().gotoAndPlay(1);
                     }
                     if(Math.abs(yPos - originalYPos) >= 12)
                     {
                        ++counter_1;
                        counter_2 = 0;
                        yVel = 0;
                        yPos = originalYPos - 12;
                        tick_1 = 0;
                     }
                  }
                  else if(counter_1 == 2)
                  {
                     tick_1 += 1 / 60;
                     if(tick_1 >= 0.5)
                     {
                        tick_1 = 0.5;
                        counter_1 = 3;
                     }
                     yPos = Easings.easeOutQuad(tick_1,originalYPos - 12,-12,0.5);
                  }
                  else if(counter_1 == 3)
                  {
                     ++counter_2;
                     if(counter_2 >= 30)
                     {
                        ++CAUGHT_COUNTER;
                        if(isInsideSoundScreen())
                        {
                           SoundSystem.PlaySound("item_pop");
                        }
                        stateMachine.performAction("END_ACTION");
                        level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos + WIDTH * 0.5,yPos + 8,0,0,0);
                     }
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(sprite.frame == 1 && !this.IS_FROZEN)
         {
            sprite.gfxHandleClip().gotoAndStop(level.itemsManager.coin_frame + 1);
         }
      }
      
      public function collectedAndApplyMultiplier(_multiplier:Number = 1) : void
      {
         this.MULTIPLIER = _multiplier;
         collected();
      }
      
      override protected function collectedAnimation() : void
      {
         counter_1 = 0;
         counter_2 = 0;
         tick_1 = 0;
         SoundSystem.PlaySound("red_coin");
         Utils.AddCoins(1 * this.MULTIPLIER);
         level.particlesManager.itemSparkles("red",aabb.x + aabb.width * 0.5,aabb.y + aabb.height * 0.5,-1,this);
         sprite.gotoAndStop(4);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      override public function getMidXPos() : Number
      {
         return xPos + 8;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos + 8;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
