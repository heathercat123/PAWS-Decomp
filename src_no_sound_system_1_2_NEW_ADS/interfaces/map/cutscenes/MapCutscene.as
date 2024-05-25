package interfaces.map.cutscenes
{
   import interfaces.map.MapCamera;
   import interfaces.map.WorldMap;
   
   public class MapCutscene
   {
       
      
      public var worldMap:WorldMap;
      
      public var dead:Boolean;
      
      public var INDEX:int;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var PROGRESSION:int;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var t_start_y:Number;
      
      protected var t_diff_y:Number;
      
      protected var t_tick_y:Number;
      
      protected var t_time_y:Number;
      
      public function MapCutscene(_worldMap:WorldMap, _index:int = 0)
      {
         super();
         this.worldMap = _worldMap;
         this.dead = false;
         this.INDEX = _index;
         this.PROGRESSION = this.counter1 = this.counter2 = this.counter3 = 0;
         this.t_start = this.t_diff = this.t_tick = this.t_time = 0;
         this.t_start_y = this.t_diff_y = this.t_tick_y = this.t_time_y = 0;
      }
      
      public function update() : void
      {
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
      }
      
      public function destroy() : void
      {
         this.worldMap = null;
      }
   }
}
