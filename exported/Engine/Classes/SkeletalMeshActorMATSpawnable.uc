class SkeletalMeshActorMATSpawnable extends SkeletalMeshActorMAT
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMATSpawnable.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMAT.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMATSpawnable.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMATSpawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMAT.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'Engine.Default__SkeletalMeshActorMATSpawnable.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshActorMAT.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMATSpawnable.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'Engine.Default__SkeletalMeshActorMATSpawnable.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'Engine.Default__SkeletalMeshActorMAT.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    bNoDelete=false
    CollisionComponent=SkeletalMeshComponent0
}