class KAsset extends Actor
    native(Physics)
    nativereplication
    placeable
    hidecategories(Navigation)
    classgroup(Physics);

var() const editconst export editinline SkeletalMeshComponent SkeletalMeshComponent;
var() bool bDamageAppliesImpulse;
var() bool bWakeOnLevelStart;
var() bool bBlockPawns;
var repnotify transient SkeletalMesh ReplicatedMesh;
var repnotify transient PhysicsAsset ReplicatedPhysAsset;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        ReplicatedMesh, ReplicatedPhysAsset;
}

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x37
    if(bWakeOnLevelStart)
    {
        SkeletalMeshComponent.WakeRigidBody();
    }
    ReplicatedMesh = SkeletalMeshComponent.SkeletalMesh;
    ReplicatedPhysAsset = SkeletalMeshComponent.PhysicsAsset;
    //return;    
}

final function SetMeshAndPhysAsset(SkeletalMesh NewMesh, PhysicsAsset NewPhysAsset)
{
    SkeletalMeshComponent.SetSkeletalMesh(NewMesh);
    ReplicatedMesh = NewMesh;
    SkeletalMeshComponent.SetPhysicsAsset(NewPhysAsset);
    ReplicatedPhysAsset = NewPhysAsset;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x44
    if(VarName == 'ReplicatedMesh')
    {
        SkeletalMeshComponent.SetSkeletalMesh(ReplicatedMesh);        
    }
    else
    {
        // End:0x84
        if(VarName == 'ReplicatedPhysAsset')
        {
            SkeletalMeshComponent.SetPhysicsAsset(ReplicatedPhysAsset);
        }
    }
    //return;    
}

simulated event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local Vector ApplyImpulse;

    super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    // End:0x17F
    if(bDamageAppliesImpulse && DamageType.default.KDamageImpulse > float(0))
    {
        // End:0x97
        if(VSize(Momentum) < 0.0010000)
        {
            return;
        }
        CheckHitInfo(HitInfo, SkeletalMeshComponent, Normal(Momentum), HitLocation);
        ApplyImpulse = Normal(Momentum) * DamageType.default.KDamageImpulse;
        // End:0x17F
        if(HitInfo.HitComponent != none)
        {
            HitInfo.HitComponent.AddImpulse(ApplyImpulse, HitLocation, HitInfo.BoneName);
        }
    }
    //return;    
}

simulated function TakeRadiusDamage(Controller InstigatedBy, float BaseDamage, float DamageRadius, Class<DamageType> DamageType, float Momentum, Vector HurtOrigin, bool bFullDamage, Actor DamageCauser, optional float DamageFalloffExponent = 1.0000000)
{
    // End:0xC4
    if((bDamageAppliesImpulse && DamageType.default.RadialDamageImpulse > float(0)) && int(Role) == int(ROLE_Authority))
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
        SkeletalMeshComponent.WakeRigidBody();
    }
    //return;    
}

simulated function OnTeleport(SeqAct_Teleport inAction)
{
    local Actor destActor;

    destActor = Actor(SeqVar_Object(inAction.VariableLinks[1].LinkedVariables[0]).GetObjectValue());
    // End:0xB7
    if(destActor != none)
    {
        SkeletalMeshComponent.SetRBPosition(destActor.Location);        
    }
    else
    {
        inAction.ScriptLog((("No Destination for" @ string(inAction)) @ "on") @ string(self));
    }
    //return;    
}

function DoKismetAttachment(Actor Attachment, SeqAct_AttachToActor Action)
{
    Attachment.SetBase(self,, SkeletalMeshComponent, Action.BoneName);
    //return;    
}

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__KAsset.KAssetSkelMeshComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'KAssetSkelMeshComponent'
    begin object name="KAssetSkelMeshComponent" class=Engine.SkeletalMeshComponent
        PhysicsWeight=1.0000000
        bSkipAllUpdateWhenPhysicsAsleep=true
        bHasPhysicsAssetInstance=true
        bUpdateKinematicBonesFromAnimation=false
        bUseTickOptimization=false
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__KAsset.MyLightEnvironment'
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        CollideActors=true
        BlockActors=true
        BlockZeroExtent=true
        BlockRigidBody=true
        bBlockFootPlacement=false
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true,BlockingVolume=true)
    end object
    SkeletalMeshComponent=KAssetSkelMeshComponent
    bDamageAppliesImpulse=true
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__KAsset.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
    end object
    Components[0]=MyLightEnvironment
    Components[1]=KAssetSkelMeshComponent
    Physics=EPhysics.PHYS_RigidBody
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    TickGroup=ETickingGroup.TG_PostAsyncWork
    bNoDelete=true
    bAlwaysRelevant=true
    bUpdateSimulatedPosition=true
    bNetInitialRotation=true
    bCollideActors=true
    bBlockActors=true
    bProjTarget=true
    bEdShouldSnap=true
    CollisionComponent=KAssetSkelMeshComponent
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
    SupportedEvents[1]=Class'Engine.SeqEvent_Destroyed'
    SupportedEvents[2]=Class'Engine.SeqEvent_TakeDamage'
    SupportedEvents[3]=Class'Engine.SeqEvent_HitWall'
    SupportedEvents[4]=Class'Engine.SeqEvent_AnimNotify'
    SupportedEvents[5]=Class'Engine.SeqEvent_MobileTouch'
    SupportedEvents[6]=Class'Engine.SeqEvent_ConstraintBroken'
    SupportedEvents[7]=Class'Engine.SeqEvent_RigidBodyCollision'
}