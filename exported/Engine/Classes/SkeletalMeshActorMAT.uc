class SkeletalMeshActorMAT extends SkeletalMeshCinematicActor
    native(Anim)
    placeable
    hidecategories(Navigation);

var transient array<AnimNodeSlot> SlotNodes;

// Export USkeletalMeshActorMAT::execMAT_SetAnimWeights(FFrame&, void* const)
native function MAT_SetAnimWeights(array<AnimSlotInfo> SlotInfos);

// Export USkeletalMeshActorMAT::execMAT_SetMorphWeight(FFrame&, void* const)
native function MAT_SetMorphWeight(name MorphNodeName, float MorphWeight);

// Export USkeletalMeshActorMAT::execMAT_SetSkelControlScale(FFrame&, void* const)
native function MAT_SetSkelControlScale(name SkelControlName, float Scale);

// Export USkeletalMeshActorMAT::execMAT_SetSkelControlStrength(FFrame&, void* const)
native function MAT_SetSkelControlStrength(name SkelControlName, float ControlStrength);

simulated event Destroyed()
{
    ClearAnimNodes();
    super(SkeletalMeshActor).Destroyed();
    //return;    
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super(Actor).PostInitAnimTree(SkelComp);
    ClearAnimNodes();
    CacheAnimNodes();
    //return;    
}

simulated function CacheAnimNodes()
{
    local AnimNodeSlot SlotNode;

    // End:0x53
    foreach SkeletalMeshComponent.AllAnimNodes(Class'Engine.AnimNodeSlot', SlotNode)
    {
        SlotNodes[SlotNodes.Length] = SlotNode;        
    }    
    //return;    
}

simulated function ClearAnimNodes()
{
    SlotNodes.Length = 0;
    //return;    
}

simulated event SetAnimPosition(name SlotName, int ChannelIndex, name InAnimSeqName, float InPosition, bool bFireNotifies, bool bLooping, bool bEnableRootMotion)
{
    MAT_SetAnimPosition(SlotName, ChannelIndex, InAnimSeqName, InPosition, bFireNotifies, bLooping, bEnableRootMotion);
    //return;    
}

// Export USkeletalMeshActorMAT::execMAT_SetAnimPosition(FFrame&, void* const)
native function MAT_SetAnimPosition(name SlotName, int ChannelIndex, name InAnimSeqName, float InPosition, bool bFireNotifies, bool bLooping, bool bEnableRootMotion);

simulated event FinishAnimControl(InterpGroup InInterpGroup)
{
    MAT_FinishAnimControl(InInterpGroup);
    //return;    
}

simulated event SetMorphWeight(name MorphNodeName, float MorphWeight)
{
    MAT_SetMorphWeight(MorphNodeName, MorphWeight);
    //return;    
}

simulated event SetSkelControlScale(name SkelControlName, float Scale)
{
    MAT_SetSkelControlScale(SkelControlName, Scale);
    //return;    
}

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMAT.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshCinematicActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        Animations=none
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMAT.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMAT.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshCinematicActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'Engine.Default__SkeletalMeshActorMAT.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshCinematicActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMAT.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'Engine.Default__SkeletalMeshActorMAT.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'Engine.Default__SkeletalMeshCinematicActor.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    CollisionComponent=SkeletalMeshComponent0
}