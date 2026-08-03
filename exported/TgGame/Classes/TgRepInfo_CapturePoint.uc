class TgRepInfo_CapturePoint extends ReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision);

var TgCapturePoint r_OwningCapturePoint;
var int r_nUniqueCapturePointId;
var repnotify int r_nControlledByTaskForce;
var repnotify float r_fOwnershipPct;
var repnotify byte r_nTransitionDirection;
var repnotify bool r_bIsLocked;
var transient TgSeqEvent_ControlPointOwnershipPercent c_OwnershipPercentKismetNode;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_OwningCapturePoint, r_bIsLocked, 
        r_fOwnershipPct, r_nControlledByTaskForce, 
        r_nTransitionDirection, r_nUniqueCapturePointId;
}

// Export UTgRepInfo_CapturePoint::execGetCurrentLocation(FFrame&, void* const)
native function Vector GetCurrentLocation();

simulated event ReplicatedEvent(name VarName)
{
    super(Actor).ReplicatedEvent(VarName);
    switch(VarName)
    {
        // End:0x3F
        case 'r_nControlledByTaskForce':
            OnTaskForceControlChanged();
            // End:0x98
            break;
        // End:0x58
        case 'r_fOwnershipPct':
            OnOwnershipPctChanged();
            // End:0x98
            break;
        // End:0x95
        case 'r_bIsLocked':
            // End:0x92
            if(r_OwningCapturePoint != none)
            {
                r_OwningCapturePoint.UpdateLockEffects();
            }
            // End:0x98
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x60
    if(GRI != none)
    {
        GRI.AddCPRI(self);
    }
    //return;    
}

simulated function OnTaskForceControlChanged()
{
    // End:0x37
    if(r_OwningCapturePoint != none)
    {
        r_OwningCapturePoint.OnTaskForceControlChanged(r_nControlledByTaskForce);
    }
    //return;    
}

simulated event OnOwnershipPctChanged()
{
    local TgPlayerController TgPC;
    local array<SequenceObject> KismetEvents;
    local TgSeqEvent_ControlPointOwnershipPercent SeqEvent;
    local int Idx, PointIndex;
    local array<int> ActivateIndices;

    // End:0x115
    if(c_OwnershipPercentKismetNode == none)
    {
        PointIndex = GetCapturePointIndex();
        WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_ControlPointOwnershipPercent', true, KismetEvents);
        Idx = 0;
        J0x76:

        // End:0x115 [Loop If]
        if(Idx < KismetEvents.Length)
        {
            SeqEvent = TgSeqEvent_ControlPointOwnershipPercent(KismetEvents[Idx]);
            // End:0x107
            if((SeqEvent != none) && SeqEvent.PointIndex == PointIndex)
            {
                c_OwnershipPercentKismetNode = SeqEvent;
                // [Explicit Break]
                goto J0x115;
            }
            Idx++;
            // [Loop Continue]
            goto J0x76;
        }
    }
    J0x115:

    // End:0x1F9
    if(c_OwnershipPercentKismetNode != none)
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x198
        if(TgPC.GetTaskForceNumber() == 1)
        {
            c_OwnershipPercentKismetNode.OwnershipPercent = 1.0000000 - r_fOwnershipPct;            
        }
        else
        {
            c_OwnershipPercentKismetNode.OwnershipPercent = r_fOwnershipPct;
        }
        ActivateIndices[0] = 0;
        c_OwnershipPercentKismetNode.CheckActivate(self, self, false, ActivateIndices);
    }
    //return;    
}

simulated event int GetCapturePointIndex()
{
    // End:0x2F
    if(r_OwningCapturePoint != none)
    {
        return r_OwningCapturePoint.GetCapturePointIndex();
    }
    return -1;
    //return ReturnValue;    
}

defaultproperties
{
    r_fOwnershipPct=0.5000000
    s_bThrottleNetRelevancy=false
}