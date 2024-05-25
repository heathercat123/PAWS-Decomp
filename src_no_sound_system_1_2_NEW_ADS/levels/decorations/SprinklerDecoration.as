package levels.decorations
{
   import levels.Level;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.particles.WaterDropParticleSprite;
   
   public class SprinklerDecoration extends Decoration
   {
       
      
      internal var sin_counter:Number;
      
      internal var counter_1:int;
      
      public function SprinklerDecoration(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0)
      {
         super(_level,_xPos,_yPos + 1);
         this.sin_counter = 0;
         this.counter_1 = 0;
         sprite = new GenericDecorationSprite(GenericDecoration.SPRINKLER);
         Utils.topWorld.addChild(sprite);
      }
      
      override public function update() : void
      {
         var pSprite:WaterDropParticleSprite = null;
         var _xVel:Number = NaN;
         var _yVel:Number = NaN;
         var range:Number = 0.6;
         this.sin_counter += 0.015;
         if(this.sin_counter >= Math.PI * 2)
         {
            this.sin_counter -= Math.PI * 2;
         }
         ++this.counter_1;
         if(this.counter_1 >= 10)
         {
            this.counter_1 = 0;
            pSprite = new WaterDropParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            _xVel = 1.5 + Math.random() * range * 2 - range;
            _yVel = -3 + Math.random() * range * 2 - range;
            level.particlesManager.pushParticle(pSprite,xPos + 8,yPos + 12,Math.sin(this.sin_counter) * _xVel,_yVel,1);
            pSprite = new WaterDropParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            _xVel = 1.5 + Math.random() * range * 2 - range;
            _yVel = -3 + Math.random() * range * 2 - range;
            level.particlesManager.pushParticle(pSprite,xPos + 8,yPos + 12,-Math.sin(this.sin_counter) * _xVel,_yVel,1);
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
