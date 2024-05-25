package game_utils
{
   public class NumberUtil
   {
       
      
      public function NumberUtil()
      {
         super();
      }
      
      public static function addCommas(value:Number) : String
      {
         var pattern:RegExp = /(\d+)(\d{3}(\.|,|$))/gi;
         var str:String = value.toString();
         while(str.match(pattern).length != 0)
         {
            str = str.replace(pattern,"$1,$2");
         }
         return str;
      }
      
      public static function addLeadingZero(value:Number) : String
      {
         return value < 10 ? "0" + value : value.toString();
      }
      
      public static function constrain(value:Number, firstValue:Number, secondValue:Number) : Number
      {
         return Math.min(Math.max(value,Math.min(firstValue,secondValue)),Math.max(firstValue,secondValue));
      }
      
      public static function createStepsBetween(begin:Number, end:Number, steps:Number) : Array
      {
         steps++;
         var i:uint = 0;
         var stepsBetween:Array = new Array();
         var increment:Number = (end - begin) / steps;
         while(++i < steps)
         {
            stepsBetween.push(i * increment + begin);
         }
         return stepsBetween;
      }
      
      public static function getOrdinalSuffix(value:int) : String
      {
         if(value >= 10 && value <= 20)
         {
            return "th";
         }
         switch(value % 10)
         {
            case 0:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
               return "th";
            case 3:
               return "rd";
            case 2:
               return "nd";
            case 1:
               return "st";
            default:
               return "";
         }
      }
      
      public static function interpolate(amount:Number, minimum:Number, maximum:Number) : Number
      {
         return minimum + (maximum - minimum) * amount;
      }
      
      public static function isBetween(value:Number, firstValue:Number, secondValue:Number) : Boolean
      {
         return !(value < Math.min(firstValue,secondValue) || value > Math.max(firstValue,secondValue));
      }
      
      public static function isEqual(val1:Number, val2:Number, precision:Number = 0) : Boolean
      {
         return Math.abs(val1 - val2) <= Math.abs(precision);
      }
      
      public static function isEven(value:Number) : Boolean
      {
         return (value & 1) == 0;
      }
      
      public static function isInteger(value:Number) : Boolean
      {
         return value % 1 == 0;
      }
      
      public static function isOdd(value:Number) : Boolean
      {
         return !NumberUtil.isEven(value);
      }
      
      public static function isPrime(value:Number) : Boolean
      {
         if(value == 1 || value == 2)
         {
            return true;
         }
         if(NumberUtil.isEven(value))
         {
            return false;
         }
         var s:Number = Math.sqrt(value);
         for(var i:Number = 3; i <= s; i++)
         {
            if(value % i == 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function loopIndex(index:int, length:uint) : uint
      {
         if(index < 0)
         {
            index = length + index % length;
         }
         if(index >= length)
         {
            return index % length;
         }
         return index;
      }
      
      public static function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number) : Number
      {
         return NumberUtil.interpolate(NumberUtil.normalize(value,min1,max1),min2,max2);
      }
      
      public static function normalize(value:Number, minimum:Number, maximum:Number) : Number
      {
         return (value - minimum) / (maximum - minimum);
      }
      
      public static function randomWithinRange(min:Number, max:Number) : Number
      {
         return min + Math.random() * (max - min);
      }
      
      public static function randomIntegerWithinRange(min:int, max:int) : int
      {
         return Math.round(NumberUtil.randomWithinRange(min,max));
      }
      
      public static function roundDecimalToPlace(value:Number, place:uint) : Number
      {
         var p:Number = Math.pow(10,place);
         return Math.round(value * p) / p;
      }
   }
}
