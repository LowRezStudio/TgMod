class TgTutorialInfo extends Actor
    placeable
    hidecategories(Navigation);

var() float fButtonHoldTime;
var() float fVolumeStandTime;
var() float fBotRespawnTime;
var() float fBotTargetsKilledWaitTime;
var() float fPlayerTeamCaptureMultiplier;
var() float fRepeatInstructionTime;
var() float fExtendedRepeatInstructionTime;
var() float fIntroExtensionTime;
var() float fBotDelayTravelToMovementTime;
var() float fBotDelayTravelToUltRangeTime;
var() float fPayloadContestPercent;
var() float fLanePusherGroundSpeed;
var() float fEnergyChargeMultiplier;
var() TgTutorialVolume ApproachHelperArea;
var() TgTutorialVolume AutoShootingRangeStandingTargetArea;
var() TgTutorialVolume UltimateShootingRangeStandingTargetArea;
var() TgTutorialVolume JumpLowerArea;
var() TgTutorialVolume JumpUpperArea;
var() TgBotFactory HelperBotFactory;
var() TgBotFactory AutoBotFactory;
var() TgBotFactory MultipleAutoBotFactory;
var() TgBotFactory BattleAbilityBotFactory;
var() TgBotFactory AltAbilityBotFactory;
var() TgBotFactory UltimateChargeBotFactory;
var() TgBotFactory UltimateAbilityBotFactory;
var() TgBotFactory ContestCapturePointBotFactory;
var() TgBotFactory ContestPayloadBotsFactory;
var() Actor HelperMoveTargetAutoRange;
var() Actor HelperMoveTargetMovementAbility;
var() Actor HelperMoveTargetUltRange;
var() Actor EndGameFocus;
var TgAIController_Behavior HelperBotController;

function SpawnHelperBot()
{
    local TgPawn TgP;

    // End:0xA0
    if(HelperBotFactory != none)
    {
        HelperBotFactory.ResetQueue();
        TgP = TgPawn(HelperBotFactory.UseSpawnTable());
        // End:0xA0
        if(TgP != none)
        {
            HelperBotController = TgAIController_Behavior(TgP.Controller);
        }
    }
    //return;    
}

function DestroyHelperBot()
{
    // End:0x83
    if(HelperBotController != none)
    {
        // End:0x60
        if(HelperBotController.Pawn != none)
        {
            HelperBotController.Pawn.Destroy();
        }
        HelperBotController.Destroy();
        HelperBotController = none;
    }
    //return;    
}

function bool HelperIsNavigatingToOrAtDestination(Actor Destination)
{
    local Vector ProjectedDestination, PawnX, PawnY, PawnZ;

    // End:0x204
    if(((Destination != none) && HelperBotController != none) && HelperBotController.Pawn != none)
    {
        GetAxes(HelperBotController.Pawn.Rotation, PawnX, PawnY, PawnZ);
        ProjectedDestination = PointProjectToPlane(Destination.Location, HelperBotController.Pawn.Location, HelperBotController.Pawn.Location + PawnX, HelperBotController.Pawn.Location + PawnY);
        // End:0x204
        if((VSizeSq(HelperBotController.Pawn.Location - ProjectedDestination) < 5000.0000000) || HelperBotController.CurrentNavigation.TargetActor == Destination)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function MoveHelperToActor(Actor Destination)
{
    local Vector ZeroVector;

    // End:0x15C
    if((Destination != none) && HelperBotController != none)
    {
        HelperBotController.ScriptedMoveTarget = Destination;
        HelperBotController.StopNavigation();
        HelperBotController.Focus = GetALocalPlayerController().Pawn;
        HelperBotController.EscortActor = GetALocalPlayerController().Pawn;
        HelperBotController.SetFocalPoint(ZeroVector);
        HelperBotController.AddActorToNavigationQueue(1048581, Destination, true, true, HelperBotController.DeviceRanges[0]);
    }
    //return;    
}

function TeleportHelperToActor(Actor Destination)
{
    local Pawn HelperPawn;

    // End:0xB2
    if(HelperBotController != none)
    {
        HelperPawn = HelperBotController.Pawn;
        // End:0xB2
        if(HelperPawn != none)
        {
            HelperPawn.SetLocation(Destination.Location);
            HelperPawn.SetRotation(Destination.Rotation);
        }
    }
    //return;    
}

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