package sprites.fishing
{
   import entities.fishing.Fish;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FishSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var swimAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var IS_RARE:Boolean;
      
      protected var IS_GOLDEN:Boolean;
      
      public function FishSprite(_type:int, _is_rare:Boolean, _is_gold:Boolean)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.IS_RARE = _is_rare;
         this.IS_GOLDEN = _is_gold;
         this.initSwimAnim();
         this.initTurnAnim();
         this.initJumpAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         if(this.TYPE == Fish.CAT_FISH || this.TYPE == Fish.SHARK || this.TYPE == Fish.TURTLE || this.TYPE == Fish.STINGRAY)
         {
            sprite.pivotX = sprite.pivotY = 20;
         }
         else
         {
            sprite.pivotX = sprite.pivotY = 16;
         }
         sprite.x = 0;
         sprite.y = 0;
         sprite.addChild(this.swimAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.jumpAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.swimAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.jumpAnim);
         this.swimAnim.dispose();
         this.turnAnim.dispose();
         this.jumpAnim.dispose();
         this.swimAnim = null;
         this.turnAnim = null;
         this.jumpAnim = null;
         super.destroy();
      }
      
      protected function initSwimAnim() : void
      {
         var pre_string:String = "";
         var time_string:String = "";
         if(Utils.TIME == Utils.DUSK)
         {
            time_string = "dusk_";
         }
         if(this.IS_RARE)
         {
            pre_string = "rare_";
         }
         if(this.TYPE == Fish.GREEN_CARP || this.TYPE == Fish.GOLDFISH || this.TYPE == Fish.RED_JUMPER || this.TYPE == Fish.BLOWFISH || this.TYPE == Fish.SHARK)
         {
            if(this.TYPE == Fish.GOLDFISH)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "goldfishSwimAnim_"));
            }
            else if(this.TYPE == Fish.BLOWFISH)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "blowFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.SHARK)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "sharkFishSwimAnim_"));
            }
            else
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "greenCarpFishSwimAnim_"));
            }
            this.swimAnim.setFrameDuration(0,0.1);
            this.swimAnim.setFrameDuration(1,0.2);
            this.swimAnim.setFrameDuration(2,0.2);
            this.swimAnim.setFrameDuration(3,0.1);
            this.swimAnim.setFrameDuration(4,0.2);
            this.swimAnim.setFrameDuration(5,0.2);
         }
         else if(this.TYPE == Fish.TURTLE)
         {
            this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "turtleFishSwimAnim_"));
            this.swimAnim.setFrameDuration(0,0.1);
            this.swimAnim.setFrameDuration(1,0.1);
            this.swimAnim.setFrameDuration(2,0.2);
         }
         else if(this.TYPE == Fish.STINGRAY || this.TYPE == Fish.OCTOPUS)
         {
            if(this.TYPE == Fish.STINGRAY)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "stingrayFishSwimAnim_"));
            }
            else
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "octopusFishSwimAnim_"));
            }
            this.swimAnim.setFrameDuration(0,0.1);
            this.swimAnim.setFrameDuration(1,0.1);
            this.swimAnim.setFrameDuration(2,0.1);
            this.swimAnim.setFrameDuration(3,0.1);
         }
         else if(this.TYPE == Fish.CAT_FISH)
         {
            this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "catFishSwimAnim_"));
            this.swimAnim.setFrameDuration(0,0.1);
            this.swimAnim.setFrameDuration(1,0.2);
            this.swimAnim.setFrameDuration(2,0.2);
            this.swimAnim.setFrameDuration(3,0.1);
            this.swimAnim.setFrameDuration(4,0.2);
            this.swimAnim.setFrameDuration(5,0.2);
         }
         else if(this.TYPE == Fish.TADPOLE || this.TYPE == Fish.SNAIL || this.TYPE == Fish.SQUID || this.TYPE == Fish.CRAB || this.TYPE == Fish.SALAMANDER || this.TYPE == Fish.FROG || this.TYPE == Fish.JELLYFISH)
         {
            if(this.TYPE == Fish.TADPOLE)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "tadpoleFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.SNAIL)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "snailFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.FROG)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "frogFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.SALAMANDER)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "salamanderFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.SQUID)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "squidFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.CRAB)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "crabFishSwimAnim_"));
            }
            else if(this.TYPE == Fish.JELLYFISH)
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "jellyfishFishSwimAnim_"));
            }
            else
            {
               this.swimAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "tadpoleFishSwimAnim_"));
            }
            this.swimAnim.setFrameDuration(0,0.5);
            this.swimAnim.setFrameDuration(1,0.5);
         }
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = true;
         Utils.juggler.add(this.swimAnim);
         if(this.TYPE == Fish.SQUID || this.TYPE == Fish.JELLYFISH)
         {
            this.swimAnim.setFrameDuration(0,0.2);
            this.swimAnim.setFrameDuration(1,0.5);
            this.swimAnim.loop = false;
         }
      }
      
      protected function initTurnAnim() : void
      {
         var pre_string:String = "";
         var time_string:String = "";
         if(Utils.TIME == Utils.DUSK)
         {
            time_string = "dusk_";
         }
         if(this.IS_RARE)
         {
            pre_string = "rare_";
         }
         if(this.TYPE == Fish.GREEN_CARP || this.TYPE == Fish.RED_JUMPER)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "greenCarpFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.CAT_FISH)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "catFishTurnAnim_a"));
         }
         else if(this.TYPE == Fish.GOLDFISH)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "goldfishTurnAnim_a"));
         }
         else if(this.TYPE == Fish.TADPOLE)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "tadpoleFishTurnAnim_a"));
         }
         else if(this.TYPE == Fish.SNAIL)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "snailFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.FROG)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "frogFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.SALAMANDER)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "salamanderFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.SQUID)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "squidFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.JELLYFISH)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "jellyfishFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.CRAB)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "crabFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.BLOWFISH)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "blowFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.SHARK)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "sharkFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.TURTLE)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + pre_string + "turtleFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.STINGRAY)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "stingrayFishTurnAnim_"));
         }
         else if(this.TYPE == Fish.OCTOPUS)
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "octopusFishTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(time_string + "greenCarpFishTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         var pre_string:String = "";
         if(this.IS_RARE)
         {
            pre_string = "rare_";
         }
         else if(this.IS_GOLDEN)
         {
            pre_string = "golden_";
         }
         if(this.TYPE == Fish.GREEN_CARP)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "greenCarpFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.CAT_FISH)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "catFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.GOLDFISH)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "goldfishJumpAnim_"));
         }
         else if(this.TYPE == Fish.TADPOLE)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "tadpoleFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.SNAIL)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "snailFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.FROG)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "frogFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.SALAMANDER)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "salamanderFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.SQUID)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "squidFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.JELLYFISH)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "jellyfishFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.CRAB)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "crabFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.RED_JUMPER)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "redJumperFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.BLOWFISH)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "blowFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.SHARK)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "sharkFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.TURTLE)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "turtleFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.STINGRAY)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "stingrayFishJumpAnim_"));
         }
         else if(this.TYPE == Fish.OCTOPUS)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "octopusFishJumpAnim_"));
         }
         else
         {
            this.jumpAnim = new GameMovieClip(TextureManager.fishingTextureAtlas.getTextures(pre_string + "greenCarpFishJumpAnim_"));
         }
         this.jumpAnim.setFrameDuration(0,0.1);
         this.jumpAnim.setFrameDuration(1,0.1);
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
   }
}
