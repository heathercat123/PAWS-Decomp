package interfaces.panels
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class SoundHudPanel extends Sprite
   {
       
      
      public var pauseButton:Button;
      
      public var helpButton:Button;
      
      protected var additional_x_margin:int;
      
      protected var additional_y_margin:int;
      
      public function SoundHudPanel()
      {
         super();
         if(Utils.IS_IPHONE_X)
         {
            this.additional_x_margin = 16;
            this.additional_y_margin = -2;
         }
         else
         {
            this.additional_x_margin = -4;
            this.additional_y_margin = -3;
         }
         this.pauseButton = new Button(TextureManager.hudTextureAtlas.getTexture("pauseButton1"),"",TextureManager.hudTextureAtlas.getTexture("pauseButton2"));
         Image(Sprite(this.pauseButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.pauseButton.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - (this.pauseButton.width + this.additional_x_margin));
         this.pauseButton.y = this.additional_y_margin;
         addChild(this.pauseButton);
         this.helpButton = new Button(TextureManager.hudTextureAtlas.getTexture("helpButton1"),"",TextureManager.hudTextureAtlas.getTexture("helpButton2"));
         Image(Sprite(this.helpButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.helpButton.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - this.helpButton.width * 2);
         this.helpButton.y = 0;
         addChild(this.helpButton);
      }
      
      public function destroy() : void
      {
         removeChild(this.pauseButton);
         this.pauseButton.dispose();
         this.pauseButton = null;
         removeChild(this.helpButton);
         this.helpButton.dispose();
         this.helpButton = null;
      }
   }
}
