package levels.decorations
{
   import flash.geom.*;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import sprites.decorations.OutsideBoneDecorationSprite;
   import sprites.particles.BoneParticleSprite;
   
   public class OutsideBoneDecoration extends Decoration
   {
       
      
      public var isBlown:Boolean;
      
      protected var id:int;
      
      public var HAS_COIN:Boolean;
      
      public function OutsideBoneDecoration(_level:Level, _xPos:Number, _yPos:Number, _id:int, _has_coin:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.id = _id;
         if(_has_coin > 0)
         {
            this.HAS_COIN = true;
         }
         sprite = new OutsideBoneDecorationSprite();
         Utils.topWorld.addChild(sprite);
         if(_id == 0)
         {
            sprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            sprite.gfxHandleClip().gotoAndStop(3);
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
      
      protected function blow() : void
      {
         var pSprite:BoneParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         SoundSystem.PlaySound("bone");
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
         if(this.id == 0)
         {
            sprite.gfxHandleClip().gotoAndStop(2);
         }
         else
         {
            sprite.gfxHandleClip().gotoAndStop(4);
         }
         var max:int = 2;
         if(Math.random() * 100 > 80)
         {
            max = 3;
         }
         for(i = 0; i < 1; i++)
         {
            pSprite = new BoneParticleSprite();
            angle = Math.random() * Math.PI * 2;
            if(_vel > 0)
            {
               pSprite.scaleX = 1;
            }
            else
            {
               pSprite.scaleX = -1;
            }
            level.particlesManager.pushParticle(pSprite,xPos + 8,yPos + 8,_vel * (i + 1 + Math.random() * 1),-(1 + Math.random() * 2),1);
         }
      }
   }
}
