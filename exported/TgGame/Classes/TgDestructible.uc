class TgDestructible extends SkeletalMeshActor
    native
    hidecategories(Navigation);

var repnotify TgEffectManager r_EffectManager;
var() int r_nMaxHealth;
var() bool m_bDisplayHealth;
var bool m_bDestroyed;
var transient bool m_bInitialized;
var(FogOfWar) bool m_bFogOfWarBlocker;
var(FogOfWar) bool m_bOneDirectional;
var() int m_nPhysicalType;
var() byte m_nTaskForce;
var repnotify int r_nHealth;
var repnotify int r_nActorInstanceId;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_EffectManager, r_nActorInstanceId, 
        r_nMaxHealth;

    // Pos:0x020
    if(int(Role) == int(ROLE_Authority))
        r_nHealth;
}

// Export UTgDestructible::execIsFriendlyWithLocalPawn(FFrame&, void* const)
native final function bool IsFriendlyWithLocalPawn();

// Export UTgDestructible::execForceNetRelevant(FFrame&, void* const)
native function ForceNetRelevant();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x7E
    if(int(Role) == int(ROLE_Authority))
    {
        r_nHealth = r_nMaxHealth;
        r_EffectManager = Spawn(Class'TgGame.TgEffectManager', self);
        r_EffectManager.r_Owner = self;
        ForceNetRelevant();
    }
    TgRepInfo_Game(WorldInfo.GRI).AddDestructible(self);
    m_bInitialized = true;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x33
    if(VarName == 'r_nHealth')
    {
        // End:0x31
        if(r_nHealth <= 0)
        {
            DestroyIt();
        }
        return;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    // End:0x5C
    if(r_nHealth <= 0)
    {
        return;
    }
    r_nHealth = r_nHealth - Damage;
    // End:0x94
    if(r_nHealth <= 0)
    {
        DestroyIt();
    }
    //return;    
}

simulated function DestroyIt(optional bool bSkipFx)
{
    // End:0x10
    if(m_bDestroyed)
    {
        return;
    }
    bNetDirty = true;
    ForceNetRelevant();
    SetCollision(false, false);
    SetPhysics(0);
    m_bDestroyed = true;
    TriggerEventClass(Class'TgGame.TgSeqEvent_PlaceableDestroyed', self, 0, false);
    SetHidden(true);
    //return;    
}

simulated function Destroyed()
{
    DestroyIt(true);
    // End:0x32
    if(r_EffectManager != none)
    {
        r_EffectManager.Destroy();
    }
    TgRepInfo_Game(WorldInfo.GRI).RemoveDestructible(self);
    super.Destroyed();
    //return;    
}

simulated event bool CanApplyEffects()
{
    return !m_bDestroyed;
    //return ReturnValue;    
}

defaultproperties
{
    r_nMaxHealth=100
    m_bDisplayHealth=true
    m_bFogOfWarBlocker=true
    m_nPhysicalType=861
    // Reference: SkeletalMeshComponent'TgGame.Default__TgDestructible.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgDestructible.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'Engine.Default__SkeletalMeshActor.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgDestructible.MyLightEnvironment'
        BlockNonZeroExtent=true
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDestructible.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgDestructible.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgDestructible.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgDestructible.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'Engine.Default__SkeletalMeshActor.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    bOnlyDirtyReplication=true
    bCollideActors=true
    bBlockActors=true
    CollisionComponent=SkeletalMeshComponent0
    SupportedEvents=/* Array type was not detected. */
}