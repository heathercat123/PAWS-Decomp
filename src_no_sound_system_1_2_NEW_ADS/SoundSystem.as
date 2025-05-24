package
{
   import flash.display.*;
   import flash.events.*;
   import flash.media.*;
   import flash.utils.*;
   
   public class SoundSystem
   {
      
      public static var sounds:Array;
      
      public static var _soundTransform:SoundTransform;
      
      public static var soundChannel:SoundChannel;
      
      public static var _musicTransform:SoundTransform;
      
      public static var musicChannel:SoundChannel;
      
      public static var musicTimer:Timer;
      
	  // Files themselves -> Renamed via stdrename + BRU
	  // All of those embed statement below -> Half an hour of manual work
      [Embed(source="../sfx/sounds/cat_brake.mp3")]
      public static var SoundCatBrake:Class;
      public static var soundCatBrake:Sound;
      
      [Embed(source="../sfx/sounds/cat_brake_low.mp3")] // Of course, instead of lowering the pitch on the fly, just make it another sound!
      public static var SoundCatBrakeLow:Class;
      public static var soundCatBrakeLow:Sound;
      
      [Embed(source="../sfx/sounds/cat_hurt.mp3")]
      public static var SoundCatHurt:Class;
      public static var soundCatHurt:Sound;
      
      [Embed(source="../sfx/sounds/cat_hurt_game_over.mp3")]
      public static var SoundCatHurtGameOver:Class;
      public static var soundCatHurtGameOver:Sound;
      
      [Embed(source="../sfx/sounds/cat_run.mp3")]
      public static var SoundCatRun:Class;
      public static var soundCatRun:Sound;
      
      [Embed(source="../sfx/sounds/cat_run_low.mp3")] // Same here!
      public static var SoundCatRunLow:Class;
      public static var soundCatRunLow:Sound;
      
      [Embed(source="../sfx/sounds/cat_jump.mp3")]
      public static var SoundCatJump:Class;
      public static var soundCatJump:Sound;
      
      [Embed(source="../sfx/sounds/cat_headbutt.mp3")]
      public static var SoundCatHeadbutt:Class;
      public static var soundCatHeadbutt:Sound;
      
      [Embed(source="../sfx/sounds/water.mp3")]
      public static var SoundWater:Class;
      public static var soundWater:Sound;
      
      [Embed(source="../sfx/sounds/water_splash.mp3")]
      public static var SoundWaterSplash:Class;
      public static var soundWaterSplash:Sound;
      
      [Embed(source="../sfx/sounds/ice_slide.mp3")]
      public static var SoundIceSlide:Class;
      public static var soundIceSlide:Sound;
      
      [Embed(source="../sfx/sounds/cat_falls_ground.mp3")] // Does the cat fall ON the ground or does it fall the ground?
      public static var SoundCatFallsGround:Class;
      public static var soundCatFallsGround:Sound;
      
      [Embed(source="../sfx/sounds/cat_jump_low.mp3")]
      public static var SoundCatJumpLow:Class;
      public static var soundCatJumpLow:Sound;
      
      [Embed(source="../sfx/sounds/cat_hop_low.mp3")]
      public static var SoundCatHopLow:Class;
      public static var soundCatHopLow:Sound;
      
      [Embed(source="../sfx/sounds/cat_falls_ground_low.mp3")] // Low pitch, not low ground!
      public static var SoundCatFallsGroundLow:Class;
      public static var soundCatFallsGroundLow:Sound;
      
      [Embed(source="../sfx/sounds/cat_ground_impact.mp3")]
      public static var SoundCatGroundImpact:Class;
      public static var soundCatGroundImpact:Sound;
      
      [Embed(source="../sfx/sounds/dark_cat.mp3")] // That's the 'going in the dark' sound and not Kuro's meow
      public static var SoundDarkCat:Class;
      public static var soundDarkCat:Sound;
      
      [Embed(source="../sfx/sounds/grey_cat_victory_jump.mp3")] // Hop. It's called a hop.
      public static var SoundGreyCatVictoryJump:Class;
      public static var soundGreyCatVictoryJump:Sound;
      
      [Embed(source="../sfx/sounds/cat_super_jump.mp3")]
      public static var SoundCatSuperJump:Class;
      public static var soundCatSuperJump:Sound;
      
      [Embed(source="../sfx/sounds/cat_super_jump_low.mp3")]
      public static var SoundCatSuperJumpLow:Class;
      public static var soundCatSuperJumpLow:Sound;
      
      [Embed(source="../sfx/sounds/cat_yawn.mp3")]
      public static var SoundCatYawn:Class;
      public static var soundCatYawn:Sound;
      
      [Embed(source="../sfx/sounds/blink.mp3")]
      public static var SoundBlink:Class;
      public static var soundBlink:Sound;
      
      [Embed(source="../sfx/sounds/item_bell_collected.mp3")]
      public static var SoundItemBellCollected:Class;
      public static var soundItemBellCollected:Sound;
      
      [Embed(source="../sfx/sounds/butterflies_appear.mp3")]
      public static var SoundButterfliesAppear:Class;
      public static var soundButterfliesAppear:Sound;
      
      [Embed(source="../sfx/sounds/item_coin.mp3")]
      public static var SoundItemCoin:Class;
      public static var soundItemCoin:Sound;
      
      [Embed(source="../sfx/sounds/item_impact.mp3")]
      public static var SoundItemImpact:Class;
      public static var soundItemImpact:Sound;
      
      [Embed(source="../sfx/sounds/item_impact_water.mp3")]
      public static var SoundItemImpactWater:Class;
      public static var soundItemImpactWater:Sound;
      
      [Embed(source="../sfx/sounds/bell_collected.mp3")]
      public static var SoundBellCollected:Class;
      public static var soundBellCollected:Sound;
      
      [Embed(source="../sfx/sounds/item_appear.mp3")]
      public static var SoundItemAppear:Class;
      public static var soundItemAppear:Sound;
      
      [Embed(source="../sfx/sounds/item_pop.mp3")]
      public static var SoundItemPop:Class;
      public static var soundItemPop:Sound;
      
      [Embed(source="../sfx/sounds/pot_collected.mp3")]
      public static var SoundPotCollected:Class;
      public static var soundPotCollected:Sound;
      
      [Embed(source="../sfx/sounds/pot_pop.mp3")]
      public static var SoundBottlePop:Class;
      public static var soundPotPop:Sound;
      
      [Embed(source="../sfx/sounds/butterfly_collect_1.mp3")]
      public static var SoundButterflyCollected1:Class;
      public static var soundButterflyCollected1:Sound;
      
      [Embed(source="../sfx/sounds/butterfly_collect_2.mp3")]
      public static var SoundButterflyCollected2:Class;
      public static var soundButterflyCollected2:Sound;
      
      [Embed(source="../sfx/sounds/butterfly_collect_3.mp3")]
      public static var SoundButterflyCollected3:Class;
      public static var soundButterflyCollected3:Sound;
      
      [Embed(source="../sfx/sounds/butterfly_collect_4.mp3")]
      public static var SoundButterflyCollected4:Class;
      public static var soundButterflyCollected4:Sound;
      
      [Embed(source="../sfx/sounds/butterfly_collect_5.mp3")]
      public static var SoundButterflyCollected5:Class;
      public static var soundButterflyCollected5:Sound;
      
      [Embed(source="../sfx/sounds/red_coin.mp3")]
      public static var SoundRedCoin:Class;
      public static var soundRedCoin:Sound;
      
      [Embed(source="../sfx/sounds/door_close.mp3")]
      public static var SoundDoorClose:Class;
      public static var soundDoorClose:Sound;
      
      [Embed(source="../sfx/sounds/door_open.mp3")]
      public static var SoundDoorOpen:Class;
      public static var soundDoorOpen:Sound;
      
      [Embed(source="../sfx/sounds/brick_destroyed_1.mp3")]
      public static var SoundBrickDestroyed1:Class;
      public static var soundBrickDestroyed1:Sound;
      
      [Embed(source="../sfx/sounds/brick_destroyed_2.mp3")]
      public static var SoundBrickDestroyed2:Class;
      public static var soundBrickDestroyed2:Sound;
      
      [Embed(source="../sfx/sounds/brick_created.mp3")]
      public static var SoundBrickCreated:Class;
      public static var soundBrickCreated:Sound;
      
      [Embed(source="../sfx/sounds/blue_platform.mp3")]
      public static var SoundBluePlatform:Class;
      public static var soundBluePlatform:Sound;
      
      [Embed(source="../sfx/sounds/bone.mp3")]
      public static var SoundBone:Class;
      public static var soundBone:Sound;
      
      [Embed(source="../sfx/sounds/fire_ball_shoot.mp3")]
      public static var SoundFireBallShoot:Class;
      public static var soundFireBallShoot:Sound;
      
      [Embed(source="../sfx/sounds/geyser.mp3")]
      public static var SoundGeyser:Class;
      public static var soundGeyser:Sound;
      
      [Embed(source="../sfx/sounds/ice_shake.mp3")]
      public static var SoundIceShake:Class;
      public static var soundIceShake:Sound;
      
      [Embed(source="../sfx/sounds/ice_impact.mp3")]
      public static var SoundIceImpact:Class;
      public static var soundIceImpact:Sound;
      
      [Embed(source="../sfx/sounds/lever.mp3")]
      public static var SoundLever:Class;
      public static var soundLever:Sound;
      
      [Embed(source="../sfx/sounds/mud.mp3")]
      public static var SoundMud:Class;
      public static var soundMud:Sound;
      
      [Embed(source="../sfx/sounds/red_platform.mp3")]
      public static var SoundRedPlatform:Class;
      public static var soundRedPlatform:Sound;
      
      [Embed(source="../sfx/sounds/crate.mp3")]
      public static var SoundCrate:Class;
      public static var soundCrate:Sound;
      
      [Embed(source="../sfx/sounds/explosion_big.mp3")]
      public static var SoundExplosionBig:Class;
      public static var soundExplosionBig:Sound;
      
      [Embed(source="../sfx/sounds/explosion_medium.mp3")]
      public static var SoundExplosionMedium:Class;
      public static var soundExplosionMedium:Sound;
      
      [Embed(source="../sfx/sounds/explosion_small.mp3")]
      public static var SoundExplosionSmall:Class;
      public static var soundExplosionSmall:Sound;
      
      [Embed(source="../sfx/sounds/clod.mp3")]
      public static var SoundClod:Class;
      public static var soundClod:Sound;
      
      [Embed(source="../sfx/sounds/sand_pit.mp3")]
      public static var SoundSandPit:Class;
      public static var soundSandPit:Sound;
      
      [Embed(source="../sfx/sounds/log_collision.mp3")]
      public static var SoundLogCollision:Class;
      public static var soundLogCollision:Sound;
      
      [Embed(source="../sfx/sounds/mud_slide.mp3")]
      public static var SoundMudSlide:Class;
      public static var soundMudSlide:Sound;
      
      [Embed(source="../sfx/sounds/impact_small.mp3")]
      public static var SoundImpactSmall:Class;
      public static var soundImpactSmall:Sound;
      
      [Embed(source="../sfx/sounds/impact_big.mp3")]
      public static var SoundImpactBig:Class;
      public static var soundImpactBig:Sound;
      
      [Embed(source="../sfx/sounds/chain_rattle.mp3")]
      public static var SoundChainRattle:Class;
      public static var soundChainRattle:Sound;
      
      [Embed(source="../sfx/sounds/woosh.mp3")]
      public static var SoundWoosh:Class;
      public static var soundWoosh:Sound;
      
      [Embed(source="../sfx/sounds/woosh_low.mp3")]
      public static var SoundWooshLow:Class;
      public static var soundWooshLow:Sound;
      
      [Embed(source="../sfx/sounds/gate_open.mp3")]
      public static var SoundGateOpen:Class;
      public static var soundGateOpen:Sound;
      
      [Embed(source="../sfx/sounds/fire_1.mp3")]
      public static var SoundFire1:Class;
      public static var soundFire1:Sound;
      
      [Embed(source="../sfx/sounds/fire_2.mp3")]
      public static var SoundFire2:Class;
      public static var soundFire2:Sound;
      
      [Embed(source="../sfx/sounds/explosion_distance.mp3")]
      public static var SoundExplosionDistance:Class;
      public static var soundExplosionDistance:Sound;
      
      [Embed(source="../sfx/sounds/brick_destroyed_echo.mp3")]
      public static var SoundBrickDestroyedEcho:Class;
      public static var soundBrickDestroyedEcho:Sound;
      
      [Embed(source="../sfx/sounds/fence_exit.mp3")]
      public static var SoundFenceExit:Class;
      public static var soundFenceExit:Sound;
      
      [Embed(source="../sfx/sounds/car_engine.mp3")]
      public static var SoundCarEngine:Class;
      public static var soundCarEngine:Sound;
      
      [Embed(source="../sfx/sounds/skid.mp3")]
      public static var SoundSkid:Class;
      public static var soundSkid:Sound;
      
      [Embed(source="../sfx/sounds/car_engine_first.mp3")]
      public static var SoundCarEngineFirst:Class;
      public static var soundCarEngineFirst:Sound;
      
      [Embed(source="../sfx/sounds/ice_melt.mp3")]
      public static var SoundIceMelt:Class;
      public static var soundIceMelt:Sound;
      
      [Embed(source="../sfx/sounds/hero_cannon.mp3")]
      public static var SoundHeroCannon:Class;
      public static var soundHeroCannon:Sound;
      
      [Embed(source="../sfx/sounds/cat_angry.mp3")]
      public static var SoundCatAngry:Class;
      public static var soundCatAngry:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_engine.mp3")]
      public static var SoundVehicleEngine:Class;
      public static var soundVehicleEngine:Sound;
      
      [Embed(source="../sfx/sounds/phone.mp3")]
      public static var SoundPhone:Class;
      public static var soundPhone:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_stop.mp3")]
      public static var SoundVehicleStop:Class;
      public static var soundVehicleStop:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_engine_up.mp3")]
      public static var SoundVehicleEngineUp:Class;
      public static var soundVehicleEngineUp:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_turn_off.mp3")]
      public static var SoundVehicleTurnOff:Class;
      public static var soundVehicleTurnOff:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_turn_on.mp3")]
      public static var SoundVehicleTurnOn:Class;
      public static var soundVehicleTurnOn:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_cannon.mp3")]
      public static var SoundVehicleCannon:Class;
      public static var soundVehicleCannon:Sound;
      
      [Embed(source="../sfx/sounds/vehicle_reload.mp3")]
      public static var SoundVehicleReload:Class;
      public static var soundVehicleReload:Sound;
      
      [Embed(source="../sfx/sounds/enemy_bullet.mp3")]
      public static var SoundEnemyBullet:Class;
      public static var soundEnemyBullet:Sound;
      
      [Embed(source="../sfx/sounds/enemy_hurt.mp3")]
      public static var SoundEnemyHurt:Class;
      public static var soundEnemyHurt:Sound;
      
      [Embed(source="../sfx/sounds/big_enemy_hurt.mp3")]
      public static var SoundBigEnemyHurt:Class;
      public static var soundBigEnemyHurt:Sound;
      
      [Embed(source="../sfx/sounds/ground_stomp.mp3")]
      public static var SoundGroundStomp:Class;
      public static var soundGroundStomp:Sound;
      
      [Embed(source="../sfx/sounds/dust_enemy.mp3")]
      public static var SoundDustEnemy:Class;
      public static var soundDustEnemy:Sound;
      
      [Embed(source="../sfx/sounds/metal_enemy_hurt_a.mp3")]
      public static var SoundMetalEnemyHurtA:Class;
      public static var soundMetalEnemyHurtA:Sound;
      
      [Embed(source="../sfx/sounds/metal_enemy_hurt_b.mp3")]
      public static var SoundMetalEnemyHurtB:Class;
      public static var soundMetalEnemyHurtB:Sound;
      
      [Embed(source="../sfx/sounds/metal_big_enemy_hurt_a.mp3")]
      public static var SoundMetalBigEnemyHurtA:Class;
      public static var soundMetalBigEnemyHurtA:Sound;
      
      [Embed(source="../sfx/sounds/metal_enemy_jump.mp3")]
      public static var SoundMetalEnemyJump:Class;
      public static var soundMetalEnemyJump:Sound;
      
      [Embed(source="../sfx/sounds/dig.mp3")]
      public static var SoundDig:Class;
      public static var soundDig:Sound;
      
      [Embed(source="../sfx/sounds/enemy_jump.mp3")]
      public static var SoundEnemyJump:Class;
      public static var soundEnemyJump:Sound;
      
      [Embed(source="../sfx/sounds/enemy_brake.mp3")]
      public static var SoundEnemyBrake:Class;
      public static var soundEnemyBrake:Sound;
      
      [Embed(source="../sfx/sounds/giant_turnip_defeat.mp3")]
      public static var SoundGiantTurnipDefeat:Class;
      public static var soundGiantTurnipDefeat:Sound;
      
      [Embed(source="../sfx/sounds/big_enemy_hit.mp3")]
      public static var SoundBigEnemyHit:Class;
      public static var soundBigEnemyHit:Sound;
      
      [Embed(source="../sfx/sounds/frog_1.mp3")]
      public static var SoundFrog1:Class;
      public static var soundFrog1:Sound;
      
      [Embed(source="../sfx/sounds/frog_2.mp3")]
      public static var SoundFrog2:Class;
      public static var soundFrog2:Sound;
      
      [Embed(source="../sfx/sounds/enemy_water.mp3")]
      public static var SoundEnemyWater:Class;
      public static var soundEnemyWater:Sound;
      
      [Embed(source="../sfx/sounds/giant_fish_roar.mp3")]
      public static var SoundGiantFishRoar:Class;
      public static var soundGiantFishRoar:Sound;
      
      [Embed(source="../sfx/sounds/giant_fish_swoosh.mp3")]
      public static var SoundGiantFishSwoosh:Class;
      public static var soundGiantFishSwoosh:Sound;
      
      [Embed(source="../sfx/sounds/enemy_run.mp3")]
      public static var SoundEnemyRun:Class;
      public static var soundEnemyRun:Sound;
      
      [Embed(source="../sfx/sounds/beam_start.mp3")]
      public static var SoundBeamStart:Class;
      public static var soundBeamStart:Sound;
      
      [Embed(source="../sfx/sounds/beam_shoot.mp3")]
      public static var SoundBeamShoot:Class;
      public static var soundBeamShoot:Sound;
      
      [Embed(source="../sfx/sounds/beam_repeat.mp3")]
      public static var SoundBeamRepeat:Class;
      public static var soundBeamRepeat:Sound;
      
      [Embed(source="../sfx/sounds/dragon_wing.mp3")]
      public static var SoundDragonWing:Class;
      public static var soundDragonWing:Sound;
      
      [Embed(source="../sfx/sounds/enemy_ice_slide.mp3")]
      public static var SoundEnemyIceSlide:Class;
      public static var soundEnemyIceSlide:Sound;
      
      [Embed(source="../sfx/sounds/ghost_scared.mp3")]
      public static var SoundGhostScared:Class;
      public static var soundGhostScared:Sound;
      
      [Embed(source="../sfx/sounds/tongue.mp3")]
      public static var SoundTongue:Class;
      public static var soundTongue:Sound;
      
      [Embed(source="../sfx/sounds/decoration_blown.mp3")]
      public static var SoundDecorationBlown:Class;
      public static var soundDecorationBlown:Sound;
      
      [Embed(source="../sfx/sounds/bird_flying.mp3")]
      public static var SoundBirdFlying:Class;
      public static var soundBirdFlying:Sound;
      
      [Embed(source="../sfx/sounds/chirp_1.mp3")]
      public static var SoundChirp1:Class;
      public static var soundChirp1:Sound;
      
      [Embed(source="../sfx/sounds/chirp_2.mp3")]
      public static var SoundChirp2:Class;
      public static var soundChirp2:Sound;
      
      [Embed(source="../sfx/sounds/loud_chirp.mp3")]
      public static var SoundLoudChirp:Class;
      public static var soundLoudChirp:Sound;
      
      [Embed(source="../sfx/sounds/giant_spaceship.mp3")]
      public static var SoundGiantSpaceship:Class;
      public static var soundGiantSpaceship:Sound;
      
      [Embed(source="../sfx/sounds/wind_breeze.mp3")]
      public static var SoundWindBreeze:Class;
      public static var soundWindBreeze:Sound;
      
      [Embed(source="../sfx/sounds/flyingship_distance.mp3")]
      public static var SoundFlyingshipDistance:Class;
      public static var soundFlyingshipDistance:Sound;
      
      [Embed(source="../sfx/sounds/flyingship_distance_first.mp3")]
      public static var SoundFlyingshipDistanceFirst:Class;
      public static var soundFlyingshipDistanceFirst:Sound;
      
      [Embed(source="../sfx/sounds/flyingship_malfunction.mp3")]
      public static var SoundFlyingshipMalfunction:Class;
      public static var soundFlyingshipMalfunction:Sound;
      
      [Embed(source="../sfx/sounds/flyingship_fall_down.mp3")]
      public static var SoundFlyingshipFallDown:Class;
      public static var soundFlyingshipFallDown:Sound;
      
      [Embed(source="../sfx/sounds/alarm.mp3")]
      public static var SoundAlarm:Class;
      public static var soundAlarm:Sound;
      
      [Embed(source="../sfx/sounds/crystal_ambience.mp3")]
      public static var SoundCrystalAmbience:Class;
      public static var soundCrystalAmbience:Sound;
      
      [Embed(source="../sfx/sounds/magic_disappear.mp3")]
      public static var SoundMagicDisappear:Class;
      public static var soundMagicDisappear:Sound;
      
      [Embed(source="../sfx/sounds/quake.mp3")]
      public static var SoundQuake:Class;
      public static var soundQuake:Sound;
      
      [Embed(source="../sfx/sounds/quake_fade.mp3")]
      public static var SoundQuakeFade:Class;
      public static var soundQuakeFade:Sound;
      
      [Embed(source="../sfx/sounds/boat_horn.mp3")]
      public static var SoundBoatHorn:Class;
      public static var soundBoatHorn:Sound;
      
      [Embed(source="../sfx/sounds/wind_strong_start.mp3")]
      public static var SoundWindStrongStart:Class;
      public static var soundWindStrongStart:Sound;
      
      [Embed(source="../sfx/sounds/wind_strong_mid.mp3")]
      public static var SoundWindStrongMid:Class;
      public static var soundWindStrongMid:Sound;
      
      [Embed(source="../sfx/sounds/wind_strong_end.mp3")]
      public static var SoundWindStrongEnd:Class;
      public static var soundWindStrongEnd:Sound;
      
      [Embed(source="../sfx/sounds/small_quake.mp3")]
      public static var SoundSmallQuake:Class;
      public static var soundSmallQuake:Sound;
      
      [Embed(source="../sfx/sounds/train_track.mp3")]
      public static var SoundTrainTrack:Class;
      public static var soundTrainTrack:Sound;
      
      [Embed(source="../sfx/sounds/train_track_slow.mp3")]
      public static var SoundTrainTrackSlow:Class;
      public static var soundTrainTrackSlow:Sound;
      
      [Embed(source="../sfx/sounds/train_whistle.mp3")]
      public static var SoundTrainWhistle:Class;
      public static var soundTrainWhistle:Sound;
      
      [Embed(source="../sfx/sounds/crystal_appear.mp3")]
      public static var SoundCrystalAppear:Class;
      public static var soundCrystalAppear:Sound;
      
      [Embed(source="../sfx/sounds/logo.mp3")]
      public static var SoundLogo:Class;
      public static var soundLogo:Sound;
      
      [Embed(source="../sfx/sounds/blip.mp3")]
      public static var SoundBlip:Class;
      public static var soundBlip:Sound;
      
      [Embed(source="../sfx/sounds/select.mp3")]
      public static var SoundSelect:Class;
      public static var soundSelect:Sound;
      
      [Embed(source="../sfx/sounds/font_1.mp3")]
      public static var SoundFont1:Class;
      public static var soundFont1:Sound;
      
      [Embed(source="../sfx/sounds/font_2.mp3")]
      public static var SoundFont2:Class;
      public static var soundFont2:Sound;
      
      [Embed(source="../sfx/sounds/font_3.mp3")]
      public static var SoundFont3:Class;
      public static var soundFont3:Sound;
      
      [Embed(source="../sfx/sounds/confirm_long.mp3")]
      public static var SoundConfirmLong:Class;
      public static var soundConfirmLong:Sound;
      
      [Embed(source="../sfx/sounds/confirm_short.mp3")]
      public static var SoundConfirmShort:Class;
      public static var soundConfirmShort:Sound;
      
      [Embed(source="../sfx/sounds/hud_item_collected.mp3")]
      public static var SoundHudItemCollected:Class;
      public static var soundHudItemCollected:Sound;
      
      [Embed(source="../sfx/sounds/error.mp3")]
      public static var SoundError:Class;
      public static var soundError:Sound;
      
      [Embed(source="../sfx/sounds/error_2.mp3")]
      public static var SoundError2:Class;
      public static var soundError2:Sound;
      
      [Embed(source="../sfx/sounds/purchase.mp3")]
      public static var SoundPurchase:Class;
      public static var soundPurchase:Sound;
      
      [Embed(source="../sfx/sounds/hud_woosh.mp3")]
      public static var SoundHudWoosh:Class;
      public static var soundHudWoosh:Sound;
      
	  // Most of the impacts are here
      [Embed(source="../sfx/sounds/bullet_ground_impact.mp3")]
      public static var SoundBulletGroundImpact:Class;
      public static var soundBulletGroundImpact:Sound;
      
      [Embed(source="../sfx/sounds/snow_bullet_impact.mp3")]
      public static var SoundSnowBulletImpact:Class;
      public static var soundSnowBulletImpact:Sound;
      
      [Embed(source="../sfx/sounds/fire_bullet_impact.mp3")]
      public static var SoundFireBulletImpact:Class;
      public static var soundFireBulletImpact:Sound;
      
      [Embed(source="../sfx/sounds/fire_bullet.mp3")] // why is it after the impact sound
      public static var SoundFireBullet:Class;
      public static var soundFireBullet:Sound;
      
      [Embed(source="../sfx/sounds/giant_bullet_impact.mp3")]
      public static var SoundGiantBulletImpact:Class;
      public static var soundGiantBulletImpact:Sound;
      
      [Embed(source="../sfx/sounds/seed_bullet_impact.mp3")]
      public static var SoundSeedBulletImpact:Class;
      public static var soundSeedBulletImpact:Sound;
      
      [Embed(source="../sfx/sounds/egg_impact.mp3")]
      public static var SoundEggImpact:Class;
      public static var soundEggImpact:Sound;
      
      [Embed(source="../sfx/sounds/throw_bullet.mp3")]
      public static var SoundThrowBullet:Class;
      public static var soundThrowBullet:Sound;
      
      [Embed(source="../sfx/sounds/fire_shoot.mp3")]
      public static var SoundFireShoot:Class;
      public static var soundFireShoot:Sound;
      
      [Embed(source="../sfx/sounds/snow_cannon.mp3")]
      public static var SoundSnowCannon:Class;
      public static var soundSnowCannon:Sound;
      
      [Embed(source="../sfx/sounds/metal_particle_impact.mp3")] // hey bud, the impact list is above!
      public static var SoundMetalParticleImpact:Class;
      public static var soundMetalParticleImpact:Sound;
      
      [Embed(source="../sfx/sounds/metal_particle_impact_high.mp3")]
      public static var SoundMetalParticleImpactHigh:Class;
      public static var soundMetalParticleImpactHigh:Sound;
      
	  // It's time to rate the cat order!
      [Embed(source="../sfx/sounds/cat_blue.mp3")] // Shinji
      public static var SoundCatBlue:Class;
      public static var soundCatBlue:Sound;
      
      [Embed(source="../sfx/sounds/cat_black.mp3")] // Kuro
      public static var SoundCatBlack:Class;
      public static var soundCatBlack:Sound;
      
      [Embed(source="../sfx/sounds/cat_glide.mp3")] // Olli
      public static var SoundCatGlide:Class;
      public static var soundCatGlide:Sound;
      
      [Embed(source="../sfx/sounds/cat_red.mp3")] // Brutus/McMeow
      public static var SoundCatRed:Class;
      public static var soundCatRed:Sound;
      
      [Embed(source="../sfx/sounds/cat_chomp.mp3")] // Brutus chomp
      public static var SoundCatChomp:Class;
      public static var soundCatChomp:Sound;
      
      [Embed(source="../sfx/sounds/cat_purr.mp3")] // purr
      public static var SoundPurr:Class;
      public static var soundCatPurr:Sound;
      
      [Embed(source="../sfx/sounds/cat_small.mp3")] // Amy
      public static var SoundCatSmall:Class;
      public static var soundCatSmall:Sound;
      
      [Embed(source="../sfx/sounds/kitten_1.mp3")] // Kitten 1
      public static var SoundKitten1:Class;
      public static var soundKitten1:Sound;
      
      [Embed(source="../sfx/sounds/kitten_2.mp3")] // Kitten 2
      public static var SoundKitten2:Class;
      public static var soundKitten2:Sound;
      
      [Embed(source="../sfx/sounds/kitten_3.mp3")] // Kitten3
      public static var SoundKitten3:Class;
      public static var soundKitten3:Sound;
      
      [Embed(source="../sfx/sounds/kitten_4.mp3")] // Kitten 4
      public static var SoundKitten4:Class;
      public static var soundKitten4:Sound;
      
      [Embed(source="../sfx/sounds/mesa_laugh.mp3")]
      public static var SoundMesaLaugh:Class;
      public static var soundMesaLaugh:Sound;
      
      [Embed(source="../sfx/sounds/mesa_snarl.mp3")]
      public static var SoundMesaSnarl:Class;
      public static var soundMesaSnarl:Sound;
      
      [Embed(source="../sfx/sounds/mesa_defeat.mp3")]
      public static var SoundMesaDefeat:Class;
      public static var soundMesaDefeat:Sound;
      
      [Embed(source="../sfx/sounds/green_laugh.mp3")]
      public static var SoundGreenLaugh:Class;
      public static var soundGreenLaugh:Sound;
      
      [Embed(source="../sfx/sounds/cat_mayor.mp3")] // Hikari City mayor
      public static var SoundCatMayor:Class;
      public static var soundCatMayor:Sound;
      
      [Embed(source="../sfx/sounds/green_hurt.mp3")] // How do you hurt a color?
      public static var SoundGreenHurt:Class;
      public static var soundGreenHurt:Sound;
      
      [Embed(source="../sfx/sounds/dragon_screech.mp3")]
      public static var SoundDragonScreech:Class;
      public static var soundDragonScreech:Sound;
      
      [Embed(source="../sfx/sounds/laal_voice_1.mp3")]
      public static var SoundVoiceLaal1:Class;
      public static var soundLaalVoice1:Sound;
      
      [Embed(source="../sfx/sounds/laal_voice_2.mp3")]
      public static var SoundVoiceLaal2:Class;
      public static var soundLaalVoice2:Sound;
      
      [Embed(source="../sfx/sounds/bite.mp3")] // There's already a chomp sound in the game that's used by Brutus, why add a second?
      public static var SoundBite:Class;
      public static var soundBite:Sound;
      
      [Embed(source="../sfx/sounds/merchant_voice_1.mp3")]
      public static var SoundMerchantVoice1:Class;
      public static var soundMerchantVoice1:Sound;
      
      [Embed(source="../sfx/sounds/merchant_voice_2.mp3")]
      public static var SoundMerchantVoice2:Class;
      public static var soundMerchantVoice2:Sound;
      
      [Embed(source="../sfx/sounds/voice_fisherman.mp3")]
      public static var SoundVoiceFisherman:Class;
      public static var soundVoiceFisherman:Sound;
      
      [Embed(source="../sfx/sounds/kallio_voice_1.mp3")]
      public static var SoundKallioVoice1:Class;
      public static var soundKallioVoice1:Sound;
      
      [Embed(source="../sfx/sounds/kallio_voice_2.mp3")]
      public static var SoundKallioVoice2:Class;
      public static var soundKallioVoice2:Sound;
      
      [Embed(source="../sfx/sounds/iridium_voice_1.mp3")]
      public static var SoundIridiumVoice1:Class;
      public static var soundIridiumVoice1:Sound;
      
      [Embed(source="../sfx/sounds/iridium_voice_2.mp3")]
      public static var SoundIridiumVoice2:Class;
      public static var soundIridiumVoice2:Sound;
      
      [Embed(source="../sfx/sounds/cat_demise.mp3")] // animal abuse
      public static var SoundCatDemise:Class;
      public static var soundCatDemise:Sound;
      
      [Embed(source="../sfx/sounds/cat_soldier.mp3")] // Pascal!
      public static var SoundCatSoldier:Class;
      public static var soundCatSoldier:Sound;
      
      [Embed(source="../sfx/sounds/baburu.mp3")]
      public static var SoundBaburu:Class;
      public static var soundBaburu:Sound;
      
      [Embed(source="../sfx/sounds/map_explosion.mp3")] // Boom boom boom boom! I want you in my world map!
      public static var SoundMapExplosion:Class;
      public static var soundMapExplosion:Sound;
      
      [Embed(source="../sfx/sounds/map_advance.mp3")]
      public static var SoundMapAdvance:Class;
      public static var soundMapAdvance:Sound;
      
      [Embed(source="../sfx/sounds/map_stomp.mp3")]
      public static var SoundMapStomp:Class;
      public static var soundMapStomp:Sound;
      
      [Embed(source="../sfx/sounds/map_appear.mp3")]
      public static var SoundMapAppear:Class;
      public static var soundMapAppear:Sound;
      
      [Embed(source="../sfx/sounds/map_rumble.mp3")]
      public static var SoundMapRumble:Class;
      public static var soundMapRumble:Sound;
      
      [Embed(source="../sfx/sounds/atomic_explosion.mp3")]
      public static var SoundAtomicExplosion:Class;
      public static var soundAtomicExplosion:Sound;
      
      [Embed(source="../sfx/sounds/title_appear.mp3")] // Logo. It's called a logo.
      public static var SoundTitleAppear:Class;
      public static var soundTitleAppear:Sound;
      
      [Embed(source="../sfx/sounds/car_start.mp3")]
      public static var SoundCarStart:Class;
      public static var soundCarStart:Sound;
      
      [Embed(source="../sfx/sounds/car_running.mp3")] // wait a minute, cars can run?
      public static var SoundCarRunning:Class;
      public static var soundCarRunning:Sound;
      
      [Embed(source="../sfx/sounds/blow.mp3")]
      public static var SoundBlow:Class;
      public static var soundBlow:Sound;
      
      [Embed(source="../sfx/sounds/rock_stomp.mp3")]
      public static var SoundRockStomp:Class;
      public static var soundRockStomp:Sound;
      
      [Embed(source="../sfx/sounds/enemy_jump_low.mp3")]
      public static var SoundEnemyJumpLow:Class;
      public static var soundEnemyJumpLow:Sound;
      
      [Embed(source="../sfx/sounds/tongue_mesa.mp3")] // shouldn've been mesa_tongue but neutronized said no
      public static var SoundTongueMesa:Class;
      public static var soundTongueMesa:Sound;
      
      [Embed(source="../sfx/sounds/eat.mp3")]
      public static var SoundEat:Class;
      public static var soundEat:Sound;
      
      [Embed(source="../sfx/sounds/enemy_shoot.mp3")]
      public static var SoundEnemyShoot:Class;
      public static var soundEnemyShoot:Sound;
      
      [Embed(source="../sfx/sounds/wiggle.mp3")]
      public static var SoundWiggle:Class;
      public static var soundWiggle:Sound;
      
      [Embed(source="../sfx/sounds/hide.mp3")]
      public static var SoundHide:Class;
      public static var soundHide:Sound;
      
      [Embed(source="../sfx/sounds/door_exit.mp3")]
      public static var SoundDoorExit:Class;
      public static var soundDoorExit:Sound;
      
      [Embed(source="../sfx/sounds/arcade_flap.mp3")]
      public static var SoundArcadeFlap:Class;
      public static var soundArcadeFlap:Sound;
      
      [Embed(source="../sfx/sounds/arcade_coin.mp3")]
      public static var SoundArcadeCoin:Class;
      public static var soundArcadeCoin:Sound;
      
      [Embed(source="../sfx/sounds/arcade_laser.mp3")]
      public static var SoundArcadeLaser:Class;
      public static var soundArcadeLaser:Sound;
      
      [Embed(source="../sfx/sounds/arcade_explosion.mp3")]
      public static var SoundArcadeExplosion:Class;
      public static var soundArcadeExplosion:Sound;
      
      [Embed(source="../sfx/sounds/arcade_walk.mp3")]
      public static var SoundArcadeWalk:Class;
      public static var soundArcadeWalk:Sound;
      
      [Embed(source="../sfx/sounds/arcade_bonus.mp3")]
      public static var SoundArcadeBonus:Class;
      public static var soundArcadeBonus:Sound;
      
      [Embed(source="../sfx/sounds/pulley_crank.mp3")]
      public static var SoundPulleyCrank:Class;
      public static var soundPulleyCrank:Sound;
      
      [Embed(source="../sfx/sounds/enemy_shoot_sticky.mp3")]
      public static var SoundEnemyShootSticky:Class;
      public static var soundEnemyShootSticky:Sound;
      
      [Embed(source="../sfx/sounds/coin_appear.mp3")]
      public static var SoundCoinAppear:Class;
      public static var soundCoinAppear:Sound;
      
      [Embed(source="../sfx/sounds/wind_enemy.mp3")]
      public static var SoundWindEnemy:Class;
      public static var soundWindEnemy:Sound;
      
      [Embed(source="../sfx/sounds/giant_door_open.mp3")]
      public static var SoundGiantDoorOpen:Class;
      public static var soundGiantDoorOpen:Sound;
      
      [Embed(source="../sfx/sounds/giant_door_close.mp3")]
      public static var SoundGiantDoorClose:Class;
      public static var soundGiantDoorClose:Sound;
      
      [Embed(source="../sfx/sounds/warlock_appear.mp3")]
      public static var SoundWarlockAppear:Class;
      public static var soundWarlockAppear:Sound;
      
      [Embed(source="../sfx/sounds/cat_rose.mp3")] // Did Rose get her sound after the Rose VS Tarra thing?
      public static var SoundCatRose:Class;
      public static var soundCatRose:Sound;
      
      [Embed(source="../sfx/sounds/cat_wink.mp3")]
      public static var SoundCatWink:Class;
      public static var soundCatWink:Sound;
      
      [Embed(source="../sfx/sounds/cat_rigs_angry.mp3")]
      public static var SoundRigsAngry:Class;
      public static var soundCatRigsAngry:Sound;
      
      [Embed(source="../sfx/sounds/rigs.mp3")] // Notice how it's called "rigs" and not "cat_rigs"
      public static var SoundRigs:Class;
      public static var soundRigs:Sound;
      
      [Embed(source="../sfx/sounds/skull_wake_up.mp3")]
      public static var SoundSkullWakeUp:Class;
      public static var soundSkullWakeUp:Sound;
      
      [Embed(source="../sfx/sounds/dash.mp3")]
      public static var SoundDash:Class;
      public static var soundDash:Sound;
      
      [Embed(source="../sfx/sounds/fox_laugh.mp3")]
      public static var SoundFoxLaugh:Class;
      public static var soundFoxLaugh:Sound;
      
      [Embed(source="../sfx/sounds/bell.mp3")]
      public static var SoundBell:Class;
      public static var soundBell:Sound;
      
      [Embed(source="../sfx/sounds/reel.mp3")]
      public static var SoundReel:Class;
      public static var soundReel:Sound;
      
      [Embed(source="../sfx/sounds/reel_struggle.mp3")] // The reel is struggling! The reel is struggling!
      public static var SoundReelStruggle:Class;
      public static var soundReelStruggle:Sound;
      
      [Embed(source="../sfx/sounds/fish_bite.mp3")]
      public static var SoundFishBite:Class;
      public static var soundFishBite:Sound;
      
      [Embed(source="../sfx/sounds/cat_mara.mp3")]
      public static var SoundCatMara:Class;
      public static var soundCatMara:Sound;
      
      [Embed(source="../sfx/sounds/whistle.mp3")]
      public static var SoundWhistle:Class;
      public static var soundWhistle:Sound;
      
      [Embed(source="../sfx/sounds/dog.mp3")] // When is this used? Never?
      public static var SoundDog:Class;
      public static var soundDog:Sound;
      
      [Embed(source="../sfx/sounds/fire_dragon_shoot.mp3")]
      public static var SoundFireDragonShoot:Class;
      public static var soundFireDragonShoot:Sound;
      
      [Embed(source="../sfx/sounds/lace.mp3")]
      public static var SoundLace:Class;
      public static var soundLace:Sound;
      
      [Embed(source="../sfx/sounds/item_notification.mp3")] // you've got mail
      public static var SoundItemNotification:Class;
      public static var soundItemNotification:Sound;
      
      [Embed(source="../sfx/sounds/seed_attack.mp3")]
      public static var SoundSeedAttack:Class;
      public static var soundSeedAttack:Sound;
      
      [Embed(source="../sfx/sounds/plant_grow.mp3")]
      public static var SoundPlantGrow:Class;
      public static var soundPlantGrow:Sound;
      
      [Embed(source="../sfx/sounds/bounce.mp3")]
      public static var SoundBounce:Class;
      public static var soundBounce:Sound;
      
      [Embed(source="../sfx/sounds/leg_move.mp3")]
      public static var SoundLegMove:Class;
      public static var soundLegMove:Sound;
      
      [Embed(source="../sfx/sounds/spider_voice.mp3")]
      public static var SoundSpiderVoice:Class;
      public static var soundSpiderVoice:Sound;
      
      [Embed(source="../sfx/sounds/spider_defeat.mp3")]
      public static var SoundSpiderDefeat:Class;
      public static var soundSpideDefeat:Sound;
      
      [Embed(source="../sfx/sounds/thunder.mp3")]
      public static var SoundThunder:Class;
      public static var soundThunder:Sound;
      
      [Embed(source="../sfx/sounds/electricity_mid.mp3")]
      public static var SoundElectricityMid:Class;
      public static var soundElectricityMid:Sound;
      
      [Embed(source="../sfx/sounds/electricity_end.mp3")] // Shortage?
      public static var SoundElectricityEnd:Class;
      public static var soundElectricityEnd:Sound;
      
      [Embed(source="../sfx/sounds/helper_bubble.mp3")]
      public static var SoundHelperBubble:Class;
      public static var soundHelperBubble:Sound;
      
      [Embed(source="../sfx/sounds/arrow.mp3")]
      public static var SoundArrow:Class;
      public static var soundArrow:Sound;
      
      [Embed(source="../sfx/sounds/cast.mp3")]
      public static var SoundCast:Class;
      public static var soundCast:Sound;
      
	  // Music definitions
      [Embed(source="../sfx/music/outside_rain.mp3")]
      public static var MusicOutsideRain:Class;
      public static var musicOutsideRain:Sound;
      
      [Embed(source="../sfx/music/outside_trees.mp3")]
      public static var MusicOutsideTrees:Class;
      public static var musicOutsideTrees:Sound;
      
      [Embed(source="../sfx/music/outside_trees_night.mp3")]
      public static var MusicOutsideTreesNight:Class;
      public static var musicOutsideTreesNight:Sound;
      
      [Embed(source="../sfx/music/outside_mountain.mp3")]
      public static var MusicOutsideMountain:Class;
      public static var musicOutsideMountain:Sound;
      
      [Embed(source="../sfx/music/outside_desert.mp3")]
      public static var MusicOutsideDesert:Class;
      public static var musicOutsideDesert:Sound;
      
      [Embed(source="../sfx/music/inside_cave.mp3")]
      public static var MusicInsideCave:Class;
      public static var musicInsideCave:Sound;
      
      [Embed(source="../sfx/music/outside_sea.mp3")]
      public static var MusicOutsideSea:Class;
      public static var musicOutsideSea:Sound;
      
      [Embed(source="../sfx/music/outside_sea_night.mp3")]
      public static var MusicOutsideSeaNight:Class;
      public static var musicOutsideSeaNight:Sound;
      
      [Embed(source="../sfx/music/rain.mp3")]
      public static var MusicRain:Class;
      public static var musicRain:Sound;
      
      [Embed(source="../sfx/music/butterflies_complete.mp3")]
      public static var MusicButterfliesComplete:Class;
      public static var musicButterfliesComplete:Sound;
      
      [Embed(source="../sfx/music/victory.mp3")]
      public static var MusicLevelComplete:Class;
      public static var musicVictory:Sound;
      
      [Embed(source="../sfx/music/game_over.mp3")]
      public static var MusicGameOver:Class;
      public static var musicGameOver:Sound;
      
      [Embed(source="../sfx/music/radio_station.mp3")]
      public static var MusicRadioStation:Class;
      public static var musicRadioStation:Sound;
      
      [Embed(source="../sfx/music/bandits.mp3")]
      public static var MusicBandits:Class;
      public static var musicBandits:Sound;
      
      [Embed(source="../sfx/music/woods.mp3")]
      public static var MusicWoods:Class;
      public static var musicWoods:Sound;
      
      [Embed(source="../sfx/music/hive.mp3")]
      public static var MusicHive:Class;
      public static var musicHive:Sound;
      
      [Embed(source="../sfx/music/mid_boss.mp3")]
      public static var MusicMidBoss:Class;
      public static var musicMidBoss:Sound;
      
      [Embed(source="../sfx/music/paws_base.mp3")]
      public static var MusicPawsBase:Class;
      public static var musicPawsBase:Sound;
      
      [Embed(source="../sfx/music/arcade.mp3")]
      public static var MusicArcade:Class;
      public static var musicArcade:Sound;
      
      [Embed(source="../sfx/music/cat_talk.mp3")]
      public static var MusicCatTalk:Class;
      public static var musicCatTalk:Sound;
      
      [Embed(source="../sfx/music/cat_danger.mp3")]
      public static var MusicCatDanger:Class;
      public static var musicCatDanger:Sound;
      
      [Embed(source="../sfx/music/arcade_start.mp3")]
      public static var MusicArcadeStart:Class;
      public static var musicArcadeStart:Sound;
      
      [Embed(source="../sfx/music/arcade_game_over.mp3")]
      public static var MusicArcadeGameOver:Class;
      public static var musicArcadeGameOver:Sound;
      
      [Embed(source="../sfx/music/canyon.mp3")]
      public static var MusicCanyon:Class;
      public static var musicCanyon:Sound;
      
      [Embed(source="../sfx/music/fortress.mp3")]
      public static var MusicFortress:Class;
      public static var musicFortress:Sound;
      
      [Embed(source="../sfx/music/boss.mp3")]
      public static var MusicBoss:Class;
      public static var musicBoss:Sound;
      
      [Embed(source="../sfx/music/beach.mp3")]
      public static var MusicBeach:Class;
      public static var musicBeach:Sound;
      
      [Embed(source="../sfx/music/cave.mp3")]
      public static var MusicCave:Class;
      public static var musicCave:Sound;
      
      [Embed(source="../sfx/music/portobello.mp3")]
      public static var MusicPortobello:Class;
      public static var musicPortobello:Sound;
      
      [Embed(source="../sfx/music/inside_tavern.mp3")]
      public static var MusicInsideTavern:Class;
      public static var musicInsideTavern:Sound;
      
      [Embed(source="../sfx/music/fishing.mp3")]
      public static var MusicFishing:Class;
      public static var musicFishing:Sound;
      
      [Embed(source="../sfx/music/fishing_fight.mp3")] // Ah yes, Fish is the game's hardest boss!
      public static var MusicFishingFight:Class;
      public static var musicFishingFight:Sound;
      
      [Embed(source="../sfx/music/butterflies.mp3")]
      public static var MusicButterflies:Class;
      public static var musicButterflies:Sound;
      
      [Embed(source="../sfx/music/ocean.mp3")]
      public static var MusicOcean:Class;
      public static var musicOcean:Sound;
      
      [Embed(source="../sfx/music/map.mp3")]
      public static var MusicMap:Class;
      public static var musicMap:Sound;
      
      [Embed(source="../sfx/music/outside_iceberg.mp3")]
      public static var MusicOutsideIceberg:Class;
      public static var musicOutsideIceberg:Sound;
      
      [Embed(source="../sfx/music/intro.mp3")]
      public static var MusicIntro:Class;
      public static var musicIntro:Sound;
      
      [Embed(source="../sfx/music/splash.mp3")]
      public static var MusicSplash:Class;
      public static var musicSplash:Sound;
      
      protected static var MUSIC_VOLUME:Number = 0.25;
      
      protected static var MUSIC_IS_STOPPED:Boolean = false;
      
      public static var last_kitty_voice:int = 0;
      
      public static var musicVolume:Number = MUSIC_VOLUME;
      
      public static var musicVolumeMultiplier:Number = 1;
      
      public static var pausePosition:int = 0;
      
      public static var stopMusicFlag:Boolean = false;
      
      public static var fadeInMusicFlag:Boolean = false;
      
      public static var lastExplosion:int = 0;
      
      public static var lastPoint:int = 0;
      
      public static var lastRandomValue:int = -1;
      
      public static var lastRandomExplosionValue:int = -1;
      
      public static var lastRandomBigExplosionValue:int = -1;
      
      public static var LastMusicName:String = "";
      
      public static var IS_INIT:Boolean = false;
      
      public function SoundSystem()
      {
         super();
      }
      
      public static function InitSounds() : void // Get ready for a long list of sounds!
      {
         var i:int = 0;
         soundCatBrake = new SoundCatBrake();
         soundCatBrakeLow = new SoundCatBrakeLow();
         soundCatHurt = new SoundCatHurt();
         soundCatHurtGameOver = new SoundCatHurtGameOver();
         soundCatRun = new SoundCatRun();
         soundCatRunLow = new SoundCatRunLow();
         soundCatJump = new SoundCatJump();
         soundCatHeadbutt = new SoundCatHeadbutt();
         soundWater = new SoundWater();
         soundWaterSplash = new SoundWaterSplash();
         soundIceSlide = new SoundIceSlide();
         soundCatFallsGround = new SoundCatFallsGround();
         soundCatJumpLow = new SoundCatJumpLow();
         soundCatHopLow = new SoundCatHopLow();
         soundCatFallsGroundLow = new SoundCatFallsGroundLow();
         soundCatGroundImpact = new SoundCatGroundImpact();
         soundDarkCat = new SoundDarkCat();
         soundCatSuperJump = new SoundCatSuperJump();
         soundCatSuperJumpLow = new SoundCatSuperJumpLow();
         soundMudSlide = new SoundMudSlide();
         soundCatYawn = new SoundCatYawn();
         soundBlink = new SoundBlink();
         soundGreyCatVictoryJump = new SoundGreyCatVictoryJump();
         soundItemBellCollected = new SoundItemBellCollected();
         soundButterfliesAppear = new SoundButterfliesAppear();
         soundItemCoin = new SoundItemCoin();
         soundItemImpact = new SoundItemImpact();
         soundItemImpactWater = new SoundItemImpactWater();
         soundBellCollected = new SoundBellCollected();
         soundItemAppear = new SoundItemAppear();
         soundItemPop = new SoundItemPop();
         soundPotCollected = new SoundPotCollected();
         soundPotPop = new SoundBottlePop();
         soundButterflyCollected1 = new SoundButterflyCollected1();
         soundButterflyCollected2 = new SoundButterflyCollected2();
         soundButterflyCollected3 = new SoundButterflyCollected3();
         soundButterflyCollected4 = new SoundButterflyCollected4();
         soundButterflyCollected5 = new SoundButterflyCollected5();
         soundRedCoin = new SoundRedCoin();
         soundCrate = new SoundCrate();
         soundDoorClose = new SoundDoorClose();
         soundDoorOpen = new SoundDoorOpen();
         soundBrickDestroyed1 = new SoundBrickDestroyed1();
         soundBrickDestroyed2 = new SoundBrickDestroyed2();
         soundBrickCreated = new SoundBrickCreated();
         soundBluePlatform = new SoundBluePlatform();
         soundRedPlatform = new SoundRedPlatform();
         soundBone = new SoundBone();
         soundFireBallShoot = new SoundFireBallShoot();
         soundGeyser = new SoundGeyser();
         soundIceShake = new SoundIceShake();
         soundIceImpact = new SoundIceImpact();
         soundLever = new SoundLever();
         soundMud = new SoundMud();
         soundExplosionBig = new SoundExplosionBig();
         soundExplosionMedium = new SoundExplosionMedium();
         soundExplosionSmall = new SoundExplosionSmall();
         soundClod = new SoundClod();
         soundSandPit = new SoundSandPit();
         soundLogCollision = new SoundLogCollision();
         soundImpactSmall = new SoundImpactSmall();
         soundImpactBig = new SoundImpactBig();
         soundChainRattle = new SoundChainRattle();
         soundWoosh = new SoundWoosh();
         soundWooshLow = new SoundWooshLow();
         soundGateOpen = new SoundGateOpen();
         soundFire1 = new SoundFire1();
         soundFire2 = new SoundFire2();
         soundExplosionDistance = new SoundExplosionDistance();
         soundBrickDestroyedEcho = new SoundBrickDestroyedEcho();
         soundFenceExit = new SoundFenceExit();
         soundCarEngine = new SoundCarEngine();
         soundSkid = new SoundSkid();
         soundCarEngineFirst = new SoundCarEngineFirst();
         soundVehicleEngine = new SoundVehicleEngine();
         soundPhone = new SoundPhone();
         soundVehicleStop = new SoundVehicleStop();
         soundVehicleTurnOff = new SoundVehicleTurnOff();
         soundVehicleTurnOn = new SoundVehicleTurnOn();
         soundVehicleCannon = new SoundVehicleCannon();
         soundVehicleEngineUp = new SoundVehicleEngineUp();
         soundVehicleReload = new SoundVehicleReload();
         soundEnemyBullet = new SoundEnemyBullet();
         soundEnemyHurt = new SoundEnemyHurt();
         soundBigEnemyHurt = new SoundBigEnemyHurt();
         soundGroundStomp = new SoundGroundStomp();
         soundDustEnemy = new SoundDustEnemy();
         soundMetalEnemyHurtA = new SoundMetalEnemyHurtA();
         soundMetalEnemyHurtB = new SoundMetalEnemyHurtB();
         soundMetalBigEnemyHurtA = new SoundMetalBigEnemyHurtA();
         soundMetalEnemyJump = new SoundMetalEnemyJump();
         soundDig = new SoundDig();
         soundEnemyJump = new SoundEnemyJump();
         soundEnemyBrake = new SoundEnemyBrake();
         soundGiantTurnipDefeat = new SoundGiantTurnipDefeat();
         soundBigEnemyHit = new SoundBigEnemyHit();
         soundFrog1 = new SoundFrog1();
         soundFrog2 = new SoundFrog2();
         soundEnemyWater = new SoundEnemyWater();
         soundGiantFishRoar = new SoundGiantFishRoar();
         soundGiantFishSwoosh = new SoundGiantFishSwoosh();
         soundEnemyRun = new SoundEnemyRun();
         soundBeamStart = new SoundBeamStart();
         soundBeamShoot = new SoundBeamShoot();
         soundBeamRepeat = new SoundBeamRepeat();
         soundDragonWing = new SoundDragonWing();
         soundEnemyIceSlide = new SoundEnemyIceSlide();
         soundGhostScared = new SoundGhostScared();
         soundTongue = new SoundTongue();
         soundDecorationBlown = new SoundDecorationBlown();
         soundBirdFlying = new SoundBirdFlying();
         soundChirp1 = new SoundChirp1();
         soundChirp2 = new SoundChirp2();
         soundLoudChirp = new SoundLoudChirp();
         soundGiantSpaceship = new SoundGiantSpaceship();
         soundWindBreeze = new SoundWindBreeze();
         soundFlyingshipDistance = new SoundFlyingshipDistance();
         soundFlyingshipDistanceFirst = new SoundFlyingshipDistanceFirst();
         soundFlyingshipMalfunction = new SoundFlyingshipMalfunction();
         soundFlyingshipFallDown = new SoundFlyingshipFallDown();
         soundAlarm = new SoundAlarm();
         soundCrystalAmbience = new SoundCrystalAmbience();
         soundMagicDisappear = new SoundMagicDisappear();
         soundQuake = new SoundQuake();
         soundQuakeFade = new SoundQuakeFade();
         soundBoatHorn = new SoundBoatHorn();
         soundWindStrongStart = new SoundWindStrongStart();
         soundWindStrongMid = new SoundWindStrongMid();
         soundWindStrongEnd = new SoundWindStrongEnd();
         soundSmallQuake = new SoundSmallQuake();
         soundTrainTrack = new SoundTrainTrack();
         soundTrainTrackSlow = new SoundTrainTrackSlow();
         soundTrainWhistle = new SoundTrainWhistle();
         soundCrystalAppear = new SoundCrystalAppear();
         soundSnowBulletImpact = new SoundSnowBulletImpact();
         soundGiantBulletImpact = new SoundGiantBulletImpact();
         soundFireBullet = new SoundFireBullet();
         soundFireBulletImpact = new SoundFireBulletImpact();
         soundBulletGroundImpact = new SoundBulletGroundImpact();
         soundMetalParticleImpact = new SoundMetalParticleImpact();
         soundMetalParticleImpactHigh = new SoundMetalParticleImpactHigh();
         soundLogo = new SoundLogo();
         soundConfirmLong = new SoundConfirmLong();
         soundConfirmShort = new SoundConfirmShort();
         soundSelect = new SoundSelect();
         soundError = new SoundError();
         soundError2 = new SoundError2();
         soundHudItemCollected = new SoundHudItemCollected();
         soundBlip = new SoundBlip();
         soundFont1 = new SoundFont1();
         soundFont2 = new SoundFont2();
         soundFont3 = new SoundFont3();
         soundPurchase = new SoundPurchase();
         soundHudWoosh = new SoundHudWoosh();
         soundCatBlue = new SoundCatBlue();
         soundCatBlack = new SoundCatBlack();
         soundCatGlide = new SoundCatGlide();
         soundCatRed = new SoundCatRed();
         soundCatChomp = new SoundCatChomp();
         soundCatSmall = new SoundCatSmall();
         soundCatPurr = new SoundPurr();
         soundKitten1 = new SoundKitten1();
         soundKitten2 = new SoundKitten2();
         soundKitten3 = new SoundKitten3();
         soundKitten4 = new SoundKitten4();
         soundDragonScreech = new SoundDragonScreech();
         soundLaalVoice1 = new SoundVoiceLaal1();
         soundLaalVoice2 = new SoundVoiceLaal2();
         soundBite = new SoundBite();
         soundVoiceFisherman = new SoundVoiceFisherman();
         soundMerchantVoice1 = new SoundMerchantVoice1();
         soundMerchantVoice2 = new SoundMerchantVoice2();
         soundKallioVoice1 = new SoundKallioVoice1();
         soundKallioVoice2 = new SoundKallioVoice2();
         soundIridiumVoice1 = new SoundIridiumVoice1();
         soundIridiumVoice2 = new SoundIridiumVoice2();
         soundCatDemise = new SoundCatDemise();
         soundCatSoldier = new SoundCatSoldier();
         soundBaburu = new SoundBaburu();
         soundMesaLaugh = new SoundMesaLaugh();
         soundMesaDefeat = new SoundMesaDefeat();
         soundMesaSnarl = new SoundMesaSnarl();
         soundGreenLaugh = new SoundGreenLaugh();
         soundCatMayor = new SoundCatMayor();
         soundGreenHurt = new SoundGreenHurt();
         soundMapExplosion = new SoundMapExplosion();
         soundMapAdvance = new SoundMapAdvance();
         soundMapStomp = new SoundMapStomp();
         soundMapAppear = new SoundMapAppear();
         soundMapRumble = new SoundMapRumble();
         soundAtomicExplosion = new SoundAtomicExplosion();
         soundTitleAppear = new SoundTitleAppear();
         soundSeedBulletImpact = new SoundSeedBulletImpact();
         soundEggImpact = new SoundEggImpact();
         soundThrowBullet = new SoundThrowBullet();
         soundFireShoot = new SoundFireShoot();
         soundSnowCannon = new SoundSnowCannon();
         soundIceMelt = new SoundIceMelt();
         soundHeroCannon = new SoundHeroCannon();
         soundCatAngry = new SoundCatAngry();
         soundCarStart = new SoundCarStart();
         soundCarRunning = new SoundCarRunning();
         soundBlow = new SoundBlow();
         soundRockStomp = new SoundRockStomp();
         soundEnemyJumpLow = new SoundEnemyJumpLow();
         soundTongueMesa = new SoundTongueMesa();
         soundEat = new SoundEat();
         soundEnemyShoot = new SoundEnemyShoot();
         soundWiggle = new SoundWiggle();
         soundHide = new SoundHide();
         soundDoorExit = new SoundDoorExit();
         soundArcadeFlap = new SoundArcadeFlap();
         soundArcadeCoin = new SoundArcadeCoin();
         soundArcadeLaser = new SoundArcadeLaser();
         soundArcadeExplosion = new SoundArcadeExplosion();
         soundArcadeWalk = new SoundArcadeWalk();
         soundArcadeBonus = new SoundArcadeBonus();
         soundPulleyCrank = new SoundPulleyCrank();
         soundEnemyShootSticky = new SoundEnemyShootSticky();
         soundCoinAppear = new SoundCoinAppear();
         soundWindEnemy = new SoundWindEnemy();
         soundGiantDoorOpen = new SoundGiantDoorOpen();
         soundGiantDoorClose = new SoundGiantDoorClose();
         soundWarlockAppear = new SoundWarlockAppear();
         soundCatRose = new SoundCatRose();
         soundCatWink = new SoundCatWink();
         soundCatRigsAngry = new SoundRigsAngry();
         soundRigs = new SoundRigs();
         soundSkullWakeUp = new SoundSkullWakeUp();
         soundDash = new SoundDash();
         soundFoxLaugh = new SoundFoxLaugh();
         soundBell = new SoundBell();
         soundCast = new SoundCast();
         soundReel = new SoundReel();
         soundReelStruggle = new SoundReelStruggle();
         soundFishBite = new SoundFishBite();
         soundCatMara = new SoundCatMara();
         soundWhistle = new SoundWhistle();
         soundDog = new SoundDog();
         soundFireDragonShoot = new SoundFireDragonShoot();
         soundLace = new SoundLace();
         soundItemNotification = new SoundItemNotification();
         soundSeedAttack = new SoundSeedAttack();
         soundPlantGrow = new SoundPlantGrow();
         soundBounce = new SoundBounce();
         soundLegMove = new SoundLegMove();
         soundSpiderVoice = new SoundSpiderVoice();
         soundSpideDefeat = new SoundSpiderDefeat();
         soundThunder = new SoundThunder();
         soundElectricityMid = new SoundElectricityMid();
         soundElectricityEnd = new SoundElectricityEnd();
         soundHelperBubble = new SoundHelperBubble();
         soundArrow = new SoundArrow();
         sounds = new Array();
         for(i = 0; i < 300; i++)
         {
            sounds.push(0);
         }
         _soundTransform = new SoundTransform(0.4);
         soundChannel = new SoundChannel();
         if(soundChannel != null)
         {
            soundChannel.soundTransform = _soundTransform;
         }
         _musicTransform = new SoundTransform(musicVolume);
         musicChannel = new SoundChannel();
         if(musicChannel != null)
         {
            musicChannel.soundTransform = _musicTransform;
         }
         musicOutsideRain = new MusicOutsideRain();
         musicRain = new MusicRain();
         musicButterfliesComplete = new MusicButterfliesComplete();
         musicVictory = new MusicLevelComplete();
         musicGameOver = new MusicGameOver();
         musicRadioStation = new MusicRadioStation();
         musicBandits = new MusicBandits();
         musicOutsideTrees = new MusicOutsideTrees();
         musicOutsideTreesNight = new MusicOutsideTreesNight();
         musicWoods = new MusicWoods();
         musicHive = new MusicHive();
         musicMidBoss = new MusicMidBoss();
         musicPawsBase = new MusicPawsBase();
         musicArcade = new MusicArcade();
         musicCatTalk = new MusicCatTalk();
         musicCatDanger = new MusicCatDanger();
         musicArcadeStart = new MusicArcadeStart();
         musicArcadeGameOver = new MusicArcadeGameOver();
         musicOutsideMountain = new MusicOutsideMountain();
         musicOutsideDesert = new MusicOutsideDesert();
         musicCanyon = new MusicCanyon();
         musicInsideCave = new MusicInsideCave();
         musicFortress = new MusicFortress();
         musicBoss = new MusicBoss();
         musicBeach = new MusicBeach();
         musicOutsideSea = new MusicOutsideSea();
         musicOutsideSeaNight = new MusicOutsideSeaNight();
         musicCave = new MusicCave();
         musicPortobello = new MusicPortobello();
         musicInsideTavern = new MusicInsideTavern();
         musicFishing = new MusicFishing();
         musicFishingFight = new MusicFishingFight();
         musicButterflies = new MusicButterflies();
         musicOcean = new MusicOcean();
         musicMap = new MusicMap();
         musicOutsideIceberg = new MusicOutsideIceberg();
         musicIntro = new MusicIntro();
         musicSplash = new MusicSplash();
         SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
         IS_INIT = true;
      }
      
      public static function Update() : void
      {
         if(stopMusicFlag)
         {
            musicVolume -= 0.005;
            _musicTransform.volume = musicVolume * musicVolumeMultiplier;
            if(musicChannel != null)
            {
               musicChannel.soundTransform = _musicTransform;
            }
            if(musicVolume <= 0)
            {
               stopMusicFlag = false;
               musicChannel.stop();
            }
         }
         if(fadeInMusicFlag)
         {
            musicVolume += 0.00075;
            if(musicVolume >= MUSIC_VOLUME)
            {
               musicVolume = MUSIC_VOLUME;
               fadeInMusicFlag = false;
            }
            _musicTransform.volume = musicVolume * musicVolumeMultiplier;
            if(musicChannel != null)
            {
               musicChannel.soundTransform = _musicTransform;
            }
         }
         for(var i:int = 0; i < sounds.length; i++)
         {
            if(sounds[i] > 0)
            {
               --sounds[i];
            }
         }
         lastPoint = 0;
         ++lastExplosion;
         if(lastExplosion > 10)
         {
            lastExplosion = 10;
         }
      }
      
      public static function StopSound() : void
      {
         soundChannel.stop();
      }
      
      public static function PlayLastMusic(_force:Boolean = false) : void
      {
         PlayMusic(LastMusicName,-1,_force);
      }
      
      public static function PlayLevelMusic() : void // best function ever
      {
      }
      
      public static function PlayMusic(musicName:String, _time:int = -1, _forced:Boolean = false, _fade_in:Boolean = false) : void
      {
         if(_musicTransform == null)
         {
            return;
         }
         if(!Utils.MusicOn)
         {
            return;
         }
         if(musicName == LastMusicName && !_forced)
         {
            return;
         }
         if(stopMusicFlag || Utils.IS_ANDROID)
         {
            stopMusicFlag = false;
            if(musicChannel != null)
            {
               musicChannel.stop();
            }
         }
         if(musicChannel != null)
         {
            if(musicName == "")
            {
               SoundSystem.StopMusic();
            }
            else
            {
               musicChannel.stop();
            }
         }
         if(_fade_in)
         {
            musicVolume = 0;
            fadeInMusicFlag = true;
         }
         else
         {
            musicVolume = MUSIC_VOLUME;
         }
         _musicTransform.volume = musicVolume * musicVolumeMultiplier;
         if(musicChannel != null)
         {
            musicChannel.soundTransform = _musicTransform;
         }
         LastMusicName = musicName;
         switch(musicName) // What the heck...
         {
            case "outside_rain":
               musicChannel = musicOutsideRain.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "rain":
               musicChannel = musicRain.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "butterflies_complete":
               musicChannel = musicButterfliesComplete.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "victory":
               musicChannel = musicVictory.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "game_over":
               musicChannel = musicGameOver.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "radio_station":
               musicChannel = musicRadioStation.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "bandits":
               musicChannel = musicBandits.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_trees":
            case "outside_background":
               musicChannel = musicOutsideTrees.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_trees_night":
            case "outside_background_night":
               musicChannel = musicOutsideTreesNight.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_mountain":
               musicChannel = musicOutsideMountain.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "woods":
               musicChannel = musicWoods.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "hive":
            case "temple":
               musicChannel = musicHive.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "mid_boss":
               musicChannel = musicMidBoss.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "paws_base":
               musicChannel = musicPawsBase.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "arcade":
               musicChannel = musicArcade.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "cutscene_cats":
               musicChannel = musicCatTalk.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "cutscene_danger":
               musicChannel = musicCatDanger.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "arcade_start":
               musicChannel = musicArcadeStart.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "arcade_game_over":
               musicChannel = musicArcadeGameOver.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "canyon":
               musicChannel = musicCanyon.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_desert":
            case "outside_canyon":
               musicChannel = musicOutsideDesert.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "inside_cave":
               musicChannel = musicInsideCave.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "fortress":
               musicChannel = musicFortress.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "boss":
               musicChannel = musicBoss.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "beach":
               musicChannel = musicBeach.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_sea":
               musicChannel = musicOutsideSea.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_sea_night":
               musicChannel = musicOutsideSeaNight.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "cave":
               musicChannel = musicCave.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "portobello":
               musicChannel = musicPortobello.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "tavern":
               musicChannel = musicInsideTavern.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "fishing":
               musicChannel = musicFishing.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "fishing_fight":
               musicChannel = musicFishingFight.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "butterflies":
               musicChannel = musicButterflies.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "ocean":
               musicChannel = musicOcean.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "map":
               musicChannel = musicMap.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "outside_iceberg":
               musicChannel = musicOutsideIceberg.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "intro":
               musicChannel = musicIntro.play(_time,1);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
               break;
            case "splash":
               musicChannel = musicSplash.play(_time,10000);
               if(musicChannel != null)
               {
                  musicChannel.soundTransform = _musicTransform;
               }
         }
      }
      
      protected static function onLevelMusicComplete(event:Event) : void
      {
         PlayMusic("level",0);
      }
      
      public static function StopMusic(instant:Boolean = false, isAds:Boolean = false) : void
      {
         if(!isAds)
         {
            LastMusicName = "";
         }
         stopMusicFlag = true;
         if(instant)
         {
            musicVolume = 0;
         }
         if(Utils.IS_ANDROID)
         {
            if(instant)
            {
               musicChannel.stop();
            }
         }
      }
      
      public static function TurnOffMusicVolume() : void
      {
         musicVolumeMultiplier = 0;
         _musicTransform.volume = musicVolume * musicVolumeMultiplier;
         if(musicChannel != null)
         {
            musicChannel.soundTransform = _musicTransform;
         }
      }
      
      public static function TurnOnMusicVolume() : void
      {
         musicVolumeMultiplier = 1;
         _musicTransform.volume = musicVolume * musicVolumeMultiplier;
         if(musicChannel != null)
         {
            musicChannel.soundTransform = _musicTransform;
         }
      }
      
      public static function StopAll() : void
      {
         SoundMixer.stopAll();
      }
      
      public static function PlaySound(soundName:String) : void
      {
         var rand_value:int = 0;
         var total_attempts:int = 0;
         if(Utils.SoundOn)
         {
            switch(soundName) // what the heck...
            {
               case "logo":
                  if(sounds[0] <= 0)
                  {
                     soundChannel = soundLogo.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[0] = 2;
                  }
                  break;
               case "confirmLong":
                  if(sounds[1] <= 0)
                  {
                     soundChannel = soundConfirmLong.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[1] = 2;
                  }
                  break;
               case "confirmShort":
                  if(sounds[2] <= 0)
                  {
                     soundChannel = soundConfirmShort.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[2] = 2;
                  }
                  break;
               case "select":
               case "selectGo":
               case "selectBack":
                  if(sounds[3] <= 0)
                  {
                     soundChannel = soundSelect.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[3] = 2;
                  }
                  break;
               case "back":
                  if(sounds[4] <= 0)
                  {
                     soundChannel = soundError.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[4] = 2;
                  }
                  break;
               case "coin":
                  if(sounds[5] <= 0)
                  {
                     soundChannel = soundItemCoin.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[5] = 2;
                  }
                  break;
               case "item_impact":
                  if(sounds[6] <= 0)
                  {
                     soundChannel = soundItemImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[6] = 2;
                  }
                  break;
               case "item_bell_collected":
                  if(sounds[7] <= 0)
                  {
                     soundChannel = soundBellCollected.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[7] = 2;
                  }
                  break;
               case "item_appear":
                  if(sounds[8] <= 0)
                  {
                     soundChannel = soundItemAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[8] = 2;
                  }
                  break;
               case "item_pop":
                  if(sounds[9] <= 0)
                  {
                     soundChannel = soundItemPop.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[9] = 2;
                  }
                  break;
               case "butterflies_appear":
                  if(sounds[10] <= 0)
                  {
                     soundChannel = soundButterfliesAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[10] = 2;
                  }
                  break;
               case "pot_collected":
                  if(sounds[11] <= 0)
                  {
                     soundChannel = soundPotCollected.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[11] = 2;
                  }
                  break;
               case "pot_pop":
                  if(sounds[12] <= 0)
                  {
                     soundChannel = soundPotPop.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[12] = 2;
                  }
                  break;
               case "butterfly_collect_1":
                  if(sounds[13] <= 0)
                  {
                     soundChannel = soundButterflyCollected1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[13] = 2;
                  }
                  break;
               case "butterfly_collect_2":
                  if(sounds[14] <= 0)
                  {
                     soundChannel = soundButterflyCollected2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[14] = 2;
                  }
                  break;
               case "butterfly_collect_3":
                  if(sounds[15] <= 0)
                  {
                     soundChannel = soundButterflyCollected3.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[15] = 2;
                  }
                  break;
               case "butterfly_collect_4":
                  if(sounds[16] <= 0)
                  {
                     soundChannel = soundButterflyCollected4.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[16] = 2;
                  }
                  break;
               case "butterfly_collect_5":
                  if(sounds[17] <= 0)
                  {
                     soundChannel = soundButterflyCollected5.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[17] = 2;
                  }
                  break;
               case "hud_item_collected":
                  if(sounds[18] <= 0)
                  {
                     soundChannel = soundHudItemCollected.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[18] = 2;
                  }
                  break;
               case "door_close":
                  if(sounds[19] <= 0)
                  {
                     soundChannel = soundDoorClose.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[19] = 2;
                  }
                  break;
               case "decoration_blown":
                  if(sounds[20] <= 0)
                  {
                     soundChannel = soundDecorationBlown.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[20] = 5;
                  }
                  break;
               case "map_explosion":
                  if(sounds[21] <= 0)
                  {
                     soundChannel = soundMapExplosion.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[21] = 5;
                  }
                  break;
               case "map_advance":
                  if(sounds[22] <= 0)
                  {
                     soundChannel = soundMapAdvance.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[22] = 5;
                  }
                  break;
               case "map_stomp":
                  if(sounds[23] <= 0)
                  {
                     soundChannel = soundMapStomp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[23] = 5;
                  }
                  break;
               case "map_appear":
                  if(sounds[24] <= 0)
                  {
                     soundChannel = soundMapAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[24] = 5;
                  }
                  break;
               case "map_rumble":
                  if(sounds[25] <= 0)
                  {
                     soundChannel = soundMapRumble.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[25] = 150;
                  }
                  break;
               case "cat_run":
                  if(sounds[26] <= 0)
                  {
                     soundChannel = soundCatRun.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[26] = 20;
                  }
                  break;
               case "cat_jump":
                  if(sounds[27] <= 0)
                  {
                     soundChannel = soundCatJump.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[27] = 5;
                  }
                  break;
               case "cat_brake":
                  if(sounds[28] <= 0)
                  {
                     soundChannel = soundCatBrake.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[28] = 5;
                  }
                  break;
               case "cat_headbutt":
                  if(sounds[29] <= 0)
                  {
                     soundChannel = soundCatHeadbutt.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[29] = 5;
                  }
                  break;
               case "water":
                  if(sounds[30] <= 0)
                  {
                     soundChannel = soundWater.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[30] = 5;
                  }
                  break;
               case "water_splash":
                  if(sounds[31] <= 0)
                  {
                     soundChannel = soundWaterSplash.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[31] = 5;
                  }
                  break;
               case "cat_hurt":
                  if(sounds[32] <= 0)
                  {
                     soundChannel = soundCatHurt.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[32] = 5;
                  }
                  break;
               case "cat_hurt_game_over":
                  if(sounds[33] <= 0)
                  {
                     soundChannel = soundCatHurtGameOver.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[33] = 10;
                  }
                  break;
               case "hud_font":
                  if(sounds[34] <= 0)
                  {
                     rand_value = int(Math.random() * 3);
                     if(rand_value == 0)
                     {
                        soundChannel = soundFont1.play(0,1);
                     }
                     else if(rand_value == 1)
                     {
                        soundChannel = soundFont2.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundFont3.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[34] = 5;
                  }
                  break;
               case "brick_destroyed":
                  if(sounds[35] <= 0)
                  {
                     rand_value = int(Math.random() * 2);
                     if(rand_value == 0)
                     {
                        soundChannel = soundBrickDestroyed1.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundBrickDestroyed2.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[35] = 2;
                  }
                  break;
               case "brick_created":
                  if(sounds[36] <= 0)
                  {
                     soundChannel = soundBrickCreated.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[36] = 5;
                  }
                  break;
               case "item_impact_water":
                  if(sounds[37] <= 0)
                  {
                     soundChannel = soundItemImpactWater.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[37] = 2;
                  }
                  break;
               case "ground_stomp":
                  if(sounds[38] <= 0)
                  {
                     soundChannel = soundGroundStomp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[38] = 10;
                  }
                  break;
               case "blip":
                  if(sounds[41] <= 0)
                  {
                     soundChannel = soundBlip.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[41] = 5;
                  }
                  break;
               case "ground_impact":
                  if(sounds[43] <= 0)
                  {
                     soundChannel = soundBulletGroundImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[43] = 5;
                  }
                  break;
               case "red_coin":
                  if(sounds[46] <= 0)
                  {
                     soundChannel = soundRedCoin.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[46] = 5;
                  }
                  break;
               case "blue_platform":
                  if(sounds[47] <= 0)
                  {
                     soundChannel = soundBluePlatform.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[47] = 5;
                  }
                  break;
               case "lever":
                  if(sounds[49] <= 0)
                  {
                     soundChannel = soundLever.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[49] = 5;
                  }
                  break;
               case "gate":
                  if(sounds[50] <= 0)
                  {
                     soundChannel = soundGateOpen.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[50] = 5;
                  }
                  break;
               case "bone":
                  if(sounds[52] <= 0)
                  {
                     soundChannel = soundBone.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[52] = 5;
                  }
                  break;
               case "dark":
                  if(sounds[53] <= 0)
                  {
                     soundChannel = soundDarkCat.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[53] = 50;
                  }
                  break;
               case "skull_wake_up":
                  if(sounds[54] <= 0)
                  {
                     soundChannel = soundSkullWakeUp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[54] = 10;
                  }
                  break;
               case "ice_slide":
                  if(sounds[57] <= 0)
                  {
                     soundChannel = soundIceSlide.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[57] = 10;
                  }
                  break;
               case "ice_shake":
                  if(sounds[58] <= 0)
                  {
                     soundChannel = soundIceShake.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[58] = 5;
                  }
                  break;
               case "ice_impact":
                  if(sounds[59] <= 0)
                  {
                     soundChannel = soundIceImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[59] = 10;
                  }
                  break;
               case "snow_bullet_impact":
               case "coconut_bullet_impact":
                  if(sounds[61] <= 0)
                  {
                     soundChannel = soundSnowBulletImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[61] = 5;
                  }
                  break;
               case "giant_bullet_impact":
                  if(sounds[64] <= 0)
                  {
                     soundChannel = soundGiantBulletImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[64] = 5;
                  }
                  break;
               case "geyser":
                  if(sounds[65] <= 0)
                  {
                     soundChannel = soundGeyser.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[65] = 10;
                  }
                  break;
               case "fire_bullet":
                  if(sounds[66] <= 0)
                  {
                     soundChannel = soundFireBullet.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[66] = 5;
                  }
                  break;
               case "fire_bullet_impact":
                  if(sounds[67] <= 0)
                  {
                     soundChannel = soundFireBulletImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[67] = 5;
                  }
                  break;
               case "red_platform":
                  if(sounds[68] <= 0)
                  {
                     soundChannel = soundRedPlatform.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[68] = 10;
                  }
                  break;
               case "fire_ball":
                  if(sounds[69] <= 0)
                  {
                     soundChannel = soundFireBallShoot.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[69] = 10;
                  }
                  break;
               case "fire_dragon_shoot":
                  if(sounds[70] <= 0)
                  {
                     soundChannel = soundFireDragonShoot.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[70] = 10;
                  }
                  break;
               case "mud":
                  if(sounds[72] <= 0)
                  {
                     soundChannel = soundMud.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[72] = 5;
                  }
                  break;
               case "cat_grey_victory_jump":
                  if(sounds[77] <= 0)
                  {
                     soundChannel = soundGreyCatVictoryJump.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[77] = 5;
                  }
                  break;
               case "cat_red":
               case "cat_mcmeow":
                  if(sounds[78] <= 0)
                  {
                     soundChannel = soundCatRed.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[78] = 5;
                  }
                  break;
               case "cat_chomp":
                  if(sounds[79] <= 0)
                  {
                     soundChannel = soundCatChomp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[79] = 5;
                  }
                  break;
               case "cat_blue":
                  if(sounds[80] <= 0)
                  {
                     soundChannel = soundCatBlue.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[80] = 5;
                  }
                  break;
               case "cat_black":
                  if(sounds[81] <= 0)
                  {
                     soundChannel = soundCatBlack.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[81] = 5;
                  }
                  break;
               case "cat_small":
                  if(sounds[82] <= 0)
                  {
                     soundChannel = soundCatSmall.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[82] = 5;
                  }
                  break;
               case "cat_purr":
                  if(sounds[83] <= 0)
                  {
                     soundChannel = soundCatPurr.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[83] = 5;
                  }
                  break;
               case "cat_glide":
                  if(sounds[84] <= 0)
                  {
                     soundChannel = soundCatGlide.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[84] = 5;
                  }
                  break;
               case "enemy_hurt":
                  if(sounds[87] <= 0)
                  {
                     soundChannel = soundEnemyHurt.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[87] = 5;
                  }
                  break;
               case "seed_attack":
                  if(sounds[88] <= 0)
                  {
                     soundChannel = soundSeedAttack.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[88] = 5;
                  }
                  break;
               case "seed_impact":
                  if(sounds[90] <= 0)
                  {
                     soundChannel = soundSeedBulletImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[90] = 5;
                  }
                  break;
               case "enemy_hurt_bullet":
               case "enemy_hit":
                  if(sounds[91] <= 0)
                  {
                     soundChannel = soundEnemyBullet.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[91] = 5;
                  }
                  break;
               case "ice_melt":
                  if(sounds[93] <= 0)
                  {
                     soundChannel = soundIceMelt.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[93] = 10;
                  }
                  break;
               case "big_enemy_hurt":
                  if(sounds[96] <= 0)
                  {
                     soundChannel = soundBigEnemyHurt.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[96] = 10;
                  }
                  break;
               case "purchase":
                  if(sounds[97] <= 0)
                  {
                     soundChannel = soundPurchase.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[97] = 10;
                  }
                  break;
               case "bell_collected":
                  if(sounds[98] <= 0)
                  {
                     soundChannel = soundItemBellCollected.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[98] = 10;
                  }
                  break;
               case "cat_falls_ground":
                  if(sounds[100] <= 0)
                  {
                     soundChannel = soundCatFallsGround.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[100] = 5;
                  }
                  break;
               case "door_open":
                  if(sounds[101] <= 0)
                  {
                     soundChannel = soundDoorOpen.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[101] = 5;
                  }
                  break;
               case "cat_falls_ground_low":
                  if(sounds[102] <= 0)
                  {
                     soundChannel = soundCatFallsGroundLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[102] = 5;
                  }
                  break;
               case "cat_hop_low":
                  if(sounds[103] <= 0)
                  {
                     soundChannel = soundCatHopLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[103] = 5;
                  }
                  break;
               case "cat_jump_low":
                  if(sounds[104] <= 0)
                  {
                     soundChannel = soundCatJumpLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[104] = 5;
                  }
                  break;
               case "cat_ground_impact":
                  if(sounds[105] <= 0)
                  {
                     soundChannel = soundCatGroundImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[105] = 5;
                  }
                  break;
               case "bird_flying":
                  if(sounds[106] <= 0)
                  {
                     soundChannel = soundBirdFlying.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[106] = 20;
                  }
                  break;
               case "cat_brake_low":
                  if(sounds[107] <= 0)
                  {
                     soundChannel = soundCatBrakeLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[107] = 9;
                  }
                  break;
               case "cat_run_low":
                  if(sounds[108] <= 0)
                  {
                     soundChannel = soundCatRunLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[108] = 20;
                  }
                  break;
               case "chirp":
                  if(sounds[109] <= 0)
                  {
                     if(Math.random() * 100 > 50)
                     {
                        soundChannel = soundChirp1.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundChirp2.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[109] = 5;
                  }
                  break;
               case "dust":
                  if(sounds[110] <= 0)
                  {
                     soundChannel = soundDustEnemy.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[110] = 5;
                  }
                  break;
               case "metal_impact":
                  if(sounds[111] <= 0)
                  {
                     if(Math.random() * 100 > 50)
                     {
                        soundChannel = soundMetalParticleImpact.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundMetalParticleImpactHigh.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[111] = 5;
                  }
                  break;
               case "cat_super_jump":
                  if(sounds[112] <= 0)
                  {
                     soundChannel = soundCatSuperJump.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[112] = 5;
                  }
                  break;
               case "cat_super_jump_low":
                  if(sounds[113] <= 0)
                  {
                     soundChannel = soundCatSuperJumpLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[113] = 5;
                  }
                  break;
               case "vehicle_engine":
                  if(sounds[114] <= 0)
                  {
                     soundChannel = soundVehicleEngine.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[114] = 34;
                  }
                  break;
               case "phone":
                  if(sounds[115] <= 0)
                  {
                     soundChannel = soundPhone.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[115] = 15;
                  }
                  break;
               case "vehicle_stop":
                  if(sounds[116] <= 0)
                  {
                     soundChannel = soundVehicleStop.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[116] = 15;
                  }
                  break;
               case "vehicle_turn_off":
                  if(sounds[117] <= 0)
                  {
                     soundChannel = soundVehicleTurnOff.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[117] = 5;
                  }
                  break;
               case "vehicle_turn_on":
                  if(sounds[118] <= 0)
                  {
                     soundChannel = soundVehicleTurnOn.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[118] = 5;
                  }
                  break;
               case "vehicle_cannon":
                  if(sounds[119] <= 0)
                  {
                     soundChannel = soundVehicleCannon.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[119] = 5;
                  }
                  break;
               case "vehicle_engine_up":
                  if(sounds[120] <= 0)
                  {
                     soundChannel = soundVehicleEngineUp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[120] = 34;
                  }
                  break;
               case "vehicle_reload":
                  if(sounds[121] <= 0)
                  {
                     soundChannel = soundVehicleReload.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[121] = 5;
                  }
                  break;
               case "crate":
                  if(sounds[122] <= 0)
                  {
                     soundChannel = soundCrate.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[122] = 5;
                  }
                  break;
               case "explosion_small":
                  if(sounds[123] <= 0)
                  {
                     soundChannel = soundExplosionSmall.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[123] = 5;
                  }
                  break;
               case "explosion":
               case "explosion_medium":
                  if(sounds[124] <= 0)
                  {
                     soundChannel = soundExplosionMedium.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[124] = 5;
                  }
                  break;
               case "explosion_big":
                  if(sounds[125] <= 0)
                  {
                     soundChannel = soundExplosionBig.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[125] = 5;
                  }
                  break;
               case "enemy_metal_hurt":
                  if(sounds[126] <= 0)
                  {
                     if(Math.random() * 100 > 50)
                     {
                        soundChannel = soundMetalEnemyHurtA.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundMetalEnemyHurtB.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[126] = 5;
                  }
                  break;
               case "enemy_big_metal_hurt":
                  if(sounds[127] <= 0)
                  {
                     soundChannel = soundMetalBigEnemyHurtA.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[127] = 10;
                  }
                  break;
               case "enemy_metal_jump":
                  if(sounds[128] <= 0)
                  {
                     soundChannel = soundMetalEnemyJump.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[128] = 10;
                  }
                  break;
               case "kitten":
                  if(sounds[129] <= 0)
                  {
                     total_attempts = 0;
                     rand_value = int(Math.random() * 4);
                     while(rand_value == last_kitty_voice && total_attempts < 25)
                     {
                        rand_value = int(Math.random() * 4);
                        total_attempts++;
                     }
                     last_kitty_voice = rand_value;
                     if(last_kitty_voice == 0)
                     {
                        soundChannel = soundKitten1.play(0,1);
                     }
                     else if(last_kitty_voice == 1)
                     {
                        soundChannel = soundKitten2.play(0,1);
                     }
                     else if(last_kitty_voice == 2)
                     {
                        soundChannel = soundKitten3.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundKitten4.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[129] = 5;
                  }
                  break;
               case "dig":
                  if(sounds[130] <= 0)
                  {
                     soundChannel = soundDig.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[130] = 5;
                  }
                  break;
               case "clod":
                  if(sounds[131] <= 0)
                  {
                     soundChannel = soundClod.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[131] = 5;
                  }
                  break;
               case "giant_spaceship":
                  if(sounds[132] <= 0)
                  {
                     soundChannel = soundGiantSpaceship.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[132] = 30;
                  }
                  break;
               case "enemy_jump":
                  if(sounds[133] <= 0)
                  {
                     soundChannel = soundEnemyJump.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[133] = 5;
                  }
                  break;
               case "enemy_brake":
                  if(sounds[134] <= 0)
                  {
                     soundChannel = soundEnemyBrake.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[134] = 5;
                  }
                  break;
               case "giant_turnip_defeat":
                  if(sounds[135] <= 0)
                  {
                     soundChannel = soundGiantTurnipDefeat.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[135] = 5;
                  }
                  break;
               case "big_enemy_hit":
                  if(sounds[136] <= 0)
                  {
                     soundChannel = soundBigEnemyHit.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[136] = 10;
                  }
                  break;
               case "egg_impact":
                  if(sounds[137] <= 0)
                  {
                     soundChannel = soundEggImpact.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[137] = 5;
                  }
                  break;
               case "frog":
                  if(sounds[138] <= 0)
                  {
                     if(Math.random() * 100 > 50)
                     {
                        soundChannel = soundFrog1.play(0,1);
                     }
                     else
                     {
                        soundChannel = soundFrog2.play(0,1);
                     }
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[138] = 5;
                  }
                  break;
               case "sandpit":
                  if(sounds[139] <= 0)
                  {
                     soundChannel = soundSandPit.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[139] = 5;
                  }
                  break;
               case "enemy_water":
                  if(sounds[140] <= 0)
                  {
                     soundChannel = soundEnemyWater.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[140] = 5;
                  }
                  break;
               case "log_collision":
                  if(sounds[141] <= 0)
                  {
                     soundChannel = soundLogCollision.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[141] = 5;
                  }
                  break;
               case "mud_slide":
                  if(sounds[142] <= 0)
                  {
                     soundChannel = soundMudSlide.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[142] = 10;
                  }
                  break;
               case "big_impact":
                  if(sounds[143] <= 0)
                  {
                     soundChannel = soundImpactBig.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[143] = 10;
                  }
                  break;
               case "small_impact":
                  if(sounds[144] <= 0)
                  {
                     soundChannel = soundImpactSmall.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[144] = 5;
                  }
                  break;
               case "chain":
                  if(sounds[145] <= 0)
                  {
                     soundChannel = soundChainRattle.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[145] = 5;
                  }
                  break;
               case "woosh":
                  if(sounds[146] <= 0)
                  {
                     soundChannel = soundWoosh.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[146] = 5;
                  }
                  break;
               case "woosh_low":
                  if(sounds[147] <= 0)
                  {
                     soundChannel = soundWooshLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[147] = 5;
                  }
                  break;
               case "fire":
                  if(sounds[148] <= 0)
                  {
                     soundChannel = soundFire1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[148] = 5;
                  }
                  break;
               case "fire_short":
                  if(sounds[149] <= 0)
                  {
                     soundChannel = soundFire2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[149] = 5;
                  }
                  break;
               case "loud_chirp":
               case "chirp_loud":
                  if(sounds[150] <= 0)
                  {
                     soundChannel = soundLoudChirp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[150] = 5;
                  }
                  break;
               case "cat_yawn":
                  if(sounds[151] <= 0)
                  {
                     soundChannel = soundCatYawn.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[151] = 10;
                  }
                  break;
               case "eye_blink":
               case "blink":
               case "cat_blink":
                  if(sounds[152] <= 0)
                  {
                     soundChannel = soundBlink.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[152] = 5;
                  }
                  break;
               case "wind_breeze":
                  if(sounds[153] <= 0)
                  {
                     soundChannel = soundWindBreeze.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[153] = 90;
                  }
                  break;
               case "flyingship_distance":
                  if(sounds[154] <= 0)
                  {
                     soundChannel = soundFlyingshipDistance.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[154] = 20;
                  }
                  break;
               case "flyingship_distance_first":
                  if(sounds[154] <= 0)
                  {
                     soundChannel = soundFlyingshipDistanceFirst.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[154] = 20;
                  }
                  break;
               case "flyingship_malfunction":
                  if(sounds[155] <= 0)
                  {
                     soundChannel = soundFlyingshipMalfunction.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[155] = 20;
                  }
                  break;
               case "flyingship_falldown":
                  if(sounds[156] <= 0)
                  {
                     soundChannel = soundFlyingshipFallDown.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[156] = 20;
                  }
                  break;
               case "explosion_distance":
                  if(sounds[157] <= 0)
                  {
                     soundChannel = soundExplosionDistance.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[157] = 5;
                  }
                  break;
               case "mesa_defeat":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundMesaDefeat.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "mesa_laugh":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundMesaLaugh.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "mesa_snarl":
               case "snarl":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundMesaSnarl.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "green_laugh":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundGreenLaugh.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "mayor":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundCatMayor.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "punch_1":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundBrickDestroyed1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "punch_2":
               case "brick_destroyed_echo":
                  if(sounds[159] <= 0)
                  {
                     soundChannel = soundBrickDestroyedEcho.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[159] = 5;
                  }
                  break;
               case "alarm":
                  if(sounds[160] <= 0)
                  {
                     soundChannel = soundAlarm.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[160] = 60;
                  }
                  break;
               case "hud_woosh":
                  if(sounds[161] <= 0)
                  {
                     soundChannel = soundHudWoosh.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[161] = 5;
                  }
                  break;
               case "fence_exit":
                  if(sounds[162] <= 0)
                  {
                     soundChannel = soundFenceExit.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[162] = 5;
                  }
                  break;
               case "car_engine":
                  if(sounds[163] <= 0)
                  {
                     soundChannel = soundCarEngine.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[163] = 48;
                  }
                  break;
               case "skid":
                  if(sounds[164] <= 0)
                  {
                     soundChannel = soundSkid.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[164] = 5;
                  }
                  break;
               case "wroom":
                  if(sounds[165] <= 0)
                  {
                     soundChannel = soundCarEngineFirst.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[165] = 5;
                  }
                  break;
               case "crystal_ambience":
                  if(sounds[166] <= 0)
                  {
                     soundChannel = soundCrystalAmbience.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[166] = 300;
                  }
                  break;
               case "magic_disappear":
                  if(sounds[167] <= 0)
                  {
                     soundChannel = soundMagicDisappear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[167] = 5;
                  }
                  break;
               case "green_hurt":
                  if(sounds[158] <= 0)
                  {
                     soundChannel = soundGreenHurt.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[158] = 5;
                  }
                  break;
               case "giant_fish_roar":
                  if(sounds[168] <= 0)
                  {
                     soundChannel = soundGiantFishRoar.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[168] = 5;
                  }
                  break;
               case "swoosh":
               case "giant_fish_swoosh":
                  if(sounds[169] <= 0)
                  {
                     soundChannel = soundGiantFishSwoosh.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[169] = 30;
                  }
                  break;
               case "quake":
                  if(sounds[170] <= 0)
                  {
                     soundChannel = soundQuake.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[170] = 300;
                  }
                  break;
               case "quake_fade":
                  if(sounds[170] <= 0)
                  {
                     soundChannel = soundQuakeFade.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[170] = 300;
                  }
                  break;
               case "throw":
                  if(sounds[42] <= 0)
                  {
                     soundChannel = soundThrowBullet.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[42] = 5;
                  }
                  break;
               case "enemy_run":
                  if(sounds[171] <= 0)
                  {
                     soundChannel = soundEnemyRun.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[171] = 5;
                  }
                  break;
               case "boat_horn":
                  if(sounds[172] <= 0)
                  {
                     soundChannel = soundBoatHorn.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[172] = 15;
                  }
                  break;
               case "dragon_screech":
                  if(sounds[173] <= 0)
                  {
                     soundChannel = soundDragonScreech.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[173] = 5;
                  }
                  break;
               case "laal_voice_1":
                  if(sounds[174] <= 0)
                  {
                     soundChannel = soundLaalVoice1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[174] = 5;
                  }
                  break;
               case "laal_voice_2":
                  if(sounds[174] <= 0)
                  {
                     soundChannel = soundLaalVoice2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[174] = 5;
                  }
                  break;
               case "bite":
                  if(sounds[175] <= 0)
                  {
                     soundChannel = soundBite.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[175] = 5;
                  }
                  break;
               case "wind_strong_start":
                  if(sounds[176] <= 0)
                  {
                     soundChannel = soundWindStrongStart.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[176] = 50;
                  }
                  break;
               case "wind_strong_mid":
                  if(sounds[177] <= 0)
                  {
                     soundChannel = soundWindStrongMid.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[177] = 15;
                  }
                  break;
               case "wind_strong_end":
                  if(sounds[178] <= 0)
                  {
                     soundChannel = soundWindStrongEnd.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[178] = 50;
                  }
                  break;
               case "fisherman_voice":
                  if(sounds[179] <= 0)
                  {
                     soundChannel = soundVoiceFisherman.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[179] = 5;
                  }
                  break;
               case "merchant_voice_1":
                  if(sounds[179] <= 0)
                  {
                     soundChannel = soundMerchantVoice1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[179] = 5;
                  }
                  break;
               case "merchant_voice_2":
                  if(sounds[180] <= 0)
                  {
                     soundChannel = soundMerchantVoice2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[180] = 5;
                  }
                  break;
               case "kallio_voice_1":
                  if(sounds[179] <= 0)
                  {
                     soundChannel = soundKallioVoice1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[179] = 5;
                  }
                  break;
               case "kallio_voice_2":
                  if(sounds[180] <= 0)
                  {
                     soundChannel = soundKallioVoice2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[180] = 5;
                  }
                  break;
               case "beam_start":
                  if(sounds[181] <= 0)
                  {
                     soundChannel = soundBeamStart.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[181] = 100;
                  }
                  break;
               case "beam_repeat":
                  if(sounds[181] <= 0)
                  {
                     soundChannel = soundBeamRepeat.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[181] = 60;
                  }
                  break;
               case "beam_shoot":
                  if(sounds[183] <= 0)
                  {
                     soundChannel = soundBeamShoot.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[183] = 5;
                  }
                  break;
               case "dragon_wing":
               case "wing":
                  if(sounds[184] <= 0)
                  {
                     soundChannel = soundDragonWing.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[184] = 5;
                  }
                  break;
               case "small_quake":
                  if(sounds[185] <= 0)
                  {
                     soundChannel = soundSmallQuake.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[185] = 60;
                  }
                  break;
               case "train_track":
                  if(sounds[186] <= 0)
                  {
                     soundChannel = soundTrainTrack.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[186] = 5;
                  }
                  break;
               case "train_track_slow":
                  if(sounds[187] <= 0)
                  {
                     soundChannel = soundTrainTrackSlow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[187] = 5;
                  }
                  break;
               case "train_whistle":
                  if(sounds[188] <= 0)
                  {
                     soundChannel = soundTrainWhistle.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[188] = 5;
                  }
                  break;
               case "enemy_ice_slide":
                  if(sounds[189] <= 0)
                  {
                     soundChannel = soundEnemyIceSlide.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[189] = 10;
                  }
                  break;
               case "fire_shoot":
                  if(sounds[190] <= 0)
                  {
                     soundChannel = soundFireShoot.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[190] = 5;
                  }
                  break;
               case "ghost_scared":
                  if(sounds[191] <= 0)
                  {
                     soundChannel = soundGhostScared.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[191] = 5;
                  }
                  break;
               case "iridium_voice_1":
                  if(sounds[192] <= 0)
                  {
                     soundChannel = soundIridiumVoice1.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[192] = 5;
                  }
                  break;
               case "iridium_voice_2":
                  if(sounds[193] <= 0)
                  {
                     soundChannel = soundIridiumVoice2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[193] = 5;
                  }
                  break;
               case "sound_crystal_appear":
                  if(sounds[194] <= 0)
                  {
                     soundChannel = soundCrystalAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[194] = 60;
                  }
                  break;
               case "tongue":
                  if(sounds[195] <= 0)
                  {
                     soundChannel = soundTongue.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[195] = 5;
                  }
                  break;
               case "snow_cannon":
                  if(sounds[196] <= 0)
                  {
                     soundChannel = soundSnowCannon.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[196] = 5;
                  }
                  break;
               case "cat_demise":
                  if(sounds[197] <= 0)
                  {
                     soundChannel = soundCatDemise.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[197] = 30;
                  }
                  break;
               case "cat_grey":
               case "cat_soldier":
                  if(sounds[198] <= 0)
                  {
                     soundChannel = soundCatSoldier.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[198] = 5;
                  }
                  break;
               case "error":
                  if(sounds[199] <= 0)
                  {
                     soundChannel = soundError2.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[199] = 2;
                  }
                  break;
               case "baburu":
                  if(sounds[200] <= 0)
                  {
                     soundChannel = soundBaburu.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[200] = 5;
                  }
                  break;
               case "hero_cannon":
                  if(sounds[201] <= 0)
                  {
                     soundChannel = soundHeroCannon.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[201] = 5;
                  }
                  break;
               case "cat_angry":
                  if(sounds[202] <= 0)
                  {
                     soundChannel = soundCatAngry.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[202] = 5;
                  }
                  break;
               case "atomic_explosion":
                  if(sounds[203] <= 0)
                  {
                     soundChannel = soundAtomicExplosion.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[203] = 60;
                  }
                  break;
               case "title_appear":
                  if(sounds[204] <= 0)
                  {
                     soundChannel = soundTitleAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[204] = 5;
                  }
                  break;
               case "car_start":
                  if(sounds[204] <= 0)
                  {
                     soundChannel = soundCarStart.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[204] = 5;
                  }
                  break;
               case "car_running":
                  if(sounds[203] <= 0)
                  {
                     soundChannel = soundCarRunning.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[203] = 15;
                  }
                  break;
               case "blow":
                  if(sounds[203] <= 0)
                  {
                     soundChannel = soundBlow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[203] = 5;
                  }
                  break;
               case "rock_stomp":
                  if(sounds[204] <= 0)
                  {
                     soundChannel = soundRockStomp.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[204] = 5;
                  }
                  break;
               case "enemy_jump_low":
                  if(sounds[205] <= 0)
                  {
                     soundChannel = soundEnemyJumpLow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[205] = 5;
                  }
                  break;
               case "tongue_mesa":
                  if(sounds[206] <= 0)
                  {
                     soundChannel = soundTongueMesa.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[206] = 5;
                  }
                  break;
               case "eat":
                  if(sounds[207] <= 0)
                  {
                     soundChannel = soundEat.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[207] = 5;
                  }
                  break;
               case "unglue":
               case "wiggle":
                  if(sounds[208] <= 0)
                  {
                     soundChannel = soundWiggle.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[208] = 5;
                  }
                  break;
               case "enemy_shoot":
               case "enemy_shoot_bubble":
                  if(sounds[209] <= 0)
                  {
                     soundChannel = soundEnemyShoot.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[209] = 5;
                  }
                  break;
               case "arcade_laser":
                  if(sounds[210] <= 0)
                  {
                     soundChannel = soundArcadeLaser.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[210] = 5;
                  }
                  break;
               case "arcade_coin":
                  if(sounds[210] <= 0)
                  {
                     soundChannel = soundArcadeCoin.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[210] = 5;
                  }
                  break;
               case "arcade_explosion":
                  if(sounds[211] <= 0)
                  {
                     soundChannel = soundArcadeExplosion.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[211] = 5;
                  }
                  break;
               case "arcade_flap":
                  if(sounds[211] <= 0)
                  {
                     soundChannel = soundArcadeFlap.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[211] = 5;
                  }
                  break;
               case "arcade_walk":
                  if(sounds[212] <= 0)
                  {
                     soundChannel = soundArcadeWalk.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[212] = 10;
                  }
                  break;
               case "arcade_bonus":
                  if(sounds[213] <= 0)
                  {
                     soundChannel = soundArcadeBonus.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[213] = 10;
                  }
                  break;
               case "crank":
                  if(sounds[214] <= 0)
                  {
                     soundChannel = soundPulleyCrank.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[214] = 60;
                  }
                  break;
               case "hide":
                  if(sounds[215] <= 0)
                  {
                     soundChannel = soundHide.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[215] = 5;
                  }
                  break;
               case "door_exit":
                  if(sounds[215] <= 0)
                  {
                     soundChannel = soundDoorExit.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[215] = 5;
                  }
                  break;
               case "enemy_shoot_sticky":
                  if(sounds[216] <= 0)
                  {
                     soundChannel = soundEnemyShootSticky.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[216] = 5;
                  }
                  break;
               case "coin_appear":
                  if(sounds[215] <= 0)
                  {
                     soundChannel = soundCoinAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[215] = 2;
                  }
                  break;
               case "wind_enemy":
                  if(sounds[216] <= 0)
                  {
                     soundChannel = soundWindEnemy.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[216] = 5;
                  }
                  break;
               case "giant_door_open":
                  if(sounds[218] <= 0)
                  {
                     soundChannel = soundGiantDoorOpen.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[218] = 5;
                  }
                  break;
               case "giant_door_close":
                  if(sounds[219] <= 0)
                  {
                     soundChannel = soundGiantDoorClose.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[219] = 5;
                  }
                  break;
               case "warlock_appear":
                  if(sounds[220] <= 0)
                  {
                     soundChannel = soundWarlockAppear.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[220] = 5;
                  }
                  break;
               case "cat_rose":
                  if(sounds[221] <= 0)
                  {
                     soundChannel = soundCatRose.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[221] = 5;
                  }
                  break;
               case "cat_wink":
               case "wink":
                  if(sounds[222] <= 0)
                  {
                     soundChannel = soundCatWink.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[222] = 5;
                  }
                  break;
               case "cat_rigs_angry":
               case "rigs_angry":
                  if(sounds[223] <= 0)
                  {
                     soundChannel = soundCatRigsAngry.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[223] = 15;
                  }
                  break;
               case "rigs":
               case "cat_rigs":
                  if(sounds[224] <= 0)
                  {
                     soundChannel = soundRigs.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[224] = 5;
                  }
                  break;
               case "dash":
                  if(sounds[225] <= 0)
                  {
                     soundChannel = soundDash.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[225] = 5;
                  }
                  break;
               case "fox_laugh":
                  if(sounds[226] <= 0)
                  {
                     soundChannel = soundFoxLaugh.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[226] = 5;
                  }
                  break;
               case "bell":
                  if(sounds[226] <= 0)
                  {
                     soundChannel = soundBell.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[226] = 5;
                  }
                  break;
               case "cast":
                  if(sounds[227] <= 0)
                  {
                     soundChannel = soundCast.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[227] = 5;
                  }
                  break;
               case "reel":
                  if(sounds[228] <= 0)
                  {
                     soundChannel = soundReel.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[228] = 9;
                  }
                  break;
               case "reel_struggle":
                  if(sounds[230] <= 0)
                  {
                     soundChannel = soundReelStruggle.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[230] = 9;
                  }
                  break;
               case "fish_bite":
                  if(sounds[229] <= 0)
                  {
                     soundChannel = soundFishBite.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[229] = 5;
                  }
                  break;
               case "mara":
               case "cat_mara":
                  if(sounds[230] <= 0)
                  {
                     soundChannel = soundCatMara.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[230] = 5;
                  }
                  break;
               case "whistle":
                  if(sounds[231] <= 0)
                  {
                     soundChannel = soundWhistle.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[231] = 10;
                  }
                  break;
               case "dog":
                  if(sounds[232] <= 0)
                  {
                     soundChannel = soundDog.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[232] = 5;
                  }
                  break;
               case "lace":
                  if(sounds[233] <= 0)
                  {
                     soundChannel = soundLace.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[233] = 10;
                  }
                  break;
               case "item_notification":
                  if(sounds[234] <= 0)
                  {
                     soundChannel = soundItemNotification.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[234] = 10;
                  }
                  break;
               case "plant_grow":
                  if(sounds[234] <= 0)
                  {
                     soundChannel = soundPlantGrow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[234] = 5;
                  }
                  break;
               case "bounce":
                  if(sounds[235] <= 0)
                  {
                     soundChannel = soundBounce.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[235] = 5;
                  }
                  break;
               case "leg":
               case "spider_leg":
                  if(sounds[236] <= 0)
                  {
                     soundChannel = soundLegMove.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[236] = 5;
                  }
                  break;
               case "spider_voice":
                  if(sounds[237] <= 0)
                  {
                     soundChannel = soundSpiderVoice.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[237] = 5;
                  }
                  break;
               case "spider_defeat":
                  if(sounds[238] <= 0)
                  {
                     soundChannel = soundSpideDefeat.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[238] = 5;
                  }
                  break;
               case "thunder":
                  if(sounds[239] <= 0)
                  {
                     soundChannel = soundThunder.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[239] = 5;
                  }
                  break;
               case "electricity_mid":
                  if(sounds[240] <= 0)
                  {
                     soundChannel = soundElectricityMid.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[240] = 5;
                  }
                  break;
               case "electricity_end":
                  if(sounds[241] <= 0)
                  {
                     soundChannel = soundElectricityEnd.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[241] = 5;
                  }
                  break;
               case "bubble_attack":
                  if(sounds[242] <= 0)
                  {
                     soundChannel = soundHelperBubble.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[242] = 5;
                  }
                  break;
               case "arrow":
                  if(sounds[243] <= 0)
                  {
                     soundChannel = soundArrow.play(0,1);
                     if(soundChannel != null)
                     {
                        soundChannel.soundTransform = _soundTransform;
                     }
                     sounds[243] = 5;
                  }
            }
         }
      }
   }
}

