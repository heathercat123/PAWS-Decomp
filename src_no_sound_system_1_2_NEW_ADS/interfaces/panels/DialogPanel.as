package interfaces.panels
{
   import flash.geom.Point;
   import interfaces.texts.GameText;
   import interfaces.texts.GameTextArea;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class DialogPanel extends Sprite
   {
       
      
      protected var backgroundQuad:Image;
      
      protected var bluePanel:BluePanel;
      
      protected var dialogText:GameTextArea;
      
      public var DONE:Boolean;
      
      public function DialogPanel()
      {
         super();
         this.backgroundQuad = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.backgroundQuad.width = Utils.WIDTH;
         this.backgroundQuad.height = Utils.HEIGHT;
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         this.backgroundQuad.alpha = 0.8;
         addChild(this.backgroundQuad);
         this.bluePanel = new BluePanel(int(Utils.WIDTH * 0.55),int(Utils.HEIGHT * 0.35));
         addChild(this.bluePanel);
         this.bluePanel.x = int((Utils.WIDTH - this.bluePanel.WIDTH) * 0.5);
         this.bluePanel.y = int((Utils.HEIGHT - this.bluePanel.HEIGHT) * 0.5);
         this.dialogText = null;
         addEventListener(TouchEvent.TOUCH,this.onClick);
         this.DONE = false;
      }
      
      public function destroy() : void
      {
         removeEventListener(TouchEvent.TOUCH,this.onClick);
         if(this.dialogText != null)
         {
            removeChild(this.dialogText);
            this.dialogText.destroy();
            this.dialogText.dispose();
            this.dialogText = null;
         }
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      protected function onClick(event:TouchEvent) : void
      {
         var touches:Vector.<Touch> = null;
         var previousPosition:Point = null;
         var position:Point = null;
         try
         {
            touches = event.getTouches(Utils.rootStage);
            previousPosition = touches[touches.length - 1].getPreviousLocation(Utils.rootStage);
            position = touches[touches.length - 1].getLocation(Utils.rootStage);
            if(touches[touches.length - 1].phase != "began")
            {
               if(touches[touches.length - 1].phase != "moved")
               {
                  if(touches[touches.length - 1].phase == "ended")
                  {
                     this.DONE = true;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function setText(_string:String) : void
      {
         if(this.dialogText != null)
         {
            removeChild(this.dialogText);
            this.dialogText.destroy();
            this.dialogText.dispose();
         }
         this.dialogText = new GameTextArea(_string,GameText.TYPE_SMALL_WHITE,this.bluePanel.WIDTH - 32,this.bluePanel.HEIGHT - 32);
         addChild(this.dialogText);
         this.dialogText.x = int(this.bluePanel.x + (this.bluePanel.WIDTH - this.dialogText.WIDTH) * 0.5);
         this.dialogText.y = int(this.bluePanel.y + (this.bluePanel.HEIGHT - this.dialogText.HEIGHT) * 0.5) - 1;
         this.DONE = false;
      }
   }
}
