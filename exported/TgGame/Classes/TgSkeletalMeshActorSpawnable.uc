class TgSkeletalMeshActorSpawnable extends TgSkeletalMeshActor
    native(Pawns)
    hidecategories(Navigation);

defaultproperties
{
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0.AnimNodeSeq0_6'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0.AnimNodeSeq0'
        begin object name="AnimNodeSeq0_6"
        end object
        Animations=AnimNodeSeq0_6
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActor.FaceAudioComponent'
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