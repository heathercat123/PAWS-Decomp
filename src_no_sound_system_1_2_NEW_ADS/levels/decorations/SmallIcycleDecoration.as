package levels.decorations
{
   import levels.Level;
   import sprites.decorations.GenericDecorationSprite;
   
   public class SmallIcycleDecoration extends Decoration
   {
       
      
      public function SmallIcycleDecoration(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = new GenericDecorationSprite(GenericDecoration.ICICLE_SMALL);
         Utils.topWorld.addChild(sprite);
      }
      
      override public function update() : void
      {
         if(sprite.gfxHandleClip().isComplete)
         {
            sprite.gfxHandleClip().setFrameDuration(0,int(Math.round(Math.random() * 3 + 2)));
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
