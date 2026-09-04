class TgPawn_SiegeEngine_Payload extends TgPawn_Juggernaut
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

enum EAutoMovePayload
{
    AUTOMOVE_None,                  // 0
    AUTOMOVE_Forward,               // 1
    AUTOMOVE_Backward,              // 2
    AUTOMOVE_MAX                    // 3
};

enum EPayloadControlState
{
    PAYLOADCONTROL_None,            // 0
    PAYLOADCONTROL_Ally,            // 1
    PAYLOADCONTROL_Enemy,           // 2
    PAYLOADCONTROL_Contested,       // 3
    PAYLOADCONTROL_MAX              // 4
};

var float s_fTotalSplineLength;
var float s_fPreviousSplineLength;
var bool r_bEnable;
var const bool m_bRequireLineOfSightForNearby;
var private repnotify bool r_bMovingBackwards;
var private bool r_bCanAutoPushForward;
var const float m_fBaseSpeedScale;
var const float m_fNearbyProximityDistance;
var TgCollisionProxy m_NearbyCollisionProxy;
var array<TgPawn> m_TouchingPlayers;
var array<TgPawn> m_VisiblePlayers;
var const float m_fSpeedScaleIncreasePerFriendly;
var const float m_fLineOfSightUpdatePeriod;
var float m_fNextLineOfSightUpdateTime;
var const float s_fTimeUntilMoveBackwards;
var const float m_fMoveBackSpeedScale;
var private repnotify TgPawn_SiegeEngine_Payload.EAutoMovePayload r_eMoveWithoutAllies;
var private TgPawn_SiegeEngine_Payload.EPayloadControlState m_eControlState;
var repnotify byte r_nFriends;
var repnotify byte r_nEnemies;
var private const float m_fAutoPushForwardDelay;
var private const float r_fAutoPushForwardSpeedScale;
var private const float m_fStopAutoPushDelay;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bCanAutoPushForward, r_bEnable, 
        r_bMovingBackwards, r_eMoveWithoutAllies;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_fAutoPushForwardSpeedScale;

    // Pos:0x031
    if((int(Role) == int(ROLE_Authority)) && bDemoRecording || m_bRequireLineOfSightForNearby)
        r_nEnemies, r_nFriends;
}

// Export UTgPawn_SiegeEngine_Payload::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_SiegeEngine_Payload::execCreateCollisionProxy(FFrame&, void* const)
native function CreateCollisionProxy();

// Export UTgPawn_SiegeEngine_Payload::execSetSpline(FFrame&, void* const)
native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);

// Export UTgPawn_SiegeEngine_Payload::execUpdatePayloadProgress(FFrame&, void* const)
native function UpdatePayloadProgress();

// Export UTgPawn_SiegeEngine_Payload::execIsNonCombat(FFrame&, void* const)
native function bool IsNonCombat();

// Export UTgPawn_SiegeEngine_Payload::execNativeIsContested(FFrame&, void* const)
native function bool NativeIsContested();

// Export UTgPawn_SiegeEngine_Payload::execNativeIsMovingBackwards(FFrame&, void* const)
native function bool NativeIsMovingBackwards();

// Export UTgPawn_SiegeEngine_Payload::execVisibilityCheck(FFrame&, void* const)
native function bool VisibilityCheck(Actor Target);

// Export UTgPawn_SiegeEngine_Payload::execUpdateFriendEnemyCounts(FFrame&, void* const)
native final function UpdateFriendEnemyCounts();

// Export UTgPawn_SiegeEngine_Payload::execIsImmuneToDamage(FFrame&, void* const)
native function bool IsImmuneToDamage();

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_bEnable':
            OnEnableChanged();
            // End:0x9D
            break;
        // End:0x45
        case 'r_eMoveWithoutAllies':
            FullUpdate();
            // End:0x9D
            break;
        // End:0x74
        case 'r_bMovingBackwards':
            ((r_bMovingBackwards) ? StartMovingBackwards() : StopMovingBackwards());
        // End:0x80
        case 'r_nFriends':
        // End:0x9A
        case 'r_nEnemies':
            UpdateAlliesNearbyBehavior();
            // End:0x9D
            break;
        // End:0xFFFF
        default:
            break;
    }
    super(TgPawn_LanePusherBase).ReplicatedEvent(VarName);
    //return;    
}

simulated event bool PostPawnSetup()
{
    // End:0x72
    if(super.PostPawnSetup())
    {
        // End:0x70
        if((((m_NearbyCollisionProxy == none) && !bDeleteMe) && (GetPRI()) != none) && GetPRI().r_TaskForce != none)
        {
            CreateCollisionProxy();
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event OnGroupChange()
{
    super(TgPawn).OnGroupChange();
    // End:0xAD
    if(int(Role) < int(ROLE_Authority))
    {
        // End:0x93
        if((((m_bInitialized && m_NearbyCollisionProxy == none) && !bDeleteMe) && (GetPRI()) != none) && GetPRI().r_TaskForce != none)
        {
            CreateCollisionProxy();            
        }
        else
        {
            // End:0xAD
            if(m_NearbyCollisionProxy != none)
            {
                UpdateAlliesNearbyBehavior();
            }
        }
    }
    //return;    
}

final function SetEnable(bool bEnable)
{
    // End:0x38
    if(bEnable != r_bEnable)
    {
        r_bEnable = bEnable;
        OnEnableChanged();
    }
    //return;    
}

simulated function OnEnableChanged()
{
    UpdateAlliesNearbyBehavior();
    //return;    
}

singular simulated function FullUpdate()
{
    UpdateBackwardsTimers();
    UpdateMoving();
    //return;    
}

final simulated function bool HasFriendlyPlayersNearby()
{
    return (int(m_eControlState) == int(1)) || int(m_eControlState) == int(3);
    //return ReturnValue;    
}

final simulated function bool HasEnemyPlayersNearby()
{
    return (int(m_eControlState) == int(2)) || int(m_eControlState) == int(3);
    //return ReturnValue;    
}

final simulated function bool IsContested()
{
    return int(m_eControlState) == int(3);
    //return ReturnValue;    
}

simulated function ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    AddNearbyPlayer(Other);
    //return;    
}

simulated function ProxyUnTouch(Actor Other)
{
    RemoveNearbyPlayer(Other);
    //return;    
}

private final simulated function AddNearbyPlayer(Actor Other)
{
    local TgPawn OtherPawn;

    // End:0x199
    if((int(Role) == int(ROLE_Authority)) || !m_bRequireLineOfSightForNearby)
    {
        OtherPawn = TgPawn(Other);
        // End:0x199
        if(((OtherPawn != none) && OtherPawn.PlayerReplicationInfo != none) && !OtherPawn.PlayerReplicationInfo.IsBot())
        {
            m_TouchingPlayers.AddItem(OtherPawn);
            // End:0x199
            if(VisibilityCheck(OtherPawn))
            {
                m_VisiblePlayers.AddItem(OtherPawn);
                ((IsEnemy(OtherPawn)) ? r_nEnemies++ : r_nFriends++);
                // End:0x18E
                if((int(WorldInfo.NetMode) != int(NM_Client)) && TgPawn_Character(OtherPawn) != none)
                {
                    TgPawn_Character(OtherPawn).r_bNearPayload = true;
                }
                UpdateAlliesNearbyBehavior(true);
            }
        }
    }
    //return;    
}

private final simulated function RemoveNearbyPlayer(Actor Other)
{
    local TgPawn OtherPawn;
    local int nIndex;

    OtherPawn = TgPawn(Other);
    nIndex = ((OtherPawn != none) ? m_TouchingPlayers.Find(OtherPawn) : -1);
    // End:0x168
    if(nIndex != -1)
    {
        m_TouchingPlayers.Remove(nIndex, 1);
        nIndex = m_VisiblePlayers.Find(OtherPawn);
        // End:0x168
        if(nIndex != -1)
        {
            // End:0x11A
            if((int(WorldInfo.NetMode) != int(NM_Client)) && TgPawn_Character(OtherPawn) != none)
            {
                TgPawn_Character(OtherPawn).r_bNearPayload = false;
            }
            m_VisiblePlayers.Remove(nIndex, 1);
            ((IsEnemy(OtherPawn)) ? r_nEnemies-- : r_nFriends--);
            UpdateAlliesNearbyBehavior(true);
        }
    }
    //return;    
}

private final simulated function UpdateAlliesNearbyBehavior(optional bool bSkipCountUpdate = false)
{
    local bool bAlliesNearby, bEnemiesNearby;
    local TgPawn_SiegeEngine_Payload.EPayloadControlState NextControlState;

    bAlliesNearby = false;
    bEnemiesNearby = false;
    // End:0x14A
    if(r_bEnable)
    {
        // End:0x90
        if((!bSkipCountUpdate && !WorldInfo.IsPlayingDemo()) && (int(Role) == int(ROLE_Authority)) || !m_bRequireLineOfSightForNearby)
        {
            UpdateFriendEnemyCounts();
        }
        bAlliesNearby = int(r_nFriends) > int(0);
        bEnemiesNearby = int(r_nEnemies) > int(0);
        NextControlState = 0;
        // End:0xFF
        if(bEnemiesNearby && bAlliesNearby)
        {
            NextControlState = 3;            
        }
        else
        {
            // End:0x11B
            if(bAlliesNearby)
            {
                NextControlState = 1;                
            }
            else
            {
                // End:0x134
                if(bEnemiesNearby)
                {
                    NextControlState = 2;
                }
            }
        }
        SetPayloadControlState(NextControlState);        
    }
    else
    {
        // End:0x1A9
        if(int(m_eControlState) != int(0))
        {
            // End:0x19A
            if(!WorldInfo.IsPlayingDemo())
            {
                r_nFriends = 0;
                r_nEnemies = 0;
            }
            SetPayloadControlState(0);            
        }
        else
        {
            // End:0x1E5
            if(!WorldInfo.IsPlayingDemo())
            {
                r_nFriends = 0;
                r_nEnemies = 0;
            }
            FullUpdate();
        }
    }
    //return;    
}

simulated function SetPayloadControlState(TgPawn_SiegeEngine_Payload.EPayloadControlState NextControlState)
{
    // End:0x38
    if(int(m_eControlState) != int(NextControlState))
    {
        m_eControlState = NextControlState;
        UpdateAutoPushState();
    }
    //return;    
}

private final function StartAutoMoveForward(optional bool bSkipUpdate)
{
    SetMoveWithoutAllies(1, bSkipUpdate);
    //return;    
}

private final function StopAutoMoveForward(optional bool bSkipUpdate)
{
    SetMoveWithoutAllies(0, bSkipUpdate);
    //return;    
}

final function SetMoveWithoutAllies(TgPawn_SiegeEngine_Payload.EAutoMovePayload eMove, optional bool bSkipFullUpdate)
{
    // End:0x48
    if(int(r_eMoveWithoutAllies) != int(eMove))
    {
        r_eMoveWithoutAllies = eMove;
        // End:0x48
        if(!bSkipFullUpdate)
        {
            FullUpdate();
        }
    }
    //return;    
}

private final function UpdateBackwardsTimers()
{
    local bool bAlliesNearby;

    bAlliesNearby = HasFriendlyPlayersNearby();
    // End:0x56
    if((!r_bEnable || bAlliesNearby) || int(r_eMoveWithoutAllies) == int(1))
    {
        StopMovingBackwards();        
    }
    else
    {
        // End:0xCB
        if(!r_bMovingBackwards)
        {
            // End:0x9B
            if((s_fTimeUntilMoveBackwards <= 0.0000000) || int(r_eMoveWithoutAllies) == int(2))
            {
                StartMovingBackwards();                
            }
            else
            {
                // End:0xCB
                if(!IsTimerActive('StartMovingBackwards'))
                {
                    SetTimer(s_fTimeUntilMoveBackwards, false, 'StartMovingBackwards');
                }
            }
        }
    }
    //return;    
}

private final simulated function StartMovingBackwards()
{
    ClearTimer('StartMovingBackwards');
    // End:0x9B
    if(!r_bMovingBackwards)
    {
        r_bMovingBackwards = true;
        // End:0x9B
        if(TgGame_PaladinsExtended(WorldInfo.Game) != none)
        {
            TgGame_PaladinsExtended(WorldInfo.Game).SendClientsRequestHelpText(163);
        }
    }
    UpdateMoving();
    //return;    
}

private final simulated function StopMovingBackwards()
{
    ClearTimer('StartMovingBackwards');
    // End:0x2D
    if(r_bMovingBackwards)
    {
        r_bMovingBackwards = false;
    }
    UpdateMoving();
    //return;    
}

final event ToggleCanAutoPushFoward(bool bEnable)
{
    // End:0x38
    if(r_bCanAutoPushForward != bEnable)
    {
        r_bCanAutoPushForward = bEnable;
        UpdateAutoPushState();
    }
    //return;    
}

private final function UpdateAutoPushState()
{
    // End:0x164
    if(r_bCanAutoPushForward)
    {
        switch(m_eControlState)
        {
            // End:0xB0
            case 1:
                ClearTimer('StopAutoMoveForward');
                // End:0xAD
                if((int(r_eMoveWithoutAllies) != int(1)) && !IsTimerActive('StartAutoMoveForward'))
                {
                    // End:0xA2
                    if(m_fAutoPushForwardDelay > 0.0000000)
                    {
                        SetMoveWithoutAllies(0, true);
                        SetTimer(m_fAutoPushForwardDelay, false, 'StartAutoMoveForward');                        
                    }
                    else
                    {
                        StartAutoMoveForward(true);
                    }
                }
                // End:0x161
                break;
            // End:0xE0
            case 0:
                ClearTimer('StopAutoMoveForward');
                ClearTimer('StartAutoMoveForward');
                // End:0x161
                break;
            // End:0xFFFF
            default:
                ClearTimer('StartAutoMoveForward');
                // End:0x15E
                if((int(r_eMoveWithoutAllies) == int(1)) && !IsTimerActive('StopAutoMoveForward'))
                {
                    // End:0x153
                    if(m_fStopAutoPushDelay > 0.0000000)
                    {
                        SetTimer(m_fAutoPushForwardDelay, false, 'StopAutoMoveForward');                        
                    }
                    else
                    {
                        StopAutoMoveForward(true);
                    }
                }
                // End:0x161
                break;
                break;
        }        
    }
    else
    {
        // End:0x185
        if(int(r_eMoveWithoutAllies) == int(1))
        {
            SetMoveWithoutAllies(0, true);
        }
        ClearTimer('StartAutoMoveForward');
        ClearTimer('StopAutoMoveForward');
    }
    FullUpdate();
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super(TgPawn_LanePusher).Tick(DeltaSeconds);
    // End:0xB4
    if(((m_bRequireLineOfSightForNearby && int(Role) == int(ROLE_Authority)) && m_TouchingPlayers.Length > 0) && WorldInfo.TimeSeconds >= m_fNextLineOfSightUpdateTime)
    {
        UpdateAlliesNearbyBehavior();
        m_fNextLineOfSightUpdateTime = WorldInfo.TimeSeconds + m_fLineOfSightUpdatePeriod;
    }
    //return;    
}

simulated event Destroyed()
{
    local TgPawn Other;

    super(TgPawn_LanePusher).Destroyed();
    // End:0x8E
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        // End:0x8D
        foreach m_VisiblePlayers(Other)
        {
            // End:0x8C
            if(TgPawn_Character(Other) != none)
            {
                TgPawn_Character(Other).r_bNearPayload = false;
            }            
        }        
    }
    m_VisiblePlayers.Length = 0;
    m_TouchingPlayers.Length = 0;
    // End:0x138
    if(m_NearbyCollisionProxy != none)
    {
        m_NearbyCollisionProxy.__ProxyTouch__Delegate = None;
        m_NearbyCollisionProxy.__ProxyUnTouch__Delegate = None;
        m_NearbyCollisionProxy.Destroy();
        m_NearbyCollisionProxy = none;
    }
    //return;    
}

defaultproperties
{
    r_bEnable=true
    m_bRequireLineOfSightForNearby=true
    m_fNearbyProximityDistance=600.0000000
    m_fLineOfSightUpdatePeriod=1.0000000
    s_fTimeUntilMoveBackwards=5.0000000
    m_fMoveBackSpeedScale=-0.1600000
    m_fBaseWheelSpeed=1.5000000
    m_fDamageScaleWhileTraveling=0.0000000
    m_bDoNotScaleCollisionBoxWithDatabase=true
    m_bFullStopWhenNoDesiredSpeed=true
    s_bStopBackpeddlingAtCheckpoints=true
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_Juggernaut.CollisionBox'
    begin object name="CollisionBox"
        StaticMesh=StaticMesh'GOD_CommonAssets.Meshes.GoldPayloadCollisionMesh'
        ReplacementPrimitive=none
        Translation=(X=0.0000000,Y=0.0000000,Z=-70.0000000)
    end object
    m_CollisionBox=CollisionBox
    m_fAcceleration=0.0000000
    m_bShowNameplate=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Juggernaut.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Juggernaut.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_Payload.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Juggernaut.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    m_SilhouetteClass=Class'TgGame.TgSilhouetteComponentPayload'
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Juggernaut.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Juggernaut.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Juggernaut.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Juggernaut.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    CollisionComponent=CollisionBox
}