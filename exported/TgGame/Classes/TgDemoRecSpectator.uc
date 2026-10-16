class TgDemoRecSpectator extends TgSpectatorController
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

struct native SpectatorCommand
{
    var int nFrame;
    var bool bUseIndex;
    var float fSpeed;

    structdefaultproperties
    {
        nFrame=0
        bUseIndex=false
        fSpeed=0.0000000
    }
};

struct native DilationData
{
    var float fValue;
    var string sName;

    structdefaultproperties
    {
        fValue=0.0000000
        sName=""
    }
};

var array<SpectatorCommand> PendingCommands;
var int m_TimeIndex;
var array<DilationData> m_TimeDilations;
var native Pointer m_pTgCallbackDevice;
var transient int m_1xTimeIndex;
var transient bool m_bIsPaused;
var transient bool m_bInStasis;
var transient bool m_bSpectatorMaster;
var transient bool m_bSyncWithMasterEnabled;
var transient bool m_bIsSyncingWithMaster;
var config transient bool m_bAutoSlomo;
var config transient bool m_bReceiveCamSync;
var transient int m_nLastReceivedMasterFrame;
var transient float m_fLastReceivedMasterTimeDilation;
var transient float m_fLastReceievedRealTimeStamp;
var const config int m_nSyncFrameThreshold;
var const config int m_nSyncFrameCheckThreshold;
var const config int m_nSyncAheadFrameThreshold;
var transient int m_nLastTimerValue;
var TgSpectatorDirector m_SpectatorDirector;
var transient TgCollisionProxy_SpectatorActionListener m_ActionListener;
var config transient float m_fActionListenerRadius;
var config transient float m_fActionListenerHeight;
var transient int m_nCurrentActionListenerRating;
var config transient int m_nActionListenerRatingThreshold;
var float m_fRemainingAutoSlomoTime;
var config transient float m_fAutoSlomoExpirationTime;
var config transient int m_nAutoSlomoSpeedIndex;
var config transient int m_nAutoSlomoNearbyPlayersNum;
var config transient float m_fAutoSlomoFrequency;
var transient float m_fRemainingAutoSlomoTimeoutTime;

// Export UTgDemoRecSpectator::execOnSynced(FFrame&, void* const)
native function OnSynced();

// Export UTgDemoRecSpectator::execRequestSync(FFrame&, void* const)
native function RequestSync();

// Export UTgDemoRecSpectator::execUpdateTimeDilation(FFrame&, void* const)
native function UpdateTimeDilation();

// Export UTgDemoRecSpectator::execUpdateSyncingUI(FFrame&, void* const)
native function bool UpdateSyncingUI();

// Export UTgDemoRecSpectator::execUpdateCameraModeUI(FFrame&, void* const)
native function UpdateCameraModeUI();

// Export UTgDemoRecSpectator::execRegisterEngineCallbacks(FFrame&, void* const)
native function RegisterEngineCallbacks();

// Export UTgDemoRecSpectator::execUnregisterEngineCallbacks(FFrame&, void* const)
native function UnregisterEngineCallbacks();

// Export UTgDemoRecSpectator::execGetHudClass(FFrame&, void* const)
native function Class<HUD> GetHudClass(Class<HUD> pNewHudType);

// Export UTgDemoRecSpectator::execCreateManualRewindPoint(FFrame&, void* const)
native exec function CreateManualRewindPoint();

// Export UTgDemoRecSpectator::execToggleThirdPersonView(FFrame&, void* const)
native exec function ToggleThirdPersonView();

// Export UTgDemoRecSpectator::execStartAutoCombatLog(FFrame&, void* const)
native function StartAutoCombatLog();

simulated event ReceivedPlayer()
{
    super(TgPlayerController).ReceivedPlayer();
    CachedPRI.SetTaskForceNumber(10, true);
    ClientSetHUD(none);
    GotoState('SpectatingMatch');
    // End:0x5D
    if(m_bAutoSlomo)
    {
        EnableAutoSlomo(true);
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x77 [Loop If]
    if(I < m_TimeDilations.Length)
    {
        // End:0x69
        if(m_TimeDilations[I].fValue == 1.0000000)
        {
            m_1xTimeIndex = I;
            // [Explicit Break]
            goto J0x77;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    J0x77:

    RegisterEngineCallbacks();
    CheckSpectatorMasterSlave();
    StartAutoCombatLog();
    // End:0xDA
    if(WorldInfo.IsPlayingDemo())
    {
        m_SpectatorDirector = Spawn(Class'TgGame.TgSpectatorDirector', self);
    }
    super.PostBeginPlay();
    //return;    
}

// Export UTgDemoRecSpectator::execSlomo(FFrame&, void* const)
native exec function Slomo(float NewTimeDilation);

// Export UTgDemoRecSpectator::execPause(FFrame&, void* const)
native exec function Pause();

// Export UTgDemoRecSpectator::execDilateTime(FFrame&, void* const)
native exec function DilateTime(float Amount, optional bool bForceReset);

// Export UTgDemoRecSpectator::execRewind(FFrame&, void* const)
native exec function Rewind(int JumpAmount, optional int FrameNum = -1);

// Export UTgDemoRecSpectator::execGoToFrame(FFrame&, void* const)
native exec function GoToFrame(float fPercent);

// Export UTgDemoRecSpectator::execCanFastForward(FFrame&, void* const)
native function bool CanFastForward();

// Export UTgDemoRecSpectator::execSetSpectatorMasterSlave(FFrame&, void* const)
native function bool SetSpectatorMasterSlave();

// Export UTgDemoRecSpectator::execPauseEx(FFrame&, void* const)
native function PauseEx();

// Export UTgDemoRecSpectator::execRewindGraphs(FFrame&, void* const)
native function RewindGraphs();

// Export UTgDemoRecSpectator::execSetSyncTargetFrame(FFrame&, void* const)
native exec function SetSyncTargetFrame(int FrameNum, float TimeDilation);

// Export UTgDemoRecSpectator::execGetSyncTargetFrame(FFrame&, void* const)
native function int GetSyncTargetFrame();

// Export UTgDemoRecSpectator::execIsSyncedWithMaster(FFrame&, void* const)
native function bool IsSyncedWithMaster(int Threshold);

exec function EnableSync(bool bEnabled)
{
    // End:0x82
    if(!m_bSpectatorMaster)
    {
        // End:0x35
        if(m_bSyncWithMasterEnabled)
        {
            m_TimeIndex = 3;
            UpdateTimeDilation();            
        }
        else
        {
            // End:0x4C
            if(m_bIsPaused)
            {
                PauseEx();
            }
        }
        m_bSyncWithMasterEnabled = bEnabled;
        // End:0x78
        if(m_bSyncWithMasterEnabled)
        {
            RequestSync();
        }
        UpdateSyncingUI();
    }
    //return;    
}

exec function ToggleSync()
{
    EnableSync(!m_bSyncWithMasterEnabled);
    //return;    
}

function CheckSpectatorMasterSlave()
{
    // End:0x24
    if(SetSpectatorMasterSlave())
    {
        ClearTimer('CheckSpectatorMasterSlave');        
    }
    else
    {
        SetTimer(1.0000000, true, 'CheckSpectatorMasterSlave');
    }
    //return;    
}

simulated event PostDemoRewind()
{
    // End:0x33
    if(myHUD != none)
    {
        myHUD.Tick(0.0000000);
    }
    RewindGraphs();
    m_nCurrentActionListenerRating = 0;
    m_fRemainingAutoSlomoTime = 0.0000000;
    super(Actor).PostDemoRewind();
    //return;    
}

exec function DirectorModeToggle()
{
    // End:0x9A
    if(m_SpectatorDirector != none)
    {
        // End:0x90
        if(int(m_CurrentSpectatorMode) == int(1))
        {
            // End:0x8D
            if(m_SpectatorDirector.IsActive() && m_SpectatorDirector.IsPending())
            {
                m_SpectatorDirector.m_fRemainingAutoReturnCheckTime = 0.0000000;
            }            
        }
        else
        {
            FindNearbyAssistedViewTarget();
        }
    }
    //return;    
}

event FindNearbyAssistedViewTarget()
{
    local Vector2D ForcedDirectorLocation;
    local Vector CamLoc;
    local Rotator CamRot;

    // End:0xCA
    if(int(m_CurrentSpectatorMode) == int(2))
    {
        GetPlayerViewPoint(CamLoc, CamRot);
        ForcedDirectorLocation.X = CamLoc.X;
        ForcedDirectorLocation.Y = CamLoc.Y;
        m_SpectatorDirector.SetForcedDirectorLocation(ForcedDirectorLocation);
    }
    //return;    
}

event FindNextClosestAssistedViewTarget()
{
    local Vector2D ForcedDirectorLocation;
    local Vector CamLoc, BestLocation;
    local Rotator CamRot;
    local TgPawn P;
    local float DistSq, ClosestDistSq;

    ClosestDistSq = -1.0000000;
    // End:0x2DF
    if(int(m_CurrentSpectatorMode) == int(2))
    {
        GetPlayerViewPoint(CamLoc, CamRot);
        BestLocation.X = CamLoc.X;
        BestLocation.Y = CamLoc.Y;
        // End:0x244
        foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', P)
        {
            // End:0x243
            if((P.Health > 0) && P.r_nPhysicalType == 10034)
            {
                DistSq = VSizeSq(CamLoc - P.Location);
                // End:0x243
                if((ClosestDistSq < float(0)) || DistSq < ClosestDistSq)
                {
                    ClosestDistSq = DistSq;
                    BestLocation.X = P.Location.X;
                    BestLocation.Y = P.Location.Y;
                }
            }            
        }        
        ForcedDirectorLocation.X = BestLocation.X;
        ForcedDirectorLocation.Y = BestLocation.Y;
        m_SpectatorDirector.SetForcedDirectorLocation(ForcedDirectorLocation);
    }
    //return;    
}

exec function SetNewSpectatorMode(TgSpectatorController.ESpectatorMode NewMode)
{
    local TgSpectatorController.ESpectatorMode OldMode;

    OldMode = m_CurrentSpectatorMode;
    super.SetNewSpectatorMode(NewMode);
    // End:0x135
    if(int(OldMode) != int(NewMode))
    {
        switch(NewMode)
        {
            // End:0x8B
            case 0:
                // End:0x88
                if(m_SpectatorDirector != none)
                {
                    m_SpectatorDirector.SetActive(false);
                }
                // End:0x12B
                break;
            // End:0xC2
            case 1:
                // End:0xBF
                if(m_SpectatorDirector != none)
                {
                    m_SpectatorDirector.SetActive(true);
                }
                // End:0x12B
                break;
            // End:0xF9
            case 2:
                // End:0xF6
                if(m_SpectatorDirector != none)
                {
                    m_SpectatorDirector.SetActive(true);
                }
                // End:0x12B
                break;
            // End:0xFFFF
            default:
                // End:0x12B
                if(m_SpectatorDirector != none)
                {
                    m_SpectatorDirector.SetActive(false);
                }
                break;
        }
        UpdateCameraModeUI();
    }
    //return;    
}

simulated function bool PingMap(Vector WorldLocation, const out array<ReplicationInfo> worldActorRepInfo, TgObject.PING_TYPE Type)
{
    local Vector2D ForcedLocation;

    // End:0xF3
    if(m_SpectatorDirector != none)
    {
        // End:0x45
        if(int(m_CurrentSpectatorMode) == int(1))
        {
            m_SpectatorDirector.OnPlayerMoved();            
        }
        else
        {
            // End:0xF3
            if(int(m_CurrentSpectatorMode) == int(2))
            {
                ForcedLocation.X = WorldLocation.X;
                ForcedLocation.Y = WorldLocation.Y;
                m_SpectatorDirector.SetForcedDirectorLocation(ForcedLocation);
            }
        }
    }
    return super.PingMap(WorldLocation, worldActorRepInfo, Type);
    //return ReturnValue;    
}

exec function SpecViewPlayer(string PlayerName)
{
    // End:0x44
    if((m_SpectatorDirector != none) && int(m_CurrentSpectatorMode) == int(2))
    {
        m_SpectatorDirector.ClearAssistModeTarget();
    }
    super.SpecViewPlayer(PlayerName);
    //return;    
}

exec function ToggleAutoSlomo()
{
    local bool bEnabled;

    bEnabled = !m_bAutoSlomo;
    EnableAutoSlomo(bEnabled);
    //return;    
}

exec function EnableAutoSlomo(bool bEnabled)
{
    m_bAutoSlomo = bEnabled;
    // End:0xEC
    if(m_bAutoSlomo)
    {
        // End:0xE9
        if(m_ActionListener == none)
        {
            m_ActionListener = Spawn(Class'TgGame.TgCollisionProxy_SpectatorActionListener');
            m_ActionListener.m_CollisionCylinder.SetCylinderSize(m_fActionListenerRadius, m_fActionListenerHeight);
            m_ActionListener.__ProxyDeviceOnStartFire__Delegate = OnActionListenerStartFire;
            m_ActionListener.DelegatesUpdated();
        }        
    }
    else
    {
        Slomo(1.0000000);
        m_fRemainingAutoSlomoTime = 0.0000000;
        // End:0x13C
        if(m_ActionListener != none)
        {
            m_ActionListener.Destroy();
            m_ActionListener = none;
        }
    }
    //return;    
}

// Export UTgDemoRecSpectator::execOnActionListenerStartFire(FFrame&, void* const)
native function OnActionListenerStartFire(TgPawn FiringPawn, int nEquipSlot);

// Export UTgDemoRecSpectator::execTriggerAutoSlomo(FFrame&, void* const)
native function TriggerAutoSlomo(float SlomoTime);

exec function EnableCamSync(bool bEnabled)
{
    m_bReceiveCamSync = bEnabled;
    //return;    
}

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
    super.SpectatorSetViewTarget(VT, TransitionParams);
    SendCamSyncTarget();
    //return;    
}

event SpectatorReceivedViewTarget(Actor VT)
{
    SpectatorSetViewTarget(VT);
    //return;    
}

// Export UTgDemoRecSpectator::execSendCamSyncTarget(FFrame&, void* const)
native function SendCamSyncTarget();

// Export UTgDemoRecSpectator::execReceiveCamSyncTarget(FFrame&, void* const)
native function ReceiveCamSyncTarget(int PawnId, int SourcePlayerId);

defaultproperties
{
    m_TimeIndex=3
    m_TimeDilations[0]=(fValue=0.1250000,sName="1/8x")
    m_TimeDilations[1]=(fValue=0.2500000,sName="1/4x")
    m_TimeDilations[2]=(fValue=0.5000000,sName="1/2x")
    m_TimeDilations[3]=(fValue=1.0000000,sName="1x")
    m_TimeDilations[4]=(fValue=2.0000000,sName="2x")
    m_TimeDilations[5]=(fValue=4.0000000,sName="4x")
    m_TimeDilations[6]=(fValue=8.0000000,sName="8x")
    m_TimeDilations[7]=(fValue=16.0000000,sName="16x")
    m_bSpectatorMaster=true
    m_bAutoSlomo=true
    m_nLastReceivedMasterFrame=-1
    m_nSyncFrameThreshold=10
    m_nSyncFrameCheckThreshold=20
    m_nSyncAheadFrameThreshold=90
    m_fActionListenerRadius=900.0000000
    m_fActionListenerHeight=1000.0000000
    m_nActionListenerRatingThreshold=1
    m_fAutoSlomoExpirationTime=0.7500000
    m_nAutoSlomoSpeedIndex=1
    m_fAutoSlomoFrequency=30.0000000
    // Reference: CylinderComponent'TgGame.Default__TgDemoRecSpectator.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgSpectatorController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    RemoteRole=ENetRole.ROLE_AutonomousProxy
    bDemoOwner=true
    bAlwaysTick=true
    CollisionComponent=CollisionCylinder
}