package starling.extensions.pixelmask
{
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.core.Starling;
   import starling.display.BlendMode;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   import starling.events.Event;
   import starling.rendering.Painter;
   import starling.textures.RenderTexture;
   import starling.utils.Pool;
   
   public class PixelMaskDisplayObject extends DisplayObjectContainer
   {
      
      private static const MASK_MODE_NORMAL:String = "mask";
      
      private static const MASK_MODE_INVERTED:String = "maskInverted";
      
      private static var sIdentity:Matrix = new Matrix();
       
      
      private var _mask:DisplayObject;
      
      private var _renderTexture:RenderTexture;
      
      private var _maskRenderTexture:RenderTexture;
      
      private var _quad:Quad;
      
      private var _maskQuad:Quad;
      
      private var _superRenderFlag:Boolean = false;
      
      private var _scaleFactor:Number;
      
      private var _isAnimated:Boolean = true;
      
      private var _maskRendered:Boolean = false;
      
      public function PixelMaskDisplayObject(scaleFactor:Number = -1, isAnimated:Boolean = true)
      {
         super();
         BlendMode.register(MASK_MODE_NORMAL,Context3DBlendFactor.ZERO,Context3DBlendFactor.SOURCE_ALPHA);
         BlendMode.register(MASK_MODE_INVERTED,Context3DBlendFactor.ZERO,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
         this._isAnimated = isAnimated;
         this._scaleFactor = scaleFactor;
         this._quad = new Quad(100,100);
         this._maskQuad = new Quad(100,100);
         this._maskQuad.blendMode = MASK_MODE_NORMAL;
         Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,0,true);
      }
      
      override public function dispose() : void
      {
         this.clearRenderTextures();
         this._quad.dispose();
         this._maskQuad.dispose();
         Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         super.dispose();
      }
      
      private function onContextCreated(event:Object) : void
      {
         this.refreshRenderTextures();
      }
      
      public function get isAnimated() : Boolean
      {
         return this._isAnimated;
      }
      
      public function set isAnimated(value:Boolean) : void
      {
         this._isAnimated = value;
      }
      
      public function get inverted() : Boolean
      {
         return this._maskQuad.blendMode == MASK_MODE_INVERTED;
      }
      
      public function set inverted(value:Boolean) : void
      {
         this._maskQuad.blendMode = value ? MASK_MODE_INVERTED : MASK_MODE_NORMAL;
      }
      
      public function get pixelMask() : DisplayObject
      {
         return this._mask;
      }
      
      public function set pixelMask(value:DisplayObject) : void
      {
         this._mask = value;
         if(value)
         {
            if(this._mask.width == 0 || this._mask.height == 0)
            {
               throw new Error("Mask must have dimensions. Current dimensions are " + this._mask.width + "x" + this._mask.height + ".");
            }
            this.refreshRenderTextures();
         }
         else
         {
            this.clearRenderTextures();
         }
      }
      
      private function clearRenderTextures() : void
      {
         if(this._maskRenderTexture)
         {
            this._maskRenderTexture.dispose();
         }
         if(this._renderTexture)
         {
            this._renderTexture.dispose();
         }
      }
      
      private function refreshRenderTextures() : void
      {
         var maskBounds:Rectangle = null;
         var maskWidth:Number = NaN;
         var maskHeight:Number = NaN;
         if(this._mask)
         {
            this.clearRenderTextures();
            maskBounds = this._mask.getBounds(this._mask,Pool.getRectangle());
            maskWidth = maskBounds.width;
            maskHeight = maskBounds.height;
            Pool.putRectangle(maskBounds);
            this._renderTexture = new RenderTexture(maskWidth,maskHeight,false,this._scaleFactor);
            this._maskRenderTexture = new RenderTexture(maskWidth,maskHeight,false,this._scaleFactor);
            this._quad.texture = this._renderTexture;
            this._quad.readjustSize();
            this._maskQuad.texture = this._maskRenderTexture;
            this._maskQuad.readjustSize();
         }
         this._maskRendered = false;
      }
      
      override public function render(painter:Painter) : void
      {
         if(this._isAnimated || !this._isAnimated && !this._maskRendered)
         {
            painter.finishMeshBatch();
            painter.excludeFromCache(this);
            if(this._superRenderFlag || !this._mask)
            {
               super.render(painter);
            }
            else if(this._mask)
            {
               this._maskRenderTexture.draw(this._mask,sIdentity);
               this._renderTexture.drawBundled(this.drawRenderTextures);
               painter.pushState();
               painter.state.transformModelviewMatrix(this._mask.transformationMatrix);
               this._quad.render(painter);
               this._maskRendered = true;
               painter.popState();
            }
         }
         else
         {
            this._quad.render(painter);
         }
      }
      
      private function drawRenderTextures() : void
      {
         var matrix:Matrix = Pool.getMatrix();
         matrix.copyFrom(this._mask.transformationMatrix);
         matrix.invert();
         this._superRenderFlag = true;
         this._renderTexture.draw(this,matrix);
         this._superRenderFlag = false;
         this._renderTexture.draw(this._maskQuad,sIdentity);
         Pool.putMatrix(matrix);
      }
   }
}
