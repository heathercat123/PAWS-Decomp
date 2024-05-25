package entities.enemies
{
   import levels.Level;
   import sprites.GameSprite;
   import sprites.particles.MetalBoltParticleSprite;
   import sprites.particles.MetalNutParticleSprite;
   
   public class TinEnemy extends Enemy
   {
       
      
      public function TinEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai);
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            SoundSystem.PlaySound("enemy_metal_hurt");
         }
      }
      
      override public function hit(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : void
      {
         var i:int = 0;
         var amount:int = 0;
         var pSprite:GameSprite = null;
         var vel_x:Number = NaN;
         var vel_mult:Number = NaN;
         super.hit(_source_x,_source_y);
         vel_mult = 1;
         if(Math.random() * 100 > 50)
         {
            amount = 2;
         }
         else if(Math.random() * 100 > 50)
         {
            amount = 3;
         }
         else
         {
            amount = 1;
         }
         if(_source_x > getMidXPos())
         {
            vel_mult = -1;
         }
         for(i = 0; i < amount; i++)
         {
            if(i % 2 == 0)
            {
               pSprite = new MetalNutParticleSprite();
            }
            else
            {
               pSprite = new MetalBoltParticleSprite();
            }
            pSprite.gfxHandleClip().gotoAndPlay(int(Math.random() * pSprite.gfxHandleClip().numFrames));
            vel_x = (Math.random() * 2 + 1) * vel_mult;
            if(vel_x < 0)
            {
               pSprite.scaleX = -1;
            }
            level.particlesManager.pushParticle(pSprite,getMidXPos(),getMidYPos(),vel_x,-(Math.random() * 2 + 1),0.98,int(5 + Math.random() * 15));
         }
      }
   }
}
