class TgTutorialInfo extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

var () float fButtonHoldTime;
var () float fVolumeStandTime;
var () float fBotRespawnTime;
var () float fBotTargetsKilledWaitTime;
var () float fPlayerTeamCaptureMultiplier;
var () float fRepeatInstructionTime;
var () float fExtendedRepeatInstructionTime;
var () float fIntroExtensionTime;
var () float fBotDelayTravelToMovementTime;
var () float fBotDelayTravelToUltRangeTime;
var () float fPayloadContestPercent;
var () float fLanePusherGroundSpeed;
var () float fEnergyChargeMultiplier;
var () TgTutorialVolume ApproachHelperArea;
var () TgTutorialVolume AutoShootingRangeStandingTargetArea;
var () TgTutorialVolume UltimateShootingRangeStandingTargetArea;
var () TgTutorialVolume JumpLowerArea;
var () TgTutorialVolume JumpUpperArea;
var () TgBotFactory HelperBotFactory;
var () TgBotFactory AutoBotFactory;
var () TgBotFactory MultipleAutoBotFactory;
var () TgBotFactory BattleAbilityBotFactory;
var () TgBotFactory AltAbilityBotFactory;
var () TgBotFactory UltimateChargeBotFactory;
var () TgBotFactory UltimateAbilityBotFactory;
var () TgBotFactory ContestCapturePointBotFactory;
var () TgBotFactory ContestPayloadBotsFactory;
var () Actor HelperMoveTargetAutoRange;
var () Actor HelperMoveTargetMovementAbility;
var () Actor HelperMoveTargetUltRange;
var () Actor EndGameFocus;
var TgAIController_Behavior HelperBotController;

function SpawnHelperBot() { }

function DestroyHelperBot() { }

function bool HelperIsNavigatingToOrAtDestination(Actor Destination) { }

function MoveHelperToActor(Actor Destination) { }

function TeleportHelperToActor(Actor Destination) { }

defaultproperties
{
    fButtonHoldTime=0.5000000
    fVolumeStandTime=0.7500000
    fBotRespawnTime=0.7500000
    fBotTargetsKilledWaitTime=0.5000000
    fPlayerTeamCaptureMultiplier=0.8500000
    fRepeatInstructionTime=8.0000000
    fExtendedRepeatInstructionTime=16.0000000
    fIntroExtensionTime=4.2000000
    fBotDelayTravelToMovementTime=1.5000000
    fBotDelayTravelToUltRangeTime=1.5000000
    fPayloadContestPercent=0.6500000
    fLanePusherGroundSpeed=1000.0000000
    fEnergyChargeMultiplier=7.0000000
    Components[0]=none
}
