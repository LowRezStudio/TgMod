class TgCapturePoint extends Actor
    native(Game)
    placeable
    hidecategories(Navigation);

var TgCollisionProxy_Cylinder s_CollisionProxy;
var TgRepInfo_CapturePoint r_RepInfo;
var() const float m_fCollisionProxyRadius;
var() const float m_fCollisionProxyHeight;
var const float m_fBaseTransitionSpeed;
var const float m_fTransitionSpeedBuff;
var transient float m_fCurrentTransitionSpeed;
var transient TgSeqEvent_ControlPointOwnershipChange c_OwnershipChangedKismetNode;
var() TgBotFactory_PointCapture s_BotSpawners[2];
var transient TgBotFactory_PointCapture m_CurrentBotSpawners[2];
var() TgBotFactory_PointCapture s_NeutralBotSpawner;
var() const int m_CapturePointIndex;
var() const float s_fReplenishBotTime;
var private transient float s_fRemainingReplenishBotTime;
var float s_fFriendlyReplenishBuffPct;
var float m_fRegenUpdateTimer;
var const float m_fOwnedManaRegen;
var const float m_fOwnedHealthRegen;
var transient TgGame_Mission s_GameInfo;
var transient int m_nTF1Count;
var transient int m_nTF2Count;
var transient float m_fLastEnemyKillVoxTimestamp;
var() int m_nLaneNumber;
var() export editinline SpriteComponent m_WorldIconSprite;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_RepInfo;
}

// Export UTgCapturePoint::execAlertPointChanged(FFrame&, void* const)
native function AlertPointChanged();

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    //return;    
}

function SpawnNeutralBot()
{
    s_NeutralBotSpawner.SpawnNextBot();
    //return;    
}

simulated event PreBeginPlay()
{
    super.PreBeginPlay();
    // End:0x61
    if(int(Role) == int(ROLE_Authority))
    {
        r_RepInfo = Spawn(Class'TgGame.TgRepInfo_CapturePoint', self);
        r_RepInfo.r_OwningCapturePoint = self;
    }
    //return;    
}

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x196
    if(int(Role) == int(ROLE_Authority))
    {
        s_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, Location, Rotation,, true);
        s_CollisionProxy.SetBase(self);
        s_CollisionProxy.__ProxyTouch__Delegate = CollisionProxyOnTouch;
        s_CollisionProxy.__ProxyUnTouch__Delegate = CollisionProxyOnUnTouch;
        s_CollisionProxy.DelegatesUpdated();
        s_CollisionProxy.m_CollisionCylinder.SetCylinderSize(m_fCollisionProxyRadius, m_fCollisionProxyHeight);
        s_BotSpawners[0].m_CapturePoint = self;
        s_BotSpawners[1].m_CapturePoint = self;
        s_NeutralBotSpawner.m_CapturePoint = self;
    }
    //return;    
}

simulated event CollisionProxyOnTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x2D
    if(Other.IsA('TgPawn_Character'))
    {
        NearbyPawnsUpdated();
    }
    //return;    
}

simulated event CollisionProxyOnUnTouch(Actor Other)
{
    // End:0x2D
    if(Other.IsA('TgPawn_Character'))
    {
        NearbyPawnsUpdated();
    }
    //return;    
}

function NearbyPawnsUpdated()
{
    local TgPawn_Character NearByPawn;
    local int I;

    // End:0x40
    if(s_GameInfo == none)
    {
        s_GameInfo = TgGame_Mission(WorldInfo.Game);
    }
    // End:0xA7
    if((s_GameInfo == none) || (int(s_GameInfo.m_eTimerState) != int(3)) && int(s_GameInfo.m_eTimerState) != int(4))
    {
        return;
    }
    // End:0xCB
    if(r_RepInfo.r_bIsLocked)
    {
        return;
    }
    m_nTF1Count = 0;
    m_nTF2Count = 0;
    I = 0;
    J0xEC:

    // End:0x1C3 [Loop If]
    if(I < s_CollisionProxy.m_NearByPlayers.Length)
    {
        NearByPawn = TgPawn_Character(s_CollisionProxy.m_NearByPlayers[I]);
        // End:0x1B5
        if(NearByPawn != none)
        {
            switch(NearByPawn.GetTaskForceNumber())
            {
                // End:0x19F
                case 1:
                    m_nTF1Count++;
                    // End:0x1B5
                    break;
                // End:0x1B2
                case 2:
                    m_nTF2Count++;
                    // End:0x1B5
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        else
        {
            I++;
            // [Loop Continue]
            goto J0xEC;
        }/* !MISMATCHING REMOVE, tried Loop got Type:Else Position:0x1B5! */
        // End:0x1F5
        if((m_nTF1Count > 0) && m_nTF2Count > 0)
        {
            m_fCurrentTransitionSpeed = 0.0000000;            
        }
        else
        {
            // End:0x2E7
            if(r_RepInfo.r_nControlledByTaskForce == 0)
            {
                // End:0x24B
                if((m_nTF1Count == 0) && m_nTF2Count == 0)
                {
                    m_fCurrentTransitionSpeed = 0.0000000;                    
                }
                else
                {
                    // End:0x2E4
                    if(s_NeutralBotSpawner.nCurrentCount == 0)
                    {
                        // End:0x2B6
                        if(m_nTF1Count > 0)
                        {
                            m_fCurrentTransitionSpeed = -1.0000000 * (m_fBaseTransitionSpeed + (m_fTransitionSpeedBuff * float(m_nTF1Count - 1)));                            
                        }
                        else
                        {
                            m_fCurrentTransitionSpeed = m_fBaseTransitionSpeed + (m_fTransitionSpeedBuff * float(m_nTF1Count - 1));
                        }
                    }
                }                
            }
            else
            {
                // End:0x3D0
                if(r_RepInfo.r_nControlledByTaskForce == 1)
                {
                    // End:0x373
                    if((m_nTF2Count > 0) && m_CurrentBotSpawners[0].nCurrentCount == 0)
                    {
                        m_fCurrentTransitionSpeed = m_fBaseTransitionSpeed + (m_fTransitionSpeedBuff * float(m_nTF1Count - 1));                        
                    }
                    else
                    {
                        // End:0x3CD
                        if(r_RepInfo.r_fOwnershipPct > 0.0000000)
                        {
                            m_fCurrentTransitionSpeed = -1.0000000 * (m_fBaseTransitionSpeed + (m_fTransitionSpeedBuff * float(m_nTF1Count)));
                        }
                    }                    
                }
                else
                {
                    // End:0x4B7
                    if(r_RepInfo.r_nControlledByTaskForce == 2)
                    {
                        // End:0x464
                        if((m_nTF1Count > 0) && m_CurrentBotSpawners[1].nCurrentCount == 0)
                        {
                            m_fCurrentTransitionSpeed = -1.0000000 * (m_fBaseTransitionSpeed + (m_fTransitionSpeedBuff * float(m_nTF1Count - 1)));                            
                        }
                        else
                        {
                            // End:0x4B7
                            if(r_RepInfo.r_fOwnershipPct < 1.0000000)
                            {
                                m_fCurrentTransitionSpeed = m_fBaseTransitionSpeed + (m_fTransitionSpeedBuff * float(m_nTF1Count));
                            }
                        }
                    }
                }
            }
        }
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:Loop Position:0x0EC! */
}

event OnPointCaptureOwnershipChanged(int NewTaskForceOwner, int PreviousTaskForceOwner)
{
    local int I;
    local TgPawn_Character NearByPawn;
    local TgGame_Mission TgG;
    local array<SequenceObject> KismetEvents;
    local TgSeqEvent_ControlPointOwnershipChange_Server SeqEvent;
    local array<int> ActivateIndices;

    s_fRemainingReplenishBotTime = 0.0000000;
    m_fLastEnemyKillVoxTimestamp = -1.0000000;
    // End:0x79
    if(TgGame_SinglePointCaptureAndHold(WorldInfo.Game) != none)
    {
        // End:0x76
        if((PreviousTaskForceOwner != 1) && PreviousTaskForceOwner != 2)
        {
            SpawnBotsForCurrentTaskForce();
        }        
    }
    else
    {
        SpawnBotsForCurrentTaskForce();
    }
    TgG = TgGame_Mission(WorldInfo.Game);
    // End:0x1FD
    if(TgG != none)
    {
        I = 0;
        J0xCE:

        // End:0x1AC [Loop If]
        if(I < s_CollisionProxy.m_NearByPlayers.Length)
        {
            NearByPawn = TgPawn_Character(s_CollisionProxy.m_NearByPlayers[I]);
            // End:0x19E
            if((NearByPawn != none) && int(NearByPawn.GetTaskForceNumber()) == NewTaskForceOwner)
            {
                TgG.CapturedPoint(NearByPawn);
            }
            I++;
            // [Loop Continue]
            goto J0xCE;
        }
        TgG.OnPointCaptureOwnershipChanged(self, NewTaskForceOwner, PreviousTaskForceOwner);
        TgG.UpdateLockedPointStatus();
    }
    AlertPointChanged();
    WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_ControlPointOwnershipChange_Server', true, KismetEvents);
    I = 0;
    J0x25A:

    // End:0x320 [Loop If]
    if(I < KismetEvents.Length)
    {
        SeqEvent = TgSeqEvent_ControlPointOwnershipChange_Server(KismetEvents[I]);
        // End:0x312
        if((SeqEvent != none) && SeqEvent.PointIndex == (GetCapturePointIndex()))
        {
            ActivateIndices[0] = 0;
            SeqEvent.CheckActivate(self, self, false, ActivateIndices);
            // [Explicit Break]
            goto J0x320;
        }
        I++;
        // [Loop Continue]
        goto J0x25A;
    }
    J0x320:

    // End:0x379
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && r_RepInfo != none)
    {
        r_RepInfo.OnTaskForceControlChanged();
    }
    //return;    
}

event OnPointReclaimed()
{
    local int I;
    local TgPawn_Character NearByPawn;
    local TgGame_Mission TgG;

    SpawnBotsForCurrentTaskForce();
    TgG = TgGame_Mission(WorldInfo.Game);
    // End:0x102
    if(TgG != none)
    {
        I = 0;
        J0x55:

        // End:0x102 [Loop If]
        if(I < s_CollisionProxy.m_NearByPlayers.Length)
        {
            NearByPawn = TgPawn_Character(s_CollisionProxy.m_NearByPlayers[I]);
            // End:0xF4
            if(NearByPawn != none)
            {
                TgG.CapturePointReclaimed(NearByPawn);
            }
            I++;
            // [Loop Continue]
            goto J0x55;
        }
    }
    //return;    
}

event OnBotDied(int DeadBotTaskForce)
{
    // End:0x3F
    if(DeadBotTaskForce == r_RepInfo.r_nControlledByTaskForce)
    {
        s_fRemainingReplenishBotTime = s_fReplenishBotTime;
    }
    NearbyPawnsUpdated();
    //return;    
}

event SpawnBotsForCurrentTaskForce()
{
    local TgGame_Mission GameInfo;

    // End:0x13
    if(s_fRemainingReplenishBotTime > float(0))
    {
        return;
    }
    GameInfo = TgGame_Mission(WorldInfo.Game);
    // End:0x124
    if((r_RepInfo != none) && GameInfo != none)
    {
        // End:0x124
        if(true)
        {
            // End:0xC7
            if(r_RepInfo.r_nControlledByTaskForce == 1)
            {
                s_BotSpawners[0].SpawnNextBot();
                m_CurrentBotSpawners[0] = s_BotSpawners[0];                
            }
            else
            {
                // End:0x124
                if(r_RepInfo.r_nControlledByTaskForce == 2)
                {
                    s_BotSpawners[1].SpawnNextBot();
                    m_CurrentBotSpawners[1] = s_BotSpawners[1];
                }
            }
        }
    }
    //return;    
}

simulated function int GetCapturePointIndex()
{
    return m_CapturePointIndex;
    //return ReturnValue;    
}

simulated function OnTaskForceControlChanged(int NewTaskForce)
{
    local TgPlayerController TgPC;
    local array<SequenceObject> KismetEvents;
    local TgSeqEvent_ControlPointOwnershipChange SeqEvent;
    local int Idx, PointIndex;
    local array<int> ActivateIndices;

    // End:0x200
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x13E
        if(c_OwnershipChangedKismetNode == none)
        {
            PointIndex = GetCapturePointIndex();
            WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_ControlPointOwnershipChange', true, KismetEvents);
            Idx = 0;
            J0x9F:

            // End:0x13E [Loop If]
            if(Idx < KismetEvents.Length)
            {
                SeqEvent = TgSeqEvent_ControlPointOwnershipChange(KismetEvents[Idx]);
                // End:0x130
                if((SeqEvent != none) && SeqEvent.PointIndex == PointIndex)
                {
                    c_OwnershipChangedKismetNode = SeqEvent;
                    // [Explicit Break]
                    goto J0x13E;
                }
                Idx++;
                // [Loop Continue]
                goto J0x9F;
            }
        }
        J0x13E:

        // End:0x200
        if(c_OwnershipChangedKismetNode != none)
        {
            TgPC = TgPlayerController(GetALocalPlayerController());
            // End:0x189
            if(NewTaskForce == 0)
            {
                ActivateIndices[0] = 0;                
            }
            else
            {
                // End:0x1C6
                if(TgPC.GetTaskForceNumber() == NewTaskForce)
                {
                    ActivateIndices[0] = 1;                    
                }
                else
                {
                    ActivateIndices[0] = 2;
                }
            }
            c_OwnershipChangedKismetNode.CheckActivate(self, self, false, ActivateIndices);
        }
    }
    //return;    
}

simulated event Destroyed()
{
    super.Destroyed();
    // End:0x31
    if(s_CollisionProxy != none)
    {
        s_CollisionProxy.Destroy();
    }
    // End:0x5C
    if(s_BotSpawners[1] != none)
    {
        s_BotSpawners[1].Destroy();
    }
    // End:0x87
    if(s_BotSpawners[0] != none)
    {
        s_BotSpawners[0].Destroy();
    }
    //return;    
}

function OnNearbyEnemyPlayerDied(TgPawn DeadPawn)
{
    local TgPlayerController TgPC;
    local int I;

    // End:0x169
    if(((WorldInfo.TimeSeconds - 10.0000000) > m_fLastEnemyKillVoxTimestamp) || m_fLastEnemyKillVoxTimestamp == -1.0000000)
    {
        I = 0;
        J0x53:

        // End:0x169 [Loop If]
        if(I < DeadPawn.s_Damagers.Length)
        {
            // End:0x15B
            if(DeadPawn.s_Damagers[I].DamagerPawn != none)
            {
                TgPC = TgPlayerController(DeadPawn.s_Damagers[I].DamagerPawn.Controller);
                // End:0x15B
                if(TgPC != none)
                {
                    m_fLastEnemyKillVoxTimestamp = WorldInfo.TimeSeconds;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x53;
        }
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x86
    if(Action.InputLinks[0].bHasImpulse)
    {
        r_RepInfo.r_bIsLocked = false;
        r_RepInfo.bNetDirty = true;
        SpawnNeutralBot();        
    }
    else
    {
        // End:0x16F
        if(Action.InputLinks[1].bHasImpulse)
        {
            r_RepInfo.r_nControlledByTaskForce = 0;
            r_RepInfo.r_fOwnershipPct = 0.5000000;
            OnPointCaptureOwnershipChanged(0, r_RepInfo.r_nControlledByTaskForce);
            r_RepInfo.r_bIsLocked = true;
            r_RepInfo.bNetDirty = true;            
        }
        else
        {
            // End:0x2CA
            if(Action.InputLinks[2].bHasImpulse)
            {
                // End:0x21B
                if(r_RepInfo.r_bIsLocked == true)
                {
                    r_RepInfo.r_bIsLocked = false;
                    r_RepInfo.bNetDirty = true;
                    SpawnNeutralBot();                    
                }
                else
                {
                    r_RepInfo.r_nControlledByTaskForce = 0;
                    r_RepInfo.r_fOwnershipPct = 0.5000000;
                    OnPointCaptureOwnershipChanged(0, r_RepInfo.r_nControlledByTaskForce);
                    r_RepInfo.r_bIsLocked = true;
                    r_RepInfo.bNetDirty = true;
                }
            }
        }
    }
    //return;    
}

simulated function UpdateLockEffects()
{
    m_WorldIconSprite.SetHidden(!r_RepInfo.r_bIsLocked);
    //return;    
}

simulated function OnGetTaskForceNumber(TgSeqAct_GetTaskForceNumber Action)
{
    SeqVar_Int(Action.VariableLinks[1].LinkedVariables[0]).IntValue = r_RepInfo.r_nControlledByTaskForce;
    //return;    
}

defaultproperties
{
    m_fCollisionProxyRadius=500.0000000
    m_fCollisionProxyHeight=200.0000000
    m_fBaseTransitionSpeed=5000.0000000
    m_fTransitionSpeedBuff=0.0050000
    m_CapturePointIndex=-1
    s_fReplenishBotTime=30.0000000
    s_fFriendlyReplenishBuffPct=0.2500000
    m_fLastEnemyKillVoxTimestamp=-1.0000000
    // Reference: SpriteComponent'TgGame.Default__TgCapturePoint.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    begin object name="WorldIcon" class=Engine.SpriteComponent
        bIsScreenSizeScaled=true
        ScreenSize=0.0000100
        ReplacementPrimitive=none
        DepthPriorityGroup=ESceneDepthPriorityGroup.SDPG_Foreground
        HiddenGame=true
        HiddenEditor=true
        Translation=(X=0.0000000,Y=0.0000000,Z=300.0000000)
        Scale=70.0000000
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=WorldIcon
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    NetPriority=2.0000000
}