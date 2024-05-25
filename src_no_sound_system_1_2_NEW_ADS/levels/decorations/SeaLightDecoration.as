package levels.decorations
{
   import levels.Level;
   import sprites.decorations.GenericDecorationSprite;
   
   public class SeaLightDecoration extends Decoration
   {
       
      
      protected var sinCounter1:Number;
      
      public function SeaLightDecoration(_level:Level, _xPos:Number, _yPos:Number, index:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new GenericDecorationSprite(index);
         sprite.gotoAndStop(index);
         var x_t:int = int(_xPos / Utils.TILE_WIDTH);
         sprite.gfxHandleClip().gotoAndPlay(int(x_t % 6) + 1);
         this.sinCounter1 = Math.random() * Math.PI * 2;
         Utils.backWorld.addChild(sprite);
      }
      
      override public function update() : void
      {
         super.update();
         this.sinCounter1 += 0.025;
         if(this.sinCounter1 > Math.PI * 2)
         {
            this.sinCounter1 -= Math.PI * 2;
         }
         xPos = originalXPos + Math.sin(this.sinCounter1) * 8;
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
