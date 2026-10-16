class ApexDestructibleActor extends Actor
    native(Mesh)
    placeable
    hidecategories(Navigation);

var() export editinline DynamicLightEnvironmentComponent LightEnvironment;
var() bool bFractureMaterialOverride;
var() const bool bPlaySingleFractureMaterialEffect;
var() const editfixedsize array<FractureMaterial> FractureMaterials;
var() const editconst export editinline ApexStaticDestructibleComponent StaticDestructibleComponent;
var() const int LOD;
var init array<init byte> VisibilityFactors;
var transient array<SoundCue> FractureSounds;
var transient array<ParticleSystem> FractureParticleEffects;

event SpawnFractureEmitter(ParticleSystem EmitterTemplate, Vector SpawnLocation, Vector SpawnDirection)
{
    local editinline ParticleSystemComponent PSC;
    local LightingChannelContainer Lights;

    PSC = WorldInfo.MyEmitterPool.SpawnEmitter(EmitterTemplate, SpawnLocation, Rotator(SpawnDirection));
    Lights = PSC.LightingChannels;
    Lights.Dynamic = true;
    Lights.bInitialized = true;
    PSC.SetLightingChannels(Lights);
    //return;    
}

// Export UApexDestructibleActor::execCacheFractureEffects(FFrame&, void* const)
native function CacheFractureEffects();

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    CacheFractureEffects();
    //return;    
}

// Export UApexDestructibleActor::execTakeDamage(FFrame&, void* const)
native simulated function TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser);

// Export UApexDestructibleActor::execTakeRadiusDamage(FFrame&, void* const)
native simulated function TakeRadiusDamage(Controller InstigatedBy, float BaseDamage, float DamageRadius, Class<DamageType> DamageType, float Momentum, Vector HurtOrigin, bool bFullDamage, Actor DamageCauser, optional float DamageFalloffExponent = 1.0000000);

function OnSetMaterial(SeqAct_SetMaterial Action)
{
    StaticDestructibleComponent.SetMaterial(Action.MaterialIndex, Action.NewMaterial);
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__ApexDestructibleActor.LightEnvironment0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'LightEnvironment0'
    begin object name="LightEnvironment0" class=Engine.DynamicLightEnvironmentComponent
        bEnabled=false
    end object
    LightEnvironment=LightEnvironment0
    // Reference: ApexStaticDestructibleComponent'Engine.Default__ApexDestructibleActor.DestructibleComponent0'
    begin object name="DestructibleComponent0" class=Engine.ApexStaticDestructibleComponent
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__ApexDestructibleActor.LightEnvironment0'
        bAllowApproximateOcclusion=true
        bForceDirectLightMap=true
        bCastDynamicShadow=false
    end object
    StaticDestructibleComponent=DestructibleComponent0
    LOD=-1
    Components[0]=LightEnvironment0
    Components[1]=DestructibleComponent0
    bNoDelete=true
    bRouteBeginPlayEvenIfStatic=false
    bGameRelevant=true
    bCanBeDamaged=true
    bCollideActors=true
    bBlockActors=true
    bProjTarget=true
    bNoEncroachCheck=true
    bEdShouldSnap=true
    CollisionComponent=DestructibleComponent0
}