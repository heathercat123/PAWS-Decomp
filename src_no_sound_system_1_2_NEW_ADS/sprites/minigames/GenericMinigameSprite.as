package sprites.minigames
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericMinigameSprite extends GameSprite
   {
      
      public static var SPRITE_MEGAPANG_HERO:int = 0;
      
      public static var SPRITE_DIGITS:int = 1;
      
      public static var SPRITE_HUD_ARROW:int = 2;
      
      public static var SPRITE_BAT_HERO:int = 3;
       
      
      protected var TYPE:int;
      
      protected var anim1:GameMovieClip;
      
      protected var anim2:GameMovieClip;
      
      protected var anim3:GameMovieClip;
      
      public function GenericMinigameSprite(_type:int)
      {
         super();
         this.TYPE = _type;
         this.initAnim1();
         this.initAnim2();
         this.initAnim3();
         addChild(this.anim1);
         addChild(this.anim2);
         addChild(this.anim3);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.anim1);
         Utils.juggler.remove(this.anim2);
         Utils.juggler.remove(this.anim3);
         this.anim1.dispose();
         this.anim2.dispose();
         this.anim3.dispose();
         this.anim1 = null;
         this.anim2 = null;
         this.anim3 = null;
         super.destroy();
      }
      
      protected function initAnim1() : void
      {
         if(this.TYPE == GenericMinigameSprite.SPRITE_MEGAPANG_HERO)
         {
            this.anim1 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("megapangHeroSpriteWalkAnim_a"));
            this.anim1.x = this.anim1.y = -8;
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_DIGITS)
         {
            this.anim1 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("minigame_digits_"));
            this.anim1.x = this.anim1.y = 0;
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_HUD_ARROW)
         {
            this.anim1 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("arrow_button_"));
            this.anim1.x = this.anim1.y = -24;
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_BAT_HERO)
         {
            this.anim1 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("batHeroSpriteStandAnim_a"));
            this.anim1.x = this.anim1.y = -12;
         }
         this.anim1.textureSmoothing = Utils.getSmoothing();
         this.anim1.touchable = false;
         this.anim1.loop = true;
         Utils.juggler.add(this.anim1);
      }
      
      protected function initAnim2() : void
      {
         if(this.TYPE == GenericMinigameSprite.SPRITE_MEGAPANG_HERO)
         {
            this.anim2 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("megapangHeroSpriteWalkAnim_"));
            this.anim2.setFrameDuration(0,0.1);
            this.anim2.setFrameDuration(1,0.1);
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_DIGITS)
         {
            this.anim2 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("minigame_digits_0"));
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_HUD_ARROW)
         {
            this.anim2 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("arrow_button_a"));
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_BAT_HERO)
         {
            this.anim2 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("batHeroSpriteFlapAnim_a"));
         }
         this.anim2.textureSmoothing = Utils.getSmoothing();
         this.anim2.touchable = false;
         this.anim2.x = this.anim2.y = -8;
         if(this.TYPE == GenericMinigameSprite.SPRITE_BAT_HERO)
         {
            this.anim2.x = this.anim2.y = -12;
         }
         this.anim2.loop = true;
         Utils.juggler.add(this.anim2);
      }
      
      protected function initAnim3() : void
      {
         if(this.TYPE == GenericMinigameSprite.SPRITE_MEGAPANG_HERO)
         {
            this.anim3 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("megapangHeroSpriteGameOverAnim_"));
            this.anim3.setFrameDuration(0,0.1);
            this.anim3.setFrameDuration(1,0.1);
            this.anim3.setFrameDuration(2,0.1);
            this.anim3.setFrameDuration(3,0.1);
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_DIGITS)
         {
            this.anim3 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("minigame_digits_0"));
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_HUD_ARROW)
         {
            this.anim3 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("arrow_button_a"));
         }
         else if(this.TYPE == GenericMinigameSprite.SPRITE_BAT_HERO)
         {
            this.anim3 = new GameMovieClip(TextureManager.minigamesTextureAtlas.getTextures("batHeroSpriteGameOverAnim_"));
            this.anim3.setFrameDuration(0,0.1);
            this.anim3.setFrameDuration(1,0.1);
            this.anim3.setFrameDuration(2,0.1);
            this.anim3.setFrameDuration(3,0.1);
         }
         this.anim3.textureSmoothing = Utils.getSmoothing();
         this.anim3.touchable = false;
         this.anim3.x = this.anim3.y = -8;
         if(this.TYPE == GenericMinigameSprite.SPRITE_BAT_HERO)
         {
            this.anim3.x = this.anim2.y = -12;
         }
         this.anim3.loop = true;
         Utils.juggler.add(this.anim3);
      }
   }
}
