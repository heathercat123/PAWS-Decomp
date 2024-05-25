package levels.backgrounds
{
   import levels.Level;
   import sprites.particles.GreenLeafBackgroundParticleSprite;
   import starling.core.Starling;
   
   public class WoodsBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var TYPE:int;
      
      public function WoodsBackground(_level:Level, _type:int = 0)
      {
         super(_level);
         this.TYPE = _type;
         Starling.current.stage.color = 0;
         this.pCounter = 0;
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      override public function particles(area:ParticleArea) : void
      {
         if(area.counter1++ > 0)
         {
            area.counter1 = -(Math.random() * 20 + 5);
            particlesManager.pushParticle(new GreenLeafBackgroundParticleSprite(),area.aabb.x + Math.random() * area.aabb.width,area.aabb.y,0,0,1,0,0.5 * int(Math.random() * 2));
         }
      }
      
      override public function shake() : void
      {
         var i:int = 0;
         var amount:int = Math.random() * 5 + 8;
         for(i = 0; i < amount; i++)
         {
            particlesManager.pushParticle(new GreenLeafBackgroundParticleSprite(),level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos - (Math.random() * 2 + 1) * 16,0,0,1,0,0.5 * int(Math.random() * 3));
         }
      }
   }
}
