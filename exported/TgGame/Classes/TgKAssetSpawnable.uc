class TgKAssetSpawnable extends KAssetSpawnable
    native
    hidecategories(Navigation);

defaultproperties
{
    // Reference: TgSkeletalMeshComponent'TgGame.Default__TgKAssetSpawnable.SkelMeshComp'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkelMeshComp'
    begin object name="SkelMeshComp" class=TgGame.TgSkeletalMeshComponent
        PhysicsWeight=1.0000000
        bSkipAllUpdateWhenPhysicsAsleep=true
        bHasPhysicsAssetInstance=true
        bUpdateKinematicBonesFromAnimation=false
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgKAssetSpawnable.MyLightEnvironment'
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        CollideActors=true
        BlockActors=true
        BlockZeroExtent=true
        BlockRigidBody=true
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true)
    end object
    SkeletalMeshComponent=SkelMeshComp
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgKAssetSpawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__KAssetSpawnable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    Components[0]=MyLightEnvironment
    // Reference: SkeletalMeshComponent'TgGame.Default__TgKAssetSpawnable.KAssetSkelMeshComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'KAssetSkelMeshComponent'
    // Archetype: SkeletalMeshComponent'Engine.Default__KAssetSpawnable.KAssetSkelMeshComponent'
    begin object name="KAssetSkelMeshComponent"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgKAssetSpawnable.MyLightEnvironment'
    end object
    Components[1]=KAssetSkelMeshComponent
    Components[2]=SkelMeshComp
    CollisionComponent=SkelMeshComp
}