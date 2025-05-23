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
      
      public static var soundCatBrake:SoundCatBrake;
      
      public static var soundCatBrakeLow:SoundCatBrakeLow;
      
      public static var soundCatHurt:SoundCatHurt;
      
      public static var soundCatHurtGameOver:SoundCatHurtGameOver;
      
      public static var soundCatRun:SoundCatRun;
      
      public static var soundCatRunLow:SoundCatRunLow;
      
      public static var soundCatJump:SoundCatJump;
      
      public static var soundCatHeadbutt:SoundCatHeadbutt;
      
      public static var soundWater:SoundWater;
      
      public static var soundWaterSplash:SoundWaterSplash;
      
      public static var soundIceSlide:SoundIceSlide;
      
      public static var soundCatFallsGround:SoundCatFallsGround;
      
      public static var soundCatJumpLow:SoundCatJumpLow;
      
      public static var soundCatHopLow:SoundCatHopLow;
      
      public static var soundCatFallsGroundLow:SoundCatFallsGroundLow;
      
      public static var soundCatGroundImpact:SoundCatGroundImpact;
      
      public static var soundDarkCat:SoundDarkCat;
      
      public static var soundGreyCatVictoryJump:SoundGreyCatVictoryJump;
      
      public static var soundCatSuperJump:SoundCatSuperJump;
      
      public static var soundCatSuperJumpLow:SoundCatSuperJumpLow;
      
      public static var soundCatYawn:SoundCatYawn;
      
      public static var soundBlink:SoundBlink;
      
      public static var soundItemBellCollected:SoundItemBellCollected;
      
      public static var soundButterfliesAppear:SoundButterfliesAppear;
      
      public static var soundItemCoin:SoundItemCoin;
      
      public static var soundItemImpact:SoundItemImpact;
      
      public static var soundItemImpactWater:SoundItemImpactWater;
      
      public static var soundBellCollected:SoundBellCollected;
      
      public static var soundItemAppear:SoundItemAppear;
      
      public static var soundItemPop:SoundItemPop;
      
      public static var soundPotCollected:SoundPotCollected;
      
      public static var soundPotPop:SoundBottlePop;
      
      public static var soundButterflyCollected1:SoundButterflyCollected1;
      
      public static var soundButterflyCollected2:SoundButterflyCollected2;
      
      public static var soundButterflyCollected3:SoundButterflyCollected3;
      
      public static var soundButterflyCollected4:SoundButterflyCollected4;
      
      public static var soundButterflyCollected5:SoundButterflyCollected5;
      
      public static var soundRedCoin:SoundRedCoin;
      
      public static var soundDoorClose:SoundDoorClose;
      
      public static var soundDoorOpen:SoundDoorOpen;
      
      public static var soundBrickDestroyed1:SoundBrickDestroyed1;
      
      public static var soundBrickDestroyed2:SoundBrickDestroyed2;
      
      public static var soundBrickCreated:SoundBrickCreated;
      
      public static var soundBluePlatform:SoundBluePlatform;
      
      public static var soundBone:SoundBone;
      
      public static var soundFireBallShoot:SoundFireBallShoot;
      
      public static var soundGeyser:SoundGeyser;
      
      public static var soundIceShake:SoundIceShake;
      
      public static var soundIceImpact:SoundIceImpact;
      
      public static var soundLever:SoundLever;
      
      public static var soundMud:SoundMud;
      
      public static var soundRedPlatform:SoundRedPlatform;
      
      public static var soundCrate:SoundCrate;
      
      public static var soundExplosionBig:SoundExplosionBig;
      
      public static var soundExplosionMedium:SoundExplosionMedium;
      
      public static var soundExplosionSmall:SoundExplosionSmall;
      
      public static var soundClod:SoundClod;
      
      public static var soundSandPit:SoundSandPit;
      
      public static var soundLogCollision:SoundLogCollision;
      
      public static var soundMudSlide:SoundMudSlide;
      
      public static var soundImpactSmall:SoundImpactSmall;
      
      public static var soundImpactBig:SoundImpactBig;
      
      public static var soundChainRattle:SoundChainRattle;
      
      public static var soundWoosh:SoundWoosh;
      
      public static var soundWooshLow:SoundWooshLow;
      
      public static var soundGateOpen:SoundGateOpen;
      
      public static var soundFire1:SoundFire1;
      
      public static var soundFire2:SoundFire2;
      
      public static var soundExplosionDistance:SoundExplosionDistance;
      
      public static var soundBrickDestroyedEcho:SoundBrickDestroyedEcho;
      
      public static var soundFenceExit:SoundFenceExit;
      
      public static var soundCarEngine:SoundCarEngine;
      
      public static var soundSkid:SoundSkid;
      
      public static var soundCarEngineFirst:SoundCarEngineFirst;
      
      public static var soundIceMelt:SoundIceMelt;
      
      public static var soundHeroCannon:SoundHeroCannon;
      
      public static var soundCatAngry:SoundCatAngry;
      
      public static var soundVehicleEngine:SoundVehicleEngine;
      
      public static var soundPhone:SoundPhone;
      
      public static var soundVehicleStop:SoundVehicleStop;
      
      public static var soundVehicleEngineUp:SoundVehicleEngineUp;
      
      public static var soundVehicleTurnOff:SoundVehicleTurnOff;
      
      public static var soundVehicleTurnOn:SoundVehicleTurnOn;
      
      public static var soundVehicleCannon:SoundVehicleCannon;
      
      public static var soundVehicleReload:SoundVehicleReload;
      
      public static var soundEnemyBullet:SoundEnemyBullet;
      
      public static var soundEnemyHurt:SoundEnemyHurt;
      
      public static var soundBigEnemyHurt:SoundBigEnemyHurt;
      
      public static var soundGroundStomp:SoundGroundStomp;
      
      public static var soundDustEnemy:SoundDustEnemy;
      
      public static var soundMetalEnemyHurtA:SoundMetalEnemyHurtA;
      
      public static var soundMetalEnemyHurtB:SoundMetalEnemyHurtB;
      
      public static var soundMetalBigEnemyHurtA:SoundMetalBigEnemyHurtA;
      
      public static var soundMetalEnemyJump:SoundMetalEnemyJump;
      
      public static var soundDig:SoundDig;
      
      public static var soundEnemyJump:SoundEnemyJump;
      
      public static var soundEnemyBrake:SoundEnemyBrake;
      
      public static var soundGiantTurnipDefeat:SoundGiantTurnipDefeat;
      
      public static var soundBigEnemyHit:SoundBigEnemyHit;
      
      public static var soundFrog1:SoundFrog1;
      
      public static var soundFrog2:SoundFrog2;
      
      public static var soundEnemyWater:SoundEnemyWater;
      
      public static var soundGiantFishRoar:SoundGiantFishRoar;
      
      public static var soundGiantFishSwoosh:SoundGiantFishSwoosh;
      
      public static var soundEnemyRun:SoundEnemyRun;
      
      public static var soundBeamStart:SoundBeamStart;
      
      public static var soundBeamShoot:SoundBeamShoot;
      
      public static var soundBeamRepeat:SoundBeamRepeat;
      
      public static var soundDragonWing:SoundDragonWing;
      
      public static var soundEnemyIceSlide:SoundEnemyIceSlide;
      
      public static var soundGhostScared:SoundGhostScared;
      
      public static var soundTongue:SoundTongue;
      
      public static var soundDecorationBlown:SoundDecorationBlown;
      
      public static var soundBirdFlying:SoundBirdFlying;
      
      public static var soundChirp1:SoundChirp1;
      
      public static var soundChirp2:SoundChirp2;
      
      public static var soundLoudChirp:SoundLoudChirp;
      
      public static var soundGiantSpaceship:SoundGiantSpaceship;
      
      public static var soundWindBreeze:SoundWindBreeze;
      
      public static var soundFlyingshipDistance:SoundFlyingshipDistance;
      
      public static var soundFlyingshipDistanceFirst:SoundFlyingshipDistanceFirst;
      
      public static var soundFlyingshipMalfunction:SoundFlyingshipMalfunction;
      
      public static var soundFlyingshipFallDown:SoundFlyingshipFallDown;
      
      public static var soundAlarm:SoundAlarm;
      
      public static var soundCrystalAmbience:SoundCrystalAmbience;
      
      public static var soundMagicDisappear:SoundMagicDisappear;
      
      public static var soundQuake:SoundQuake;
      
      public static var soundQuakeFade:SoundQuakeFade;
      
      public static var soundBoatHorn:SoundBoatHorn;
      
      public static var soundWindStrongStart:SoundWindStrongStart;
      
      public static var soundWindStrongMid:SoundWindStrongMid;
      
      public static var soundWindStrongEnd:SoundWindStrongEnd;
      
      public static var soundSmallQuake:SoundSmallQuake;
      
      public static var soundTrainTrack:SoundTrainTrack;
      
      public static var soundTrainTrackSlow:SoundTrainTrackSlow;
      
      public static var soundTrainWhistle:SoundTrainWhistle;
      
      public static var soundCrystalAppear:SoundCrystalAppear;
      
      public static var soundLogo:SoundLogo;
      
      public static var soundBlip:SoundBlip;
      
      public static var soundSelect:SoundSelect;
      
      public static var soundFont1:SoundFont1;
      
      public static var soundFont2:SoundFont2;
      
      public static var soundFont3:SoundFont3;
      
      public static var soundConfirmLong:SoundConfirmLong;
      
      public static var soundConfirmShort:SoundConfirmShort;
      
      public static var soundHudItemCollected:SoundHudItemCollected;
      
      public static var soundError:SoundError;
      
      public static var soundError2:SoundError2;
      
      public static var soundPurchase:SoundPurchase;
      
      public static var soundHudWoosh:SoundHudWoosh;
      
      public static var soundBulletGroundImpact:SoundBulletGroundImpact;
      
      public static var soundSnowBulletImpact:SoundSnowBulletImpact;
      
      public static var soundFireBulletImpact:SoundFireBulletImpact;
      
      public static var soundFireBullet:SoundFireBullet;
      
      public static var soundGiantBulletImpact:SoundGiantBulletImpact;
      
      public static var soundSeedBulletImpact:SoundSeedBulletImpact;
      
      public static var soundEggImpact:SoundEggImpact;
      
      public static var soundThrowBullet:SoundThrowBullet;
      
      public static var soundFireShoot:SoundFireShoot;
      
      public static var soundSnowCannon:SoundSnowCannon;
      
      public static var soundMetalParticleImpact:SoundMetalParticleImpact;
      
      public static var soundMetalParticleImpactHigh:SoundMetalParticleImpactHigh;
      
      public static var soundCatBlue:SoundCatBlue;
      
      public static var soundCatBlack:SoundCatBlack;
      
      public static var soundCatGlide:SoundCatGlide;
      
      public static var soundCatRed:SoundCatRed;
      
      public static var soundCatChomp:SoundCatChomp;
      
      public static var soundCatPurr:SoundPurr;
      
      public static var soundCatSmall:SoundCatSmall;
      
      public static var soundKitten1:SoundKitten1;
      
      public static var soundKitten2:SoundKitten2;
      
      public static var soundKitten3:SoundKitten3;
      
      public static var soundKitten4:SoundKitten4;
      
      public static var soundMesaLaugh:SoundMesaLaugh;
      
      public static var soundMesaSnarl:SoundMesaSnarl;
      
      public static var soundMesaDefeat:SoundMesaDefeat;
      
      public static var soundGreenLaugh:SoundGreenLaugh;
      
      public static var soundCatMayor:SoundCatMayor;
      
      public static var soundGreenHurt:SoundGreenHurt;
      
      public static var soundDragonScreech:SoundDragonScreech;
      
      public static var soundLaalVoice1:SoundVoiceLaal1;
      
      public static var soundLaalVoice2:SoundVoiceLaal2;
      
      public static var soundBite:SoundBite;
      
      public static var soundMerchantVoice1:SoundMerchantVoice1;
      
      public static var soundMerchantVoice2:SoundMerchantVoice2;
      
      public static var soundVoiceFisherman:SoundVoiceFisherman;
      
      public static var soundKallioVoice1:SoundKallioVoice1;
      
      public static var soundKallioVoice2:SoundKallioVoice2;
      
      public static var soundIridiumVoice1:SoundIridiumVoice1;
      
      public static var soundIridiumVoice2:SoundIridiumVoice2;
      
      public static var soundCatDemise:SoundCatDemise;
      
      public static var soundCatSoldier:SoundCatSoldier;
      
      public static var soundBaburu:SoundBaburu;
      
      public static var soundMapExplosion:SoundMapExplosion;
      
      public static var soundMapAdvance:SoundMapAdvance;
      
      public static var soundMapStomp:SoundMapStomp;
      
      public static var soundMapAppear:SoundMapAppear;
      
      public static var soundMapRumble:SoundMapRumble;
      
      public static var soundAtomicExplosion:SoundAtomicExplosion;
      
      public static var soundTitleAppear:SoundTitleAppear;
      
      public static var soundCarStart:SoundCarStart;
      
      public static var soundCarRunning:SoundCarRunning;
      
      public static var soundBlow:SoundBlow;
      
      public static var soundRockStomp:SoundRockStomp;
      
      public static var soundEnemyJumpLow:SoundEnemyJumpLow;
      
      public static var soundTongueMesa:SoundTongueMesa;
      
      public static var soundEat:SoundEat;
      
      public static var soundEnemyShoot:SoundEnemyShoot;
      
      public static var soundWiggle:SoundWiggle;
      
      public static var soundHide:SoundHide;
      
      public static var soundDoorExit:SoundDoorExit;
      
      public static var soundArcadeFlap:SoundArcadeFlap;
      
      public static var soundArcadeCoin:SoundArcadeCoin;
      
      public static var soundArcadeLaser:SoundArcadeLaser;
      
      public static var soundArcadeExplosion:SoundArcadeExplosion;
      
      public static var soundArcadeWalk:SoundArcadeWalk;
      
      public static var soundArcadeBonus:SoundArcadeBonus;
      
      public static var soundPulleyCrank:SoundPulleyCrank;
      
      public static var soundEnemyShootSticky:SoundEnemyShootSticky;
      
      public static var soundCoinAppear:SoundCoinAppear;
      
      public static var soundWindEnemy:SoundWindEnemy;
      
      public static var soundGiantDoorOpen:SoundGiantDoorOpen;
      
      public static var soundGiantDoorClose:SoundGiantDoorClose;
      
      public static var soundWarlockAppear:SoundWarlockAppear;
      
      public static var soundCatRose:SoundCatRose;
      
      public static var soundCatWink:SoundCatWink;
      
      public static var soundCatRigsAngry:SoundRigsAngry;
      
      public static var soundRigs:SoundRigs;
      
      public static var soundSkullWakeUp:SoundSkullWakeUp;
      
      public static var soundDash:SoundDash;
      
      public static var soundFoxLaugh:SoundFoxLaugh;
      
      public static var soundBell:SoundBell;
      
      public static var soundReel:SoundReel;
      
      public static var soundReelStruggle:SoundReelStruggle;
      
      public static var soundFishBite:SoundFishBite;
      
      public static var soundCatMara:SoundCatMara;
      
      public static var soundWhistle:SoundWhistle;
      
      public static var soundDog:SoundDog;
      
      public static var soundFireDragonShoot:SoundFireDragonShoot;
      
      public static var soundLace:SoundLace;
      
      public static var soundItemNotification:SoundItemNotification;
      
      public static var soundSeedAttack:SoundSeedAttack;
      
      public static var soundPlantGrow:SoundPlantGrow;
      
      public static var soundBounce:SoundBounce;
      
      public static var soundLegMove:SoundLegMove;
      
      public static var soundSpiderVoice:SoundSpiderVoice;
      
      public static var soundSpideDefeat:SoundSpiderDefeat;
      
      public static var soundThunder:SoundThunder;
      
      public static var soundElectricityMid:SoundElectricityMid;
      
      public static var soundElectricityEnd:SoundElectricityEnd;
      
      public static var soundHelperBubble:SoundHelperBubble;
      
      public static var soundArrow:SoundArrow;
      
      public static var soundCast:SoundCast;
      
      public static var musicOutsideRain:MusicOutsideRain;
      
      public static var musicOutsideTrees:MusicOutsideTrees;
      
      public static var musicOutsideTreesNight:MusicOutsideTreesNight;
      
      public static var musicOutsideMountain:MusicOutsideMountain;
      
      public static var musicOutsideDesert:MusicOutsideDesert;
      
      public static var musicInsideCave:MusicInsideCave;
      
      public static var musicOutsideSea:MusicOutsideSea;
      
      public static var musicOutsideSeaNight:MusicOutsideSeaNight;
      
      public static var musicRain:MusicRain;
      
      public static var musicButterfliesComplete:MusicButterfliesComplete;
      
      public static var musicVictory:MusicLevelComplete;
      
      public static var musicGameOver:MusicGameOver;
      
      public static var musicRadioStation:MusicRadioStation;
      
      public static var musicBandits:MusicBandits;
      
      public static var musicWoods:MusicWoods;
      
      public static var musicHive:MusicHive;
      
      public static var musicMidBoss:MusicMidBoss;
      
      public static var musicPawsBase:MusicPawsBase;
      
      public static var musicArcade:MusicArcade;
      
      public static var musicCatTalk:MusicCatTalk;
      
      public static var musicCatDanger:MusicCatDanger;
      
      public static var musicArcadeStart:MusicArcadeStart;
      
      public static var musicArcadeGameOver:MusicArcadeGameOver;
      
      public static var musicCanyon:MusicCanyon;
      
      public static var musicFortress:MusicFortress;
      
      public static var musicBoss:MusicBoss;
      
      public static var musicBeach:MusicBeach;
      
      public static var musicCave:MusicCave;
      
      public static var musicPortobello:MusicPortobello;
      
      public static var musicInsideTavern:MusicInsideTavern;
      
      public static var musicFishing:MusicFishing;
      
      public static var musicFishingFight:MusicFishingFight;
      
      public static var musicButterflies:MusicButterflies;
      
      public static var musicOcean:MusicOcean;
      
      public static var musicMap:MusicMap;
      
      public static var musicOutsideIceberg:MusicOutsideIceberg;
      
      public static var musicIntro:MusicIntro;
      
      public static var musicSplash:MusicSplash;
      
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
      
      public static function InitSounds() : void
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
      
      public static function PlayLevelMusic() : void
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
         switch(musicName)
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
            switch(soundName)
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

