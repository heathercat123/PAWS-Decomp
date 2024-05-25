package game_utils
{
   import flash.geom.ColorTransform;
   
   public class ColorUtil
   {
       
      
      public function ColorUtil()
      {
         super();
      }
      
      public static function ARGBToHex(a:uint, r:uint, g:uint, b:uint) : uint
      {
         return a << 24 | r << 16 | g << 8 | b;
      }
      
      public static function RGBToHex(r:uint, g:uint, b:uint) : uint
      {
         return r << 16 | g << 8 | b;
      }
      
      public static function RGBtoHSV(r:uint, g:uint, b:uint) : Object
      {
         var max:uint = Math.max(r,g,b);
         var min:uint = Math.min(r,g,b);
         var hue:Number = 0;
         var saturation:Number = 0;
         var value:Number = 0;
         if(max == min)
         {
            hue = 0;
         }
         else if(max == r)
         {
            hue = (60 * (g - b) / (max - min) + 360) % 360;
         }
         else if(max == g)
         {
            hue = 60 * (b - r) / (max - min) + 120;
         }
         else if(max == b)
         {
            hue = 60 * (r - g) / (max - min) + 240;
         }
         value = max;
         if(max == 0)
         {
            saturation = 0;
         }
         else
         {
            saturation = (max - min) / max;
         }
         var hsv:Object = {};
         hsv.h = Math.round(hue);
         hsv.s = Math.round(saturation * 100);
         hsv.v = Math.round(value / 255 * 100);
         return hsv;
      }
      
      public static function HexToRGB(hex:uint) : Object
      {
         var rgb:Object = {};
         rgb.r = hex >> 16 & 255;
         rgb.g = hex >> 8 & 255;
         rgb.b = hex & 255;
         return rgb;
      }
      
      public static function HexToARGB(hex:uint) : Object
      {
         var rgb:Object = {};
         rgb.a = hex >> 24 & 255;
         rgb.r = hex >> 16 & 255;
         rgb.g = hex >> 8 & 255;
         rgb.b = hex & 255;
         return rgb;
      }
      
      public static function HSVtoRGB(h:Number, s:Number, v:Number) : Object
      {
         var r:Number = 0;
         var g:Number = 0;
         var b:Number = 0;
         var tempS:Number = s / 100;
         var tempV:Number = v / 100;
         var hi:int = Math.floor(h / 60) % 6;
         var f:Number = h / 60 - Math.floor(h / 60);
         var p:Number = tempV * (1 - tempS);
         var q:Number = tempV * (1 - f * tempS);
         var t:Number = tempV * (1 - (1 - f) * tempS);
         switch(hi)
         {
            case 0:
               r = tempV;
               g = t;
               b = p;
               break;
            case 1:
               r = q;
               g = tempV;
               b = p;
               break;
            case 2:
               r = p;
               g = tempV;
               b = t;
               break;
            case 3:
               r = p;
               g = q;
               b = tempV;
               break;
            case 4:
               r = t;
               g = p;
               b = tempV;
               break;
            case 5:
               r = tempV;
               g = p;
               b = q;
         }
         var rgb:Object = {};
         rgb.r = Math.round(r * 255);
         rgb.g = Math.round(g * 255);
         rgb.b = Math.round(b * 255);
         return rgb;
      }
      
      public static function HSVtoHEX(h:Number, s:Number, v:Number) : uint
      {
         var rgb:Object = ColorUtil.HSVtoRGB(h,s,v);
         return ColorUtil.RGBToHex(rgb.r,rgb.g,rgb.b);
      }
      
      public static function interpolateColor(begin:ColorTransform, end:ColorTransform, amount:Number) : ColorTransform
      {
         var interpolation:ColorTransform = new ColorTransform();
         interpolation.redMultiplier = NumberUtil.interpolate(amount,begin.redMultiplier,end.redMultiplier);
         interpolation.greenMultiplier = NumberUtil.interpolate(amount,begin.greenMultiplier,end.greenMultiplier);
         interpolation.blueMultiplier = NumberUtil.interpolate(amount,begin.blueMultiplier,end.blueMultiplier);
         interpolation.alphaMultiplier = NumberUtil.interpolate(amount,begin.alphaMultiplier,end.alphaMultiplier);
         interpolation.redOffset = NumberUtil.interpolate(amount,begin.redOffset,end.redOffset);
         interpolation.greenOffset = NumberUtil.interpolate(amount,begin.greenOffset,end.greenOffset);
         interpolation.blueOffset = NumberUtil.interpolate(amount,begin.blueOffset,end.blueOffset);
         interpolation.alphaOffset = NumberUtil.interpolate(amount,begin.alphaOffset,end.alphaOffset);
         return interpolation;
      }
      
      public static function randomRBG() : uint
      {
         return ColorUtil.RGBToHex(NumberUtil.randomIntegerWithinRange(0,255),NumberUtil.randomIntegerWithinRange(0,255),NumberUtil.randomIntegerWithinRange(0,255));
      }
      
      public static function randomARBG() : uint
      {
         return ColorUtil.ARGBToHex(NumberUtil.randomIntegerWithinRange(0,255),NumberUtil.randomIntegerWithinRange(0,255),NumberUtil.randomIntegerWithinRange(0,255),NumberUtil.randomIntegerWithinRange(0,255));
      }
      
      public static function getGradientColor(hex:uint, hex2:uint, ratio:Number) : uint
      {
         var r:uint = uint(hex >> 16);
         var g:uint = uint(hex >> 8 & 255);
         var b:uint = uint(hex & 255);
         r += ((hex2 >> 16) - r) * ratio;
         g += ((hex2 >> 8 & 255) - g) * ratio;
         b += ((hex2 & 255) - b) * ratio;
         return r << 16 | g << 8 | b;
      }
      
      public static function getGradientSteps(hex1:uint, hex2:uint, steps:int) : Array
      {
         var ratio:Number = NaN;
         var newArry:Array = [hex1];
         var r:uint = uint(hex1 >> 16);
         var g:uint = uint(hex1 >> 8 & 255);
         var b:uint = uint(hex1 & 255);
         var rd:uint = uint((hex2 >> 16) - r);
         var gd:uint = uint((hex2 >> 8 & 255) - g);
         var bd:uint = uint((hex2 & 255) - b);
         steps++;
         for(var i:int = 1; i < steps; i++)
         {
            ratio = i / steps;
            newArry.push(r + rd * ratio << 16 | g + gd * ratio << 8 | b + bd * ratio);
         }
         newArry.push(hex2);
         return newArry;
      }
   }
}
