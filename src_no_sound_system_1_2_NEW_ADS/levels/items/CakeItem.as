package levels.items
{
   import entities.enemies.*;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.*;
   import sprites.items.CakeItemSprite;
   import sprites.particles.ItemExplosionParticleSprite;
   
   public class CakeItem extends Item
   {
       
      
      protected var cake_index:int;
      
      public function CakeItem(_level:Level, _xPos:Number, _yPos:Number, _index:int)
      {
         super(_level,_xPos,_yPos,_index);
         this.cake_index = _index;
         sprite = new CakeItemSprite();
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         stateMachine.setState("IS_STANDING_STATE");
         var date:Date = new Date();
         if(date.hours % 4 != this.cake_index)
         {
            dead = true;
         }
         if((Utils.Slot.gameProgression[45] >> this.cake_index & 1) == 1)
         {
            dead = true;
         }
         if(Utils.Slot.gameProgression[44] < 2)
         {
            dead = true;
         }
      }
      
      override public function update() : void
      {
         if(stateMachine.currentState == "IS_COLLECTED_STATE")
         {
            stateMachine.performAction("END_ACTION");
            if(isInsideSoundScreen())
            {
               SoundSystem.PlaySound("item_pop");
            }
            level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos + WIDTH * 0.5,yPos + 5,0,0,0);
         }
      }
      
      override protected function collectedAnimation() : void
      {
         counter_1 = 0;
         counter_2 = 0;
         tick_1 = 0;
         SoundSystem.PlaySound("pot_collected");
         Utils.Slot.gameProgression[45] |= 1 << this.cake_index;
         SaveManager.SaveGameProgression();
      }
   }
}
