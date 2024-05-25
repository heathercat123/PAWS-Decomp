package levels.decorations
{
   import levels.Level;
   import sprites.GameSprite;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.particles.SmallSteamParticleSprite;
   
   public class FoodDecoration extends Decoration
   {
       
      
      protected var counter1:int;
      
      public function FoodDecoration(_level:Level, _xPos:Number, _yPos:Number, _flip:int, _id:int)
      {
         super(_level,_xPos,_yPos);
         if(_id == 2)
         {
            sprite = new GenericDecorationSprite(GenericDecoration.FOOD_2);
         }
         else
         {
            sprite = new GenericDecorationSprite(GenericDecoration.FOOD_1);
         }
         sprite.gfxHandleClip().gotoAndStop(_id);
         this.counter1 = 0;
         if(_flip > 0)
         {
            sprite.scaleX = -1;
         }
         Utils.backWorld.addChild(sprite);
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
               _xPos = xPos + 5 + Math.random() * 13;
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
               level.particlesManager.pushParticle(pSprite,_xPos,yPos - 2 + 12,0,_yVel,1,yPos + 8,-1);
               level.particlesManager.pushBackParticle(pBackSprite,_xPos,yPos - 2 + 12,0,_yVel,1,yPos + 8,-1);
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
