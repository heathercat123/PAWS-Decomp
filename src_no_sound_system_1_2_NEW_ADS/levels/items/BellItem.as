package levels.items
{
   import entities.Hero;
   import entities.enemies.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import levels.Level;
   import levels.cameras.*;
   import sprites.items.BellInvisibleItemSprite;
   import sprites.items.BellItemSprite;
   import sprites.items.BubbleItemSprite;
   import sprites.particles.BubbleItemBurstParticleSprite;
   import starling.display.Image;
   
   public class BellItem extends Item
   {
       
      
      protected var forced_max_y_pos:Number;
      
      protected var bubbleSprite:BubbleItemSprite;
      
      protected var bubbleBackImage:Image;
      
      protected var bubble_aabb:Rectangle;
      
      protected var IS_GIVING_COINS:Boolean;
      
      protected var coin_counter_1:int;
      
      protected var coin_counter_2:int;
      
      protected var coins_amount:int;
      
      public function BellItem(_level:Level, _xPos:Number, _yPos:Number, _index:int, _forced_max_y_pos:Number = 0, _isBubble:int = 0)
      {
         super(_level,_xPos,_yPos,_index);
         this.bubbleSprite = null;
         this.bubbleBackImage = null;
         this.forced_max_y_pos = _forced_max_y_pos;
         this.bubble_aabb = new Rectangle(-12,-12,24,24);
         this.coins_amount = 5;
         if(got_already)
         {
            sprite = new BellInvisibleItemSprite();
         }
         else
         {
            sprite = new BellItemSprite();
         }
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         if(_isBubble > 0)
         {
            IS_INSIDE_BUBBLE = true;
            this.bubbleSprite = new BubbleItemSprite();
            Utils.world.addChild(this.bubbleSprite);
            this.bubbleBackImage = new Image(TextureManager.sTextureAtlas.getTexture("bubbleItemSpriteBackAnim_a"));
            this.bubbleBackImage.pivotX = this.bubbleBackImage.pivotY = 20;
            this.bubbleBackImage.touchable = false;
            Utils.world.addChild(this.bubbleBackImage);
            Utils.world.setChildIndex(this.bubbleBackImage,0);
            this.fetchScripts();
            if(path_start_y > 0)
            {
               MOVEMENT_TYPE = 1;
               if(yPos + 8 > (path_start_y + path_end_y) * 0.5)
               {
                  IS_A_TO_B = false;
                  yPos = path_end_y;
               }
               else
               {
                  yPos = path_start_y;
               }
            }
            else if(path_start_x > 0)
            {
               MOVEMENT_TYPE = 2;
               if(xPos + 8 > (path_start_x + path_end_x) * 0.5)
               {
                  IS_A_TO_B = false;
                  xPos = path_end_x;
               }
               else
               {
                  xPos = path_start_x;
               }
            }
         }
         else
         {
            IS_INSIDE_BUBBLE = false;
         }
         stateMachine.setRule("IS_STANDING_STATE","COIN_REWARD_ACTION","IS_GIVING_COINS_STATE");
         stateMachine.setRule("IS_GIVING_COINS_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setRule("IS_FROZEN_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_FROZEN_STATE",this.frozenAnimation);
         stateMachine.setFunctionToState("IS_GIVING_COINS_STATE",this.givingCoinsAnimation);
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function getAABB() : Rectangle
      {
         if(IS_INSIDE_BUBBLE)
         {
            if(MOVEMENT_TYPE == 1)
            {
               return new Rectangle(xPos + 8 - float_y_offset + this.bubble_aabb.x,yPos + 10 + this.bubble_aabb.y,this.bubble_aabb.width,this.bubble_aabb.height);
            }
            return new Rectangle(xPos + 8 + this.bubble_aabb.x,yPos - float_y_offset + 10 + this.bubble_aabb.y,this.bubble_aabb.width,this.bubble_aabb.height);
         }
         return new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
      }
      
      override public function destroy() : void
      {
         this.bubble_aabb = null;
         if(IS_INSIDE_BUBBLE)
         {
            Utils.world.removeChild(this.bubbleSprite);
            this.bubbleSprite.destroy();
            this.bubbleSprite.dispose();
            this.bubbleSprite = null;
            Utils.world.removeChild(this.bubbleBackImage);
            this.bubbleBackImage.dispose();
            this.bubbleBackImage = null;
         }
         super.destroy();
      }
      
      override public function postInit() : void
      {
         var x_t:int = getMidXPos() / Utils.TILE_WIDTH;
         var y_t:int = getMidYPos() / Utils.TILE_HEIGHT;
         if(level.levelData.getTileValueAt(x_t,y_t) != 0)
         {
            stateMachine.setState("IS_FROZEN_STATE");
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_FROZEN_STATE")
         {
            if(level.levelData.getTileValueAt(getMidXPos() / Utils.TILE_WIDTH,getMidYPos() / Utils.TILE_HEIGHT) == 0)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(this.IS_GIVING_COINS)
         {
            if(counter1-- < 0)
            {
               counter1 = 12;
               SoundSystem.PlaySound("coin");
               Utils.AddCoins(1);
               level.topParticlesManager.createItemParticlesAt(LevelItems.ITEM_COIN,xPos + 8,yPos - 4);
               --this.coins_amount;
               if(this.coins_amount <= 0)
               {
                  this.IS_GIVING_COINS = false;
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         if(this.forced_max_y_pos > 0)
         {
            if(yPos >= this.forced_max_y_pos)
            {
               yPos = this.forced_max_y_pos;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(IS_INSIDE_BUBBLE)
         {
            if(MOVEMENT_TYPE == 1)
            {
               this.bubbleSprite.x = this.bubbleBackImage.x = int(Math.floor(xPos + 8 - float_y_offset - camera.xPos));
               this.bubbleSprite.y = this.bubbleBackImage.y = int(Math.floor(yPos + 10 - camera.yPos));
            }
            else
            {
               this.bubbleSprite.x = this.bubbleBackImage.x = int(Math.floor(xPos + 8 - camera.xPos));
               this.bubbleSprite.y = this.bubbleBackImage.y = int(Math.floor(yPos - float_y_offset + 10 - camera.yPos));
            }
         }
      }
      
      override public function collected() : void
      {
         if(Utils.LEVEL_ITEMS[level_index] == false)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_BELL_COLLECTED_BY_ANY_CAT);
            if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_BELL_COLLECTED_BY_RIGS);
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_ROSE)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_BELL_COLLECTED_BY_ROSE);
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_PASCAL)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_BELL_COLLECTED_BY_PASCAL);
            }
         }
         Utils.QUEST_BELL_COLLECTED_FLAG = true;
         Utils.LEVEL_ITEMS[level_index] = true;
         if(got_already)
         {
            stateMachine.performAction("COIN_REWARD_ACTION");
         }
         else
         {
            stateMachine.performAction("COLLECTED_ACTION");
         }
         if(IS_INSIDE_BUBBLE)
         {
            if(this.bubbleSprite.visible)
            {
               SoundSystem.PlaySound("item_pop");
               this.bubbleSprite.visible = false;
               this.bubbleBackImage.visible = false;
               level.particlesManager.pushParticle(new BubbleItemBurstParticleSprite(),xPos + 8,yPos + float_y_offset + 10,0,0,0);
            }
         }
      }
      
      override protected function standingAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter_1 = counter_2 = 0;
      }
      
      protected function frozenAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
      }
      
      protected function givingCoinsAnimation() : void
      {
         sprite.visible = false;
         if(got_already)
         {
            this.IS_GIVING_COINS = true;
            this.coin_counter_1 = this.coin_counter_2 = 0;
         }
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         var area_enemy:Rectangle = new Rectangle(xPos - 0,yPos - 0,16,16);
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               if(level.scriptsManager.verPathScripts[i].intersects(area_enemy))
               {
                  path_start_y = level.scriptsManager.verPathScripts[i].y;
                  path_end_y = level.scriptsManager.verPathScripts[i].y + level.scriptsManager.verPathScripts[i].height;
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               if(level.scriptsManager.horPathScripts[i].intersects(area_enemy))
               {
                  path_start_x = level.scriptsManager.horPathScripts[i].x;
                  path_end_x = level.scriptsManager.horPathScripts[i].x + level.scriptsManager.horPathScripts[i].width;
               }
            }
         }
      }
   }
}
