package levels.collisions
{
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.decorations.DandelionFlowerDecoration;
   import levels.decorations.GenericDecoration;
   import levels.items.BellItem;
   import sprites.bullets.SeedHelperBulletSprite;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import starling.display.Image;
   import states.LevelState;
   
   public class ClodCollision extends Collision
   {
       
      
      public var stateMachine:StateMachine;
      
      protected var TYPE:int;
      
      protected var param_1:int;
      
      protected var param_2:int;
      
      protected var clod_index:int;
      
      protected var IS_GIVING_COINS:Boolean;
      
      protected var coin_counter_1:int;
      
      protected var coin_counter_2:int;
      
      protected var rope:RopeAreaCollision;
      
      protected var dandelion:DandelionFlowerDecoration;
      
      protected var redFlower:GenericDecoration;
      
      protected var shake_counter_1:int;
      
      protected var shake_counter_2:int;
      
      protected var plantGrowSprite:ClodCollisionSprite;
      
      protected var plantImage:Vector.<Image>;
      
      protected var plantData:Vector.<Point>;
      
      protected var plantTopImage:Image;
      
      protected var plant_counter_1:int;
      
      protected var plant_counter_2:int;
      
      protected var plant_yPos:Number;
      
      protected var plant_anim_index:int;
      
      protected var plant_offset:int;
      
      protected var plant_offset_counter_1:int;
      
      protected var plant_offset_counter_2:int;
      
      protected var IS_VINE_ALLOWED:Boolean;
      
      protected var grow_sfx_counter:int;
      
      public function ClodCollision(_level:Level, _xPos:Number, _yPos:Number, _param_1:int, _param_2:int, _index:int)
      {
         super(_level,_xPos,_yPos);
         this.param_1 = _param_1;
         this.param_2 = _param_2;
         this.clod_index = _index;
         this.shake_counter_1 = this.shake_counter_2 = 0;
         this.plant_counter_1 = this.plant_counter_2 = this.plant_yPos = 0;
         this.plant_anim_index = this.plant_offset = this.plant_offset_counter_1 = this.plant_offset_counter_2 = 0;
         this.grow_sfx_counter = 0;
         this.IS_VINE_ALLOWED = true;
         this.plantGrowSprite = null;
         this.plantImage = null;
         this.plantData = null;
         this.plantTopImage = null;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_13)
         {
            this.TYPE = 1;
            this.IS_VINE_ALLOWED = false;
         }
         else
         {
            this.TYPE = 0;
         }
         sprite = new ClodCollisionSprite(this.TYPE);
         Utils.topWorld.addChild(sprite);
         this.dandelion = null;
         this.redFlower = null;
         this.rope = null;
         WIDTH = 16;
         HEIGHT = 4;
         aabb.x = -2;
         aabb.y = 10;
         aabb.width = 20;
         aabb.height = 10;
         this.IS_GIVING_COINS = false;
         this.coin_counter_1 = this.coin_counter_2 = 0;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_NORMAL_STATE","SEED_ACTION","IS_SEEDING_STATE");
         this.stateMachine.setRule("IS_SEEDING_STATE","END_ACTION","IS_FLOWER_STATE");
         this.stateMachine.setRule("IS_FLOWER_STATE","END_ACTION","IS_PLANT_BASE_STATE");
         this.stateMachine.setRule("IS_SEEDING_STATE","GROW_ACTION","IS_GROWING_STATE");
         this.stateMachine.setRule("IS_GROWING_STATE","END_ACTION","IS_ROPE_STATE");
         this.stateMachine.setFunctionToState("IS_NORMAL_STATE",this.normalAnimation);
         this.stateMachine.setFunctionToState("IS_SEEDING_STATE",this.seedingAnimation);
         this.stateMachine.setFunctionToState("IS_FLOWER_STATE",this.flowerAnimation);
         this.stateMachine.setFunctionToState("IS_PLANT_BASE_STATE",this.plantBaseAnimation);
         this.stateMachine.setFunctionToState("IS_GROWING_STATE",this.growAnimation);
         this.stateMachine.setFunctionToState("IS_ROPE_STATE",this.ropeAnimation);
      }
      
      override public function postInit() : void
      {
         super.postInit();
         if(Utils.LEVEL_CLOD_STATE[this.clod_index] == 0)
         {
            this.stateMachine.setState("IS_NORMAL_STATE");
         }
         else if(Utils.LEVEL_CLOD_STATE[this.clod_index] == 1)
         {
            this.stateMachine.setState("IS_FLOWER_STATE");
         }
         else if(Utils.LEVEL_CLOD_STATE[this.clod_index] == 2)
         {
            this.stateMachine.setState("IS_FLOWER_STATE");
            this.stateMachine.setState("IS_PLANT_BASE_STATE");
         }
         else if(Utils.LEVEL_CLOD_STATE[this.clod_index] == 3)
         {
            this.stateMachine.setState("IS_ROPE_STATE");
            this.growFullVine();
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_13)
         {
            if(Utils.Slot.gameProgression[18] == 1)
            {
               this.stateMachine.setState("IS_FLOWER_STATE");
            }
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.plantImage != null)
         {
            for(i = 0; i < this.plantImage.length; i++)
            {
               Utils.backWorld.removeChild(this.plantImage[i]);
               this.plantImage[i].dispose();
               this.plantImage[i] = null;
            }
         }
         this.plantImage = null;
         if(this.plantGrowSprite != null)
         {
            Utils.backWorld.removeChild(this.plantGrowSprite);
            this.plantGrowSprite.destroy();
            this.plantGrowSprite.dispose();
            this.plantGrowSprite = null;
         }
         if(this.plantTopImage != null)
         {
            Utils.backWorld.removeChild(this.plantTopImage);
            this.plantTopImage.dispose();
            this.plantTopImage = null;
         }
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.topWorld.removeChild(sprite);
         if(this.dandelion != null)
         {
            this.dandelion.destroy();
            this.dandelion = null;
         }
         if(this.redFlower != null)
         {
            this.redFlower.destroy();
            this.redFlower = null;
         }
         if(this.rope != null)
         {
            this.rope.destroy();
            this.rope = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var plant:Image = null;
         if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            for(i = 0; i < level.bulletsManager.bullets.length; i++)
            {
               if(level.bulletsManager.bullets[i] != null)
               {
                  if(level.bulletsManager.bullets[i].sprite != null)
                  {
                     if(level.bulletsManager.bullets[i].sprite is SeedHelperBulletSprite)
                     {
                        if(level.bulletsManager.bullets[i].IS_HELPER)
                        {
                           if(level.bulletsManager.bullets[i].getAABB().intersects(getAABB()))
                           {
                              level.bulletsManager.bullets[i].dead = true;
                              this.stateMachine.performAction("SEED_ACTION");
                           }
                        }
                     }
                  }
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_SEEDING_STATE")
         {
            if(sprite.gfxHandleClip().currentFrame == 1)
            {
               ++this.shake_counter_2;
               if(this.shake_counter_2 >= 30)
               {
                  if(this.shake_counter_1++ > 1)
                  {
                     SoundSystem.PlaySound("wiggle");
                     this.shake_counter_1 = 0;
                     if(xPos >= originalXPos)
                     {
                        xPos = originalXPos - 1;
                     }
                     else
                     {
                        xPos = originalXPos + 1;
                     }
                  }
               }
            }
            else
            {
               xPos = originalXPos;
            }
            if(sprite.gfxHandleClip().isComplete)
            {
               if(Utils.Slot.playerInventory[LevelItems.ITEM_HELPER_COCONUT] >= 3 && this.IS_VINE_ALLOWED)
               {
                  this.stateMachine.performAction("GROW_ACTION");
               }
               else
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_FLOWER_STATE")
         {
            if(this.dandelion != null)
            {
               if(this.dandelion.isBlown)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_GROWING_STATE")
         {
            ++this.plant_offset_counter_1;
            if(this.plant_offset_counter_1 >= 3)
            {
               this.plant_offset_counter_1 = 0;
               if(this.plant_offset > 0)
               {
                  this.plant_offset = 0;
                  SoundSystem.PlaySound("plant_grow");
               }
               else
               {
                  this.plant_offset = 1;
               }
            }
            ++this.plant_counter_1;
            if(this.plant_counter_1 > 0)
            {
               this.plant_counter_1 = 0;
               ++this.plant_anim_index;
               --this.plant_yPos;
               if(this.plant_anim_index >= 20)
               {
                  this.plant_anim_index = 0;
                  plant = new Image(TextureManager.sTextureAtlas.getTexture("clodPlantCollisionSpriteAnim_t"));
                  plant.touchable = false;
                  Utils.backWorld.addChild(plant);
                  this.plantImage.push(plant);
               }
               if(this.plant_yPos <= -16)
               {
                  this.plant_offset = 0;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         if(this.dandelion != null)
         {
            this.dandelion.update();
         }
         if(this.redFlower != null)
         {
            this.redFlower.update();
         }
         if(this.rope != null)
         {
            this.rope.update();
            this.rope.checkEntitiesCollision();
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var outer_aabb:Rectangle = null;
         var hero_aabb:Rectangle = level.hero.getAABB();
         var clod_aabb:Rectangle = getAABB();
         if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != LevelItems.ITEM_HELPER_COCONUT)
            {
               outer_aabb = getAABB();
               outer_aabb.x -= 48;
               outer_aabb.width += 96;
               if(hero_aabb.intersects(outer_aabb))
               {
                  level.soundHud.showHint(LevelItems.ITEM_HELPER_COCONUT);
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         if(this.dandelion != null)
         {
            this.dandelion.updateScreenPosition(camera);
         }
         if(this.redFlower != null)
         {
            this.redFlower.updateScreenPosition(camera);
         }
         if(this.rope != null)
         {
            this.rope.updateScreenPosition(camera);
         }
         if(this.plantTopImage != null)
         {
            this.plantTopImage.x = int(Math.floor(xPos + 1 + this.plant_offset - camera.xPos));
            this.plantTopImage.y = int(Math.floor(this.plant_yPos - camera.yPos));
         }
         if(this.plantGrowSprite != null)
         {
            this.plantGrowSprite.x = int(Math.floor(xPos + this.plant_offset - camera.xPos));
            this.plantGrowSprite.y = int(Math.floor(yPos - 4 - camera.yPos));
            this.plantGrowSprite.updateScreenPosition();
            this.plantGrowSprite.gfxHandleClip().gotoAndStop(this.plant_anim_index);
         }
         if(this.plantImage != null)
         {
            for(i = 0; i < this.plantImage.length; i++)
            {
               if(this.plantImage[i] != null)
               {
                  this.plantImage[i].x = int(Math.floor(xPos + this.plant_offset - camera.xPos));
                  this.plantImage[i].y = int(Math.floor(yPos - 4 - i * 20 - this.plant_anim_index - camera.yPos));
               }
            }
         }
      }
      
      protected function createReward() : void
      {
         var item:BellItem = null;
         if(this.param_1 == 0)
         {
            item = new BellItem(level,xPos,yPos,this.param_2);
            item.stateMachine.performAction("COLLECTED_ACTION");
            item.updateScreenPosition(level.camera);
            level.itemsManager.items.push(item);
         }
         else if(this.param_1 == 1)
         {
            this.IS_GIVING_COINS = true;
            this.coin_counter_1 = this.coin_counter_2 = 0;
         }
      }
      
      protected function normalAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
      }
      
      protected function seedingAnimation() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         QuestsManager.SubmitQuestAction(QuestsManager.ACTION_SEED_PLANTED_BY_COCONUT_HELPER);
         if(Utils.Slot.playerInventory[LevelItems.ITEM_HELPER_COCONUT] >= 3 && this.IS_VINE_ALLOWED)
         {
            sprite.gfxHandleClip().setFrameDuration(2,0);
            sprite.gfxHandleClip().setFrameDuration(3,0);
         }
         this.shake_counter_1 = this.shake_counter_2 = 0;
      }
      
      protected function flowerAnimation() : void
      {
         if(level.level_tick > 30)
         {
            SoundSystem.PlaySound("item_pop");
         }
         Utils.LEVEL_CLOD_STATE[this.clod_index] = 1;
         sprite.visible = false;
         var is_coin:int = 0;
         if(Utils.Slot.playerInventory[LevelItems.ITEM_HELPER_COCONUT] <= 1)
         {
            if(Math.random() * 100 > 50)
            {
               is_coin = 1;
            }
         }
         else if(Math.random() * 100 > 25)
         {
            is_coin = 1;
         }
         if(this.TYPE == 1)
         {
            this.redFlower = new GenericDecoration(level,xPos + 1,yPos,0,0,GenericDecoration.RED_FLOWER);
            this.redFlower.updateScreenPosition(level.camera);
         }
         else
         {
            this.dandelion = new DandelionFlowerDecoration(level,xPos + 1,yPos,0,is_coin,true);
            this.dandelion.updateScreenPosition(level.camera);
         }
      }
      
      protected function plantBaseAnimation() : void
      {
         Utils.LEVEL_CLOD_STATE[this.clod_index] = 2;
         this.dandelion.blowWithoutEffects();
      }
      
      protected function growAnimation() : void
      {
         sprite.gotoAndStop(3);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.plantGrowSprite = new ClodCollisionSprite();
         this.plantGrowSprite.gotoAndStop(4);
         this.plantGrowSprite.gfxHandleClip().gotoAndStop(1);
         Utils.backWorld.addChild(this.plantGrowSprite);
         this.plantImage = new Vector.<Image>();
         this.plantTopImage = new Image(TextureManager.sTextureAtlas.getTexture("clodPlantTop1"));
         this.plantTopImage.touchable = false;
         Utils.backWorld.addChild(this.plantTopImage);
         this.plant_counter_1 = this.plant_counter_2 = 0;
         this.plant_yPos = yPos + 8;
         this.plant_anim_index = 0;
         this.plant_offset = this.plant_offset_counter_1 = this.plant_offset_counter_2 = 0;
      }
      
      protected function ropeAnimation() : void
      {
         Utils.LEVEL_CLOD_STATE[this.clod_index] = 3;
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.rope = new RopeAreaCollision(level,xPos,0,16,yPos - this.plant_yPos - 16);
      }
      
      protected function growFullVine() : void
      {
         var i:int = 0;
         var plant:Image = null;
         this.plantImage = new Vector.<Image>();
         this.plantTopImage = new Image(TextureManager.sTextureAtlas.getTexture("clodPlantTop1"));
         this.plantTopImage.touchable = false;
         Utils.backWorld.addChild(this.plantTopImage);
         this.plant_yPos = -16;
         var plants_amount:int = int(yPos - this.plant_yPos) / 20;
         for(i = 0; i < plants_amount; i++)
         {
            plant = new Image(TextureManager.sTextureAtlas.getTexture("clodPlantCollisionSpriteAnim_t"));
            plant.touchable = false;
            Utils.backWorld.addChild(plant);
            this.plantImage.push(plant);
         }
      }
   }
}
