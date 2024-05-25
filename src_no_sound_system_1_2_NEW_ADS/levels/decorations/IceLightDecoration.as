package levels.decorations
{
   import levels.Level;
   import sprites.decorations.IceLightDecorationSprite;
   
   public class IceLightDecoration extends Decoration
   {
       
      
      protected var sinCounter1:Number;
      
      protected var oldXPos:Number;
      
      protected var oldYPos:Number;
      
      protected var index_offset:int;
      
      public function IceLightDecoration(_level:Level, _xPos:Number, _yPos:Number, index:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new IceLightDecorationSprite();
         sprite.gotoAndStop(index);
         this.oldXPos = this.oldYPos = 0;
         var x_t:int = int(_xPos / Utils.TILE_WIDTH);
         this.index_offset = int(x_t % 6);
         this.sinCounter1 = Math.random() * Math.PI * 2;
         Utils.topWorld.addChild(sprite);
      }
      
      override public function update() : void
      {
         super.update();
         var diff_x:Number = Math.abs(level.camera.xPos - this.oldXPos);
         var diff_y:Number = Math.abs(level.camera.yPos - this.oldYPos);
         var diff:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         this.oldXPos = level.camera.xPos;
         this.oldYPos = level.camera.yPos;
         diff *= 0.005;
         this.sinCounter1 += diff;
         if(this.sinCounter1 > Math.PI * 2)
         {
            this.sinCounter1 -= Math.PI * 2;
         }
         xPos = originalXPos + Math.sin(this.sinCounter1) * 8;
         var camera_position:Number = Math.abs(level.camera.xPos + level.camera.yPos);
         var anim_index:int = int(camera_position % 96 * 0.0625) + 1;
         anim_index += this.index_offset;
         if(anim_index > 6)
         {
            anim_index -= 6;
         }
         sprite.gfxHandleClip().gotoAndStop(anim_index);
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
