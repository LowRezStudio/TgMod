class TgSiegePushActor extends Actor
    placeable
    hidecategories(Navigation);

enum EPushState
{
    PushState_Paused,               // 0
    PushState_Forward,              // 1
    PushState_PendingReverse,       // 2
    PushState_Reverse,              // 3
    PushState_MAX                   // 4
};

var TgCollisionProxy_Cylinder s_CollisionProxy;
var() const float m_fCollisionProxyRadius;
var() const float m_fCollisionProxyHeight;
var() export editinline SkeletalMeshComponent m_SkelMesh;
var() export editinline StaticMeshComponent m_RadiusMesh;
var transient int m_nTF1Count;
var transient int m_nTF2Count;
var() int m_nDefenderTaskForce;
var transient TgSiegePushActor.EPushState m_CurrentPushState;
var() float m_fPendingReverseTime;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x132
    if(int(Role) == int(ROLE_Authority))
    {
        s_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, Location, Rotation,, true);
        s_CollisionProxy.SetBase(self);
        s_CollisionProxy.__ProxyTouch__Delegate = CollisionProxyOnTouch;
        s_CollisionProxy.__ProxyUnTouch__Delegate = CollisionProxyOnUnTouch;
        s_CollisionProxy.DelegatesUpdated();
        s_CollisionProxy.m_CollisionCylinder.SetCylinderSize(m_fCollisionProxyRadius, m_fCollisionProxyHeight);
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

    m_nTF1Count = 0;
    m_nTF2Count = 0;
    I = 0;
    J0x21:

    // End:0xF8 [Loop If]
    if(I < s_CollisionProxy.m_NearByPlayers.Length)
    {
        NearByPawn = TgPawn_Character(s_CollisionProxy.m_NearByPlayers[I]);
        // End:0xEA
        if(NearByPawn != none)
        {
            switch(NearByPawn.GetTaskForceNumber())
            {
                // End:0xD4
                case 1:
                    m_nTF1Count++;
                    // End:0xEA
                    break;
                // End:0xE7
                case 2:
                    m_nTF2Count++;
                    // End:0xEA
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
            goto J0x21;
        }/* !MISMATCHING REMOVE, tried Loop got Type:Else Position:0x0EA! */
        // End:0x127
        if((m_nTF1Count > 0) && m_nTF2Count > 0)
        {
            SetCurrentPushState(0);            
        }
        else
        {
            // End:0x163
            if(m_nDefenderTaskForce == 1)
            {
                // End:0x154
                if(m_nTF1Count > 0)
                {
                    SetCurrentPushState(1);                    
                }
                else
                {
                    SetCurrentPushState(2);
                }                
            }
            else
            {
                // End:0x19D
                if(m_nDefenderTaskForce == 2)
                {
                    // End:0x191
                    if(m_nTF2Count > 0)
                    {
                        SetCurrentPushState(1);                        
                    }
                    else
                    {
                        SetCurrentPushState(2);
                    }
                }
            }
        }
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:Loop Position:0x021! */
}

function SetReversePushState()
{
    SetCurrentPushState(3);
    //return;    
}

function SetCurrentPushState(TgSiegePushActor.EPushState NewPushState)
{
    // End:0x1D
    if(int(m_CurrentPushState) == int(NewPushState))
    {
        return;
    }
    ClearTimer('SetReversePushState');
    switch(NewPushState)
    {
        // End:0x7B
        case 2:
            SetTimer(m_fPendingReverseTime, false, 'SetReversePushState');
            TriggerEventClass(Class'TgGame.TgSeqEvent_SiegePush', self, 2);
            // End:0xDC
            break;
        // End:0x9B
        case 0:
            TriggerEventClass(Class'TgGame.TgSeqEvent_SiegePush', self, 2);
            // End:0xDC
            break;
        // End:0xBA
        case 1:
            TriggerEventClass(Class'TgGame.TgSeqEvent_SiegePush', self, 0);
            // End:0xDC
            break;
        // End:0xD9
        case 3:
            TriggerEventClass(Class'TgGame.TgSeqEvent_SiegePush', self, 1);
            // End:0xDC
            break;
        // End:0xFFFF
        default:
            break;
    }
    m_CurrentPushState = NewPushState;
    //return;    
}

defaultproperties
{
    m_fCollisionProxyRadius=500.0000000
    m_fCollisionProxyHeight=200.0000000
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSiegePushActor.SiegeEngine'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SiegeEngine'
    begin object name="SiegeEngine" class=Engine.SkeletalMeshComponent
        ReplacementPrimitive=none
        CollideActors=true
        BlockActors=true
        BlockZeroExtent=true
        BlockNonZeroExtent=true
        BlockRigidBody=true
        Scale=3.0000000
    end object
    m_SkelMesh=SiegeEngine
    // Reference: StaticMeshComponent'TgGame.Default__TgSiegePushActor.RadiusMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RadiusMesh'
    begin object name="RadiusMesh" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        CollideActors=false
        BlockActors=false
        BlockZeroExtent=false
        BlockNonZeroExtent=false
        BlockRigidBody=false
    end object
    m_RadiusMesh=RadiusMesh
    m_fPendingReverseTime=5.0000000
    Components[0]=none
    Components[1]=SiegeEngine
    Components[2]=RadiusMesh
    Physics=EPhysics.PHYS_Interpolating
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bCollideActors=true
    bBlockActors=true
    bProjTarget=true
    NetPriority=2.0000000
    CollisionComponent=SiegeEngine
    SupportedEvents=/* Array type was not detected. */
}