package sprites.npcs
{
   import entities.npcs.GenericNPC;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericNPCSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      public function GenericNPCSprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         if(this.TYPE == GenericNPC.NPC_GUY)
         {
            sprite.pivotX = 20;
            sprite.x = 10;
            sprite.y = -24;
         }
         else
         {
            sprite.pivotX = 16;
            sprite.x = 8;
            sprite.y = -15;
         }
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cat1NpcStandAnim_"));
         }
         else if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoHelmetNpcStandAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatNpcStandAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenTomoNpcStandAnim_"));
         }
         else if(this.TYPE == 4)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatBigNpcStandAnim_"));
         }
         else if(this.TYPE == 5)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tinNpcStandAnim_"));
         }
         else if(this.TYPE == 6)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("kitNpcStandAnim_"));
         }
         else if(this.TYPE == 7)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowSitNpcStandAnim_"));
         }
         else if(this.TYPE == 8)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mediumAcornNpcStandAnim_"));
         }
         else if(this.TYPE == 9)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallAcornNpcStandAnim_"));
         }
         else if(this.TYPE == 10)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bigAcornNpcStandAnim_"));
         }
         else if(this.TYPE == 11)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blackDuckNpcStandAnim_"));
         }
         else if(this.TYPE == 12)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("workerNpcStandAnim_"));
         }
         else if(this.TYPE == 13)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lightFishImmigrantNpcCleanAnim_a"));
         }
         else if(this.TYPE == 14)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyMoleNpcStandAnim_"));
         }
         else if(this.TYPE == 15)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("brownMoleNpcStandAnim_"));
         }
         else if(this.TYPE == 16)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pigNpcStandAnim_"));
         }
         else if(this.TYPE == 17)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterRedBigNpcStandAnim_"));
         }
         else if(this.TYPE == 18)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoSailorNpcStandAnim_"));
         }
         else if(this.TYPE == 19)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterBlueBigNpcStandAnim_"));
         }
         else if(this.TYPE == 20)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterRedSmallNpcStandAnim_"));
         }
         else if(this.TYPE == 21)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterBlueSmallNpcStandAnim_"));
         }
         else if(this.TYPE == 22)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach1NPCStandAnim_"));
         }
         else if(this.TYPE == 23)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach2NPCStandAnim_"));
         }
         else if(this.TYPE == 24)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach3NPCStandAnim_"));
         }
         else if(this.TYPE == 25)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach4NPCStandAnim_"));
         }
         else if(this.TYPE == 26)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoBluePunkNpcStandAnim_"));
         }
         else if(this.TYPE == 27)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("whiteMouseNpcStandAnim_"));
         }
         else if(this.TYPE == 28)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sebastienneNpcStandAnim_"));
         }
         else if(this.TYPE == 29)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("chefTomoNpcStandAnim_"));
         }
         else if(this.TYPE == 30)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("oldAcornNpcStandAnim_"));
         }
         else if(this.TYPE == 31)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("concettaNpcStandAnim_a"));
         }
         else if(this.TYPE == 32)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyNPCLaughAnim_"));
         }
         else if(this.TYPE == 33)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("zombieTomoNpcStandAnim_a"));
         }
         if(this.TYPE == 14 || this.TYPE == 15 || this.TYPE == 27 || this.TYPE == 28)
         {
            this.standAnim.setFrameDuration(0,1);
            this.standAnim.setFrameDuration(1,1);
         }
         else if(this.TYPE == 32)
         {
            this.standAnim.setFrameDuration(0,0.1);
            this.standAnim.setFrameDuration(1,0.1);
         }
         else if(!(this.TYPE == 16 || this.TYPE == 23 || this.TYPE == 24 || this.TYPE == 25 || this.TYPE == 26 || this.TYPE == 30 || this.TYPE == 31 || this.TYPE == 33))
         {
            if(this.TYPE != 6 && this.TYPE != 11 && this.TYPE != 13)
            {
               this.standAnim.setFrameDuration(0,1);
               this.standAnim.setFrameDuration(1,0.1);
               this.standAnim.setFrameDuration(2,0.1);
               this.standAnim.setFrameDuration(3,0.1);
            }
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         if(this.TYPE == 11 || this.TYPE == 14 || this.TYPE == 15 || this.TYPE == 28 || this.TYPE == 32)
         {
            this.standAnim.loop = true;
         }
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cat1NpcTurnAnim_"));
         }
         else if(this.TYPE == 1)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoHelmetNpcTurnAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatNpcTurnAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenTomoNpcTurnAnim_a"));
         }
         else if(this.TYPE == 4)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatBigNpcTurnAnim_a"));
         }
         else if(this.TYPE == 5)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tinNpcTurnAnim_"));
         }
         else if(this.TYPE == 6)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("kitNpcTurnAnim_"));
         }
         else if(this.TYPE == 7)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowSitNpcStandAnim_a"));
         }
         else if(this.TYPE == 8)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mediumAcornNpcTurnAnim_"));
         }
         else if(this.TYPE == 9)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallAcornNpcTurnAnim_"));
         }
         else if(this.TYPE == 10)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bigAcornNpcTurnAnim_"));
         }
         else if(this.TYPE == 11)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blackDuckNpcTurnAnim_"));
         }
         else if(this.TYPE == 12)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("workerNpcTurnAnim_"));
         }
         else if(this.TYPE == 13)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lightFishImmigrantNpcCleanAnim_d"));
         }
         else if(this.TYPE == 14)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyMoleNpcTurnAnim_"));
         }
         else if(this.TYPE == 15)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("brownMoleNpcTurnAnim_"));
         }
         else if(this.TYPE == 16)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pigNpcTurnAnim_"));
         }
         else if(this.TYPE == 17)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterRedBigNpcTurnAnim_"));
         }
         else if(this.TYPE == 18)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoSailorNpcTurnAnim_"));
         }
         else if(this.TYPE == 19)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterBlueBigNpcTurnAnim_"));
         }
         else if(this.TYPE == 20)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterRedSmallNpcTurnAnim_"));
         }
         else if(this.TYPE == 21)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterBlueSmallNpcTurnAnim_"));
         }
         else if(this.TYPE == 22)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach1NPCTurnAnim_"));
         }
         else if(this.TYPE == 23)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach2NPCTurnAnim_"));
         }
         else if(this.TYPE == 24)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach3NPCStandAnim_"));
         }
         else if(this.TYPE == 25)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach4NPCTurnAnim_"));
         }
         else if(this.TYPE == 26)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoBluePunkNpcTurnAnim_"));
         }
         else if(this.TYPE == 27)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("whiteMouseNpcTurnAnim_"));
         }
         else if(this.TYPE == 28)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sebastienneNpcTurnAnim_"));
         }
         else if(this.TYPE == 29)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("chefTomoNpcTurnAnim_"));
         }
         else if(this.TYPE == 30)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("oldAcornNpcStandAnim_a"));
         }
         else if(this.TYPE == 31)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("concettaNpcStandAnim_a"));
         }
         else if(this.TYPE == 32)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyNPCTurnAnim_a"));
         }
         else if(this.TYPE == 33)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("zombieTomoNpcTurnAnim_a"));
         }
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cat1NpcStandAnim_"));
         }
         else if(this.TYPE == 1)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyTomoHelmetNpcWalkAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatNpcWalkAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greenTomoNpcStandAnim_"));
         }
         else if(this.TYPE == 4)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wombatBigNpcWalkAnim_"));
         }
         else if(this.TYPE == 5)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tinNpcWalkAnim_"));
         }
         else if(this.TYPE == 6)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("kitNpcStandAnim_"));
         }
         else if(this.TYPE == 7)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowSitNpcStandAnim_"));
         }
         else if(this.TYPE == 8)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mediumAcornNpcStandAnim_"));
         }
         else if(this.TYPE == 9)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallAcornNpcWalkAnim_"));
         }
         else if(this.TYPE == 10)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bigAcornNpcStandAnim_"));
         }
         else if(this.TYPE == 11)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("blackDuckNpcStandAnim_"));
         }
         else if(this.TYPE == 12)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("workerNpcStandAnim_"));
         }
         else if(this.TYPE == 13)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lightFishImmigrantNpcCleanAnim_"));
         }
         else if(this.TYPE == 14)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("greyMoleNpcStandAnim_"));
         }
         else if(this.TYPE == 15)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("brownMoleNpcStandAnim_"));
         }
         else if(this.TYPE == 16)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pigNpcWalkAnim_"));
         }
         else if(this.TYPE == 17 || this.TYPE == 18)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterRedBigNpcWalkAnim_"));
         }
         else if(this.TYPE == 19)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterBlueBigNpcWalkAnim_"));
         }
         else if(this.TYPE == 20)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterRedSmallNpcWalkAnim_"));
         }
         else if(this.TYPE == 21)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lobsterBlueSmallNpcWalkAnim_"));
         }
         else if(this.TYPE == 22)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach1NPCStandAnim_"));
         }
         else if(this.TYPE == 23)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach2NPCStandAnim_"));
         }
         else if(this.TYPE == 24)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach3NPCStandAnim_"));
         }
         else if(this.TYPE == 25)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach4NPCStandAnim_a"));
         }
         else if(this.TYPE == 26)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("beach4NPCStandAnim_a"));
         }
         else if(this.TYPE == 27)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("whiteMouseNpcStandAnim_a"));
         }
         else if(this.TYPE == 28)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sebastienneNpcStandAnim_a"));
         }
         else if(this.TYPE == 29)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("chefTomoNpcStandAnim_a"));
         }
         else if(this.TYPE == 30)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("oldAcornNpcStandAnim_a"));
         }
         else if(this.TYPE == 31)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("concettaNpcStandAnim_a"));
         }
         else if(this.TYPE == 32)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyNPCWalkAnim_"));
         }
         else if(this.TYPE == 33)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("zombieTomoNpcStandAnim_a"));
         }
         if(!(this.TYPE == 6 || this.TYPE == 7 || this.TYPE == 11 || this.TYPE == 12 || this.TYPE == 13 || this.TYPE == 14 || this.TYPE == 15 || this.TYPE == 22 || this.TYPE == 23 || this.TYPE == 24 || this.TYPE == 25 || this.TYPE == 26 || this.TYPE == 27 || this.TYPE == 28 || this.TYPE == 29 || this.TYPE == 30 || this.TYPE == 31 || this.TYPE == 33))
         {
            if(this.TYPE == 32)
            {
               this.walkAnim.setFrameDuration(0,0.1);
               this.walkAnim.setFrameDuration(1,0.1);
               this.walkAnim.setFrameDuration(2,0.1);
            }
            else
            {
               this.walkAnim.setFrameDuration(0,0.1);
               this.walkAnim.setFrameDuration(1,0.1);
               this.walkAnim.setFrameDuration(2,0.1);
               this.walkAnim.setFrameDuration(3,0.1);
            }
         }
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
   }
}
