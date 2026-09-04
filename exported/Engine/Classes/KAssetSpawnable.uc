class KAssetSpawnable extends KAsset
    native(Physics)
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__KAssetSpawnable.KAssetSkelMeshComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'KAssetSkelMeshComponent'
    // Archetype: SkeletalMeshComponent'Engine.Default__KAsset.KAssetSkelMeshComponent'
    begin object name="KAssetSkelMeshComponent"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__KAssetSpawnable.MyLightEnvironment'
    end object
    SkeletalMeshComponent=KAssetSkelMeshComponent
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__KAssetSpawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__KAsset.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    Components[0]=MyLightEnvironment
    Components[1]=KAssetSkelMeshComponent
    bNoDelete=false
    CollisionComponent=KAssetSkelMeshComponent
}