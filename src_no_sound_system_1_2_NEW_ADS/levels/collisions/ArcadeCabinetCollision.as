package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.CoinPrices;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import interfaces.dialogs.Dialog;
   import interfaces.panels.*;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import starling.display.Image;
   
   public class ArcadeCabinetCollision extends Collision
   {
       
      
      protected var TYPE:int;
      
      protected var IS_ON:Boolean;
      
      protected var light_image:Image;
      
      protected var hero_collision_delay:int;
      
      protected var fooEntity:Entity;
      
      protected var dialog:Dialog;
      
      protected var outerAABB:Rectangle;
      
      protected var IS_HERO_COLLIDING:Boolean;
      
      protected var star_image:Image;
      
      protected var GAME_ID:int;
      
      public function ArcadeCabinetCollision(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0, _is_on:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.IS_HERO_COLLIDING = false;
         this.TYPE = _type;
         WIDTH = 24;
         HEIGHT = 32;
         this.hero_collision_delay = 30;
         this.star_image = null;
         this.fooEntity = new Entity(level,xPos + 3,yPos + 8,Entity.RIGHT);
         this.GAME_ID = _is_on;
         this.IS_ON = false;
         if(_is_on > 0)
         {
            this.IS_ON = true;
         }
         aabb.x = aabb.y = 0;
         aabb.width = 24;
         aabb.height = 32;
         this.outerAABB = new Rectangle(-4,0,32,32);
         if(this.TYPE == 1)
         {
            sprite = new GenericCollisionSprite(5);
         }
         else if(this.TYPE == 2)
         {
            sprite = new GenericCollisionSprite(6);
         }
         else if(this.TYPE == 3)
         {
            sprite = new GenericCollisionSprite(8);
            this.fooEntity.xPos = xPos + 1;
            aabb.x = -2;
            aabb.y = 0;
            aabb.width = 24;
            aabb.height = 22;
            this.outerAABB.x = -6;
            this.outerAABB.width = 30;
            this.outerAABB.height = 22;
         }
         else
         {
            sprite = new GenericCollisionSprite(4);
         }
         Utils.backWorld.addChild(sprite);
         if(this.TYPE == 3)
         {
            this.initStarImages();
         }
         else
         {
            this.light_image = new Image(TextureManager.sTextureAtlas.getTexture("arcade_screen_image"));
            this.light_image.touchable = false;
            Utils.backWorld.addChild(this.light_image);
            this.light_image.visible = false;
         }
         if(this.IS_ON)
         {
            this.light_image.visible = true;
         }
         counter1 = counter2 = 0;
      }
      
      override public function destroy() : void
      {
         this.fooEntity.destroy();
         this.fooEntity = null;
         this.outerAABB = null;
         this.dialog = null;
         Utils.backWorld.removeChild(sprite);
         Utils.backWorld.removeChild(this.light_image);
         this.light_image.dispose();
         this.light_image = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.IS_ON)
         {
            --this.hero_collision_delay;
            if(this.hero_collision_delay <= 0)
            {
               this.hero_collision_delay = -1;
            }
            if(this.TYPE == 3)
            {
               if(counter1++ >= (this.light_image.visible ? 30 : 15))
               {
                  counter1 = 0;
                  this.light_image.visible = !this.light_image.visible;
               }
            }
            else if(counter1++ >= 1)
            {
               counter1 = 0;
               if(counter2 == 0)
               {
                  this.light_image.alpha = 1;
                  counter2 = 1;
               }
               else
               {
                  this.light_image.alpha = 0.8;
                  counter2 = 0;
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var outer_aabb:Rectangle = null;
         if(this.hero_collision_delay > 0)
         {
            return;
         }
         if(!this.IS_ON)
         {
            return;
         }
         var hero_aabb:Rectangle = level.hero.getAABB();
         var this_aabb:Rectangle = getAABB();
         if(this.IS_HERO_COLLIDING)
         {
            outer_aabb = new Rectangle(xPos + this.outerAABB.x,yPos + this.outerAABB.y,this.outerAABB.width,this.outerAABB.height);
            if(!hero_aabb.intersects(outer_aabb))
            {
               if(this.IS_HERO_COLLIDING)
               {
                  this.endInteraction();
               }
               this.IS_HERO_COLLIDING = false;
            }
         }
         else if(hero_aabb.intersects(this_aabb))
         {
            if(!this.IS_HERO_COLLIDING)
            {
               this.startInteraction();
            }
            this.IS_HERO_COLLIDING = true;
         }
      }
      
      protected function playArcade(_success:Boolean) : void
      {
         if(this.TYPE == 3)
         {
            if(LevelItems.GetCoinsAmount() < CoinPrices.GetPrice(CoinPrices.GACHAPON))
            {
               SoundSystem.PlaySound("error");
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
               {
                  Utils.ShopIndex = -1;
                  Utils.LAST_SHOP_MENU = 3;
                  Utils.ShopOn = true;
               }
            }
            else
            {
               SoundSystem.PlaySound("purchase");
               Utils.Slot.playerInventory[LevelItems.ITEM_COIN] -= CoinPrices.GetPrice(CoinPrices.GACHAPON);
               Utils.GACHA_INDEX = this.getGachaPrize();
               SaveManager.SaveInventory();
               SaveManager.SaveGameVariables();
               SettingsPanel.iCloudSaveCoins();
               level.MINIGAME_FLAG = true;
               Utils.MINIGAME_ID = 1;
            }
         }
         else if(LevelItems.GetCoinsAmount() < CoinPrices.GetPrice(CoinPrices.ARCADE_MEGA_PANG))
         {
            SoundSystem.PlaySound("error");
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
            {
               Utils.ShopIndex = -1;
               Utils.LAST_SHOP_MENU = 3;
               Utils.ShopOn = true;
            }
         }
         else
         {
            SoundSystem.PlaySound("purchase");
            Utils.Slot.playerInventory[LevelItems.ITEM_COIN] -= CoinPrices.GetPrice(CoinPrices.ARCADE_MEGA_PANG);
            SaveManager.SaveInventory(true);
            SettingsPanel.iCloudSaveCoins();
            level.MINIGAME_FLAG = true;
            if(this.GAME_ID == 2)
            {
               Utils.MINIGAME_ID = 2;
            }
            else
            {
               Utils.MINIGAME_ID = 0;
            }
         }
      }
      
      protected function getGachaPrize() : int
      {
         var random_index:int = this.getToyIndex();
         Utils.Slot.playerInventory[LevelItems.ITEM_GACHA_1] |= 1 << random_index;
         return random_index;
      }
      
      protected function startInteraction() : void
      {
         if(this.TYPE == 3)
         {
            this.dialog = level.hud.dialogsManager.createPriceBalloonOn(StringsManager.GetString("play_gacha_1"),CoinPrices.GetPrice(CoinPrices.GACHAPON),this.fooEntity,null,0,this.playArcade);
         }
         else
         {
            this.dialog = level.hud.dialogsManager.createPriceBalloonOn(StringsManager.GetString("play_arcade_" + this.GAME_ID),CoinPrices.GetPrice(CoinPrices.ARCADE_MEGA_PANG),this.fooEntity,null,0,this.playArcade);
         }
      }
      
      protected function endInteraction() : void
      {
         if(this.dialog != null)
         {
            this.dialog.endRendering();
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.TYPE == 3)
         {
            this.star_image.x = this.light_image.x = sprite.x + 5;
            this.star_image.y = this.light_image.y = sprite.y - 8;
         }
         else
         {
            this.light_image.x = sprite.x + 3;
            this.light_image.y = sprite.y + 8;
         }
         Utils.backWorld.setChildIndex(sprite,Utils.backWorld.numChildren - 1);
         Utils.backWorld.setChildIndex(this.light_image,Utils.backWorld.numChildren - 1);
      }
      
      protected function initStarImages() : void
      {
         this.star_image = new Image(TextureManager.sTextureAtlas.getTexture("gachaStarCollisionSpriteAnim_b"));
         this.star_image.touchable = false;
         Utils.backWorld.addChild(this.star_image);
         this.light_image = new Image(TextureManager.sTextureAtlas.getTexture("gachaStarCollisionSpriteAnim_a"));
         this.light_image.touchable = false;
         Utils.backWorld.addChild(this.light_image);
         this.light_image.visible = false;
      }
      
      protected function getToyIndex() : int
      {
         var i:int = 0;
         var random_choice:int = 0;
         var toys_amount:int = 20;
         var rolls_amount:Array = new Array();
         var random_factor:Number = 0.5;
         for(i = 0; i < toys_amount; i++)
         {
            rolls_amount.push(1 + int(Utils.Slot.gameVariables[GameSlot.VARIABLE_GACHA_0_SPAWN_0 + i] * random_factor));
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 89)
         {
            rolls_amount[toys_amount - 2] *= 2;
         }
         else
         {
            rolls_amount[toys_amount - 2] *= 3;
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 86)
         {
            rolls_amount[toys_amount - 1] *= 2;
         }
         else
         {
            rolls_amount[toys_amount - 1] *= 3;
         }
         var found:Boolean = false;
         while(!found)
         {
            random_choice = int(Math.random() * toys_amount);
            if(rolls_amount[random_choice]-- <= 0)
            {
               found = true;
            }
         }
         ++Utils.Slot.gameVariables[GameSlot.VARIABLE_GACHA_0_SPAWN_0 + random_choice];
         return random_choice;
      }
   }
}
