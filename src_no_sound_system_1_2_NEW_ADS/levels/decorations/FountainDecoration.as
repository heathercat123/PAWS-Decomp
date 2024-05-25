package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.particles.WaterDropParticleSprite;
   import starling.display.Image;
   
   public class FountainDecoration extends Decoration
   {
       
      
      protected var sxSideImage:Image;
      
      protected var dxSideImage:Image;
      
      protected var light1Image:Image;
      
      protected var light2Image:Image;
      
      protected var light3Image:Image;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var FLAG_1:Boolean;
      
      protected var TYPE:int;
      
      public function FountainDecoration(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0)
      {
         this.TYPE = _type;
         super(_level,_xPos,_yPos);
         sprite = new GenericDecorationSprite(GenericDecoration.FOUNTAIN_WATER);
         Utils.world.addChild(sprite);
         sprite.gfxHandleClip().gotoAndStop(1);
         if(this.TYPE == 0)
         {
            this.sxSideImage = new Image(TextureManager.sTextureAtlas.getTexture("parkFountainImage"));
            this.sxSideImage.touchable = false;
            this.dxSideImage = new Image(TextureManager.sTextureAtlas.getTexture("parkFountainImage"));
            this.dxSideImage.touchable = false;
            this.dxSideImage.scaleX = -1;
         }
         else
         {
            this.sxSideImage = new Image(TextureManager.sTextureAtlas.getTexture("parkFountainImage_2"));
            this.sxSideImage.touchable = false;
            this.dxSideImage = null;
         }
         this.light1Image = new Image(TextureManager.sTextureAtlas.getTexture("snow_tile_2"));
         this.light2Image = new Image(TextureManager.sTextureAtlas.getTexture("snow_tile_2"));
         this.light3Image = new Image(TextureManager.sTextureAtlas.getTexture("snow_tile_2"));
         this.light1Image.touchable = this.light2Image.touchable = this.light3Image.touchable = false;
         this.light1Image.width = 2;
         this.light2Image.width = 12;
         this.light3Image.width = 2;
         this.light1Image.height = this.light2Image.height = this.light3Image.height = 1;
         Utils.world.addChild(this.sxSideImage);
         if(this.dxSideImage != null)
         {
            Utils.world.addChild(this.dxSideImage);
         }
         Utils.world.addChild(this.light1Image);
         Utils.world.addChild(this.light2Image);
         Utils.world.addChild(this.light3Image);
         this.counter_1 = this.counter_2 = 0;
         this.FLAG_1 = false;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         Utils.world.removeChild(this.light1Image);
         Utils.world.removeChild(this.light2Image);
         Utils.world.removeChild(this.light3Image);
         this.light1Image.dispose();
         this.light2Image.dispose();
         this.light3Image.dispose();
         this.light1Image = null;
         this.light2Image = null;
         this.light3Image = null;
         Utils.world.removeChild(this.sxSideImage);
         this.sxSideImage.dispose();
         this.sxSideImage = null;
         if(this.dxSideImage != null)
         {
            Utils.world.removeChild(this.dxSideImage);
            this.dxSideImage.dispose();
            this.dxSideImage = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:WaterDropParticleSprite = null;
         var _xVel:Number = NaN;
         var _yVel:Number = NaN;
         var range:Number = 0.6;
         if(this.counter_1++ > 5)
         {
            this.counter_1 = 0;
            this.FLAG_1 = !this.FLAG_1;
         }
         if(this.counter_2++ >= 10)
         {
            this.counter_2 = 0;
            pSprite = new WaterDropParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            _xVel = Math.random() * 0.5 * 2 - 0.5;
            _yVel = -(Math.random() * 2 + 2);
            if(this.TYPE == 1)
            {
               level.particlesManager.pushBackParticle(pSprite,xPos + 40,yPos + 8,_xVel,_yVel,1,0,0,0,yPos + 40);
            }
            else
            {
               level.particlesManager.pushBackParticle(pSprite,xPos + 40,yPos + 8,_xVel,_yVel,1);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos + 40 - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         if(this.TYPE == 1)
         {
            sprite.visible = false;
         }
         this.sxSideImage.x = int(Math.floor(xPos - camera.xPos));
         if(this.dxSideImage != null)
         {
            this.dxSideImage.x = int(Math.floor(xPos + 80 - camera.xPos));
         }
         if(this.TYPE == 1)
         {
            this.sxSideImage.y = int(Math.floor(yPos + 16 - camera.yPos - 16));
         }
         else
         {
            this.sxSideImage.y = int(Math.floor(yPos + 16 - camera.yPos));
         }
         if(this.dxSideImage != null)
         {
            this.dxSideImage.y = this.sxSideImage.y;
         }
         if(this.FLAG_1)
         {
            this.light1Image.x = int(Math.floor(xPos + 14 - camera.xPos));
            if(this.TYPE == 1)
            {
               this.light2Image.x = int(Math.floor(xPos + 34 - 9 - camera.xPos));
            }
            else
            {
               this.light2Image.x = int(Math.floor(xPos + 34 - camera.xPos));
            }
            this.light3Image.x = int(Math.floor(xPos + 64 - camera.xPos));
            if(this.TYPE == 1)
            {
               this.light2Image.width = 12 + 18;
            }
            else
            {
               this.light2Image.width = 12;
            }
            sprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            this.light1Image.x = int(Math.floor(xPos + 15 - camera.xPos));
            this.light2Image.x = int(Math.floor(xPos + 35 - camera.xPos));
            this.light3Image.x = int(Math.floor(xPos + 63 - camera.xPos));
            this.light2Image.width = 10;
            sprite.gfxHandleClip().gotoAndStop(2);
         }
         this.light1Image.y = int(Math.floor(yPos + 46 - camera.yPos));
         this.light2Image.y = int(Math.floor(yPos + 46 - camera.yPos));
         this.light3Image.y = int(Math.floor(yPos + 46 - camera.yPos));
         sprite.updateScreenPosition();
         Utils.world.setChildIndex(this.light1Image,0);
         Utils.world.setChildIndex(this.light2Image,0);
         Utils.world.setChildIndex(this.light3Image,0);
         Utils.world.setChildIndex(sprite,0);
         Utils.world.setChildIndex(this.sxSideImage,0);
         if(this.dxSideImage != null)
         {
            Utils.world.setChildIndex(this.dxSideImage,0);
         }
      }
   }
}
