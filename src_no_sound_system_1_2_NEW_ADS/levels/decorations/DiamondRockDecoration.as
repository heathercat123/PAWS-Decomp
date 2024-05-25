package levels.decorations
{
   import levels.Level;
   import sprites.decorations.DiamondRockDecorationSprite;
   
   public class DiamondRockDecoration extends Decoration
   {
       
      
      public function DiamondRockDecoration(_level:Level, _xPos:Number, _yPos:Number, _id:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new DiamondRockDecorationSprite();
         sprite.gotoAndStop(_id + 1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         Utils.topWorld.addChild(sprite);
      }
      
      override public function update() : void
      {
         super.update();
         if(sprite.gfxHandleClip().isComplete)
         {
            sprite.gfxHandleClip().setFrameDuration(0,Math.random() * 1 + 1);
            sprite.gfxHandleClip().gotoAndPlay(1);
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
