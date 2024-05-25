package levels.decorations
{
   import levels.Level;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.particles.DewParticleSprite;
   
   public class DewDecoration extends Decoration
   {
       
      
      public var HAS_DRIPPED:Boolean;
      
      public var drip_delay:int;
      
      public function DewDecoration(_level:Level, _xPos:Number, _yPos:Number, _flip:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new GenericDecorationSprite(GenericDecoration.DEW);
         Utils.topWorld.addChild(sprite);
         WIDTH = HEIGHT = 16;
         this.HAS_DRIPPED = false;
         if(_flip == 1)
         {
            sprite.scaleY = -1;
         }
         var x_t:int = int(xPos / Utils.TILE_WIDTH);
         if(x_t % 2 == 0)
         {
            sprite.gfxHandleClip().gotoAndPlay(2);
         }
      }
      
      override public function update() : void
      {
         if(this.HAS_DRIPPED)
         {
            if(this.drip_delay-- == 0)
            {
               level.particlesManager.pushParticle(new DewParticleSprite(),xPos + WIDTH * 0.5,yPos - WIDTH * 0.5,0,0,1);
               sprite.visible = false;
            }
            else if(this.drip_delay < 0)
            {
               if(isOutsideScreen())
               {
                  this.HAS_DRIPPED = false;
                  sprite.visible = true;
               }
            }
         }
      }
      
      override public function shake() : void
      {
         if(!this.HAS_DRIPPED)
         {
            if(sprite.scaleY < 0)
            {
               if(isInsideScreen())
               {
                  this.HAS_DRIPPED = true;
                  this.drip_delay = Math.random() * 10;
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
