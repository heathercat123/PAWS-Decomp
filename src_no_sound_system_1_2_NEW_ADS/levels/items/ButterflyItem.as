package levels.items
{
   import levels.Level;
   import sprites.items.ButterflyItemSprite;
   import sprites.particles.NumberParticleSprite;
   
   public class ButterflyItem extends Item
   {
      
      public static var CAUGHT_COUNTER:int;
       
      
      protected var invisible_counter:int;
      
      protected var sin_counter:Number;
      
      protected var radius:Number;
      
      protected var GO_UP:Boolean;
      
      protected var CLOCKWISE:Boolean;
      
      protected var appear_counter:int;
      
      protected var life_counter:int;
      
      public function ButterflyItem(_level:Level, _xPos:Number, _yPos:Number, _index:int)
      {
         super(_level,_xPos,_yPos,-1);
         CAUGHT_COUNTER = 0;
         this.sin_counter = 0;
         this.invisible_counter = this.appear_counter = 0;
         this.life_counter = 0;
         aabb.x = -7;
         aabb.y = -5;
         aabb.width = 13;
         aabb.height = 11;
         this.radius = Math.random() * 4;
         this.GO_UP = true;
         if(Math.random() * 100 > 50)
         {
            this.CLOCKWISE = true;
         }
         else
         {
            this.CLOCKWISE = false;
         }
         sprite = new ButterflyItemSprite();
         Utils.world.addChild(sprite);
         sprite.gotoAndStop(_index + 1);
         sprite.gfxHandleClip().gotoAndPlay(int(Math.random() * 3) + 1);
         stateMachine.setRule("IS_INVISIBLE_STATE","APPEAR_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_INVISIBLE_STATE",this.invisibleAnimation);
         stateMachine.setState("IS_INVISIBLE_STATE");
      }
      
      override public function update() : void
      {
         if(stateMachine.currentState == "IS_INVISIBLE_STATE")
         {
            if(this.invisible_counter++ > 0)
            {
               stateMachine.performAction("APPEAR_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(this.CLOCKWISE)
            {
               this.sin_counter += 0.05;
            }
            else
            {
               this.sin_counter -= 0.05;
            }
            if(Math.random() * 500 > 480)
            {
               this.CLOCKWISE = !this.CLOCKWISE;
            }
            xPos = originalXPos + Math.sin(this.sin_counter) * int(this.radius) * 2;
            yPos = originalYPos + Math.cos(this.sin_counter) * int(this.radius) * 2;
            if(this.GO_UP)
            {
               this.radius += Math.random() * 0.2;
               if(this.radius >= 4)
               {
                  this.radius = 4;
                  this.GO_UP = false;
               }
            }
            else
            {
               this.radius -= Math.random() * 0.2;
               if(this.radius <= 0)
               {
                  this.radius = 0;
                  this.GO_UP = true;
               }
            }
         }
         ++this.life_counter;
         if(this.life_counter >= 14 * 60)
         {
            ++counter1;
            if(counter1 > 3)
            {
               counter1 = 0;
               sprite.visible = !sprite.visible;
            }
            if(this.life_counter >= 15 * 60)
            {
               stateMachine.performAction("END_ACTION");
               level.restoreLevelMusicAfterButterflies();
            }
         }
      }
      
      override protected function standingAnimation() : void
      {
         sprite.visible = true;
         level.particlesManager.itemSparkles("yellow",0,0,WIDTH,this);
         SoundSystem.PlaySound("item_appear");
         this.appear_counter = int(Math.random() * 2 + 3) * 10;
      }
      
      protected function invisibleAnimation() : void
      {
         this.invisible_counter = -int(Math.random() * 30);
         sprite.visible = false;
      }
      
      override protected function collectedAnimation() : void
      {
         stateMachine.performAction("END_ACTION");
         ++CAUGHT_COUNTER;
         if(CAUGHT_COUNTER >= 5)
         {
            level.restoreLevelMusicAfterButterflies();
         }
         SoundSystem.PlaySound("butterfly_collect_" + CAUGHT_COUNTER);
         var pSprite:NumberParticleSprite = new NumberParticleSprite();
         pSprite.gfxHandleClip().gotoAndStop(CAUGHT_COUNTER);
         level.topParticlesManager.pushParticle(pSprite,xPos,yPos,0,0,0);
      }
   }
}
