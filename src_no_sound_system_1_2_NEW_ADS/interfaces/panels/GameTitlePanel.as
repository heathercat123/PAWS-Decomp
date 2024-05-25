package interfaces.panels
{
   import entities.Easings;
   import sprites.GameSprite;
   import sprites.hud.*;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.ColorMatrixFilter;
   
   public class GameTitlePanel extends Sprite
   {
       
      
      protected var titleImage:Image;
      
      protected var letters:Array;
      
      protected var delays:Array;
      
      public var IS_LIGHTED_UP:Boolean;
      
      protected var light_counter_1:int;
      
      protected var light_counter_2:int;
      
      protected var brightness:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      public function GameTitlePanel()
      {
         var gSprite:GameSprite = null;
         super();
         this.titleImage = new Image(TextureManager.hudTextureAtlas.getTexture("game_title_2"));
         this.IS_LIGHTED_UP = false;
         this.light_counter_1 = this.light_counter_2 = 0;
         this.brightness = this.t_start = this.t_diff = this.t_tick = this.t_time = 0;
         addChild(this.titleImage);
         this.titleImage.x = this.titleImage.y = 0;
         this.letters = new Array();
         this.delays = new Array();
         gSprite = new LetterFirstCHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 8;
         gSprite.y = 32;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterFirstAHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 46;
         gSprite.y = 40;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterFirstTHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 89;
         gSprite.y = 44;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterSecondTHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 138;
         gSprite.y = 44;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterSecondAHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 165;
         gSprite.y = 44;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterFirstLHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 204;
         gSprite.y = 44;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterFirstEHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 229;
         gSprite.y = 40;
         this.letters.push(gSprite);
         this.delays.push(-1);
         gSprite = new LetterFirstSHudSprite();
         gSprite.visible = false;
         addChild(gSprite);
         gSprite.x = 251;
         gSprite.y = 32;
         this.letters.push(gSprite);
         this.delays.push(-1);
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.filter = null;
         for(i = 0; i < this.letters.length; i++)
         {
            removeChild(this.letters[i]);
            this.letters[i].destroy();
            this.letters[i].dispose();
            this.letters[i] = null;
         }
         this.letters = null;
         this.delays = null;
         removeChild(this.titleImage);
         this.titleImage.dispose();
         this.titleImage = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var end_flag:Boolean = false;
         for(i = 0; i < this.letters.length; i++)
         {
            if(this.delays[i] > 0)
            {
               --this.delays[i];
               if(this.delays[i] == 0)
               {
                  this.letters[i].gfxHandleClip().gotoAndPlay(1);
                  this.letters[i].visible = true;
               }
            }
            if(this.letters[i].gfxHandleClip().isComplete)
            {
               this.letters[i].visible = false;
            }
            this.letters[i].updateScreenPosition();
         }
         if(this.IS_LIGHTED_UP)
         {
            end_flag = false;
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.IS_LIGHTED_UP = false;
               end_flag = true;
            }
            this.brightness = Easings.easeInCubic(this.t_tick,this.t_start,this.t_diff,this.t_time);
            if(end_flag)
            {
               if(this.filter != null)
               {
                  this.filter.dispose();
                  this.filter = null;
               }
            }
            else
            {
               ColorMatrixFilter(this.filter).reset();
               ColorMatrixFilter(this.filter).adjustBrightness(this.brightness);
            }
         }
      }
      
      public function lightUp() : void
      {
         if(this.IS_LIGHTED_UP)
         {
            return;
         }
         this.IS_LIGHTED_UP = true;
         this.light_counter_1 = this.light_counter_2 = 0;
         this.brightness = 1;
         this.t_time = 0.25;
         this.t_start = 1;
         this.t_diff = -1;
         this.t_tick = 0;
         this.filter = new ColorMatrixFilter();
         ColorMatrixFilter(this.filter).adjustBrightness(this.brightness);
      }
      
      public function blink(reverse:Boolean = false) : void
      {
         var i:int = 0;
         for(i = 0; i < this.delays.length; i++)
         {
            if(reverse)
            {
               this.delays[i] = 1 + (this.delays.length - i) * 3;
            }
            else
            {
               this.delays[i] = 1 + i * 3;
            }
         }
      }
   }
}
