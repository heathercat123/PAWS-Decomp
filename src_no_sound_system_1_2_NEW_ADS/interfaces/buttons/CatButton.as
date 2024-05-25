package interfaces.buttons
{
   import flash.geom.Matrix;
   import game_utils.LevelItems;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class CatButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var top_y:int;
      
      protected var bottom_y:int;
      
      protected var catIcon:Image;
      
      protected var skillIcon:Image;
      
      protected var catName:Image;
      
      protected var index:int;
      
      protected var isCatUnlocked:Boolean;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var isSkillDisplayed:Boolean;
      
      protected var REDRAW_FLAG:Boolean;
      
      public function CatButton(_index:int, _WIDTH:Number, _HEIGHT:Number)
      {
         var text_a:RenderTexture = null;
         var text_b:RenderTexture = null;
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.index = _index;
         this.top_y = int((this.HEIGHT - 6) * 0.33333);
         this.bottom_y = int((this.HEIGHT - 6) * 0.75);
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.isSkillDisplayed = true;
         this.REDRAW_FLAG = false;
         this.upTexture = null;
         this.downTexture = null;
         this.createUpTexture();
         this.createDownTexture();
         this.isCatUnlocked = this.isCatAvailable();
         if(this.isCatUnlocked)
         {
            text_a = this.upTexture;
            text_b = this.downTexture;
         }
         else
         {
            text_a = this.downTexture;
            text_b = this.downTexture;
         }
         super(text_a,"",text_b);
         if(this.isCatUnlocked)
         {
            this.initUnlockedCat();
         }
         else
         {
            this.initLockedCat();
         }
         this.upTexture.root.onRestore = this.restoreUp;
         this.downTexture.root.onRestore = this.restoreDown;
      }
      
      protected function restoreUp() : void
      {
         this.REDRAW_FLAG = true;
      }
      
      protected function restoreDown() : void
      {
         this.REDRAW_FLAG = true;
      }
      
      public function destroy() : void
      {
         this.downTexture.dispose();
         this.downTexture = null;
         this.upTexture.dispose();
         this.upTexture = null;
         this.catIcon.dispose();
         this.catIcon = null;
         this.skillIcon.dispose();
         this.skillIcon = null;
         if(this.catName != null)
         {
            this.catName.dispose();
            this.catName = null;
         }
      }
      
      public function update() : void
      {
         var timeLimit:int = 0;
         if(this.REDRAW_FLAG)
         {
            this.REDRAW_FLAG = false;
            this.createUpTexture();
            this.createDownTexture();
         }
         if(!this.isCatUnlocked)
         {
            this.catIcon.y = this.top_y + 8;
            this.skillIcon.y = this.bottom_y + 8;
            this.touchable = false;
         }
         else
         {
            ++this.counter1;
            timeLimit = 120;
            if(!this.isSkillDisplayed)
            {
               timeLimit = 120;
            }
            if(this.counter1 > timeLimit)
            {
               ++this.counter2;
               if(this.counter2 > 3)
               {
                  this.counter2 = 0;
                  if(this.isSkillDisplayed)
                  {
                     this.skillIcon.alpha -= 0.3;
                     this.catName.alpha += 0.3;
                     if(this.skillIcon.alpha <= 0)
                     {
                        this.skillIcon.alpha = 0;
                        this.catName.alpha = 1;
                        this.isSkillDisplayed = !this.isSkillDisplayed;
                        this.counter1 = 0;
                     }
                  }
                  else
                  {
                     this.skillIcon.alpha += 0.3;
                     this.catName.alpha -= 0.3;
                     if(this.skillIcon.alpha >= 1)
                     {
                        this.skillIcon.alpha = 1;
                        this.catName.alpha = 0;
                        this.isSkillDisplayed = !this.isSkillDisplayed;
                        this.counter1 = 0;
                     }
                  }
               }
            }
            if(state == "down")
            {
               this.catIcon.y = this.top_y + 8;
               this.skillIcon.y = this.bottom_y + 8;
               if(this.catName != null)
               {
                  this.catName.y = this.bottom_y + 8;
               }
            }
            else
            {
               this.catIcon.y = this.top_y;
               this.skillIcon.y = this.bottom_y;
               if(this.catName != null)
               {
                  this.catName.y = this.bottom_y;
               }
            }
         }
      }
      
      public function resetData() : void
      {
         if(this.isCatUnlocked)
         {
            this.counter1 = this.counter2 = this.counter3 = 0;
            this.catName.alpha = 0;
            this.skillIcon.alpha = 1;
            this.isSkillDisplayed = true;
         }
      }
      
      protected function createUpTexture() : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         if(this.upTexture == null)
         {
            this.upTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.upTexture.clear();
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart1"));
         this.upTexture.draw(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 24) / 8);
         matrix.translate(this.WIDTH - 8,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 16);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 16);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 16);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 24) / 8);
         matrix.translate(0,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 24) / 8);
         matrix.translate(8,8);
         this.upTexture.draw(image,matrix);
      }
      
      protected function createDownTexture() : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         if(this.downTexture == null)
         {
            this.downTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.downTexture.clear();
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart1"));
         matrix = new Matrix();
         matrix.translate(0,6);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,6);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,6);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 22) / 8);
         matrix.translate(this.WIDTH - 8,6 + 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 22) / 8);
         matrix.translate(0,6 + 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 22) / 8);
         matrix.translate(8,6 + 8);
         this.downTexture.draw(image,matrix);
      }
      
      protected function isCatAvailable() : Boolean
      {
         if(this.index == 0)
         {
            return true;
         }
         if(this.index == 1)
         {
            return LevelItems.HasItem(LevelItems.ITEM_BIG_CAT);
         }
         if(this.index == 2)
         {
            return LevelItems.HasItem(LevelItems.ITEM_EVIL_CAT);
         }
         if(this.index == 3)
         {
            return LevelItems.HasItem(LevelItems.ITEM_WATER_CAT);
         }
         if(this.index == 4)
         {
            return LevelItems.HasItem(LevelItems.ITEM_SMALL_CAT);
         }
         if(this.index == 5)
         {
            return LevelItems.HasItem(LevelItems.ITEM_GLIDE_CAT);
         }
         return false;
      }
      
      protected function initLockedCat() : void
      {
         var skill_icon_name:String = null;
         var cat_icon_name:String = this.getLockedCatName();
         skill_icon_name = this.getLockedSkillName();
         this.catIcon = new Image(TextureManager.hudTextureAtlas.getTexture(cat_icon_name));
         this.catIcon.pivotX = int(this.catIcon.width * 0.5);
         this.catIcon.pivotY = int(this.catIcon.height * 0.5);
         this.catIcon.x = int(this.WIDTH * 0.5);
         this.catIcon.y = this.top_y;
         addChild(this.catIcon);
         this.skillIcon = new Image(TextureManager.hudTextureAtlas.getTexture(skill_icon_name));
         this.skillIcon.pivotX = this.skillIcon.pivotY = 9;
         this.skillIcon.x = this.catIcon.x;
         this.skillIcon.y = this.bottom_y;
         addChild(this.skillIcon);
         this.catName = null;
      }
      
      protected function initUnlockedCat() : void
      {
         var cat_icon_name:String = this.getUnlockedCatName();
         var skill_icon_name:String = this.getUnlockedSkillName();
         this.catIcon = new Image(TextureManager.hudTextureAtlas.getTexture(cat_icon_name));
         this.catIcon.pivotX = int(this.catIcon.width * 0.5);
         this.catIcon.pivotY = int(this.catIcon.height * 0.5);
         this.catIcon.x = int(this.WIDTH * 0.5);
         this.catIcon.y = this.top_y;
         addChild(this.catIcon);
         this.skillIcon = new Image(TextureManager.hudTextureAtlas.getTexture(skill_icon_name));
         this.skillIcon.pivotX = this.skillIcon.pivotY = 9;
         this.skillIcon.x = this.catIcon.x;
         this.skillIcon.y = this.bottom_y;
         addChild(this.skillIcon);
         this.catName = new Image(TextureManager.hudTextureAtlas.getTexture("catName_" + this.index));
         this.catName.pivotX = int(this.catName.width * 0.5);
         this.catName.pivotY = int(this.catName.height * 0.5);
         this.catName.x = this.skillIcon.x;
         this.catName.y = this.bottom_y;
         this.catName.alpha = 0;
         addChild(this.catName);
      }
      
      protected function getLockedCatName() : String
      {
         if(this.index == 1)
         {
            return "bigCatItemHudSpriteHiddenAnim_a";
         }
         if(this.index == 2)
         {
            return "evilCatItemHudSpriteHiddenAnim_a";
         }
         if(this.index == 3)
         {
            return "waterCatItemHudSpriteHiddenAnim_a";
         }
         if(this.index == 4)
         {
            return "smallCatItemHudSpriteHiddenAnim_a";
         }
         if(this.index == 5)
         {
            return "glideCatItemHudSpriteHiddenAnim_a";
         }
         return "unkownCat";
      }
      
      protected function getLockedSkillName() : String
      {
         return "catIconSkill_0";
      }
      
      protected function getUnlockedCatName() : String
      {
         if(this.index == 0)
         {
            return "greyCatItemHudSpriteVisibleAnim_a";
         }
         if(this.index == 1)
         {
            return "bigCatItemHudSpriteVisibleAnim_a";
         }
         if(this.index == 2)
         {
            return "evilCatItemHudSpriteVisibleAnim_a";
         }
         if(this.index == 3)
         {
            return "waterCatItemHudSpriteVisibleAnim_a";
         }
         if(this.index == 4)
         {
            return "smallCatItemHudSpriteVisibleAnim_a";
         }
         if(this.index == 5)
         {
            return "glideCatItemHudSpriteVisibleAnim_a";
         }
         return "greyCatItemHudSpriteVisibleAnim_a";
      }
      
      protected function getUnlockedSkillName() : String
      {
         return "catIconSkill_" + (this.index + 1);
      }
   }
}
