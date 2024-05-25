package interfaces.dialogs
{
   import entities.*;
   import flash.geom.Point;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import starling.display.Button;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class DialogsManager
   {
       
      
      public var level:Level;
      
      public var dialogs:Array;
      
      public function DialogsManager(_level:Level)
      {
         super();
         this.level = _level;
         this.dialogs = new Array();
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this._onClick);
      }
      
      private function _onClick(event:TouchEvent) : void
      {
         var position:Point = null;
         if(this.level.stateMachine.currentState != "IS_CUTSCENE_STATE" || Utils.PauseOn)
         {
            return;
         }
         var touch:Touch = event.getTouch(Utils.rootStage);
         if(touch != null)
         {
            if(touch.target is Button)
            {
               return;
            }
            position = touch.getLocation(Utils.rootStage);
            if(touch.phase != "began")
            {
               if(touch.phase != "moved")
               {
                  if(touch.phase == "ended")
                  {
                     if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
                     {
                        this.level.hud.endContinue();
                     }
                     this.sendInputToDialogs();
                  }
               }
            }
         }
      }
      
      public function getDialogsAmount() : int
      {
         var i:int = 0;
         var amount:int = 0;
         for(i = 0; i < this.dialogs.length; i++)
         {
            if(this.dialogs[i] != null)
            {
               amount++;
            }
         }
         return amount;
      }
      
      public function restoreTextLabels() : void
      {
         var i:int = 0;
         for(i = 0; i < this.dialogs.length; i++)
         {
            if(this.dialogs[i] != null)
            {
               this.dialogs[i].dead = true;
               this.level.hud.top_container.removeChild(this.dialogs[i]);
               this.dialogs[i].destroy();
               this.dialogs[i].dispose();
               this.dialogs[i] = null;
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.dialogs.length; i++)
         {
            if(this.dialogs[i] != null)
            {
               this.level.hud.top_container.removeChild(this.dialogs[i]);
               this.dialogs[i].destroy();
               this.dialogs[i].dispose();
               this.dialogs[i] = null;
            }
         }
         this.dialogs = null;
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this._onClick);
         this.level = null;
      }
      
      public function createNarrationAt(_text:String, _xPos:Number = 0, _yPos:Number = 0, _time_alive:int = 60, _onComplete:Function = null, _delay:int = 0, _renderAll:Boolean = false) : void
      {
         Utils.LAST_DIALOG = Dialog.NO_SOUND;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new NarrationDialog(this.level,_xPos,_yPos,_text,_onComplete,_delay,null,_renderAll,_time_alive);
         this.level.hud.top_container.addChild(dialog);
         dialog.setPosition(_xPos,_yPos);
         this.dialogs.push(dialog);
      }
      
      public function createCaptionAt(_text:String, _xPos:Number = 0, _yPos:Number = 0, _onComplete:Function = null, _delay:int = 0, _renderAll:Boolean = false) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CaptionDialog(this.level,_xPos,_yPos,_text,_onComplete,_delay,null,false);
         this.level.hud.top_container.addChild(dialog);
         dialog.setPosition(_xPos,_yPos);
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createCaptionNoCameraAt(_text:String, _xPos:Number = 0, _yPos:Number = 0, _onComplete:Function = null, _delay:int = 0, _renderAll:Boolean = false) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CaptionDialog(this.level,_xPos,_yPos,_text,_onComplete,_delay,null,false);
         dialog.ABSOLUTE_POSITION = true;
         this.level.hud.top_container.addChild(dialog);
         dialog.setPosition(_xPos,_yPos);
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createBalloonAt(_text:String, _xPos:Number = 0, _yPos:Number = 0, _onComplete:Function = null, _delay:int = 0) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CharacterDialog(this.level,_xPos,_yPos,_text,_onComplete,_delay);
         this.level.hud.top_container.addChild(dialog);
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createTimedBalloonAt(_text:String, _xPos:Number = 0, _yPos:Number = 0, _time:int = 60, _delay:int = 0) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CharacterDialog(this.level,_xPos,_yPos,_text,null,_delay,null,false,_time);
         this.level.hud.top_container.addChild(dialog);
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createMoneyQuestionBalloonOn(_text:String, _entity:Entity, _onComplete:Function = null, _delay:int = 0, _onQuestionAnswered:Function = null, _price:int = -1) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CharacterDialog(this.level,_entity.xPos + _entity.getBalloonXOffset(),_entity.yPos + _entity.getBalloonYOffset(),_text,_onComplete,_delay,null,true,-1,_price);
         dialog.entity = _entity;
         dialog.setQuestionHandler(_onQuestionAnswered);
         this.level.hud.top_container.addChild(dialog);
         if(_entity.sprite == null)
         {
            dialog.setPosition(int(Math.floor(_entity.xPos - this.level.camera.xPos)) + _entity.getBalloonXOffset(),int(Math.floor(_entity.yPos - this.level.camera.yPos)) + _entity.getBalloonYOffset());
         }
         else
         {
            dialog.setPosition(_entity.sprite.x + _entity.getBalloonXOffset(),_entity.sprite.y + _entity.getBalloonYOffset());
         }
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createQuestionBalloonOn(_text:String, _entity:Entity, _onComplete:Function = null, _delay:int = 0, _onQuestionAnswered:Function = null) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CharacterDialog(this.level,_entity.xPos + _entity.getBalloonXOffset(),_entity.yPos + _entity.getBalloonYOffset(),_text,_onComplete,_delay,null,true);
         dialog.entity = _entity;
         dialog.setQuestionHandler(_onQuestionAnswered);
         this.level.hud.top_container.addChild(dialog);
         if(_entity.sprite == null)
         {
            dialog.setPosition(int(Math.floor(_entity.xPos - this.level.camera.xPos)) + _entity.getBalloonXOffset(),int(Math.floor(_entity.yPos - this.level.camera.yPos)) + _entity.getBalloonYOffset());
         }
         else
         {
            dialog.setPosition(_entity.sprite.x + _entity.getBalloonXOffset(),_entity.sprite.y + _entity.getBalloonYOffset());
         }
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createPriceBalloonOn(_text:String, _price:int, _entity:Entity, _onComplete:Function = null, _delay:int = 0, _onQuestionAnswered:Function = null) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         var dialog:Dialog = new CharacterDialog(this.level,_entity.xPos + _entity.getBalloonXOffset(),_entity.yPos + _entity.getBalloonYOffset(),_text,_onComplete,_delay,null,true,-1,_price);
         dialog.entity = _entity;
         dialog.setQuestionHandler(_onQuestionAnswered);
         this.level.hud.top_container.addChild(dialog);
         if(_entity.sprite == null)
         {
            dialog.setPosition(int(Math.floor(_entity.xPos - this.level.camera.xPos)) + _entity.getBalloonXOffset(),int(Math.floor(_entity.yPos - this.level.camera.yPos)) + _entity.getBalloonYOffset());
         }
         else
         {
            dialog.setPosition(_entity.sprite.x + _entity.getBalloonXOffset(),_entity.sprite.y + _entity.getBalloonYOffset());
         }
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createBalloonOn(_text:String, _entity:Entity, _onComplete:Function = null, _delay:int = 0, _sound:int = 0) : Dialog
      {
         if(this.level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            this.level.hud.resetCutsceneContinueTimer();
         }
         Utils.LAST_DIALOG = _sound;
         var dialog:Dialog = new CharacterDialog(this.level,_entity.xPos + _entity.getBalloonXOffset(),_entity.yPos + _entity.getBalloonYOffset(),_text,_onComplete,_delay);
         if(_entity is BrainEntity)
         {
            dialog.entity = _entity as BrainEntity;
         }
         this.level.hud.top_container.addChild(dialog);
         dialog.setPosition(_entity.sprite.x + _entity.getBalloonXOffset(),_entity.sprite.y + _entity.getBalloonYOffset());
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function createTutorialDialog(_text:String, _xPos:Number = 0, _yPos:Number = 0, _sprite:GameSprite = null) : Dialog
      {
         Utils.LAST_DIALOG = Dialog.SOUND_NORMAL;
         var dialog:Dialog = new CharacterDialog(this.level,_xPos,_yPos,_text,null,0,_sprite);
         this.level.hud.top_container.addChild(dialog);
         this.dialogs.push(dialog);
         return dialog;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.dialogs.length; i++)
         {
            if(this.dialogs[i] != null)
            {
               this.dialogs[i].update();
               if(this.dialogs[i].dead)
               {
                  this.level.hud.top_container.removeChild(this.dialogs[i]);
                  this.dialogs[i].destroy();
                  this.dialogs[i].dispose();
                  this.dialogs[i] = null;
               }
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.dialogs.length; i++)
         {
            if(this.dialogs[i] != null)
            {
               this.dialogs[i].updateScreenPosition(camera);
            }
         }
      }
      
      private function sendInputToDialogs() : void
      {
         var i:int = 0;
         for(i = 0; i < this.dialogs.length; i++)
         {
            if(this.dialogs[i] != null)
            {
               this.dialogs[i].processInput();
            }
         }
      }
   }
}
