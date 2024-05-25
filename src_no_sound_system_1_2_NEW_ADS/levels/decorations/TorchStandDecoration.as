package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.DarkSmallSpotCollisionSprite;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.decorations.TorchStandDecorationSprite;
   import sprites.particles.DarkGreySmokeParticleSprite;
   
   public class TorchStandDecoration extends Decoration
   {
       
      
      protected var IS_OFF:Boolean;
      
      protected var counter_1:int;
      
      protected var light:DarkSmallSpotCollisionSprite;
      
      protected var TYPE:int;
      
      protected var scale:Number = 1;
      
      public function TorchStandDecoration(_level:Level, _xPos:Number, _yPos:Number, _TYPE:int = 0, _invisible:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _TYPE;
         if(this.TYPE == 0)
         {
            sprite = new TorchStandDecorationSprite();
         }
         else if(this.TYPE == GenericDecoration.NUGGET_4 || this.TYPE == GenericDecoration.NUGGET_5 || this.TYPE == GenericDecoration.NUGGET_6)
         {
            sprite = new GenericDecorationSprite(this.TYPE);
         }
         else
         {
            sprite = new GenericDecorationSprite(GenericDecoration.WALL_TORCH);
         }
         sprite.gotoAndStop(1);
         if(this.TYPE == GenericDecoration.NUGGET_4 || this.TYPE == GenericDecoration.NUGGET_5 || this.TYPE == GenericDecoration.NUGGET_6)
         {
            Utils.topWorld.addChild(sprite);
         }
         else
         {
            Utils.backWorld.addChild(sprite);
         }
         this.IS_OFF = false;
         this.counter_1 = 0;
         this.light = new DarkSmallSpotCollisionSprite();
         this.light.gotoAndStop(1);
         if(this.TYPE == GenericDecoration.NUGGET_4 || this.TYPE == GenericDecoration.NUGGET_5 || this.TYPE == GenericDecoration.NUGGET_6)
         {
            this.light.gotoAndStop(4);
         }
         if(_invisible > 0)
         {
            sprite.visible = false;
         }
         level.darkManager.maskContainer.addChild(this.light);
      }
      
      override public function update() : void
      {
         super.update();
         this.scale += 0.1;
         if(this.scale > Math.PI * 2)
         {
            this.scale -= Math.PI * 2;
         }
         if(this.TYPE == GenericDecoration.NUGGET_4 || this.TYPE == GenericDecoration.NUGGET_5 || this.TYPE == GenericDecoration.NUGGET_6)
         {
            this.light.scaleX = this.light.scaleY = 1 + Math.sin(this.scale) * 0.5;
         }
         else
         {
            this.light.scaleX = this.light.scaleY = 1 + Math.sin(this.scale) * 0.02;
         }
         if(Utils.SAND_LEVEL > 0)
         {
            if(Utils.SAND_LEVEL < yPos)
            {
               if(!this.IS_OFF)
               {
                  this.IS_OFF = true;
                  this.counter_1 = -(Math.round(Math.random() * 3) * 15);
                  sprite.gotoAndStop(2);
               }
            }
            else if(this.IS_OFF)
            {
               ++this.counter_1;
               if(this.counter_1 > 0)
               {
                  this.counter_1 = 0;
                  this.IS_OFF = false;
                  sprite.gotoAndStop(1);
                  this.litParticles();
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.TYPE == 0)
         {
            this.light.x = int(sprite.x + 8);
            this.light.y = int(sprite.y + 0);
         }
         else if(this.TYPE == GenericDecoration.NUGGET_4 || this.TYPE == GenericDecoration.NUGGET_5 || this.TYPE == GenericDecoration.NUGGET_6)
         {
            this.light.x = int(sprite.x + 6);
            this.light.y = int(sprite.y + 6);
         }
         else
         {
            this.light.x = int(sprite.x + 8);
            this.light.y = int(sprite.y + 7);
         }
         this.light.updateScreenPosition();
      }
      
      protected function litParticles() : void
      {
         var i:int = 0;
         var pSprite:DarkGreySmokeParticleSprite = null;
         for(i = 0; i < 2; i++)
         {
            pSprite = new DarkGreySmokeParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndPlay(1);
            }
            level.particlesManager.pushBackParticle(pSprite,xPos + 8 + (Math.random() * 4 - 2),yPos + i * 8,0,-1,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80);
         }
      }
      
      override public function destroy() : void
      {
         if(this.TYPE == GenericDecoration.NUGGET_4 || this.TYPE == GenericDecoration.NUGGET_5 || this.TYPE == GenericDecoration.NUGGET_6)
         {
            Utils.topWorld.removeChild(sprite);
         }
         else
         {
            Utils.backWorld.removeChild(sprite);
         }
         level.darkManager.maskContainer.removeChild(this.light);
         this.light.destroy();
         this.light.dispose();
         this.light = null;
         super.destroy();
      }
   }
}
