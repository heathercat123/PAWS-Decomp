package minigames
{
   import flash.geom.Rectangle;
   import game_utils.AchievementsManager;
   import game_utils.EntityData;
   import game_utils.GameSlot;
   import game_utils.SaveManager;
   import sprites.minigames.GenericMinigameSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class FlappyBatMinigame extends ArcadeMinigame
   {
       
      
      protected var gameText_1:Image;
      
      protected var gameText_2:Image;
      
      protected var gameText_3:Image;
      
      protected var mountains_container:Sprite;
      
      protected var stars:Image;
      
      protected var mountains:Vector.<Image>;
      
      protected var mountains_xPos:Number;
      
      protected var CURRENT_STATE:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var counter_3:int;
      
      protected var tower_1:Sprite;
      
      protected var tower_2:Sprite;
      
      protected var tower_3:Sprite;
      
      protected var tower_1_images:Vector.<Image>;
      
      protected var tower_2_images:Vector.<Image>;
      
      protected var tower_3_images:Vector.<Image>;
      
      protected var tower_1_data:Rectangle;
      
      protected var tower_2_data:Rectangle;
      
      protected var tower_3_data:Rectangle;
      
      protected var tower_step:int;
      
      protected var tower_speed:Number;
      
      protected var heroSprite:GenericMinigameSprite;
      
      protected var heroData:EntityData;
      
      protected var hero_counter_1:int;
      
      protected var hero_counter_2:int;
      
      protected var HERO_STATE:int;
      
      protected var tower_to_check_points:int;
      
      public function FlappyBatMinigame()
      {
         super();
      }
      
      override protected function processInput() : void
      {
         var i:int = 0;
         if(Utils.IS_ON_WINDOWS)
         {
            return;
         }
         rightPressed = leftPressed = false;
         if(BLOCK_INPUT)
         {
            return;
         }
         if(touches != null)
         {
            if(touches[touches.length - 1] != null)
            {
               if(touches[touches.length - 1].phase == "began")
               {
                  this.spaceKeyPressed();
               }
            }
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var j:int = 0;
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var distance:Number = NaN;
         var radius:int = 0;
         var collision_detected:Boolean = false;
         this.processInput();
         if(this.CURRENT_STATE == 0)
         {
            ++this.counter_1;
            if(this.counter_1 >= 120)
            {
               this.CURRENT_STATE = 1;
               this.gameText_2.visible = false;
               BLOCK_INPUT = false;
            }
            else if(this.counter_1 >= 90)
            {
               this.gameText_1.visible = false;
               this.gameText_2.visible = true;
            }
         }
         else if(this.CURRENT_STATE == 1)
         {
            this.heroData.yVel += 0.1;
            if(this.heroData.yVel >= 4)
            {
               this.heroData.yVel = 4;
            }
            this.heroData.yPos += this.heroData.yVel;
            if(this.heroData.yPos <= 8)
            {
               this.heroData.yPos = 8;
               this.heroData.yVel = 0;
            }
            else if(this.heroData.yPos >= Utils.HEIGHT - 8)
            {
               this.heroData.yPos = Utils.HEIGHT - 8;
               this.heroData.yVel = 0;
            }
            this.mountains_xPos -= 0.25;
            if(this.mountains_xPos <= -96)
            {
               this.mountains_xPos += 96;
            }
            this.tower_1_data.x -= this.tower_speed;
            if(this.tower_1_data.x <= -64)
            {
               this.tower_1_data.x = 256 + this.tower_step;
               this.randomizeTower(0);
            }
            this.tower_2_data.x -= this.tower_speed;
            if(this.tower_2_data.x <= -64)
            {
               this.tower_2_data.x = 256 + this.tower_step;
               this.randomizeTower(1);
            }
            this.tower_3_data.x -= this.tower_speed;
            if(this.tower_3_data.x <= -64)
            {
               this.tower_3_data.x = 256 + this.tower_step;
               this.randomizeTower(2);
            }
            if(this.tower_to_check_points == 0)
            {
               if(this.tower_1_data.x < 48)
               {
                  this.tower_to_check_points = 1;
                  ++POINTS;
                  SoundSystem.PlaySound("arcade_coin");
               }
            }
            else if(this.tower_to_check_points == 1)
            {
               if(this.tower_2_data.x < 48)
               {
                  this.tower_to_check_points = 2;
                  ++POINTS;
                  SoundSystem.PlaySound("arcade_coin");
               }
            }
            else if(this.tower_to_check_points == 2)
            {
               if(this.tower_3_data.x < 48)
               {
                  this.tower_to_check_points = 0;
                  ++POINTS;
                  SoundSystem.PlaySound("arcade_coin");
               }
            }
            if(this.hero_counter_1 > 0)
            {
               --this.hero_counter_1;
               if(this.hero_counter_1 == 0)
               {
                  this.heroSprite.gotoAndStop(1);
               }
            }
            if(Utils.CircleRectHitTest(this.heroData.xPos,this.heroData.yPos,5,this.tower_1_data.x,this.tower_1_data.y,this.tower_1_data.x + 32,this.tower_1_data.y + 160))
            {
               this.gameOver();
            }
            else if(Utils.CircleRectHitTest(this.heroData.xPos,this.heroData.yPos,5,this.tower_1_data.x,this.tower_1_data.y - 216,this.tower_1_data.x + 32,this.tower_1_data.y - 216 + 160 + 8))
            {
               this.gameOver();
            }
            else if(Utils.CircleRectHitTest(this.heroData.xPos,this.heroData.yPos,5,this.tower_2_data.x,this.tower_2_data.y,this.tower_2_data.x + 32,this.tower_2_data.y + 160))
            {
               this.gameOver();
            }
            else if(Utils.CircleRectHitTest(this.heroData.xPos,this.heroData.yPos,5,this.tower_2_data.x,this.tower_2_data.y - 216,this.tower_2_data.x + 32,this.tower_2_data.y - 216 + 160 + 8))
            {
               this.gameOver();
            }
            else if(Utils.CircleRectHitTest(this.heroData.xPos,this.heroData.yPos,5,this.tower_3_data.x,this.tower_3_data.y,this.tower_3_data.x + 32,this.tower_3_data.y + 160))
            {
               this.gameOver();
            }
            else if(Utils.CircleRectHitTest(this.heroData.xPos,this.heroData.yPos,5,this.tower_3_data.x,this.tower_3_data.y - 216,this.tower_3_data.x + 32,this.tower_3_data.y - 216 + 160 + 8))
            {
               this.gameOver();
            }
         }
         else if(this.CURRENT_STATE == 2)
         {
            if(this.counter_1++ == 120)
            {
               GET_OUT_FLAG = true;
            }
         }
         super.update();
         this.updateScreenPositions();
      }
      
      protected function gameOver() : void
      {
         this.gameText_3.visible = true;
         Utils.world.setChildIndex(this.gameText_3,Utils.world.numChildren - 1);
         BLOCK_INPUT = true;
         this.heroSprite.gotoAndStop(3);
         this.heroSprite.gfxHandleClip().gotoAndPlay(1);
         this.heroData.yVel = 0;
         SoundSystem.PlayMusic("arcade_game_over");
         this.CURRENT_STATE = 2;
         this.counter_1 = 0;
         if(POINTS > Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_2_RECORD])
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_2_RECORD] = POINTS;
            AchievementsManager.SubmitScore("flappybat",Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_2_RECORD]);
            SaveManager.SaveGameVariables();
         }
      }
      
      override protected function spaceKeyPressed() : void
      {
         SoundSystem.PlaySound("arcade_flap");
         this.heroData.yVel = -2.5;
         this.hero_counter_1 = 10;
         this.heroSprite.gotoAndStop(2);
      }
      
      protected function updateScreenPositions() : void
      {
         this.mountains_container.x = int(this.mountains_xPos);
         this.tower_1.x = int(this.tower_1_data.x);
         this.tower_1.y = int(this.tower_1_data.y);
         this.tower_2.x = int(this.tower_2_data.x);
         this.tower_2.y = int(this.tower_2_data.y);
         this.tower_3.x = int(this.tower_3_data.x);
         this.tower_3.y = int(this.tower_3_data.y);
         this.heroSprite.x = int(Math.floor(this.heroData.xPos));
         this.heroSprite.y = int(Math.floor(this.heroData.yPos));
         this.heroSprite.updateScreenPosition();
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.world.removeChild(this.gameText_1);
         Utils.world.removeChild(this.gameText_2);
         Utils.world.removeChild(this.gameText_3);
         this.gameText_1.dispose();
         this.gameText_2.dispose();
         this.gameText_3.dispose();
         this.gameText_1 = this.gameText_2 = this.gameText_3 = null;
         Utils.world.removeChild(this.stars);
         this.stars.dispose();
         this.stars = null;
         for(i = 0; i < this.mountains.length; i++)
         {
            if(this.mountains[i] != null)
            {
               this.mountains_container.removeChild(this.mountains[i]);
               this.mountains[i].dispose();
               this.mountains[i] = null;
            }
         }
         this.mountains = null;
         Utils.world.removeChild(this.mountains_container);
         this.mountains_container.dispose();
         this.mountains_container = null;
         this.tower_1_data = this.tower_2_data = this.tower_3_data = null;
         for(i = 0; i < this.tower_1_images.length; i++)
         {
            this.tower_1.removeChild(this.tower_1_images[i]);
            this.tower_1_images[i].dispose();
            this.tower_1_images[i] = null;
         }
         this.tower_1_images = null;
         Utils.world.removeChild(this.tower_1);
         this.tower_1.dispose();
         this.tower_1 = null;
         for(i = 0; i < this.tower_2_images.length; i++)
         {
            this.tower_2.removeChild(this.tower_2_images[i]);
            this.tower_2_images[i].dispose();
            this.tower_2_images[i] = null;
         }
         this.tower_2_images = null;
         Utils.world.removeChild(this.tower_2);
         this.tower_2.dispose();
         this.tower_2 = null;
         for(i = 0; i < this.tower_3_images.length; i++)
         {
            this.tower_3.removeChild(this.tower_3_images[i]);
            this.tower_3_images[i].dispose();
            this.tower_3_images[i] = null;
         }
         this.tower_3_images = null;
         Utils.world.removeChild(this.tower_3);
         this.tower_3.dispose();
         this.tower_3 = null;
         super.destroy();
      }
      
      protected function randomizeTower(index:int) : void
      {
         if(index == 0)
         {
            this.tower_1_data.y = 56 + int(Math.random() * 5) * 24;
         }
         else if(index == 1)
         {
            this.tower_2_data.y = 56 + int(Math.random() * 5) * 24;
         }
         else
         {
            this.tower_3_data.y = 56 + int(Math.random() * 5) * 24;
         }
      }
      
      override public function init() : void
      {
         super.init();
         leftArrow.visible = rightArrow.visible = fireButton.visible = false;
         this.tower_to_check_points = 0;
         this.tower_step = 144;
         this.tower_speed = 1.2;
         this.hero_counter_1 = this.hero_counter_2 = 0;
         this.initBackground();
         this.initTowers();
         this.heroSprite = new GenericMinigameSprite(GenericMinigameSprite.SPRITE_BAT_HERO);
         Utils.world.addChild(this.heroSprite);
         this.heroSprite.gfxHandleClip().gotoAndStop(1);
         this.heroData = new EntityData(48,80,0,0);
         this.HERO_STATE = 0;
         this.randomizeTower(0);
         this.randomizeTower(1);
         this.randomizeTower(2);
         this.CURRENT_STATE = 0;
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.gameText_1 = new Image(TextureManager.minigamesTextureAtlas.getTexture("text_ready"));
         this.gameText_2 = new Image(TextureManager.minigamesTextureAtlas.getTexture("text_go"));
         this.gameText_3 = new Image(TextureManager.minigamesTextureAtlas.getTexture("text_game_over"));
         this.gameText_1.pivotX = int(this.gameText_1.width * 0.5);
         this.gameText_1.pivotY = int(this.gameText_1.height * 0.5);
         this.gameText_2.pivotX = int(this.gameText_2.width * 0.5);
         this.gameText_2.pivotY = int(this.gameText_2.height * 0.5);
         this.gameText_3.pivotX = int(this.gameText_3.width * 0.5);
         this.gameText_3.pivotY = int(this.gameText_3.height * 0.5);
         Utils.world.addChild(this.gameText_1);
         Utils.world.addChild(this.gameText_2);
         Utils.world.addChild(this.gameText_3);
         this.gameText_2.visible = this.gameText_3.visible = false;
         this.gameText_1.x = this.gameText_2.x = this.gameText_3.x = 96;
         this.gameText_1.y = this.gameText_2.y = this.gameText_3.y = 72;
      }
      
      protected function initTowers() : void
      {
         var i:int = 0;
         var image:Image = null;
         var offset:int = 64;
         this.tower_1 = new Sprite();
         this.tower_2 = new Sprite();
         this.tower_3 = new Sprite();
         this.tower_1_images = new Vector.<Image>();
         this.tower_2_images = new Vector.<Image>();
         this.tower_3_images = new Vector.<Image>();
         this.tower_1_data = new Rectangle();
         this.tower_2_data = new Rectangle();
         this.tower_3_data = new Rectangle();
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_2"));
         image.touchable = false;
         this.tower_1.addChild(image);
         this.tower_1_images.push(image);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_1"));
         image.touchable = false;
         image.y = 8;
         image.height = 160;
         this.tower_1.addChild(image);
         this.tower_1_images.push(image);
         Utils.world.addChild(this.tower_1);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_2"));
         image.touchable = false;
         image.scaleY = -1;
         image.y = -48;
         this.tower_1.addChild(image);
         this.tower_1_images.push(image);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_1"));
         image.touchable = false;
         image.y = -216;
         image.height = 160;
         this.tower_1.addChild(image);
         this.tower_1_images.push(image);
         this.tower_1_data = new Rectangle(160 + offset,96,0,0);
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_3"));
            image.touchable = false;
            image.y = i * 40 + 16;
            image.x = 8;
            this.tower_1.addChild(image);
            this.tower_1_images.push(image);
         }
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_3"));
            image.touchable = false;
            image.y = -i * 40 - 80;
            image.x = 8;
            this.tower_1.addChild(image);
            this.tower_1_images.push(image);
         }
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_2"));
         image.touchable = false;
         this.tower_2.addChild(image);
         this.tower_2_images.push(image);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_1"));
         image.touchable = false;
         image.y = 8;
         image.height = 160;
         this.tower_2.addChild(image);
         this.tower_2_images.push(image);
         Utils.world.addChild(this.tower_2);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_2"));
         image.touchable = false;
         image.scaleY = -1;
         image.y = -48;
         this.tower_2.addChild(image);
         this.tower_2_images.push(image);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_1"));
         image.touchable = false;
         image.y = -216;
         image.height = 160;
         this.tower_2.addChild(image);
         this.tower_2_images.push(image);
         this.tower_2_data = new Rectangle(160 + this.tower_step * 1 + offset,96,0,0);
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_3"));
            image.touchable = false;
            image.y = i * 40 + 16;
            image.x = 8;
            this.tower_2.addChild(image);
            this.tower_2_images.push(image);
         }
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_3"));
            image.touchable = false;
            image.y = -i * 40 - 80;
            image.x = 8;
            this.tower_2.addChild(image);
            this.tower_2_images.push(image);
         }
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_2"));
         image.touchable = false;
         this.tower_3.addChild(image);
         this.tower_3_images.push(image);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_1"));
         image.touchable = false;
         image.y = 8;
         image.height = 160;
         this.tower_3.addChild(image);
         this.tower_3_images.push(image);
         Utils.world.addChild(this.tower_3);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_2"));
         image.touchable = false;
         image.scaleY = -1;
         image.y = -48;
         this.tower_3.addChild(image);
         this.tower_3_images.push(image);
         image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_1"));
         image.touchable = false;
         image.y = -216;
         image.height = 160;
         this.tower_3.addChild(image);
         this.tower_3_images.push(image);
         this.tower_3_data = new Rectangle(160 + this.tower_step * 2 + offset,96,0,0);
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_3"));
            image.touchable = false;
            image.y = i * 40 + 16;
            image.x = 8;
            this.tower_3.addChild(image);
            this.tower_3_images.push(image);
         }
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_tower_3"));
            image.touchable = false;
            image.y = -i * 40 - 80;
            image.x = 8;
            this.tower_3.addChild(image);
            this.tower_3_images.push(image);
         }
      }
      
      protected function initBackground() : void
      {
         var i:int = 0;
         var image:Image = null;
         this.stars = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_sky"));
         this.stars.touchable = false;
         this.stars.x = 16;
         this.stars.y = 21;
         Utils.world.addChild(this.stars);
         this.mountains_xPos = 0;
         this.mountains_container = new Sprite();
         Utils.world.addChild(this.mountains_container);
         this.mountains_container.x = 0;
         this.mountains_container.y = 128;
         this.mountains = new Vector.<Image>();
         for(i = 0; i < 4; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bat_mountains"));
            image.touchable = false;
            image.x = i * image.width;
            image.y = 0;
            this.mountains.push(image);
            this.mountains_container.addChild(image);
         }
      }
   }
}
