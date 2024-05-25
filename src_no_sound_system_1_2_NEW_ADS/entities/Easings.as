package entities
{
   public class Easings
   {
      
      public static const LINEAR:int = 0;
      
      public static var none:Function = easeLinear;
      
      public static var linear:Function = easeLinear;
       
      
      public function Easings()
      {
         super();
      }
      
      public static function easeLinear(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * t / d + b;
      }
      
      public static function easeInSine(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c * Math.cos(t / d * Math.PI * 0.5) + c + b;
      }
      
      public static function easeOutSine(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * Math.sin(t / d * Math.PI * 0.5) + b;
      }
      
      public static function easeInOutSine(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
      }
      
      public static function easeInQuint(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * (t = t / d) * t * t * t * t + b;
      }
      
      public static function easeOutQuint(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
      }
      
      public static function easeInOutQuint(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * t * t * t * t * t + b;
         }
         return c / 2 * ((t = t - 2) * t * t * t * t + 2) + b;
      }
      
      public static function easeInQuart(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * (t = t / d) * t * t * t + b;
      }
      
      public static function easeOutQuart(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c * ((t = t / d - 1) * t * t * t - 1) + b;
      }
      
      public static function easeInOutQuart(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * t * t * t * t + b;
         }
         return -c / 2 * ((t = t - 2) * t * t * t - 2) + b;
      }
      
      public static function easeInQuad(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * (t = t / d) * t + b;
      }
      
      public static function easeOutQuad(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c * (t = t / d) * (t - 2) + b;
      }
      
      public static function easeInOutQuad(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * t * t + b;
         }
         return -c / 2 * (--t * (t - 2) - 1) + b;
      }
      
      public static function easeInExpo(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return t == 0 ? b : c * Math.pow(2,10 * (t / d - 1)) + b;
      }
      
      public static function easeOutExpo(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return t == d ? b + c : c * (-Math.pow(2,-10 * t / d) + 1) + b;
      }
      
      public static function easeInOutExpo(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if(t == 0)
         {
            return b;
         }
         if(t == d)
         {
            return b + c;
         }
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * Math.pow(2,10 * (t - 1)) + b;
         }
         return c / 2 * (-Math.pow(2,-10 * --t) + 2) + b;
      }
      
      public static function easeInElastic(t:Number, b:Number, c:Number, d:Number, a:Number = undefined, p:Number = undefined) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         if((t = t / d) == 1)
         {
            return b + c;
         }
         if(!p)
         {
            p = d * 0.3;
         }
         if(!a || a < Math.abs(c))
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / Math.PI * 2 * Math.asin(c / a);
         }
         return -(a * Math.pow(2,10 * (t = t - 1)) * Math.sin((t * d - s) * Math.PI * 2 / p)) + b;
      }
      
      public static function easeOutElastic(t:Number, b:Number, c:Number, d:Number, a:Number = undefined, p:Number = undefined) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         if((t = t / d) == 1)
         {
            return b + c;
         }
         if(!p)
         {
            p = d * 0.3;
         }
         if(!a || a < Math.abs(c))
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / Math.PI * 2 * Math.asin(c / a);
         }
         return a * Math.pow(2,-10 * t) * Math.sin((t * d - s) * Math.PI * 2 / p) + c + b;
      }
      
      public static function easeInOutElastic(t:Number, b:Number, c:Number, d:Number, a:Number = undefined, p:Number = undefined) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         if((t = t / (d / 2)) == 2)
         {
            return b + c;
         }
         if(!p)
         {
            p = d * (0.3 * 1.5);
         }
         if(!a || a < Math.abs(c))
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / Math.PI * 2 * Math.asin(c / a);
         }
         if(t < 1)
         {
            return -0.5 * (a * Math.pow(2,10 * (t = t - 1)) * Math.sin((t * d - s) * Math.PI * 2 / p)) + b;
         }
         return a * Math.pow(2,-10 * (t = t - 1)) * Math.sin((t * d - s) * Math.PI * 2 / p) * 0.5 + c + b;
      }
      
      public static function easeInCircular(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c * (Math.sqrt(1 - (t = t / d) * t) - 1) + b;
      }
      
      public static function easeOutCircular(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * Math.sqrt(1 - (t = t / d - 1) * t) + b;
      }
      
      public static function easeInOutCircular(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
         }
         return c / 2 * (Math.sqrt(1 - (t = t - 2) * t) + 1) + b;
      }
      
      public static function easeInBack(t:Number, b:Number, c:Number, d:Number, s:Number = 1.70158) : Number
      {
         return c * (t = t / d) * t * ((s + 1) * t - s) + b;
      }
      
      public static function easeOutBack(t:Number, b:Number, c:Number, d:Number, s:Number = 1.70158) : Number
      {
         return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
      }
      
      public static function easeInOutBack(t:Number, b:Number, c:Number, d:Number, s:Number = 1.70158) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * (t * t * (((s = s * 1.525) + 1) * t - s)) + b;
         }
         return c / 2 * ((t = t - 2) * t * (((s = s * 1.525) + 1) * t + s) + 2) + b;
      }
      
      public static function easeInBounce(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c - easeOutBounce(d - t,0,c,d) + b;
      }
      
      public static function easeOutBounce(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if((t = t / d) < 1 / 2.75)
         {
            return c * (7.5625 * t * t) + b;
         }
         if(t < 2 / 2.75)
         {
            return c * (7.5625 * (t = t - 1.5 / 2.75) * t + 0.75) + b;
         }
         if(t < 2.5 / 2.75)
         {
            return c * (7.5625 * (t = t - 2.25 / 2.75) * t + 0.9375) + b;
         }
         return c * (7.5625 * (t = t - 2.625 / 2.75) * t + 0.984375) + b;
      }
      
      public static function easeInOutBounce(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if(t < d / 2)
         {
            return easeInBounce(t * 2,0,c,d) * 0.5 + b;
         }
         return easeOutBounce(t * 2 - d,0,c,d) * 0.5 + c * 0.5 + b;
      }
      
      public static function easeInCubic(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * (t = t / d) * t * t + b;
      }
      
      public static function easeOutCubic(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * ((t = t / d - 1) * t * t + 1) + b;
      }
      
      public static function easeInOutCubic(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if((t = t / (d / 2)) < 1)
         {
            return c / 2 * t * t * t + b;
         }
         return c / 2 * ((t = t - 2) * t * t + 2) + b;
      }
   }
}
