package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class NightStarBackgroundSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      protected var speed_value:Number;
      
      protected var TYPE:int;
      
      protected var TYPE_2:int;
      
      public function NightStarBackgroundSprite(type:int = 0, speed:int = 0, type_2:int = 0)
      {
         super();
         this.TYPE = type;
         this.speed_value = speed;
         this.TYPE_2 = type_2;
         this.initAnims1();
         addChild(this.standAnimation1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         this.standAnimation1.dispose();
         this.standAnimation1 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         if(this.TYPE_2 == 1)
         {
            if(this.TYPE == 0)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_1_"),1);
            }
            else if(this.TYPE == 1)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_2_"),1);
            }
            else if(this.TYPE == 2)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_3_"),1);
            }
            else if(this.TYPE == 3)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_4_"),1);
            }
            else if(this.TYPE == 4)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_5_"),1);
            }
            else if(this.TYPE == 5)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_6_"),1);
            }
            else if(this.TYPE == 6)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_7_"),1);
            }
            else if(this.TYPE == 7)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_8_"),1);
            }
            else if(this.TYPE == 8)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starDuskBackgroundSpriteAnim_9_"),1);
            }
         }
         else if(this.TYPE_2 == 2)
         {
            if(this.TYPE == 0)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_1_"),1);
            }
            else if(this.TYPE == 1)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_2_"),1);
            }
            else if(this.TYPE == 2)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_3_"),1);
            }
            else if(this.TYPE == 3)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_4_"),1);
            }
            else if(this.TYPE == 4)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_5_"),1);
            }
            else if(this.TYPE == 5)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_6_"),1);
            }
            else if(this.TYPE == 6)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_7_"),1);
            }
            else if(this.TYPE == 7)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_8_"),1);
            }
            else if(this.TYPE == 8)
            {
               this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starHalloweenBackgroundSpriteAnim_9_"),1);
            }
         }
         else if(this.TYPE == 0)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim1_"),2);
         }
         else if(this.TYPE == 1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim2_"),2);
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim3_"),2);
         }
         else if(this.TYPE == 3)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim4_"),2);
         }
         else if(this.TYPE == 4)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim5_"),2);
         }
         else if(this.TYPE == 5)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim6_"),2);
         }
         else if(this.TYPE == 6)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim7_"),2);
         }
         else if(this.TYPE == 7)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim8_"),2);
         }
         else if(this.TYPE == 8)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("starBackgroundSpriteAnim9_"),2);
         }
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
