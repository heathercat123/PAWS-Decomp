package interfaces.panels
{
   import entities.Easings;
   import entities.fishing.BaseFish;
   import entities.fishing.FishManager;
   import game_utils.LevelItems;
   import interfaces.texts.GameText;
   import starling.animation.*;
   import starling.display.*;
   import starling.textures.*;
   
   public class FishInfoPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      protected var big_text:GameText;
      
      protected var fish_background:Image;
      
      protected var fish_image:Image;
      
      protected var textContainer:Sprite;
      
      protected var text_name:GameText;
      
      protected var text_size:GameText;
      
      protected var text_type:GameText;
      
      protected var text_points:GameText;
      
      protected var star_1:Image;
      
      protected var star_2:Image;
      
      protected var star_3:Image;
      
      protected var star_4:Image;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var points:int;
      
      protected var IS_APPEARING:Boolean;
      
      protected var IS_DISAPPEARING:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var IS_NEW_RECORD:Boolean;
      
      protected var new_record_blink_1:int;
      
      protected var new_record_blink_2:int;
      
      protected var points_counter_1:int;
      
      protected var points_counter_2:int;
      
      protected var is_type_visible:Boolean;
      
      public function FishInfoPanel(_fish:BaseFish)
      {
         var type_string:String = null;
         super();
         this.points = 0;
         this.IS_APPEARING = this.IS_DISAPPEARING = false;
         this.t_start = this.t_diff = this.t_tick = this.t_time = 0;
         this.counter_1 = this.counter_2 = this.new_record_blink_1 = this.new_record_blink_2 = 0;
         this.points_counter_1 = 60;
         this.points_counter_2 = 0;
         this.is_type_visible = true;
         var _fish_id:int = LevelItems.GetFishItemId(_fish.TYPE);
         if(_fish.SIZE > Utils.Slot.fishRecords[_fish_id])
         {
            this.IS_NEW_RECORD = true;
         }
         else
         {
            this.IS_NEW_RECORD = false;
         }
         var points_mult:Number = this.getPointsMultiplier(_fish.TYPE,_fish.SIZE);
         var rank:Number = _fish.RANK;
         var _points:Number = Math.pow(rank + 2,points_mult * points_mult);
         if(_fish.IS_RARE)
         {
            _points += Math.pow(32,points_mult);
         }
         else if(_fish.IS_GOLDEN)
         {
            _points += Math.pow(128,points_mult);
         }
         this.points = Math.round(_points);
         var stars_amount:int = this.getStarsAmount(_fish.TYPE,_fish.SIZE);
         if(this.IS_NEW_RECORD)
         {
            this.big_text = new GameText(StringsManager.GetString("fishing_record"),GameText.TYPE_BIG);
         }
         else if(stars_amount == 0 || stars_amount == 1)
         {
            this.big_text = new GameText(StringsManager.GetString("fishing_result_1"),GameText.TYPE_BIG);
         }
         else if(stars_amount == 2 || stars_amount == 3)
         {
            this.big_text = new GameText(StringsManager.GetString("fishing_result_2"),GameText.TYPE_BIG);
         }
         else
         {
            this.big_text = new GameText(StringsManager.GetString("fishing_result_3"),GameText.TYPE_BIG);
         }
         this.WIDTH = int(this.big_text.WIDTH + 12);
         this.HEIGHT = 78;
         var temp:GameText = new GameText(StringsManager.GetString("fish_size") + " " + _fish.SIZE,GameText.TYPE_SMALL_WHITE);
         if(temp.WIDTH + 56 + 48 > this.WIDTH)
         {
            this.WIDTH = int(temp.WIDTH + 56 + 48 + 12);
         }
         if(this.WIDTH < int(Utils.WIDTH * 0.48))
         {
            this.WIDTH = int(Utils.WIDTH * 0.48);
         }
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         addChild(this.big_text);
         this.big_text.x = int((this.WIDTH - this.big_text.WIDTH) * 0.5);
         this.big_text.y = 6;
         this.bluePanel.drawLine(6,this.big_text.y + this.big_text.HEIGHT + 4,this.WIDTH - 12);
         this.fish_background = new Image(TextureManager.fishingTextureAtlas.getTexture("fish_panel_1"));
         this.fish_background.touchable = false;
         addChild(this.fish_background);
         this.fish_background.x = 6;
         this.fish_background.y = this.big_text.y + this.big_text.HEIGHT + 12;
         this.textContainer = new Sprite();
         if(_fish.IS_GOLDEN)
         {
            type_string = StringsManager.GetString("fish_type_golden");
         }
         else if(_fish.IS_RARE)
         {
            type_string = StringsManager.GetString("fish_type_rare");
         }
         else
         {
            type_string = StringsManager.GetString("fish_type_common");
         }
         this.text_name = new GameText(this.getFishName(_fish.TYPE),GameText.TYPE_SMALL_WHITE);
         this.text_size = new GameText(StringsManager.GetString("fish_size") + " " + _fish.SIZE,GameText.TYPE_SMALL_WHITE);
         this.text_type = new GameText(StringsManager.GetString("fish_type") + " " + type_string,GameText.TYPE_SMALL_WHITE);
         this.text_points = new GameText(StringsManager.GetString("fish_points") + " +" + this.points,GameText.TYPE_SMALL_WHITE);
         addChild(this.textContainer);
         this.textContainer.addChild(this.text_name);
         this.textContainer.addChild(this.text_size);
         this.textContainer.addChild(this.text_type);
         this.textContainer.addChild(this.text_points);
         this.text_points.alpha = 0;
         this.text_size.y = this.text_name.y + this.text_name.HEIGHT + 4;
         this.text_type.y = this.text_size.y + this.text_size.HEIGHT + 4;
         this.text_points.y = this.text_type.y;
         this.star_1 = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol" + (stars_amount < 1 ? "_empty" : "")));
         this.star_2 = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol" + (stars_amount < 2 ? "_empty" : "")));
         this.star_3 = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol" + (stars_amount < 3 ? "_empty" : "")));
         this.star_4 = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol" + (stars_amount < 4 ? "_empty" : "")));
         this.star_1.touchable = this.star_2.touchable = this.star_3.touchable = this.star_4.touchable = false;
         this.star_1.x = this.text_size.x + this.text_size.WIDTH + 6;
         this.star_2.x = this.star_1.x + 12;
         this.star_3.x = this.star_2.x + 12;
         this.star_4.x = this.star_3.x + 12;
         this.star_1.y = this.star_2.y = this.star_3.y = this.star_4.y = this.text_size.y;
         this.textContainer.addChild(this.star_1);
         this.textContainer.addChild(this.star_2);
         this.textContainer.addChild(this.star_3);
         this.textContainer.addChild(this.star_4);
         this.textContainer.x = this.fish_background.x + this.fish_background.width + 4;
         var text_container_height:int = 32;
         this.textContainer.y = this.fish_background.y + 3;
         var end_string:String = "";
         if(_fish.IS_GOLDEN)
         {
            end_string = "_golden";
         }
         else if(_fish.IS_RARE)
         {
            end_string = "_rare";
         }
         this.fish_image = new Image(TextureManager.fishingTextureAtlas.getTexture("fish_hud_" + LevelItems.GetFishItemId(_fish.TYPE) + "" + end_string));
         this.fish_image.touchable = false;
         this.fish_image.pivotX = int(this.fish_image.width * 0.5);
         this.fish_image.pivotY = int(this.fish_image.height * 0.5);
         addChild(this.fish_image);
         this.fish_image.x = int(this.fish_background.x + this.fish_background.width * 0.5);
         this.fish_image.y = int(this.fish_background.y + this.fish_background.height * 0.5);
      }
      
      protected function getPointsMultiplier(type:int, size:Number) : Number
      {
         var min:Number = FishManager.GetFishData()[type].MIN_SIZE;
         var max:Number = FishManager.GetFishData()[type].MAX_SIZE;
         max -= min;
         size -= min;
         min = 0;
         var perc:Number = size / max;
         return perc + 1;
      }
      
      protected function getStarsAmount(type:int, size:Number) : int
      {
         var min:Number = FishManager.GetFishData()[type].MIN_SIZE;
         var max:Number = FishManager.GetFishData()[type].MAX_SIZE;
         max -= min;
         size -= min;
         min = 0;
         var perc:Number = size / max;
         if(perc <= 0.1)
         {
            return 0;
         }
         if(perc <= 0.3)
         {
            return 1;
         }
         if(perc <= 0.7)
         {
            return 2;
         }
         if(perc <= 0.9)
         {
            return 3;
         }
         return 4;
      }
      
      public function update() : void
      {
         var _conditions:int = 0;
         if(this.IS_APPEARING)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               _conditions++;
            }
            y = int(Easings.easeOutCubic(this.t_tick,this.t_start,this.t_diff,this.t_time));
            ++this.counter_1;
            if(this.counter_1 > 3)
            {
               this.counter_1 = 0;
               this.alpha += 0.25;
               if(alpha >= 1)
               {
                  _conditions++;
                  alpha = 1;
               }
            }
            if(_conditions >= 2)
            {
               this.IS_APPEARING = false;
            }
         }
         else if(this.IS_DISAPPEARING)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               _conditions++;
            }
            y = int(Easings.easeInCubic(this.t_tick,this.t_start,this.t_diff,this.t_time));
            ++this.counter_1;
            if(this.counter_1 > 3)
            {
               this.counter_1 = 0;
               this.alpha -= 0.25;
               if(alpha <= 0)
               {
                  _conditions++;
                  alpha = 0;
                  visible = false;
               }
            }
            if(_conditions >= 2)
            {
               this.IS_DISAPPEARING = false;
            }
         }
         else
         {
            ++this.points_counter_1;
            if(this.points_counter_1 >= 180)
            {
               if(this.points_counter_2++ > 3)
               {
                  this.points_counter_2 = 0;
                  if(this.is_type_visible)
                  {
                     this.text_type.alpha -= 0.2;
                     this.text_points.alpha += 0.2;
                     if(this.text_type.alpha <= 0)
                     {
                        this.text_type.alpha = 0;
                        this.text_points.alpha = 1;
                        this.is_type_visible = false;
                        this.points_counter_1 = 0;
                     }
                  }
                  else
                  {
                     this.text_type.alpha += 0.2;
                     this.text_points.alpha -= 0.2;
                     if(this.text_points.alpha <= 0)
                     {
                        this.text_type.alpha = 1;
                        this.text_points.alpha = 0;
                        this.is_type_visible = true;
                        this.points_counter_1 = 0;
                     }
                  }
               }
            }
         }
         if(this.IS_NEW_RECORD)
         {
            if(this.new_record_blink_1 >= 0)
            {
               ++this.new_record_blink_1;
               if(this.new_record_blink_1 > (this.big_text.visible ? 20 : 10))
               {
                  this.new_record_blink_1 = 0;
                  this.big_text.visible = !this.big_text.visible;
                  ++this.new_record_blink_2;
               }
            }
            if(this.new_record_blink_2 >= 10)
            {
               this.big_text.visible = true;
               this.new_record_blink_1 = -1;
            }
         }
      }
      
      protected function getFishName(_id:*) : String
      {
         return StringsManager.GetString("shop_title_" + LevelItems.GetFishItemId(_id));
      }
      
      public function destroy() : void
      {
         removeChild(this.fish_image);
         this.textContainer.removeChild(this.text_name);
         this.textContainer.removeChild(this.text_size);
         this.textContainer.removeChild(this.text_type);
         this.textContainer.removeChild(this.text_points);
         removeChild(this.textContainer);
         removeChild(this.fish_background);
         removeChild(this.bluePanel);
         removeChild(this.big_text);
         this.fish_image.dispose();
         this.fish_image = null;
         this.text_name.destroy();
         this.text_name.dispose();
         this.text_name = null;
         this.text_size.destroy();
         this.text_size.dispose();
         this.text_size = null;
         this.text_type.destroy();
         this.text_points.destroy();
         this.text_type.dispose();
         this.text_points.dispose();
         this.text_type = null;
         this.text_points = null;
         this.textContainer.dispose();
         this.textContainer = null;
         this.fish_background.dispose();
         this.fish_background = null;
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         this.big_text.destroy();
         this.big_text.dispose();
         this.big_text = null;
      }
      
      public function setAppear() : void
      {
         this.IS_APPEARING = true;
         this.IS_DISAPPEARING = false;
         this.t_start = this.y - 8;
         this.t_diff = 8;
         this.t_time = 0.25;
         this.t_tick = 0;
         this.y = this.t_start;
         this.counter_1 = this.counter_2 = 0;
         this.visible = true;
         this.alpha = 0;
      }
      
      public function setDisappear() : void
      {
         this.IS_DISAPPEARING = true;
         this.IS_APPEARING = false;
         this.t_start = this.y;
         this.t_diff = 8;
         this.t_time = 0.25;
         this.t_tick = 0;
         this.counter_1 = this.counter_2 = 0;
         this.visible = true;
         this.alpha = 1;
      }
   }
}
