package interfaces.map.decorations
{
   import game_utils.GameSlot;
   import interfaces.map.*;
   import sprites.*;
   import sprites.map.*;
   import starling.display.*;
   
   public class GenericMapDecoration extends Decoration
   {
       
      
      protected var INDEX:int;
      
      public var sprite:GameSprite;
      
      protected var original_xPos:Number;
      
      protected var original_yPos:Number;
      
      protected var xPos:Number;
      
      protected var yPos:Number;
      
      protected var sin_counter_1:Number;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      public function GenericMapDecoration(_worldMap:WorldMap, _index:int, _xPos:Number, _yPos:Number, _flip_x:int, _flip_y:int, _width:int = -1, _height:int = -1)
      {
         this.INDEX = _index;
         super(_worldMap);
         this.counter_1 = this.counter_2 = 0;
         this.xPos = this.original_xPos = _xPos;
         this.yPos = this.original_yPos = _yPos;
         this.sprite = new GenericMapSprite(this.INDEX);
         Utils.world.addChild(this.sprite);
         if(this.INDEX == MapDecorations.CLOUD_1 || this.INDEX == MapDecorations.CLOUD_2)
         {
            this.sin_counter_1 = Math.random() * Math.PI * 2;
         }
         else if(this.INDEX == MapDecorations.WAVE_1)
         {
            this.sin_counter_1 = Utils.random.nextNumber();
         }
         else if(this.INDEX == MapDecorations.BARRIER_2)
         {
            this.sprite.height = 38;
         }
         else if(this.INDEX == MapDecorations.SMALL_BOAT_1)
         {
            if(Boolean(Utils.Slot.levelSeqUnlocked[802]) && !Utils.Slot.levelUnlocked[802])
            {
               this.sprite.visible = false;
            }
         }
         else if(this.INDEX == MapDecorations.EGG_1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
            {
               if(this.xPos < 465)
               {
                  if((Utils.Slot.gameProgression[17] >> 0 & 1) == 1)
                  {
                     this.sprite.visible = false;
                  }
               }
               else if((Utils.Slot.gameProgression[17] >> 1 & 1) == 1)
               {
                  this.sprite.visible = false;
               }
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
            {
               if(this.xPos < 496)
               {
                  if((Utils.Slot.gameProgression[17] >> 2 & 1) == 1)
                  {
                     this.sprite.visible = false;
                  }
               }
            }
         }
         if(_width > -1)
         {
            this.sprite.width = _width;
         }
         if(_height > -1)
         {
            this.sprite.height = _height;
         }
         if(_flip_x > 0)
         {
            this.sprite.scaleX = -1;
         }
         if(_flip_y > 0)
         {
            this.sprite.scaleY = -1;
         }
         if(this.xPos % 2 == 0)
         {
            this.sprite.gfxHandleClip().gotoAndPlay(1);
         }
         else
         {
            this.sprite.gfxHandleClip().gotoAndPlay(2);
         }
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.sprite);
         this.sprite.destroy();
         this.sprite.dispose();
         this.sprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.INDEX == MapDecorations.CLOUD_1 || this.INDEX == MapDecorations.CLOUD_2)
         {
            this.sin_counter_1 += 0.025;
            if(this.sin_counter_1 >= Math.PI * 2)
            {
               this.sin_counter_1 -= Math.PI * 2;
            }
            this.xPos = this.original_xPos + Math.sin(this.sin_counter_1) * 2;
         }
         else if(this.INDEX == MapDecorations.WAVE_1)
         {
            this.sin_counter_1 += 0.02;
            if(this.sin_counter_1 >= Math.PI * 2)
            {
               this.sin_counter_1 -= Math.PI * 2;
            }
            this.xPos = this.original_xPos + Math.sin(this.sin_counter_1) * 2;
         }
         else if(this.INDEX == MapDecorations.MAP_2_SHORE_1 || this.INDEX == MapDecorations.MAP_2_SHORE_2 || this.INDEX == MapDecorations.MAP_2_SHORE_3 || this.INDEX == MapDecorations.MAP_2_SHORE_4 || this.INDEX == MapDecorations.MAP_2_SHORE_5)
         {
            ++this.counter_2;
            if(this.counter_2 >= 30)
            {
               this.counter_2 = 0;
               ++this.counter_1;
               if(this.counter_1 > 5)
               {
                  this.counter_1 = 0;
               }
            }
            if(this.counter_1 > 0)
            {
               this.sprite.visible = true;
               this.sprite.gfxHandleClip().gotoAndStop(this.counter_1);
            }
            else
            {
               this.sprite.visible = false;
            }
         }
      }
      
      override public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         this.sprite.x = int(Math.floor(this.xPos - mapCamera.xPos));
         this.sprite.y = int(Math.floor(this.yPos - mapCamera.yPos));
         if(this.INDEX == MapDecorations.MAP_2_SHORE_1 || this.INDEX == MapDecorations.MAP_2_SHORE_2 || this.INDEX == MapDecorations.MAP_2_SHORE_3 || this.INDEX == MapDecorations.MAP_2_SHORE_4 || this.INDEX == MapDecorations.MAP_2_SHORE_5)
         {
            Utils.world.setChildIndex(this.sprite,0);
         }
         this.sprite.updateScreenPosition();
      }
   }
}
