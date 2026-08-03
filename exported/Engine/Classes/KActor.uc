class KActor extends DynamicSMActor
    native(Physics)
    nativereplication
    placeable
    classgroup(Physics);

var() bool bDamageAppliesImpulse;
var() repnotify bool bWakeOnLevelStart;
var bool bCurrentSlide;
var bool bSlideActive;
var(StayUprightSpring) bool bEnableStayUprightSpring;
var() bool bLimitMaxPhysicsVelocity;
var transient bool bNeedsRBStateReplication;
var bool bDisableClientSidePawnInteractions;
var(Paladins) bool TgApplyHitImpulse;
var(Paladins) bool TgApplyTouchImpulse;
var export editinline ParticleSystemComponent ImpactEffectComponent;
var export editinline AudioComponent ImpactSoundComponent;
var export editinline AudioComponent ImpactSoundComponent2;
var float LastImpactTime;
var PhysEffectInfo ImpactEffectInfo;
var export editinline ParticleSystemComponent SlideEffectComponent;
var export editinline AudioComponent SlideSoundComponent;
var float LastSlideTime;
var PhysEffectInfo SlideEffectInfo;
var(StayUprightSpring) float StayUprightTorqueFactor;
var(StayUprightSpring) float StayUprightMaxTorque;
var() float MaxPhysicsVelocity;
var native const RigidBodyState RBState;
var native const float AngErrorAccumulator;
var repnotify Vector ReplicatedDrawScale3D;
var transient Vector InitialLocation;
var transient Rotator InitialRotation;
var(Paladins) float TgTouchMagnitude;
var(Paladins) AkBaseSoundObject TgTouchSound;

replication
{
    // Pos:0x000
    if(bNeedsRBStateReplication && int(Role) == int(ROLE_Authority))
        RBState;

    // Pos:0x020
    if(bNetInitial && int(Role) == int(ROLE_Authority))
        ReplicatedDrawScale3D, bWakeOnLevelStart;
}

// Export UKActor::execGetKActorPhysMaterial(FFrame&, void* const)
native final function PhysicalMaterial GetKActorPhysMaterial();

// Export UKActor::execResolveRBState(FFrame&, void* const)
native final function ResolveRBState();

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x4B
    if(bWakeOnLevelStart && StaticMeshComponent != none)
    {
        StaticMeshComponent.WakeRigidBody();        
    }
    else
    {
        bNeedsRBStateReplication = !bNoDelete;
    }
    ReplicatedDrawScale3D = DrawScale3D * 1000.0000000;
    // End:0xB9
    if((StaticMeshComponent != none) && StaticMeshComponent.bNotifyRigidBodyCollision)
    {
        SetPhysicalCollisionProperties();
    }
    InitialLocation = Location;
    InitialRotation = Rotation;
    // End:0x135
    if((bDisableClientSidePawnInteractions && int(Role) != int(ROLE_Authority)) && StaticMeshComponent != none)
    {
        StaticMeshComponent.SetRBCollidesWithChannel(2, false);
    }
    //return;    
}

simulated event FellOutOfWorld(Class<DamageType> dmgType)
{
    ShutDown();
    super(Actor).FellOutOfWorld(dmgType);
    //return;    
}

simulated event Destroyed()
{
    // End:0x82
    if(ImpactEffectInfo.Sound != none)
    {
        // End:0x52
        if(ImpactSoundComponent != none)
        {
            ImpactSoundComponent.bAutoDestroy = true;
        }
        // End:0x82
        if(ImpactSoundComponent2 != none)
        {
            ImpactSoundComponent2.bAutoDestroy = true;
        }
    }
    // End:0xC5
    if(SlideEffectInfo.Sound != none)
    {
        SlideSoundComponent.bAutoDestroy = true;
    }
    super(Actor).Destroyed();
    //return;    
}

simulated function SetPhysicalCollisionProperties()
{
    local PhysicalMaterial PhysMat;

    PhysMat = GetKActorPhysMaterial();
    ImpactEffectInfo = PhysMat.FindPhysEffectInfo(0);
    SlideEffectInfo = PhysMat.FindPhysEffectInfo(1);
    // End:0x100
    if(ImpactEffectInfo.Effect != none)
    {
        ImpactEffectComponent = new (self) Class'Engine.ParticleSystemComponent';
        ImpactEffectComponent.bAutoActivate = false;
        ImpactEffectComponent.SetTemplate(ImpactEffectInfo.Effect);
    }
    // End:0x1C8
    if(ImpactEffectInfo.Sound != none)
    {
        ImpactSoundComponent = new (self) Class'Engine.AudioComponent';
        ImpactSoundComponent.SoundCue = ImpactEffectInfo.Sound;
        ImpactSoundComponent2 = new (self) Class'Engine.AudioComponent';
        ImpactSoundComponent2.SoundCue = ImpactEffectInfo.Sound;
    }
    // End:0x25E
    if(SlideEffectInfo.Effect != none)
    {
        SlideEffectComponent = new (self) Class'Engine.ParticleSystemComponent';
        SlideEffectComponent.bAutoActivate = false;
        SlideEffectComponent.SetTemplate(SlideEffectInfo.Effect);
    }
    // End:0x2D3
    if(SlideEffectInfo.Sound != none)
    {
        SlideSoundComponent = new (self) Class'Engine.AudioComponent';
        SlideSoundComponent.SoundCue = SlideEffectInfo.Sound;
    }
    //return;    
}

simulated event SpawnedByKismet()
{
    // End:0x2C
    if(StaticMeshComponent.bNotifyRigidBodyCollision)
    {
        SetPhysicalCollisionProperties();
    }
    InitialLocation = Location;
    InitialRotation = Rotation;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    local Vector NewDrawScale3D;

    // End:0x47
    if(VarName == 'bWakeOnLevelStart')
    {
        // End:0x44
        if(bWakeOnLevelStart)
        {
            StaticMeshComponent.WakeRigidBody();
        }        
    }
    else
    {
        // End:0x8E
        if(VarName == 'ReplicatedDrawScale3D')
        {
            NewDrawScale3D = ReplicatedDrawScale3D / 1000.0000000;
            SetDrawScale3D(NewDrawScale3D);            
        }
        else
        {
            super.ReplicatedEvent(VarName);
        }
    }
    //return;    
}

event ApplyImpulse(Vector ImpulseDir, float ImpulseMag, Vector HitLocation, optional TraceHitInfo HitInfo, optional Class<DamageType> DamageType)
{
    local Vector AppliedImpulse;

    AppliedImpulse = Normal(ImpulseDir) * ImpulseMag;
    // End:0xA8
    if(HitInfo.HitComponent != none)
    {
        HitInfo.HitComponent.AddImpulse(AppliedImpulse, HitLocation, HitInfo.BoneName);        
    }
    else
    {
        CollisionComponent.AddImpulse(AppliedImpulse, HitLocation);
    }
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super(Actor).TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    // End:0xF4
    if((bDamageAppliesImpulse && !TgApplyHitImpulse) && DamageType.default.KDamageImpulse > float(0))
    {
        // End:0xA8
        if(VSize(Momentum) < 0.0010000)
        {
            return;
        }
        ApplyImpulse(Momentum, DamageType.default.KDamageImpulse, HitLocation, HitInfo, DamageType);
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
    // End:0x178
    if(((bDamageAppliesImpulse && !TgApplyHitImpulse) && DamageType.default.RadialDamageImpulse > float(0)) && int(Role) == int(ROLE_Authority))
    {
        CollisionComponent.AddRadialImpulse(HurtOrigin, DamageRadius, DamageType.default.RadialDamageImpulse, 1, DamageType.default.bRadialDamageVelChange);
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x57
    if(Action.InputLinks[0].bHasImpulse)
    {
        StaticMeshComponent.WakeRigidBody();
    }
    //return;    
}

simulated function OnTeleport(SeqAct_Teleport inAction)
{
    local array<Object> objVars;
    local int Idx;
    local Actor destActor;

    inAction.GetObjectVars(objVars, "Destination");
    Idx = 0;
    J0x40:

    // End:0x9D [Loop If]
    if((Idx < objVars.Length) && destActor == none)
    {
        destActor = Actor(objVars[Idx]);
        Idx++;
        // [Loop Continue]
        goto J0x40;
    }
    // End:0x134
    if(destActor != none)
    {
        StaticMeshComponent.SetRBPosition(destActor.Location);
        StaticMeshComponent.SetRBRotation(destActor.Rotation);
        PlayTeleportEffect(false, true);
    }
    //return;    
}

simulated function Reset()
{
    StaticMeshComponent.SetRBLinearVelocity(vect(0.0000000, 0.0000000, 0.0000000));
    StaticMeshComponent.SetRBAngularVelocity(vect(0.0000000, 0.0000000, 0.0000000));
    StaticMeshComponent.SetRBPosition(InitialLocation);
    StaticMeshComponent.SetRBRotation(InitialRotation);
    // End:0xDE
    if(!bWakeOnLevelStart)
    {
        StaticMeshComponent.PutRigidBodyToSleep();        
    }
    else
    {
        StaticMeshComponent.WakeRigidBody();
    }
    ResolveRBState();
    bForceNetUpdate = true;
    super(Actor).Reset();
    //return;    
}

simulated function OnWeaponHit(ImpactInfo Impact, optional float ImpulseScale = 800.0000000)
{
    // End:0xBF
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xBF
        if((CollisionComponent != none) && TgApplyHitImpulse)
        {
            CollisionComponent.AddImpulse(Normal(Impact.HitLocation - Impact.StartTrace) * ImpulseScale, Impact.HitLocation);
        }
    }
    //return;    
}

simulated function ClientWeaponHitEffects(Vector ImpactLocation, Vector ImpactNormal)
{
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local Pawn OtherPawn;

    // End:0xA2
    if(int(Role) == int(ROLE_Authority))
    {
        OtherPawn = Pawn(Other);
        // End:0xA2
        if(((OtherPawn != none) && CollisionComponent != none) && TgApplyTouchImpulse)
        {
            CollisionComponent.AddImpulse(Normal(Location - HitLocation) * TgTouchMagnitude);
        }
    }
    //return;    
}

simulated function ClientTouchEffects()
{
    // End:0x7F
    if(TgTouchSound != none)
    {
        // End:0x46
        if(AkEvent(TgTouchSound) != none)
        {
            PostAkEvent(AkEvent(TgTouchSound));            
        }
        else
        {
            // End:0x7F
            if(SoundCue(TgTouchSound) != none)
            {
                PlaySound(SoundCue(TgTouchSound));
            }
        }
    }
    //return;    
}

defaultproperties
{
    bNeedsRBStateReplication=true
    bDisableClientSidePawnInteractions=true
    TgApplyHitImpulse=true
    TgApplyTouchImpulse=true
    StayUprightTorqueFactor=1000.0000000
    StayUprightMaxTorque=1500.0000000
    MaxPhysicsVelocity=350.0000000
    ReplicatedDrawScale3D=(X=1000.0000000,Y=1000.0000000,Z=1000.0000000)
    TgTouchMagnitude=2400.0000000
    // Reference: StaticMeshComponent'Engine.Default__KActor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__DynamicSMActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        WireframeColor=(R=0,G=255,B=128,A=255)
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__KActor.MyLightEnvironment'
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        BlockRigidBody=true
        bBlockFootPlacement=false
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true,BlockingVolume=true)
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__KActor.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    bPawnCanBaseOn=false
    bSafeBaseIfAsleep=true
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
    Physics=EPhysics.PHYS_RigidBody
    TickGroup=ETickingGroup.TG_PostAsyncWork
    bNoDelete=true
    bAlwaysRelevant=true
    bUpdateSimulatedPosition=true
    bNetInitialRotation=true
    bReplicateRigidBodyLocation=true
    bBlocksNavigation=true
    bCollideActors=true
    bProjTarget=true
    bBlocksTeleport=true
    bNoEncroachCheck=true
    CollisionComponent=StaticMeshComponent0
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
    SupportedEvents[1]=Class'Engine.SeqEvent_Destroyed'
    SupportedEvents[2]=Class'Engine.SeqEvent_TakeDamage'
    SupportedEvents[3]=Class'Engine.SeqEvent_HitWall'
    SupportedEvents[4]=Class'Engine.SeqEvent_AnimNotify'
    SupportedEvents[5]=Class'Engine.SeqEvent_MobileTouch'
    SupportedEvents[6]=Class'Engine.SeqEvent_RigidBodyCollision'
}