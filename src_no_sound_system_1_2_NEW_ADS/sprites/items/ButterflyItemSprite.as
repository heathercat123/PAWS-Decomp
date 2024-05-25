package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ButterflyItemSprite extends GameSprite
   {
       
      
      protected var butterfly1:GameMovieClip;
      
      protected var butterfly2:GameMovieClip;
      
      protected var butterfly3:GameMovieClip;
      
      protected var butterfly4:GameMovieClip;
      
      protected var butterfly5:GameMovieClip;
      
      public function ButterflyItemSprite()
      {
         super();
         this.initButterfly1();
         this.initButterfly2();
         this.initButterfly3();
         this.initButterfly4();
         this.initButterfly5();
         addChild(this.butterfly1);
         addChild(this.butterfly2);
         addChild(this.butterfly3);
         addChild(this.butterfly4);
         addChild(this.butterfly5);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.butterfly1);
         Utils.juggler.remove(this.butterfly2);
         Utils.juggler.remove(this.butterfly3);
         Utils.juggler.remove(this.butterfly4);
         Utils.juggler.remove(this.butterfly5);
         this.butterfly1.dispose();
         this.butterfly1 = null;
         this.butterfly2.dispose();
         this.butterfly2 = null;
         this.butterfly3.dispose();
         this.butterfly3 = null;
         this.butterfly4.dispose();
         this.butterfly4 = null;
         this.butterfly5.dispose();
         this.butterfly5 = null;
         super.destroy();
      }
      
      protected function initButterfly1() : void
      {
         this.butterfly1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("butterflyItemSprite1Anim_"),12);
         this.butterfly1.setFrameDuration(0,0.1);
         this.butterfly1.setFrameDuration(1,0.1);
         this.butterfly1.setFrameDuration(2,0.1);
         this.butterfly1.touchable = false;
         this.butterfly1.x = this.butterfly1.y = -8;
         this.butterfly1.loop = true;
         Utils.juggler.add(this.butterfly1);
      }
      
      protected function initButterfly2() : void
      {
         this.butterfly2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("butterflyItemSprite2Anim_"),12);
         this.butterfly2.setFrameDuration(0,0.1);
         this.butterfly2.setFrameDuration(1,0.1);
         this.butterfly2.setFrameDuration(2,0.1);
         this.butterfly2.touchable = false;
         this.butterfly2.x = this.butterfly2.y = -8;
         this.butterfly2.loop = true;
         Utils.juggler.add(this.butterfly2);
      }
      
      protected function initButterfly3() : void
      {
         this.butterfly3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("butterflyItemSprite3Anim_"),12);
         this.butterfly3.setFrameDuration(0,0.1);
         this.butterfly3.setFrameDuration(1,0.1);
         this.butterfly3.setFrameDuration(2,0.1);
         this.butterfly3.touchable = false;
         this.butterfly3.x = this.butterfly3.y = -8;
         this.butterfly3.loop = true;
         Utils.juggler.add(this.butterfly3);
      }
      
      protected function initButterfly4() : void
      {
         this.butterfly4 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("butterflyItemSprite4Anim_"),12);
         this.butterfly4.setFrameDuration(0,0.1);
         this.butterfly4.setFrameDuration(1,0.1);
         this.butterfly4.setFrameDuration(2,0.1);
         this.butterfly4.touchable = false;
         this.butterfly4.x = this.butterfly4.y = -8;
         this.butterfly4.loop = true;
         Utils.juggler.add(this.butterfly4);
      }
      
      protected function initButterfly5() : void
      {
         this.butterfly5 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("butterflyItemSprite5Anim_"),12);
         this.butterfly5.setFrameDuration(0,0.1);
         this.butterfly5.setFrameDuration(1,0.1);
         this.butterfly5.setFrameDuration(2,0.1);
         this.butterfly5.touchable = false;
         this.butterfly5.x = this.butterfly5.y = -8;
         this.butterfly5.loop = true;
         Utils.juggler.add(this.butterfly5);
      }
   }
}
