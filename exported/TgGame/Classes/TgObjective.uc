class TgObjective extends Actor
    native(Game)
    placeable
    hidecategories(Navigation);

const OBJECTIVE_NEUTRAL_SPECIALFX = 2954;
const OBJECTIVE_FRIENDLY_SPECIALFX = 2929;
const OBJECTIVE_ENEMY_SPECIALFX = 2928;
const OBJECTIVE_PENDING_SPECIALFX = 2930;
const OBJECTIVE_NEUTRAL_FOREGROUND_SPECIALFX = 6286;
const OBJECTIVE_FRIENDLY_FOREGROUND_SPECIALFX = 6289;
const OBJECTIVE_ENEMY_FOREGROUND_SPECIALFX = 6287;
const OBJECTIVE_PENDING_FOREGROUND_SPECIALFX = 6288;
const MIN_CAPTURE_FX_RENDER_DISTANCE = 750;

enum EObjectiveStatus
{
    Status_Inactive,                // 0
    Status_Active,                  // 1
    Status_PendingActive,           // 2
    Status_MAX                      // 3
};

var byte r_nDefenderTaskForceIndex;
var byte r_nControllingTaskForceIndex;
var repnotify byte r_nContestingTaskForceIndex;
var repnotify TgObjective.EObjectiveStatus r_eStatus;
var TgSpecialFx m_InWordIndicatorFX;
var TgSpecialFx m_ForegroundIndicatorFX;
var() int m_nActiveAlertId;
var() int m_nPendingActiveAlertId;
var() int m_nInactiveAlertId;
var() int m_nWaypointMessageOverride;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_eStatus, r_nContestingTaskForceIndex, 
        r_nControllingTaskForceIndex, r_nDefenderTaskForceIndex;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2F
    if(VarName == 'r_eStatus')
    {
        SetStatus(r_eStatus);
        return;        
    }
    else
    {
        // End:0x52
        if(VarName == 'r_nContestingTaskForceIndex')
        {
            OnContestedStatusChanged();
            return;
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

// Export UTgObjective::execSetStatus(FFrame&, void* const)
native function SetStatus(TgObjective.EObjectiveStatus NewStatus);

simulated event OnSetStatus()
{
    // End:0x88
    if(int(Role) == int(ROLE_Authority))
    {
        switch(r_eStatus)
        {
            // End:0x46
            case 0:
                TriggerEventClass(Class'TgGame.TgSeqEvent_ChaosObjectiveActive', self, 0);
                // End:0x88
                break;
            // End:0x65
            case 1:
                TriggerEventClass(Class'TgGame.TgSeqEvent_ChaosObjectiveActive', self, 1);
                // End:0x88
                break;
            // End:0x85
            case 2:
                TriggerEventClass(Class'TgGame.TgSeqEvent_ChaosObjectiveActive', self, 2);
                // End:0x88
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        //return;        
    }
}

simulated event OnContestedStatusChanged()
{
    local array<SequenceObject> Events;
    local TgSeqEvent_ChaosObjectiveStatus Evt;
    local TgPlayerController TgPC;
    local bool bFriendlyOwned;
    local Sequence Seq;
    local int Idx, tf;
    local array<int> Indices;

    // End:0x2E3
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x5D
        if(int(r_nContestingTaskForceIndex) == int(3))
        {
            Indices.AddItem(0);
            tf = -1;            
        }
        else
        {
            // End:0xAD
            if((int(r_nContestingTaskForceIndex) == int(1)) || int(r_nContestingTaskForceIndex) == int(2))
            {
                Indices.AddItem(1);
                tf = int(r_nContestingTaskForceIndex);                
            }
            else
            {
                Indices.AddItem(2);
                tf = 0;
            }
        }
        TgPC = TgPlayerController(GetALocalPlayerController());
        bFriendlyOwned = false;
        // End:0x1BE
        if(TgPC != none)
        {
            // End:0x13B
            if(WorldInfo.IsPlayingDemo())
            {
                bFriendlyOwned = tf == 1;                
            }
            else
            {
                bFriendlyOwned = ((TgPC.IsConfused()) ? TgPC.GetTaskForceNumber() != tf : TgPC.GetTaskForceNumber() == tf);
            }
        }
        Seq = WorldInfo.GetGameSequence();
        // End:0x2E3
        if(Seq != none)
        {
            Seq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_ChaosObjectiveStatus', true, Events);
            Idx = 0;
            J0x233:

            // End:0x2E3 [Loop If]
            if(Idx < Events.Length)
            {
                Evt = TgSeqEvent_ChaosObjectiveStatus(Events[Idx]);
                // End:0x2D5
                if(Evt != none)
                {
                    Evt.CheckActivate(self, self,, Indices);
                    Evt.UpdateLinkedVars(bFriendlyOwned);
                }
                Idx++;
                // [Loop Continue]
                goto J0x233;
            }
        }
    }
    //return;    
}

defaultproperties
{
    Components[0]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    NetPriority=2.0000000
    SupportedEvents=/* Array type was not detected. */
}