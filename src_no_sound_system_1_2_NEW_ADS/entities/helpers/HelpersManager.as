package entities.helpers
{
   import entities.Entity;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import sprites.particles.ItemExplosionParticleSprite;
   
   public class HelpersManager
   {
       
      
      public var level:Level;
      
      public var helpers:Array;
      
      public var helper:Helper;
      
      protected var LAST_EQUIPPED_HELPER_ID:int;
      
      protected var delay_init:int;
      
      public function HelpersManager(_level:Level)
      {
         var i:int = 0;
         super();
         this.level = _level;
         this.delay_init = 0;
         this.LAST_EQUIPPED_HELPER_ID = Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED];
         this.helper = null;
         this.helpers = new Array();
         this.helpers.push(new SeedHelper(this.level,this.level.scriptsManager.initialXPos,this.level.scriptsManager.initialYPos,Entity.RIGHT));
         this.helpers.push(new CloudHelper(this.level,this.level.scriptsManager.initialXPos,this.level.scriptsManager.initialYPos,Entity.RIGHT));
         this.helpers.push(new JellyfishHelper(this.level,this.level.scriptsManager.initialXPos,this.level.scriptsManager.initialYPos,Entity.RIGHT));
         this.helpers.push(new CupidHelper(this.level,this.level.scriptsManager.initialXPos,this.level.scriptsManager.initialYPos,Entity.RIGHT));
         this.helpers.push(new GoldenBatHelper(this.level,this.level.scriptsManager.initialXPos,this.level.scriptsManager.initialYPos,Entity.RIGHT));
         this.helpers.push(new RockHelper(this.level,this.level.scriptsManager.initialXPos,this.level.scriptsManager.initialYPos,Entity.RIGHT));
         for(i = 0; i < this.helpers.length; i++)
         {
            this.helpers[i].setInvisible();
         }
         this.helper = null;
      }
      
      public static function InventoryIndexToArrayIndex(_inventory_index:int) : int
      {
         return _inventory_index - 400;
      }
      
      public static function ArrayIndexToInventoryIndex(_array_index:int) : int
      {
         return _array_index + 400;
      }
      
      public function postInit() : void
      {
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.helpers.length; i++)
         {
            if(this.helpers[i] != null)
            {
               this.helpers[i].destroy();
               this.helpers[i] = null;
            }
         }
         this.helper = null;
         this.helpers = null;
         this.level = null;
      }
      
      public function flyAway() : void
      {
         if(this.helper != null)
         {
            this.helper.stateMachine.setState("IS_FLYING_AWAY_STATE");
         }
      }
      
      public function changeHelper(index:int, _isLevelStart:Boolean = false) : void
      {
         var _x_pos:Number = NaN;
         var _y_pos:Number = NaN;
         if(this.helper != null)
         {
            this.helper.setInvisible();
         }
         if(index == LevelItems.ITEM_HELPER_COCONUT)
         {
            this.helper = this.helpers[0];
         }
         else if(index == LevelItems.ITEM_HELPER_CLOUD)
         {
            this.helper = this.helpers[1];
         }
         else if(index == LevelItems.ITEM_HELPER_CUPID)
         {
            this.helper = this.helpers[3];
         }
         else if(index == LevelItems.ITEM_HELPER_BAT)
         {
            this.helper = this.helpers[4];
         }
         else if(index == LevelItems.ITEM_HELPER_ROCK)
         {
            this.helper = this.helpers[5];
         }
         else
         {
            this.helper = this.helpers[2];
         }
         if(this.level.hero.DIRECTION == Entity.RIGHT)
         {
            _x_pos = this.level.hero.xPos - Utils.TILE_WIDTH;
         }
         else
         {
            _x_pos = this.level.hero.xPos + this.level.hero.WIDTH + Utils.TILE_WIDTH;
         }
         _y_pos = this.level.hero.yPos - Utils.TILE_HEIGHT;
         this.helper.xPos = _x_pos;
         this.helper.yPos = _y_pos;
         this.helper.setActive();
         if(!_isLevelStart)
         {
            SoundSystem.PlaySound("item_pop");
            this.level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),_x_pos,_y_pos,0,0,0);
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         var change_helper_flag:Boolean = false;
         if(this.delay_init >= 0)
         {
            if(this.delay_init++ == 1)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != 0)
               {
                  this.changeHelper(this.LAST_EQUIPPED_HELPER_ID,true);
               }
               else
               {
                  this.helper = null;
               }
               this.delay_init = -1;
            }
         }
         else
         {
            change_helper_flag = false;
            if(this.LAST_EQUIPPED_HELPER_ID != Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED])
            {
               change_helper_flag = true;
            }
            else if(this.helper != null)
            {
               if(Utils.Slot.playerInventory[this.LAST_EQUIPPED_HELPER_ID] > this.helper.LEVEL)
               {
                  change_helper_flag = true;
               }
            }
            if(change_helper_flag)
            {
               this.LAST_EQUIPPED_HELPER_ID = Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED];
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != 0)
               {
                  this.changeHelper(this.LAST_EQUIPPED_HELPER_ID);
               }
               else
               {
                  if(this.helper != null)
                  {
                     this.helper.setDisappear();
                  }
                  this.helper = null;
               }
            }
         }
         if(this.helper != null)
         {
            this.helper.update();
         }
      }
      
      public function startCutscene() : void
      {
         if(this.helper != null)
         {
            this.helper.stateMachine.setState("IS_CUTSCENE_STATE");
         }
      }
      
      public function endCutscene() : void
      {
         if(this.helper != null)
         {
            this.helper.stateMachine.performAction("END_ACTION");
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         if(this.helper != null)
         {
            this.helper.updateScreenPosition(camera);
         }
      }
      
      public function shake() : void
      {
         var i:int = 0;
         if(this.helper != null)
         {
            this.helper.shake();
         }
      }
   }
}
