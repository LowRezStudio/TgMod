class TgSpawnTeleporterExit extends Actor
    native(Navigation)
    placeable
    hidecategories(Navigation);

const TGSPAWNTELEPORTEREXIT_TARGETHEIGHT = 128;

var() int nTaskForce;
var() int nLane;
var() int nGamePhase;
var() int nPriority;
var() bool bEnabled;

// Export UTgSpawnTeleporterExit::execHasRoomForPawn(FFrame&, void* const)
native function bool HasRoomForPawn(TgPawn TgP);

// Export UTgSpawnTeleporterExit::execGetTargetLocation(FFrame&, void* const)
native simulated function Vector GetTargetLocation(optional Actor RequestedBy, optional bool bRequestAlternateLoc);

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bEnabled = !bEnabled;
            }
        }
    }
    //return;    
}

function bool PawnCanUse(TgPawn TgP)
{
    return bEnabled && (nTaskForce <= 0) || nTaskForce == int(TgP.GetTaskForceNumber());
    //return ReturnValue;    
}

defaultproperties
{
    bEnabled=true
    Components[0]=none
    Components[1]=none
}