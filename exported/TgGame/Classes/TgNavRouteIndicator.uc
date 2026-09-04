class TgNavRouteIndicator extends TgSkeletalMeshActorSpawnable
    native(Navigation)
    hidecategories(Navigation)
    implements(Interface_NavigationHandle);

const TG_NAV_ROUTE_INDICATOR_SPINUP_FX_ID = 0;
const TG_NAV_ROUTE_INDICATOR_PATHING_FX_ID = 2276;
const TG_NAV_ROUTE_INDICATOR_SPINDOWN_FX_ID = 0;

enum eSetRouteResult
{
    SetRoute_Failed,                // 0
    SetRoute_OK,                    // 1
    SetRoute_AtDestination,         // 2
    SetRoute_MAX                    // 3
};

var private native const noexport Pointer VfTable_IInterface_NavigationHandle;
var init array<init Vector> WayPoints;
var int Position;
var float m_fPositionStartTime;
var float m_fPositionMaxSeekTime;
var float m_fSpinUpTime;
var float m_fSpinDownTime;
var TgSpecialFx m_SpinUpFx;
var TgSpecialFx m_PathingFx;
var TgSpecialFx m_SpinDownFx;
var editinline NavigationHandle NavigationHandle;

// Export UTgNavRouteIndicator::execActivateSpinUpFx(FFrame&, void* const)
native function ActivateSpinUpFx();

// Export UTgNavRouteIndicator::execActivateSpinDownFx(FFrame&, void* const)
native function ActivateSpinDownFx();

// Export UTgNavRouteIndicator::execActivatePathingFx(FFrame&, void* const)
native function ActivatePathingFx();

// Export UTgNavRouteIndicator::execDeactivateFx(FFrame&, void* const)
native function DeactivateFx();

// Export UTgNavRouteIndicator::execDeactivatePathingFx(FFrame&, void* const)
native function DeactivatePathingFx();

// Export UTgNavRouteIndicator::execSetRoute(FFrame&, void* const)
native function TgNavRouteIndicator.eSetRouteResult SetRoute(Actor destActor);

// Export UTgNavRouteIndicator::execGetCurrentWayPoint(FFrame&, void* const)
native function Vector GetCurrentWayPoint();

// Export UTgNavRouteIndicator::execAdvanceWayPoint(FFrame&, void* const)
native function bool AdvanceWayPoint();

// Export UTgNavRouteIndicator::execUpdateRotation(FFrame&, void* const)
native function UpdateRotation(float fDeltaSeconds);

simulated event PostBeginPlay()
{
    super(SkeletalMeshActor).PostBeginPlay();
    NavigationHandle = new (self) Class'Engine.NavigationHandle';
    //return;    
}

simulated function Destroyed()
{
    super(SkeletalMeshActor).Destroyed();
    DeactivateFx();
    //return;    
}

simulated function TgNavRouteIndicator.eSetRouteResult SetRouteTo(Actor destActor)
{
    // End:0x23
    if(destActor != none)
    {
        return SetRoute(destActor);
    }
    return 0;
    //return ReturnValue;    
}

simulated event FindNavHandlePath(Actor destActor, float Dist)
{
    NavigationHandle.SetFinalDestination(destActor.Location, destActor);
    NavigationHandle.FindPath();
    //return;    
}

simulated function StartSeeking()
{
    local Rotator Rot;

    // End:0x1E
    if(WayPoints.Length >= 1)
    {
        SetLocation(WayPoints[0]);
    }
    // End:0x7D
    if(WayPoints.Length >= 2)
    {
        Rot = Rotator(WayPoints[1] - WayPoints[0]);
        Rot.Roll = 0;
        SetRotation(Rot);
    }
    GotoState('SpinUp');
    //return;    
}

simulated function StartNextPath()
{
    local Pawn OwnerPawn;
    local float fDist;

    // End:0x20
    if(!AdvanceWayPoint())
    {
        GotoState('SpinDown');        
    }
    else
    {
        OwnerPawn = ((PlayerController(Owner) != none) ? PlayerController(Owner).Pawn : none);
        // End:0xF7
        if((Position == 0) && OwnerPawn != none)
        {
            SetRotation(OwnerPawn.Rotation);
            SetLocation(OwnerPawn.Location + (Vector(OwnerPawn.Rotation) * 60.0000000));
        }
        fDist = VSize((GetCurrentWayPoint()) - Location);
        m_fPositionStartTime = WorldInfo.TimeSeconds;
        // End:0x199
        if((fDist > float(0)) && VSize(Velocity) > float(0))
        {
            m_fPositionMaxSeekTime = fDist / VSize(Velocity);
            m_fPositionMaxSeekTime *= 1.5000000;            
        }
        else
        {
            m_fPositionMaxSeekTime = 0.0000000;
        }
        GotoState('Pathing');
    }
    //return;    
}

function float GetMaxSpeed()
{
    local Pawn OwnerPawn;

    OwnerPawn = ((PlayerController(Owner) != none) ? PlayerController(Owner).Pawn : none);
    // End:0x81
    if(OwnerPawn != none)
    {
        return OwnerPawn.GroundSpeed + 60.0000000;
    }
    return 200.0000000;
    //return ReturnValue;    
}

event NotifyPathChanged()
{
    //return;    
}

state SpinUp
{
    simulated function BeginState(name PrevStateName)
    {
        // End:0x35
        if(m_fSpinUpTime > float(0))
        {
            SetTimer(m_fSpinUpTime, false, 'StartNextPath');
            ActivateSpinUpFx();            
        }
        else
        {
            StartNextPath();
            ActivateSpinUpFx();
        }
        ActivatePathingFx();
        //return;        
    }
    stop;    
}

state SpinDown
{
    simulated function BeginState(name PrevStateName)
    {
        ActivateSpinDownFx();
        LifeSpan = ((m_fSpinDownTime > float(0)) ? m_fSpinDownTime : 2.0000000);
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        SetPhysics(0);
        //return;        
    }
    stop;    
}

state Pathing
{
    simulated function Tick(float DeltaTime)
    {
        local float MaxSpeed;

        UpdateRotation(DeltaTime);
        MaxSpeed = GetMaxSpeed();
        Velocity = Vector(Rotation) * MaxSpeed;
        // End:0x7C
        if(VSize((GetCurrentWayPoint()) - Location) < FMax(30.0000000, 0.0000000))
        {
            StartNextPath();            
        }
        else
        {
            // End:0xD2
            if((m_fPositionMaxSeekTime > float(0)) && Abs(WorldInfo.TimeSeconds - m_fPositionStartTime) > m_fPositionMaxSeekTime)
            {
                StartNextPath();
            }
        }
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        SetPhysics(6);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        DeactivatePathingFx();
        //return;        
    }
    stop;    
}

defaultproperties
{
    Position=-1
    m_fSpinUpTime=2.0000000
    m_fSpinDownTime=60.0000000
    c_bLoadMeshAssetts=false
    // Reference: SkeletalMeshComponent'TgGame.Default__TgNavRouteIndicator.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgNavRouteIndicator.SkeletalMeshComponent0.AnimNodeSeq0_7'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0.AnimNodeSeq0_6'
        begin object name="AnimNodeSeq0_7"
        end object
        Animations=AnimNodeSeq0_7
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgNavRouteIndicator.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgNavRouteIndicator.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgNavRouteIndicator.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgNavRouteIndicator.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgNavRouteIndicator.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    LifeSpan=60.0000000
    CollisionComponent=SkeletalMeshComponent0
}