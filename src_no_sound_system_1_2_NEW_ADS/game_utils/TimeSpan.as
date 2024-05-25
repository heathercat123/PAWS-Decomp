package game_utils
{
   public class TimeSpan
   {
      
      public static const MILLISECONDS_IN_DAY:Number = 86400000;
      
      public static const MILLISECONDS_IN_HOUR:Number = 3600000;
      
      public static const MILLISECONDS_IN_MINUTE:Number = 60000;
      
      public static const MILLISECONDS_IN_SECOND:Number = 1000;
       
      
      private var _totalMilliseconds:Number;
      
      public function TimeSpan(milliseconds:Number)
      {
         super();
         this._totalMilliseconds = Math.floor(milliseconds);
      }
      
      public static function fromDates(start:Date, end:Date) : TimeSpan
      {
         return new TimeSpan(end.time - start.time);
      }
      
      public static function fromMilliseconds(milliseconds:Number) : TimeSpan
      {
         return new TimeSpan(milliseconds);
      }
      
      public static function fromSeconds(seconds:Number) : TimeSpan
      {
         return new TimeSpan(seconds * MILLISECONDS_IN_SECOND);
      }
      
      public static function fromMinutes(minutes:Number) : TimeSpan
      {
         return new TimeSpan(minutes * MILLISECONDS_IN_MINUTE);
      }
      
      public static function fromHours(hours:Number) : TimeSpan
      {
         return new TimeSpan(hours * MILLISECONDS_IN_HOUR);
      }
      
      public static function fromDays(days:Number) : TimeSpan
      {
         return new TimeSpan(days * MILLISECONDS_IN_DAY);
      }
      
      public function get days() : int
      {
         return int(this._totalMilliseconds / MILLISECONDS_IN_DAY);
      }
      
      public function get hours() : int
      {
         return int(this._totalMilliseconds / MILLISECONDS_IN_HOUR) % 24;
      }
      
      public function get minutes() : int
      {
         return int(this._totalMilliseconds / MILLISECONDS_IN_MINUTE) % 60;
      }
      
      public function get seconds() : int
      {
         return int(this._totalMilliseconds / MILLISECONDS_IN_SECOND) % 60;
      }
      
      public function get milliseconds() : int
      {
         return int(this._totalMilliseconds) % 1000;
      }
      
      public function get totalDays() : Number
      {
         return this._totalMilliseconds / MILLISECONDS_IN_DAY;
      }
      
      public function get totalHours() : Number
      {
         return this._totalMilliseconds / MILLISECONDS_IN_HOUR;
      }
      
      public function get totalMinutes() : Number
      {
         return this._totalMilliseconds / MILLISECONDS_IN_MINUTE;
      }
      
      public function get totalSeconds() : Number
      {
         return this._totalMilliseconds / MILLISECONDS_IN_SECOND;
      }
      
      public function get totalMilliseconds() : Number
      {
         return this._totalMilliseconds;
      }
      
      public function add(date:Date) : Date
      {
         var ret:Date = new Date(date.time);
         ret.milliseconds += this.totalMilliseconds;
         return ret;
      }
   }
}
