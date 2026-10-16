class SkeletalMeshActorBasedOnExtremeContent extends SkeletalMeshActor
    native(Anim)
    placeable
    hidecategories(Navigation);

struct native SkelMaterialSetterDatum
{
    var() int MaterialIndex;
    var() MaterialInterface TheMaterial;

    structdefaultproperties
    {
        MaterialIndex=0
        TheMaterial=none
    }
};

var() array<SkelMaterialSetterDatum> ExtremeContent;
var() array<SkelMaterialSetterDatum> NonExtremeContent;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetMaterialBasedOnExtremeContent();
    //return;    
}

simulated function SetMaterialBasedOnExtremeContent()
{
    local int Idx;

    // End:0xD6
    if(WorldInfo.GRI.ShouldShowGore())
    {
        Idx = 0;
        J0x42:

        // End:0xD3 [Loop If]
        if(Idx < ExtremeContent.Length)
        {
            SkeletalMeshComponent.SetMaterial(ExtremeContent[Idx].MaterialIndex, ExtremeContent[Idx].TheMaterial);
            ++Idx;
            // [Loop Continue]
            goto J0x42;
        }        
    }
    else
    {
        Idx = 0;
        J0xE1:

        // End:0x172 [Loop If]
        if(Idx < NonExtremeContent.Length)
        {
            SkeletalMeshComponent.SetMaterial(NonExtremeContent[Idx].MaterialIndex, NonExtremeContent[Idx].TheMaterial);
            ++Idx;
            // [Loop Continue]
            goto J0xE1;
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'Engine.Default__SkeletalMeshActor.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'Engine.Default__SkeletalMeshActorBasedOnExtremeContent.FaceAudioComponent'
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