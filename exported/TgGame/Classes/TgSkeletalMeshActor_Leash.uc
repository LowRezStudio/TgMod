class TgSkeletalMeshActor_Leash extends TgSkeletalMeshActorSpawnable
    native(Pawns)
    hidecategories(Navigation);

var export editinline SkeletalMeshComponent m_StartMesh;
var name m_StartBoneName;
var export editinline SkeletalMeshComponent m_EndMesh;
var name m_EndBoneName;
var SkelControlSingleBone m_StartControl;
var SkelControlSingleBone m_EndControl;

defaultproperties
{
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Leash.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Leash.SkeletalMeshComponent0.AnimNodeSeq0_8'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0.AnimNodeSeq0_6'
        begin object name="AnimNodeSeq0_8"
        end object
        Animations=AnimNodeSeq0_8
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Leash.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Leash.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Leash.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Leash.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Leash.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    CollisionComponent=SkeletalMeshComponent0
}