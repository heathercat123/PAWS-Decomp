package interfaces.unlocks
{
   import entities.*;
   import interfaces.texts.GameText;
   import levels.Level;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class CatUnlockScene
   {
       
      
      public var level:Level;
      
      protected var container:Sprite;
      
      protected var whiteQuad:Image;
      
      protected var dxCornerImage:Vector.<Image>;
      
      protected var dxCornerContainer:Sprite;
      
      protected var catImage:Image;
      
      protected var nameContainer:Sprite;
      
      protected var nameImage:Image;
      
      protected var nameText:GameText;
      
      protected var PROGRESSION:int;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var dx_band_t_start:Number;
      
      protected var dx_band_t_diff:Number;
      
      protected var band_t_tick:Number;
      
      protected var band_t_time:Number;
      
      protected var band_2_t_start:Number;
      
      protected var band_2_t_diff:Number;
      
      protected var band_3_t_start:Number;
      
      protected var band_3_t_diff:Number;
      
      protected var cat_start_x:Number;
      
      protected var cat_diff_x:Number;
      
      protected var cat_tick:Number;
      
      protected var cat_time:Number;
      
      protected var title_start:Number;
      
      protected var title_diff:Number;
      
      protected var title_tick:Number;
      
      protected var title_time:Number;
      
      protected var dx_band_xPos:Number;
      
      protected var dx_band_yPos:Number;
      
      protected var band_offset:Number;
      
      protected var CAT_DONE:Boolean;
      
      public var DEAD:Boolean;
      
      protected var ID:int;
      
      protected var IS_BOSS:Boolean;
      
      public function CatUnlockScene(_level:Level, _ID:int, _isBoss:Boolean = false)
      {
         super();
         this.level = _level;
         this.PROGRESSION = 0;
         this.IS_BOSS = _isBoss;
         this.ID = _ID;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.dx_band_t_start = this.dx_band_t_diff = 0;
         this.band_offset = 0;
         this.band_t_tick = this.band_t_time = this.dx_band_xPos = this.dx_band_yPos = 0;
         this.band_2_t_start = this.band_2_t_diff = 0;
         this.band_3_t_start = this.band_3_t_diff = 0;
         this.cat_start_x = this.cat_diff_x = this.cat_tick = this.cat_time = 0;
         this.title_start = this.title_diff = this.title_tick = this.title_time = 0;
         this.CAT_DONE = false;
         this.DEAD = false;
         this.init();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.level = null;
         this.nameContainer.removeChild(this.nameImage);
         this.nameContainer.removeChild(this.nameText);
         this.container.removeChild(this.nameContainer);
         this.nameContainer.dispose();
         this.nameContainer = null;
         this.nameImage.dispose();
         this.nameImage = null;
         this.nameText.destroy();
         this.nameText.dispose();
         this.nameText = null;
         this.container.removeChild(this.whiteQuad);
         this.container.removeChild(this.dxCornerContainer);
         for(i = 0; i < this.dxCornerImage.length; i++)
         {
            this.dxCornerContainer.removeChild(this.dxCornerImage[i]);
            this.dxCornerImage[i].dispose();
            this.dxCornerImage[i] = null;
         }
         this.dxCornerImage = null;
         this.dxCornerContainer.dispose();
         this.dxCornerContainer = null;
         this.container.removeChild(this.catImage);
         this.whiteQuad.dispose();
         this.catImage.dispose();
         this.whiteQuad = null;
         this.catImage = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
      }
      
      protected function init() : void
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         var image2:Image = null;
         this.container = new Sprite();
         this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
         Utils.rootMovie.addChild(this.container);
         this.whiteQuad = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.whiteQuad.width = Utils.WIDTH;
         this.whiteQuad.height = Utils.HEIGHT;
         this.container.addChild(this.whiteQuad);
         this.whiteQuad.alpha = 0;
         this.dxCornerContainer = new Sprite();
         this.container.addChild(this.dxCornerContainer);
         this.dxCornerImage = new Vector.<Image>();
         if(!this.IS_BOSS)
         {
            for(i = 0; i < 5; i++)
            {
               image = new Image(TextureManager.introTextureAtlas.getTexture("cat_unlock_band_dx"));
               image.x = image.y = i * 64;
               this.dxCornerImage.push(image);
               this.dxCornerContainer.addChild(image);
               this.dxCornerContainer.x = this.dx_band_xPos = Utils.WIDTH;
               image = new Image(TextureManager.hudTextureAtlas.getTexture("redQuad"));
               image.x = i * 64 + 64;
               image.y = i * 64;
               this.dxCornerImage.push(image);
               this.dxCornerContainer.addChild(image);
               image.width = 5 * 64 - image.x;
               image.height = 64;
            }
         }
         else
         {
            for(i = 0; i < 5; i++)
            {
               image = new Image(TextureManager.introTextureAtlas.getTexture("cat_unlock_band_sx"));
               image.x = (5 - i) * 64;
               image.y = i * 64;
               this.dxCornerImage.push(image);
               this.dxCornerContainer.addChild(image);
               this.dxCornerContainer.x = this.dx_band_xPos = -64 * 5;
               image2 = new Image(TextureManager.introTextureAtlas.getTexture("purple_grey_quad"));
               image2.x = 0;
               image2.y = i * 64;
               this.dxCornerImage.push(image2);
               this.dxCornerContainer.addChild(image2);
               image2.width = (5 - i + 1) * 64 - 64;
               image2.height = 64;
            }
         }
         if(this.IS_BOSS)
         {
            this.catImage = new Image(TextureManager.introTextureAtlas.getTexture("intro_boss_" + this.ID));
         }
         else
         {
            this.catImage = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_" + this.ID));
         }
         this.container.addChild(this.catImage);
         this.catImage.pivotX = this.getPivotX();
         this.catImage.pivotY = this.getPivotY();
         if(this.IS_BOSS)
         {
            this.catImage.x = int(-this.catImage.width);
         }
         else
         {
            this.catImage.x = int(Utils.WIDTH + this.catImage.width);
         }
         this.catImage.y = int(Utils.HEIGHT * 0.5);
         this.container.addChild(this.catImage);
         this.nameContainer = new Sprite();
         this.container.addChild(this.nameContainer);
         if(this.IS_BOSS)
         {
            this.nameImage = new Image(TextureManager.introTextureAtlas.getTexture("intro_boss_name_" + this.ID));
         }
         else
         {
            this.nameImage = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_name_" + this.ID));
         }
         if(this.IS_BOSS)
         {
            this.nameImage.x = 0;
         }
         else
         {
            this.nameImage.x = -int(this.nameImage.width);
         }
         this.nameContainer.addChild(this.nameImage);
         if(this.IS_BOSS)
         {
            if(Utils.X_SCREEN_MARGIN > 0)
            {
               this.nameContainer.x = Utils.X_SCREEN_MARGIN;
            }
            else
            {
               this.nameContainer.x = 8;
            }
         }
         else if(Utils.X_SCREEN_MARGIN > 0)
         {
            this.nameContainer.x = Utils.WIDTH - Utils.X_SCREEN_MARGIN;
         }
         else
         {
            this.nameContainer.x = Utils.WIDTH - 8;
         }
         this.nameContainer.y = -(this.nameContainer.height + 1);
         if(this.IS_BOSS)
         {
            this.nameText = new GameText(StringsManager.GetString("boss_desc_" + this.ID),GameText.TYPE_BIG_BLUE);
         }
         else
         {
            this.nameText = new GameText(StringsManager.GetString("cat_joins"),GameText.TYPE_BIG);
         }
         this.nameContainer.addChild(this.nameText);
         if(this.IS_BOSS)
         {
            this.nameText.x = 0;
         }
         else
         {
            this.nameText.x = -int(this.nameText.WIDTH);
         }
         this.nameText.y = this.nameImage.height + 2;
         this.nameText.alpha = 0;
      }
      
      protected function getPivotX() : Number
      {
         if(this.ID == 0)
         {
            return int(this.catImage.width * 0.6);
         }
         if(this.ID == 2)
         {
            return int(this.catImage.width * 0.6);
         }
         if(this.ID == 3)
         {
            return int(this.catImage.width * 0.5);
         }
         return int(this.catImage.width * 0.5);
      }
      
      protected function getPivotY() : Number
      {
         if(this.ID == 0)
         {
            return int(this.catImage.height * 0.4);
         }
         if(this.ID == 2)
         {
            return int(this.catImage.height * 0.4);
         }
         if(this.ID == 3)
         {
            return int(this.catImage.height * 0.4);
         }
         return int(this.catImage.height * 0.5);
      }
      
      public function update() : void
      {
         if(this.PROGRESSION == 0)
         {
            if(this.counter1++ > 2)
            {
               this.counter1 = 0;
               this.whiteQuad.alpha += 0.2;
               if(this.whiteQuad.alpha >= 0.6)
               {
                  SoundSystem.PlayMusic("butterflies_complete");
                  this.whiteQuad.alpha = 0.6;
                  ++this.PROGRESSION;
                  if(this.IS_BOSS)
                  {
                     this.dx_band_t_start = this.dx_band_xPos = -5 * 64;
                     this.dx_band_t_diff = int(Utils.WIDTH * 0.6);
                  }
                  else
                  {
                     this.dx_band_t_start = this.dx_band_xPos = Utils.WIDTH;
                     this.dx_band_t_diff = -int(Utils.WIDTH * 0.6);
                  }
                  this.band_t_tick = 0;
                  this.band_t_time = 0.5;
                  this.dx_band_yPos = 0;
                  this.cat_start_x = this.catImage.x;
                  if(this.IS_BOSS)
                  {
                     this.cat_diff_x = int(Utils.WIDTH * 0.675 - this.catImage.x);
                  }
                  else
                  {
                     this.cat_diff_x = int(Utils.WIDTH * 0.325 - this.catImage.x);
                  }
                  this.cat_tick = 0;
                  this.cat_time = 0.5;
                  this.title_start = this.nameContainer.y;
                  this.title_diff = 8 - this.title_start;
                  this.title_tick = 0;
                  this.title_time = 0.5;
               }
            }
         }
         else if(this.PROGRESSION == 1)
         {
            this.band_t_tick += 1 / 60;
            if(this.band_t_tick >= this.band_t_time)
            {
               this.band_t_tick = this.band_t_time;
            }
            this.dx_band_xPos = int(Easings.easeOutSine(this.band_t_tick,this.dx_band_t_start,this.dx_band_t_diff,this.band_t_time));
            this.dx_band_yPos = 0;
            this.title_tick += 1 / 60;
            if(this.title_tick >= this.title_time)
            {
               this.title_tick = this.title_time;
               this.counter2 = this.counter3 = 0;
               ++this.PROGRESSION;
            }
            this.cat_tick += 1 / 60;
            if(this.cat_tick >= this.cat_time)
            {
               this.cat_tick = this.cat_time;
               this.CAT_DONE = true;
            }
            this.catImage.x = int(Easings.easeOutCubic(this.cat_tick,this.cat_start_x,this.cat_diff_x,this.cat_time));
            this.nameContainer.y = int(Easings.easeOutSine(this.title_tick,this.title_start,this.title_diff,this.title_time));
         }
         else if(this.PROGRESSION == 2)
         {
            if(this.counter3++ > 15)
            {
               ++this.counter2;
               if(this.counter2 > 3)
               {
                  this.counter2 = 0;
                  this.nameText.alpha += 0.3;
                  if(this.nameText.alpha >= 1)
                  {
                     if(this.IS_BOSS)
                     {
                        if(this.ID == 0)
                        {
                           SoundSystem.PlaySound("mesa_laugh");
                        }
                        else if(this.ID == 1)
                        {
                           SoundSystem.PlaySound("giant_fish_roar");
                        }
                     }
                     else if(this.ID == 6)
                     {
                        SoundSystem.PlaySound("cat_rose");
                     }
                     else if(this.ID == 2)
                     {
                        SoundSystem.PlaySound("cat_rigs");
                     }
                     else if(this.ID == 1)
                     {
                        SoundSystem.PlaySound("cat_red");
                     }
                     else if(this.ID == 3)
                     {
                        SoundSystem.PlaySound("cat_mara");
                     }
                     else
                     {
                        SoundSystem.PlaySound("cat_soldier");
                     }
                     this.nameText.alpha = 1;
                     this.counter2 = this.counter3 = 0;
                     ++this.PROGRESSION;
                  }
               }
            }
         }
         else if(this.PROGRESSION == 3)
         {
            if(this.counter3++ > 150)
            {
               SoundSystem.PlaySound("hud_woosh");
               this.counter1 = this.counter2 = this.counter3 = 0;
               this.CAT_DONE = false;
               ++this.PROGRESSION;
               this.cat_tick = 0;
               this.cat_time = 0.5;
               if(this.IS_BOSS)
               {
                  this.cat_start_x = this.catImage.x;
                  this.cat_diff_x = Utils.WIDTH + this.catImage.width - this.cat_start_x;
               }
               else
               {
                  this.cat_start_x = this.catImage.x;
                  this.cat_diff_x = -(this.catImage.width * 1) - this.cat_start_x;
               }
               this.title_start = this.nameContainer.y;
               this.title_diff = -(this.nameContainer.height + 32) - this.title_start;
               this.title_tick = 0;
               this.title_time = 0.5;
               this.dx_band_t_start = this.dx_band_xPos;
               if(this.IS_BOSS)
               {
                  this.dx_band_t_diff = int(-64 * 5 - this.dx_band_t_start);
               }
               else
               {
                  this.dx_band_t_diff = int(Utils.WIDTH + 1 - this.dx_band_t_start);
               }
               this.band_t_tick = 0;
               this.band_t_time = 0.5;
               this.dx_band_yPos = 0;
            }
         }
         else if(this.PROGRESSION == 4)
         {
            this.cat_tick += 1 / 60;
            if(this.cat_tick >= this.cat_time)
            {
               this.cat_tick = this.cat_time;
            }
            this.title_tick += 1 / 60;
            if(this.title_tick >= this.title_time)
            {
               this.title_tick = this.title_time;
            }
            this.band_t_tick += 1 / 60;
            if(this.band_t_tick >= this.band_t_time)
            {
               this.band_t_tick = this.band_t_time;
               this.counter1 = 0;
               ++this.PROGRESSION;
            }
            this.catImage.x = int(Easings.easeOutSine(this.cat_tick,this.cat_start_x,this.cat_diff_x,this.cat_time));
            this.nameContainer.y = int(Easings.easeOutSine(this.title_tick,this.title_start,this.title_diff,this.title_time));
            this.dx_band_xPos = int(Easings.easeOutSine(this.band_t_tick,this.dx_band_t_start,this.dx_band_t_diff,this.band_t_time));
            if(this.counter1++ > 2)
            {
               this.counter1 = 0;
               this.whiteQuad.alpha -= 0.2;
               if(this.whiteQuad.alpha <= 0)
               {
                  this.whiteQuad.alpha = 0;
               }
            }
         }
         else if(this.PROGRESSION == 5)
         {
            ++this.PROGRESSION;
         }
         else if(this.PROGRESSION == 6)
         {
            this.DEAD = true;
            ++this.PROGRESSION;
         }
         if(this.CAT_DONE)
         {
            if(this.counter1++ > 10)
            {
               this.counter1 = 0;
               if(this.IS_BOSS)
               {
                  ++this.catImage.x;
               }
               else
               {
                  --this.catImage.x;
               }
            }
         }
         this.band_offset += 0.5;
         if(this.band_offset >= 16)
         {
            this.band_offset -= 16;
         }
         if(this.IS_BOSS)
         {
            this.dxCornerContainer.x = int(this.dx_band_xPos - 32 - this.band_offset);
            this.dxCornerContainer.y = int(this.dx_band_yPos - 32 + this.band_offset);
         }
         else
         {
            this.dxCornerContainer.x = int(this.dx_band_xPos - 32 + this.band_offset);
            this.dxCornerContainer.y = int(this.dx_band_yPos - 32 + this.band_offset);
         }
      }
   }
}
