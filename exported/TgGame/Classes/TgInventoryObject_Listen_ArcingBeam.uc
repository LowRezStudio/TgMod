class TgInventoryObject_Listen_ArcingBeam extends TgInvListener
    native(Inventory);

var int m_nDeviceId;
var array<Actor> m_MarkedTargets;

simulated event AddUIMarks(Actor Target, int nNumMarks)
{
    local TgRepInfo_Player targetPRI, sourcePRI;
    local TgPawn TargetPawn, sourcePawn;

    // End:0x1DA
    if(s_Device != none)
    {
        sourcePawn = TgPawn(s_Device.Owner);
        TargetPawn = TgPawn(Target);
        // End:0x1DA
        if((sourcePawn != none) && TargetPawn != none)
        {
            sourcePRI = sourcePawn.GetPRI();
            targetPRI = TargetPawn.GetPRI();
            // End:0x1DA
            if((sourcePRI != none) && targetPRI != none)
            {
                targetPRI.AddMarkedTarget(sourcePRI.r_nPawnId, nNumMarks);
                // End:0x1DA
                if(s_Device.GetCurrentFire() != none)
                {
                    sourcePawn.ClearTimer('ExpireUIMarks');
                    sourcePawn.SetTimer(s_Device.GetCurrentFire().GetCustomValue1(), false, 'ExpireUIMarks', self);
                }
            }
        }
    }
    //return;    
}

simulated event RemoveUIMarks(Actor Target, int nNumMarks)
{
    local TgRepInfo_Player targetPRI, sourcePRI;
    local TgPawn TargetPawn, sourcePawn;

    // End:0x134
    if(s_Device != none)
    {
        sourcePawn = TgPawn(s_Device.Owner);
        TargetPawn = TgPawn(Target);
        // End:0x134
        if((sourcePawn != none) && TargetPawn != none)
        {
            sourcePRI = sourcePawn.GetPRI();
            targetPRI = TargetPawn.GetPRI();
            // End:0x134
            if((sourcePRI != none) && targetPRI != none)
            {
                targetPRI.RemoveMarkedTarget(sourcePRI.r_nPawnId, nNumMarks);
            }
        }
    }
    //return;    
}

simulated function ExpireUIMarks()
{
    local Actor Actor;

    // End:0x2C
    foreach m_MarkedTargets(Actor)
    {
        RemoveUIMarks(Actor, 1);        
    }    
    m_MarkedTargets.Remove(0, m_MarkedTargets.Length);
    //return;    
}

function int CountMarksForActor(Actor Actor)
{
    local int Count;
    local Actor iter;

    // End:0x3A
    foreach m_MarkedTargets(iter)
    {
        // End:0x39
        if(iter == Actor)
        {
            Count++;
        }        
    }    
    return Count;
    //return ReturnValue;    
}

defaultproperties
{
    m_nDeviceId=14475
}