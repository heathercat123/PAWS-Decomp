package levels.decorations
{
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.decorations.ChimneyDecorationSprite;
   import sprites.particles.ChimneySmokeParticleSprite;
   import states.LevelState;
   
   public class ChimneyDecoration extends Decoration
   {
       
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var type:int;
      
      protected var isOn:Boolean;
      
      public function ChimneyDecoration(_level:Level, _xPos:Number, _yPos:Number, _flip:int, _type:int, _isOn:int = 1)
      {
         super(_level,_xPos,_yPos);
         this.type = _type;
         if(_isOn > 0)
         {
            this.isOn = true;
         }
         else
         {
            this.isOn = false;
         }
         sprite = new ChimneyDecorationSprite();
         if(_type == 0)
         {
            sprite.gotoAndStop(1);
         }
         else
         {
            sprite.gotoAndStop(2);
         }
         if(this.isOn)
         {
            sprite.gfxHandleClip().gotoAndPlay(1);
         }
         else
         {
            sprite.gfxHandleClip().gotoAndStop(1);
         }
         if(_flip == 1)
         {
            sprite.scaleX = -1;
         }
         Utils.topWorld.addChild(sprite);
         this.counter1 = 0;
         this.counter2 = 0;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:ChimneySmokeParticleSprite = null;
         super.update();
         ++this.counter1;
         var vel_multiplier:Number = 1;
         if(this.counter1 > 0 && this.isOn)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_3_1_5)
            {
               this.counter1 = -30;
               vel_multiplier = 3;
            }
            else
            {
               this.counter1 = -((int(Math.random() * 3) + 2) * 30);
            }
            pSprite = new ChimneySmokeParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndPlay(1);
            }
            if(sprite.scaleX < 0)
            {
               level.topParticlesManager.pushParticle(pSprite,xPos - 6,yPos + 7,(Math.random() * 0.2 + 0.1) * vel_multiplier,0,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80);
            }
            else
            {
               level.topParticlesManager.pushParticle(pSprite,xPos + 6,yPos + 7,(Math.random() * 0.2 + 0.1) * vel_multiplier,0,1,Math.random() * Math.PI * 2,0,int(Math.random() * 2 + 1) * 80);
            }
         }
      }
   }
}
