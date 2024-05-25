package interfaces.buttons
{
   import game_utils.LevelItems;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class MapLevelButton extends Button
   {
       
      
      public var index:int;
      
      public var topImageUp:Image;
      
      public var topImageDown:Image;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var images_visible:Boolean;
      
      public function MapLevelButton(_upState:Texture, _string:String, _downState:Texture, _index:int, _xPos:Number, _yPos:Number)
      {
         super(_upState,_string,_downState);
         this.index = _index;
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.counter1 = this.counter2 = 0;
         this.topImageUp = null;
         this.topImageDown = null;
         this.images_visible = true;
         this.initImages();
      }
      
      public function destroy() : void
      {
         if(this.topImageUp != null)
         {
            this.removeChild(this.topImageUp);
            this.topImageUp.dispose();
            this.topImageUp = null;
         }
         if(this.topImageDown != null)
         {
            this.removeChild(this.topImageDown);
            this.topImageDown.dispose();
            this.topImageDown = null;
         }
      }
      
      public function setImagesVisible(value:Boolean) : void
      {
         if(this.topImageUp != null)
         {
            this.images_visible = value;
            this.topImageUp.visible = value;
            this.topImageDown.visible = value;
         }
      }
      
      public function getSelectionResult() : int
      {
         if(this.index == 8)
         {
            if(Utils.Slot.worldUnlocked[0] == true)
            {
               return 1;
            }
            if(Utils.Slot.playerInventory[LevelItems.ITEM_BELL] >= 10)
            {
               return 2;
            }
            return 0;
         }
         if(this.index == 16)
         {
            if(Utils.Slot.worldUnlocked[1] == true)
            {
               return 1;
            }
            if(Utils.Slot.playerInventory[LevelItems.ITEM_BELL] >= 30)
            {
               return 2;
            }
            return 0;
         }
         if(this.index == 24)
         {
            if(Utils.Slot.worldUnlocked[2] == true)
            {
               return 1;
            }
            if(Utils.Slot.playerInventory[LevelItems.ITEM_BELL] >= 60)
            {
               return 2;
            }
            return 0;
         }
         return 1;
      }
      
      protected function initImages() : void
      {
         if(this.index == 8)
         {
            if(Utils.Slot.worldUnlocked[0] == false)
            {
               this.topImageUp = new Image(TextureManager.hudTextureAtlas.getTexture("mapLevelButtonBells_1"));
               this.topImageUp.touchable = false;
               this.topImageUp.visible = false;
               addChild(this.topImageUp);
               this.topImageDown = new Image(TextureManager.hudTextureAtlas.getTexture("mapLevelButtonBells_2"));
               this.topImageDown.touchable = false;
               this.topImageDown.visible = false;
               this.topImageDown.y = 6;
               addChild(this.topImageDown);
               this.topImageUp.alpha = 0.3;
               this.topImageDown.alpha = 0.3;
            }
         }
         else if(this.index == 16)
         {
            if(Utils.Slot.worldUnlocked[1] == false)
            {
               this.topImageUp = new Image(TextureManager.hudTextureAtlas.getTexture("mapLevelButtonBells_3"));
               this.topImageUp.touchable = false;
               this.topImageUp.visible = false;
               addChild(this.topImageUp);
               this.topImageDown = new Image(TextureManager.hudTextureAtlas.getTexture("mapLevelButtonBells_4"));
               this.topImageDown.touchable = false;
               this.topImageDown.visible = false;
               this.topImageDown.y = 6;
               addChild(this.topImageDown);
               this.topImageUp.alpha = 0.3;
               this.topImageDown.alpha = 0.3;
            }
         }
         else if(this.index == 24)
         {
            if(Utils.Slot.worldUnlocked[2] == false)
            {
               this.topImageUp = new Image(TextureManager.hudTextureAtlas.getTexture("mapLevelButtonBells_5"));
               this.topImageUp.touchable = false;
               this.topImageUp.visible = false;
               addChild(this.topImageUp);
               this.topImageDown = new Image(TextureManager.hudTextureAtlas.getTexture("mapLevelButtonBells_6"));
               this.topImageDown.touchable = false;
               this.topImageDown.visible = false;
               this.topImageDown.y = 6;
               addChild(this.topImageDown);
               this.topImageUp.alpha = 0.3;
               this.topImageDown.alpha = 0.3;
            }
         }
      }
      
      public function update() : void
      {
         if(this.visible)
         {
            if(this.topImageUp != null)
            {
               if(!this.images_visible)
               {
                  this.topImageDown.visible = false;
                  this.topImageUp.visible = false;
               }
               else if(state == "down")
               {
                  this.topImageDown.visible = true;
                  this.topImageUp.visible = false;
               }
               else
               {
                  this.topImageDown.visible = false;
                  this.topImageUp.visible = true;
               }
               if(this.topImageUp.alpha < 1)
               {
                  if(this.counter1++ > 3)
                  {
                     this.topImageUp.alpha += 0.3;
                     this.topImageDown.alpha = this.topImageUp.alpha;
                     if(this.topImageUp.alpha >= 1)
                     {
                        this.topImageUp.alpha = this.topImageDown.alpha = 1;
                     }
                  }
               }
            }
         }
      }
   }
}
