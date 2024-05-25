package sprites.tutorials
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class TutorialSprite extends GameSprite
   {
       
      
      protected var INDEX:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function TutorialSprite(_index:int)
      {
         super();
         this.INDEX = _index;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.INDEX == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial1SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
         }
         else if(this.INDEX == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial2SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1.5);
            this.standAnimation.setFrameDuration(1,0.075);
            this.standAnimation.setFrameDuration(2,0.075);
            this.standAnimation.setFrameDuration(3,0.075);
            this.standAnimation.setFrameDuration(4,0.075);
            this.standAnimation.setFrameDuration(5,0.075);
            this.standAnimation.setFrameDuration(6,0.075);
            this.standAnimation.setFrameDuration(7,0.075);
         }
         else if(this.INDEX == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial3SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
         }
         else if(this.INDEX == 3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial4SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
         }
         else if(this.INDEX == 4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial5SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.05);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
         }
         else if(this.INDEX == 5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial6SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
            this.standAnimation.setFrameDuration(2,0.2);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
            this.standAnimation.setFrameDuration(6,0.1);
            this.standAnimation.setFrameDuration(7,0.1);
            this.standAnimation.setFrameDuration(8,0.1);
            this.standAnimation.setFrameDuration(9,0.4);
         }
         else if(this.INDEX == 6)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial7SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
            this.standAnimation.setFrameDuration(2,0.2);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
            this.standAnimation.setFrameDuration(6,0.1);
            this.standAnimation.setFrameDuration(7,0.1);
            this.standAnimation.setFrameDuration(8,0.1);
            this.standAnimation.setFrameDuration(9,0.4);
         }
         else if(this.INDEX == 7)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial8SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
         }
         else if(this.INDEX == 8)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial9SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
            this.standAnimation.setFrameDuration(2,0.2);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
         }
         else if(this.INDEX == 9)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial10SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
            this.standAnimation.setFrameDuration(2,0.2);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.2);
            this.standAnimation.setFrameDuration(5,0.2);
         }
         else if(this.INDEX == 10)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial11SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
            this.standAnimation.setFrameDuration(2,0.2);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.2);
            this.standAnimation.setFrameDuration(5,0.1);
            this.standAnimation.setFrameDuration(6,0.1);
            this.standAnimation.setFrameDuration(7,0.2);
         }
         else if(this.INDEX == 11)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial12SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
            this.standAnimation.setFrameDuration(2,0.2);
            this.standAnimation.setFrameDuration(3,0.2);
            this.standAnimation.setFrameDuration(4,0.2);
            this.standAnimation.setFrameDuration(5,0.2);
            this.standAnimation.setFrameDuration(6,1);
         }
         else if(this.INDEX == 12)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial13SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.2);
         }
         else if(this.INDEX == 13)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial14SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.4);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.4);
         }
         else if(this.INDEX == 16)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial17SpriteAnim_"),12);
         }
         else if(this.INDEX == 17)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial18SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
         }
         else if(this.INDEX == 18)
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("tutorial19SpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.2);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
            this.standAnimation.setFrameDuration(4,0.1);
            this.standAnimation.setFrameDuration(5,0.1);
            this.standAnimation.setFrameDuration(6,0.2);
         }
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
