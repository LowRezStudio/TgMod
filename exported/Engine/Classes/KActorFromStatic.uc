class KActorFromStatic extends KActor
    transient
    native(Physics)
    notplaceable;

var Actor MyStaticMeshActor;
var float MaxImpulseSpeed;

// Export UKActorFromStatic::execDisablePrecomputedLighting(FFrame&, void* const)
native final function DisablePrecomputedLighting();

event OnSleepRBPhysics()
{
    BecomeStatic();
    //return;    
}

event OnWakeRBPhysics()
{
    ClearTimer('BecomeStatic');
    //return;    
}

function BecomeStatic()
{
    // End:0x6E
    if(!WorldInfo.bDropDetail && (WorldInfo.TimeSeconds - LastRenderTime) < 0.1500000)
    {
        SetTimer(1.0000000, false, 'BecomeStatic');
        return;
    }
    // End:0x93
    if(StaticMeshComponent.RigidBodyIsAwake())
    {
        return;
    }
    MakeStatic();
    Destroy();
    //return;    
}

// Export UKActorFromStatic::execMakeStatic(FFrame&, void* const)
native static function MakeStatic();

// Export UKActorFromStatic::execMakeDynamic(FFrame&, void* const)
native static function KActorFromStatic MakeDynamic(StaticMeshComponent MovableMesh);

event ApplyImpulse(Vector ImpulseDir, float ImpulseMag, Vector HitLocation, optional TraceHitInfo HitInfo, optional Class<DamageType> DamageType)
{
    local float BodyMass;

    BodyMass = StaticMeshComponent.BodyInstance.GetBodyMass();
    // End:0xDB
    if((BodyMass > 0.0000000) && (DamageType == none) || !DamageType.default.bRadialDamageVelChange)
    {
        // End:0xB2
        if(BodyMass < 1.0000000)
        {
            BodyMass = Sqrt(BodyMass);
        }
        ImpulseMag = FMin(ImpulseMag / BodyMass, MaxImpulseSpeed);
    }
    CollisionComponent.AddImpulse(Normal(ImpulseDir) * ImpulseMag, HitLocation,, true);
    //return;    
}

function ReceiveImpulse(Pawn Other, Vector HitLocation, Vector HitNormal)
{
    local Vector HitDir;
    local float ImpulseMag;

    HitDir = Location - HitLocation;
    HitDir.Z = FMax(HitDir.Z, 0.0000000);
    HitDir = Normal(HitDir);
    ImpulseMag = FMax(0.5000000 * Other.GroundSpeed, (Other.Velocity - Velocity) Dot HitDir);
    ApplyImpulse(HitDir, ImpulseMag, Location);
    //return;    
}

event Bump(Actor Other, PrimitiveComponent OtherComp, Vector HitNormal)
{
    ReceiveImpulse(Pawn(Other), Other.Location, HitNormal);
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x46
    if(Pawn(Other) != none)
    {
        ReceiveImpulse(Pawn(Other), HitLocation, HitNormal);
    }
    //return;    
}

simulated function TakeRadiusDamage(Controller InstigatedBy, float BaseDamage, float DamageRadius, Class<DamageType> DamageType, float Momentum, Vector HurtOrigin, bool bFullDamage, Actor DamageCauser, optional float DamageFalloffExponent = 1.0000000)
{
    local int Idx;
    local SeqEvent_TakeDamage DmgEvt;

    Idx = 0;
    J0x14:

    // End:0xAC [Loop If]
    if(Idx < GeneratedEvents.Length)
    {
        DmgEvt = SeqEvent_TakeDamage(GeneratedEvents[Idx]);
        // End:0x9E
        if(DmgEvt != none)
        {
            DmgEvt.HandleDamage(self, InstigatedBy, DamageType, int(BaseDamage));
        }
        Idx++;
        // [Loop Continue]
        goto J0x14;
    }
    // End:0x146
    if((bDamageAppliesImpulse && DamageType.default.RadialDamageImpulse > float(0)) && int(Role) == int(ROLE_Authority))
    {
        ApplyImpulse(Location - HurtOrigin, DamageType.default.RadialDamageImpulse, Location,, DamageType);
    }
    //return;    
}

auto state Initializing
{
    event Tick(float DeltaTime)
    {
        DisablePrecomputedLighting();
        GotoState('None');
        //return;        
    }
    stop;    
}

defaultproperties
{
    MaxImpulseSpeed=900.0000000
    StaticMeshComponent=none
    LightEnvironment=none
    Components=none
    RemoteRole=ENetRole.ROLE_None
    bNoDelete=false
    bCanStepUpOn=false
    bCallRigidBodyWakeEvents=true
    CollisionComponent=none
}