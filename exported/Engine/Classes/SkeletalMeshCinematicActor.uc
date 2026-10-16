class SkeletalMeshCinematicActor extends SkeletalMeshActor
    native(Anim)
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__SkeletalMeshCinematicActor.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'Engine.Default__SkeletalMeshCinematicActor.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'Engine.Default__SkeletalMeshActor.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        bUpdateSkelWhenNotRendered=true
        bPerBoneMotionBlur=true
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshCinematicActor.MyLightEnvironment'
        bAcceptsStaticDecals=true
        bAcceptsDynamicDecals=true
        bUseOnePassLightingOnTranslucency=true
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshCinematicActor.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
        bUseBooleanEnvironmentShadowing=false
        bSynthesizeSHLight=true
        bIsCharacterLightEnvironment=true
        bAllowDynamicShadowsOnTranslucency=true
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'Engine.Default__SkeletalMeshCinematicActor.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'Engine.Default__SkeletalMeshCinematicActor.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'Engine.Default__SkeletalMeshCinematicActor.FaceAudioComponent'
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
    CollisionComponent=SkeletalMeshComponent0
}