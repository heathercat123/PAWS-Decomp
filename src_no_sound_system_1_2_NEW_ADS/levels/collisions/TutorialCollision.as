package levels.collisions
{
   import flash.geom.Rectangle;
   import interfaces.Hud;
   import interfaces.dialogs.Dialog;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.TutorialCollisionSprite;
   import sprites.tutorials.TutorialSprite;
   
   public class TutorialCollision extends Collision
   {
       
      
      protected var TYPE:int;
      
      protected var IS_TUTORIAL_ON:Boolean;
      
      protected var dialog:Dialog;
      
      protected var tutorial_id:int;
      
      public function TutorialCollision(_level:Level, _xPos:Number, _yPos:Number, _id:int, _type:int)
      {
         this.TYPE = _type;
         super(_level,_xPos,_yPos);
         sprite = new TutorialCollisionSprite(this.TYPE);
         Utils.backWorld.addChild(sprite);
         this.tutorial_id = _id;
         aabb.x = -32;
         aabb.y = -16;
         aabb.width = 80;
         aabb.height = 24;
         if(this.tutorial_id == 0)
         {
            aabb.x -= 16;
         }
         this.IS_TUTORIAL_ON = false;
         this.dialog = null;
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(sprite);
         this.dialog = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.dialog != null)
         {
            if(this.dialog.dead == false)
            {
               this.dialog.update();
               if(this.dialog.stateMachine.currentState == "IS_DESTROY_STATE")
               {
                  this.IS_TUTORIAL_ON = false;
                  Utils.gameMovie.removeChild(this.dialog);
                  this.dialog.destroy();
                  this.dialog.dispose();
                  this.dialog = null;
               }
            }
            else
            {
               this.dialog = null;
               this.IS_TUTORIAL_ON = false;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.dialog != null)
         {
            this.dialog.x = sprite.x + 8;
            this.dialog.y = sprite.y - 12;
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(level.level_tick < 30)
         {
            return;
         }
         if(Hud.SET_HUD_INVISIBLE || this.TYPE == 1)
         {
            return;
         }
         var aabb_1:Rectangle = level.hero.getAABB();
         var aabb_2:Rectangle = getAABB();
         if(level.hero.getAABB().intersects(getAABB()))
         {
            if(!this.IS_TUTORIAL_ON)
            {
               this.IS_TUTORIAL_ON = true;
               if(this.tutorial_id == 0)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(0));
               }
               else if(this.tutorial_id == 1)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(1));
               }
               else if(this.tutorial_id == 2)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(2));
               }
               else if(this.tutorial_id == 3)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(3));
               }
               else if(this.tutorial_id == 4)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(4));
               }
               else if(this.tutorial_id == 5)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(5));
               }
               else if(this.tutorial_id == 6)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(6));
               }
               else if(this.tutorial_id == 7)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(7));
               }
               else if(this.tutorial_id == 8)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(8));
               }
               else if(this.tutorial_id == 10)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(9));
               }
               else if(this.tutorial_id == 11)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,null);
               }
               else if(this.tutorial_id == 12)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(10));
               }
               else if(this.tutorial_id == 13)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(10));
               }
               else if(this.tutorial_id == 14)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(11));
               }
               else if(this.tutorial_id == 15)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,null);
               }
               else if(this.tutorial_id == 16)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(12));
               }
               else if(this.tutorial_id == 17)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(13));
               }
               else if(this.tutorial_id == 18)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(16));
               }
               else if(this.tutorial_id == 19)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(17));
               }
               else if(this.tutorial_id == 20)
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(18));
               }
               else
               {
                  this.dialog = level.hud.dialogsManager.createTutorialDialog(StringsManager.GetString("tutorial_" + this.tutorial_id),xPos + 8,yPos - 12,new TutorialSprite(0));
               }
            }
         }
         else if(this.IS_TUTORIAL_ON)
         {
            if(this.dialog != null)
            {
               this.dialog.endRendering();
            }
         }
      }
   }
}
