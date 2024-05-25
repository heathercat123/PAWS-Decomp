package levels.cutscenes
{
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.behaviours.*;
   import levels.collisions.PinkBlockCollision;
   import states.LevelState;
   
   public class QuestionMarkCutscene extends Cutscene
   {
       
      
      protected var original_xPos:Number;
      
      protected var original_yPos:Number;
      
      protected var dest_xPos:Number;
      
      protected var dest_yPos:Number;
      
      protected var distance:Number;
      
      protected var time:Number;
      
      protected var pinkBlocks:Vector.<PinkBlockCollision>;
      
      protected var horTween:HorTweenShiftBehaviour;
      
      protected var verTween:VerTweenShiftBehaviour;
      
      protected var pink_block_index:int;
      
      public function QuestionMarkCutscene(_level:Level)
      {
         super(_level);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         ++counter1;
         if(PROGRESSION == 0)
         {
            if(counter1 >= 5)
            {
               level.freezeAction(-1);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 1)
         {
            if(counter1 >= 20)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 2)
         {
            this.time = this.distance / 96;
            if(this.time < 0.5)
            {
               this.time = 0.5;
            }
            else if(this.time >= 1)
            {
               this.time = 1;
            }
            this.horTween = new HorTweenShiftBehaviour(level);
            this.horTween.x_start = this.original_xPos;
            this.horTween.x_end = this.dest_xPos;
            this.horTween.tick = 0;
            this.horTween.time = this.time;
            this.verTween = new VerTweenShiftBehaviour(level);
            this.verTween.y_start = this.original_yPos;
            this.verTween.y_end = this.dest_yPos;
            this.verTween.tick = 0;
            this.horTween.time = this.time;
            level.camera.changeHorBehaviour(this.horTween,true);
            level.camera.changeVerBehaviour(this.verTween,true);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 3)
         {
            if(counter1 >= this.time * 60)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 4)
         {
            if(counter1 >= 15)
            {
               this.pinkBlocks[this.pink_block_index].appear();
               counter1 = 0;
               ++this.pink_block_index;
               if(this.pink_block_index >= this.pinkBlocks.length)
               {
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 5)
         {
            if(counter1 >= 15)
            {
               this.time = this.distance / 96;
               if(this.time < 0.5)
               {
                  this.time = 0.5;
               }
               else if(this.time >= 1)
               {
                  this.time = 1;
               }
               this.horTween = new HorTweenShiftBehaviour(level);
               this.horTween.x_start = this.dest_xPos;
               this.horTween.x_end = this.original_xPos;
               this.horTween.tick = 0;
               this.horTween.time = this.time;
               this.verTween = new VerTweenShiftBehaviour(level);
               this.verTween.y_start = this.dest_yPos;
               this.verTween.y_end = this.original_yPos;
               this.verTween.tick = 0;
               this.verTween.time = this.time;
               level.camera.changeHorBehaviour(this.horTween,true);
               level.camera.changeVerBehaviour(this.verTween,true);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 6)
         {
            if(counter1 >= int(this.time * 60 + 10))
            {
               level.setCameraBehaviours();
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 7)
         {
            Utils.FreezeOn = false;
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.initState();
         this.pink_block_index = 0;
         this.original_xPos = this.dest_xPos = level.camera.xPos;
         this.original_yPos = this.dest_yPos = level.camera.yPos;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_4_2)
         {
            this.dest_yPos = 312 - Utils.HEIGHT * 0.5;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_7_2)
         {
            this.dest_xPos = 408 - Utils.WIDTH * 0.5;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_2)
         {
            this.dest_xPos = 1216 - Utils.WIDTH * 0.5;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_7_4)
         {
            this.dest_xPos = 976 - Utils.WIDTH * 0.5;
         }
         var diff_x:Number = this.dest_xPos - this.original_xPos;
         var diff_y:Number = this.dest_yPos - this.original_yPos;
         this.distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         this.pinkBlocks = new Vector.<PinkBlockCollision>();
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is PinkBlockCollision)
               {
                  this.pinkBlocks.push(level.collisionsManager.collisions[i] as PinkBlockCollision);
               }
            }
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         var i:int = 0;
         super.overState();
         for(i = 0; i < this.pinkBlocks.length; i++)
         {
            this.pinkBlocks[i] = null;
         }
         this.pinkBlocks = null;
         this.horTween = null;
         this.verTween = null;
      }
   }
}
