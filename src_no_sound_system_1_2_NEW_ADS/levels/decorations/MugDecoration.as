package levels.decorations
{
   import levels.Level;
   import sprites.GameSprite;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.particles.SmallSteamParticleSprite;
   
   public class MugDecoration extends Decoration
   {
       
      
      public var isBlown:Boolean;
      
      protected var counter1:int;
      
      public function MugDecoration(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _index:int)
      {
         super(_level,_xPos,_yPos);
         if(_index == 0)
         {
            sprite = new GenericDecorationSprite(GenericDecoration.MUG_1);
         }
         else
         {
            sprite = new GenericDecorationSprite(GenericDecoration.MUG_2);
         }
         Utils.backWorld.addChild(sprite);
         this.counter1 = 0;
         if(_direction > 0)
         {
            sprite.scaleX = -1;
         }
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         var pBackSprite:GameSprite = null;
         var _xPos:Number = NaN;
         var _yVel:Number = NaN;
         if(sprite.visible)
         {
            if(this.counter1++ > 0)
            {
               this.counter1 = -(Math.random() * 15 + 20);
               pSprite = new SmallSteamParticleSprite();
               pBackSprite = new SmallSteamParticleSprite();
               _xPos = xPos + 4 + Math.random() * 4;
               if(sprite.scaleX < 0)
               {
                  _xPos = xPos - 10 + Math.random() * 4;
               }
               _yVel = -(Math.random() * 0.05 + 0.1);
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
               level.particlesManager.pushParticle(pSprite,_xPos,yPos + 4,0,_yVel,1,yPos + 8,-1);
               level.particlesManager.pushBackParticle(pBackSprite,_xPos,yPos + 4,0,_yVel,1,yPos + 8,-1);
            }
         }
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
