package levels.decorations
{
   import levels.Level;
   import sprites.decorations.GenericDecorationSprite;
   
   public class ShopLightDecoration extends Decoration
   {
       
      
      public function ShopLightDecoration(_level:Level, _xPos:Number, _yPos:Number, _id:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new GenericDecorationSprite(GenericDecoration.SHOP_LIGHT);
         sprite.gfxHandleClip().gotoAndPlay(_id + 1);
         Utils.topWorld.addChild(sprite);
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
   }
}
