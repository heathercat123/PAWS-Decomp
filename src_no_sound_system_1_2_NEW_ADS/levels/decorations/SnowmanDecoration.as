package levels.decorations
{
   import flash.geom.*;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import sprites.decorations.SnowmanDecorationSprite;
   import sprites.particles.SnowParticleSprite;
   
   public class SnowmanDecoration extends Decoration
   {
       
      
      public var isBlown:Boolean;
      
      public var HAS_COIN:Boolean;
      
      public function SnowmanDecoration(_level:Level, _xPos:Number, _yPos:Number, _has_coin:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.HAS_COIN = false;
         if(_has_coin)
         {
            this.HAS_COIN = true;
         }
         sprite = new SnowmanDecorationSprite();
         Utils.topWorld.addChild(sprite);
         sprite.gotoAndStop(1);
         var x_t:int = int(xPos / Utils.TILE_WIDTH);
         if(x_t % 2 == 0)
         {
            sprite.gfxHandleClip().gotoAndPlay(2);
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var point:Point = null;
         var hero:Rectangle = null;
         if(!this.isBlown)
         {
            point = new Point(xPos + 8,yPos + 8);
            hero = level.hero.getAABB();
            if(hero.containsPoint(point))
            {
               if(level.hero.stateMachine.currentState == "IS_RUNNING_STATE" || level.hero.stateMachine.currentState == "IS_BRAKING_STATE")
               {
                  if(Math.abs(level.hero.xVel) > 1)
                  {
                     this.blow();
                  }
               }
            }
         }
      }
      
      public function revive() : void
      {
         this.isBlown = false;
         sprite.gotoAndStop(1);
         var x_t:int = int(xPos / Utils.TILE_WIDTH);
         if(x_t % 2 == 0)
         {
            sprite.gfxHandleClip().gotoAndPlay(2);
         }
      }
      
      protected function blow() : void
      {
         var pSprite:SnowParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         var vel:Number = NaN;
         SoundSystem.PlaySound("decoration_blown");
         if(this.HAS_COIN && !Utils.LEVEL_DECORATION_ITEMS[level_index])
         {
            SoundSystem.PlaySound("coin");
            Utils.AddCoins(1);
            level.topParticlesManager.createItemParticlesAt(LevelItems.ITEM_COIN,xPos + 8,yPos);
            Utils.LEVEL_DECORATION_ITEMS[level_index] = true;
         }
         var _vel:Number = 1.25;
         if(level.hero.xVel < 0)
         {
            _vel = -1.25;
         }
         this.isBlown = true;
         sprite.gotoAndStop(2);
         var max:int = 3;
         if(Math.random() * 100 > 80)
         {
            max = 4;
         }
         for(i = 0; i < max; i++)
         {
            pSprite = new SnowParticleSprite();
            angle = Math.random() * Math.PI * 2;
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            vel = _vel * (i * 0.5 + 1 + Math.random() * 1);
            level.particlesManager.pushParticle(pSprite,xPos + 7,yPos + 6,vel,-(2 + Math.random() * 1),0.98,(int(Math.random() * 2) + (i + 1)) * 0.1);
         }
      }
   }
}
