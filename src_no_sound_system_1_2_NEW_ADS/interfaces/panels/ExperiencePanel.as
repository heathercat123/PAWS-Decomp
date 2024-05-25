package interfaces.panels
{
   import entities.Easings;
   import game_utils.EntityData;
   import interfaces.texts.GameText;
   import sprites.hud.SparkleHudSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ExperiencePanel extends Sprite
   {
       
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var barContainer:Sprite;
      
      protected var level_up_text:GameText;
      
      protected var sx_image:Image;
      
      protected var center_image:Image;
      
      protected var dx_image:Image;
      
      protected var exp_bar_image:Image;
      
      protected var helper_image:Image;
      
      protected var helper_image_next_level:Image;
      
      public var HEIGHT:int;
      
      public var WIDTH:int;
      
      public var INDEX:int;
      
      protected var IS_INCREASING_EXP:Boolean;
      
      protected var CURRENT_EXP:Number;
      
      protected var EXP_INCREASE:Number;
      
      protected var WITH_IMAGE:Boolean;
      
      protected var MAX_EXP_PIXEL_WIDTH:Number;
      
      protected var PROGRESSION:int;
      
      protected var pixels_increase:Number;
      
      public var IS_EXP_INCREASE_DONE:Boolean;
      
      public var NEW_EXP_TO_SAVE:Number;
      
      public var IS_EVOLUTION:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var particleSprite:Vector.<SparkleHudSprite>;
      
      protected var particleData:Vector.<EntityData>;
      
      public function ExperiencePanel(helper_index:int, _width:int, _helper_image:Boolean = false, _exp_increase:Number = 0)
      {
         super();
         this.INDEX = helper_index;
         this.WIDTH = _width;
         this.HEIGHT = 6;
         this.WITH_IMAGE = _helper_image;
         this.helper_image = null;
         this.helper_image_next_level = null;
         this.IS_INCREASING_EXP = false;
         this.MAX_EXP_PIXEL_WIDTH = this.WIDTH - 4;
         this.counter_1 = this.counter_2 = 0;
         this.IS_EXP_INCREASE_DONE = false;
         this.IS_EVOLUTION = false;
         this.particleSprite = null;
         this.particleData = null;
         this.CURRENT_EXP = Utils.Slot.gameVariables[helper_index];
         this.EXP_INCREASE = _exp_increase;
         this.PROGRESSION = 0;
         this.pixels_increase = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.NEW_EXP_TO_SAVE = this.CURRENT_EXP + this.EXP_INCREASE;
         if(this.NEW_EXP_TO_SAVE >= 100)
         {
            this.NEW_EXP_TO_SAVE = 100;
         }
         this.initPanel();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.particleSprite != null)
         {
            for(i = 0; i < this.particleSprite.length; i++)
            {
               removeChild(this.particleSprite[i]);
               this.particleSprite[i].destroy();
               this.particleSprite[i].dispose();
               this.particleSprite[i] = null;
               this.particleData[i] = null;
            }
         }
         this.particleSprite = null;
         this.particleData = null;
         if(this.level_up_text != null)
         {
            removeChild(this.level_up_text);
            this.level_up_text.destroy();
            this.level_up_text.dispose();
            this.level_up_text = null;
         }
         if(this.helper_image != null)
         {
            removeChild(this.helper_image);
            this.helper_image.dispose();
            this.helper_image = null;
         }
         if(this.helper_image_next_level != null)
         {
            removeChild(this.helper_image_next_level);
            this.helper_image_next_level.dispose();
            this.helper_image_next_level = null;
         }
         this.barContainer.removeChild(this.sx_image);
         this.barContainer.removeChild(this.dx_image);
         this.barContainer.removeChild(this.center_image);
         this.barContainer.removeChild(this.exp_bar_image);
         removeChild(this.barContainer);
         this.barContainer.dispose();
         this.sx_image.dispose();
         this.dx_image.dispose();
         this.center_image.dispose();
         this.exp_bar_image.dispose();
         this.barContainer = null;
         this.sx_image = null;
         this.dx_image = null;
         this.center_image = null;
         this.exp_bar_image = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         if(this.IS_INCREASING_EXP)
         {
            if(this.PROGRESSION == 0)
            {
               this.pixels_increase = this.EXP_INCREASE * this.MAX_EXP_PIXEL_WIDTH / 100;
               this.t_start = this.exp_bar_image.width;
               this.t_diff = this.pixels_increase;
               this.t_tick = 0;
               this.t_time = this.pixels_increase * 0.125;
               this.counter_1 = 0;
               ++this.PROGRESSION;
            }
            else if(this.PROGRESSION == 1)
            {
               if(this.counter_1++ > 15)
               {
                  this.t_tick += 1 / 60;
                  if(this.t_tick >= this.t_time || this.exp_bar_image.width >= this.MAX_EXP_PIXEL_WIDTH)
                  {
                     this.t_tick = this.t_time;
                     ++this.PROGRESSION;
                     this.counter_1 = 0;
                  }
                  this.exp_bar_image.width = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
                  if(this.exp_bar_image.width >= this.MAX_EXP_PIXEL_WIDTH)
                  {
                     this.exp_bar_image.width = this.MAX_EXP_PIXEL_WIDTH;
                  }
               }
            }
            else if(this.PROGRESSION == 2)
            {
               if(this.counter_1++ > 15)
               {
                  this.IS_EXP_INCREASE_DONE = true;
                  this.exp_bar_image.width = int(Math.round(this.t_start + this.t_diff));
                  if(this.exp_bar_image.width >= this.MAX_EXP_PIXEL_WIDTH)
                  {
                     this.exp_bar_image.width = this.MAX_EXP_PIXEL_WIDTH;
                  }
                  ++this.PROGRESSION;
                  if(this.NEW_EXP_TO_SAVE >= 100)
                  {
                     this.setLevelUpAnimation();
                     this.IS_EVOLUTION = true;
                  }
               }
            }
         }
         if(this.particleSprite != null)
         {
            for(i = 0; i < this.particleSprite.length; i++)
            {
               if(this.particleData[i].counter1-- == 0)
               {
                  this.particleSprite[i].visible = true;
               }
               if(this.particleData[i].counter1 <= 0)
               {
                  this.particleData[i].xPos += this.particleData[i].xVel;
                  this.particleData[i].yPos += this.particleData[i].yVel;
                  this.particleData[i].xVel *= this.particleData[i].xFriction;
                  this.particleData[i].yVel *= this.particleData[i].yFriction;
                  this.particleSprite[i].x = int(Math.floor(this.particleData[i].xPos));
                  this.particleSprite[i].y = int(Math.floor(this.particleData[i].yPos));
                  if(this.particleData[i].counter2-- <= 0)
                  {
                     if(this.particleData[i].counter3++ > 1)
                     {
                        this.particleData[i].counter3 = 0;
                        ++this.particleData[i].counter4;
                        this.particleSprite[i].visible = !this.particleSprite[i].visible;
                     }
                  }
                  if(this.particleData[i].counter4 >= 6)
                  {
                     this.particleSprite[i].visible = false;
                  }
               }
            }
         }
      }
      
      public function setIncreaseExp() : void
      {
         this.IS_INCREASING_EXP = true;
      }
      
      public function setLevelUpAnimation() : void
      {
         var i:int = 0;
         var sparkleSprite:SparkleHudSprite = null;
         var power:Number = NaN;
         this.barContainer.visible = false;
         this.level_up_text.visible = true;
         this.helper_image.visible = false;
         this.helper_image_next_level.visible = true;
         this.particleSprite = new Vector.<SparkleHudSprite>();
         this.particleData = new Vector.<EntityData>();
         var amount:int = 6;
         var rand_angle:Number = Math.random() * Math.PI * 2;
         var step:Number = Math.PI * 2 / 6;
         for(i = 0; i < amount; i++)
         {
            sparkleSprite = new SparkleHudSprite();
            if(Math.random() * 100 > 50)
            {
               sparkleSprite.gotoAndStop(2);
            }
            else
            {
               sparkleSprite.gotoAndStop(1);
            }
            sparkleSprite.updateScreenPosition();
            sparkleSprite.visible = false;
            this.particleSprite.push(sparkleSprite);
            addChild(sparkleSprite);
            rand_angle += step;
            power = 4 + Math.random() * 2;
            this.particleData.push(new EntityData(Math.sin(rand_angle) * power,Math.cos(rand_angle) * power,Math.sin(rand_angle) * power,Math.cos(rand_angle) * power,0.8,0.8,int(Math.random() * 5) + 1,int(Math.random() * 25 + 5),0,0));
         }
      }
      
      protected function initPanel() : void
      {
         var amount:int = 0;
         var image_name:String = null;
         var next_amount:int = 0;
         this.barContainer = new Sprite();
         addChild(this.barContainer);
         this.sx_image = new Image(TextureManager.hudTextureAtlas.getTexture("exp_panel_1"));
         this.sx_image.touchable = false;
         this.barContainer.addChild(this.sx_image);
         this.dx_image = new Image(TextureManager.hudTextureAtlas.getTexture("exp_panel_1"));
         this.dx_image.touchable = false;
         this.dx_image.scaleX = -1;
         this.dx_image.x = this.WIDTH;
         this.barContainer.addChild(this.dx_image);
         this.center_image = new Image(TextureManager.hudTextureAtlas.getTexture("exp_panel_2"));
         this.center_image.touchable = false;
         this.center_image.width = this.WIDTH - 12;
         this.center_image.x = 6;
         this.barContainer.addChild(this.center_image);
         this.exp_bar_image = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.exp_bar_image.touchable = false;
         this.exp_bar_image.width = 1;
         this.exp_bar_image.height = 2;
         this.exp_bar_image.x = this.exp_bar_image.y = 2;
         this.barContainer.addChild(this.exp_bar_image);
         var pixel_amount:Number = this.CURRENT_EXP * this.MAX_EXP_PIXEL_WIDTH / 100;
         if(pixel_amount <= 0)
         {
            pixel_amount = 1;
         }
         else if(pixel_amount >= this.MAX_EXP_PIXEL_WIDTH)
         {
            pixel_amount = this.MAX_EXP_PIXEL_WIDTH;
         }
         this.exp_bar_image.width = pixel_amount;
         if(this.WITH_IMAGE)
         {
            amount = int(Utils.Slot.playerInventory[this.INDEX]);
            if(amount < 1)
            {
               amount = 1;
            }
            image_name = "shopItem_" + this.INDEX + "_" + amount;
            this.helper_image = new Image(TextureManager.hudTextureAtlas.getTexture(image_name));
            this.helper_image.touchable = false;
            this.helper_image.pivotX = int(this.helper_image.width * 0.5);
            this.helper_image.pivotY = int(this.helper_image.height * 0.5);
            addChild(this.helper_image);
            if(amount <= 2)
            {
               next_amount = amount + 1;
               image_name = "shopItem_" + this.INDEX + "_" + next_amount;
               this.helper_image_next_level = new Image(TextureManager.hudTextureAtlas.getTexture(image_name));
               this.helper_image_next_level.touchable = false;
               this.helper_image_next_level.pivotX = int(this.helper_image_next_level.width * 0.5);
               this.helper_image_next_level.pivotY = int(this.helper_image_next_level.height * 0.5);
               addChild(this.helper_image_next_level);
               this.helper_image_next_level.visible = false;
            }
            this.barContainer.pivotX = int(this.WIDTH * 0.5);
            this.barContainer.y = 20;
            this.level_up_text = new GameText(StringsManager.GetString("level_up"),GameText.TYPE_SMALL_WHITE);
            this.level_up_text.pivotX = int(this.level_up_text.WIDTH * 0.5);
            this.level_up_text.pivotY = 0;
            addChild(this.level_up_text);
            this.level_up_text.y = 18;
            this.level_up_text.visible = false;
         }
         else
         {
            this.helper_image = null;
            this.helper_image_next_level = null;
            this.level_up_text = null;
         }
      }
      
      public function updateAmount() : void
      {
      }
      
      protected function pauseState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 0;
      }
      
      protected function levelCompleteState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 20;
      }
      
      protected function animationOverState() : void
      {
      }
   }
}
