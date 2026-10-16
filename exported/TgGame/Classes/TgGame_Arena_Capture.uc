class TgGame_Arena_Capture extends TgGame_Arena
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int s_nCaptureHostilePointXP;
var int s_nCaptureHostilePointGold;
var int s_nReclaimPointXP;
var int s_nReclaimPointGold;
var int m_nCurrentActiveCapturePointIndex;
var float m_fNewPointTime;

event PostBeginPlay()
{
    local TgCapturePoint Point;

    super(TgGame_Mission).PostBeginPlay();
    // End:0x5A
    foreach DynamicActors(Class'TgGame.TgCapturePoint', Point)
    {
        Point.r_RepInfo.r_bIsLocked = true;        
    }    
    //return;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    super(TgGame_Battle).ChangeTimerState(eTimerState);
    UpdateLockedPointStatus();
    // End:0x31
    if(int(eTimerState) == int(3))
    {
    }
    //return;    
}

// Export UTgGame_Arena_Capture::execCapturedPoint(FFrame&, void* const)
native function CapturedPoint(TgPawn_Character PC);

// Export UTgGame_Arena_Capture::execCapturePointReclaimed(FFrame&, void* const)
native function CapturePointReclaimed(TgPawn_Character PC);

function SpawnNeutralBots()
{
    local TgRepInfo_Game GRI;
    local int NewPointIndex, I;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x1EF
    if(GRI != none)
    {
        NewPointIndex = Rand(GRI.m_CPRIArray.Length);
        // End:0xB0
        if(NewPointIndex == m_nCurrentActiveCapturePointIndex)
        {
            NewPointIndex++;
            // End:0xB0
            if(NewPointIndex >= GRI.m_CPRIArray.Length)
            {
                NewPointIndex = 0;
            }
        }
        I = 0;
        J0xBB:

        // End:0x189 [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            GRI.m_CPRIArray[I].r_bIsLocked = NewPointIndex != I;
            GRI.m_CPRIArray[I].bNetDirty = true;
            I++;
            // [Loop Continue]
            goto J0xBB;
        }
        GRI.m_CPRIArray[NewPointIndex].r_OwningCapturePoint.SpawnNeutralBot();
        m_nCurrentActiveCapturePointIndex = NewPointIndex;
    }
    //return;    
}

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner)
{
    local TgRepInfo_Game GRI;
    local int I;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x1E4
    if(GRI != none)
    {
        // End:0x1E4
        if((NewTaskForceOwner == 1) || NewTaskForceOwner == 2)
        {
            // End:0x1E1
            if((PreviousTaskForceOwner == 1) || PreviousTaskForceOwner == 2)
            {
                Point.r_RepInfo.r_nControlledByTaskForce = 0;
                Point.r_RepInfo.r_fOwnershipPct = 0.5000000;
                Point.OnPointCaptureOwnershipChanged(0, PreviousTaskForceOwner);
                SetTimer(m_fNewPointTime, false, 'SpawnNeutralBots');
                I = 0;
                J0x126:

                // End:0x1E1 [Loop If]
                if(I < GRI.m_CPRIArray.Length)
                {
                    GRI.m_CPRIArray[I].r_bIsLocked = true;
                    GRI.m_CPRIArray[I].bNetDirty = true;
                    I++;
                    // [Loop Continue]
                    goto J0x126;
                }
            }            
        }
    }
    //return;    
}

function UpdateLockedPointStatus()
{
    local TgRepInfo_Game GRI;
    local int I;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xED
    if(GRI != none)
    {
        I = 0;
        J0x36:

        // End:0xED [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            // End:0xDF
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                GRI.m_CPRIArray[I].r_OwningCapturePoint.UpdateLockEffects();
            }
            I++;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}

defaultproperties
{
    m_nCurrentActiveCapturePointIndex=-1
    m_fNewPointTime=5.0000000
    m_GameType=TG_GAME_TYPE.TGT_ARENA_CAPTURE
}