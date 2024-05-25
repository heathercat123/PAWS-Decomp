package levels.decorations
{
   import levels.Level;
   import sprites.decorations.VineHorDecorationSprite;
   import sprites.decorations.VineVerDecorationSprite;
   
   public class VineDecoration extends Decoration
   {
       
      
      public function VineDecoration(_level:Level, _xPos:Number, _yPos:Number, _isVer:int, _id:int, _flipped_hor:int, _flipped_ver:int)
      {
         super(_level,_xPos,_yPos);
         if(_isVer > 0)
         {
            sprite = new VineVerDecorationSprite();
         }
         else
         {
            sprite = new VineHorDecorationSprite();
         }
         sprite.gfxHandleClip().gotoAndStop(_id);
         if(_flipped_hor > 0)
         {
            sprite.scaleX = -1;
         }
         if(_flipped_ver > 0)
         {
            sprite.scaleY = -1;
         }
         Utils.topWorld.addChild(sprite);
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
