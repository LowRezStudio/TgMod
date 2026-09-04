class TgSkeletalMeshActor_Pedestal extends TgSkeletalMeshActor_Lobby
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader,TgSkeletalMeshActor_Lobby);

var native transient Pointer m_DefaultBot;
var(Pedestal) array<Actor> m_DefaultPedestalActors;
var transient bool m_bUsingDefaultPedestal;
var() TgObject.EPedestalType m_PedestalType;

// Export UTgSkeletalMeshActor_Pedestal::execSwitchToDefaultPedestal(FFrame&, void* const)
native function SwitchToDefaultPedestal(optional TgSkeletalMeshActor_Loader.LobbyAnimPose animPose = 0);

simulated event EndTransition()
{
    local Actor PedestalActor;

    // End:0x43
    foreach m_DefaultPedestalActors(PedestalActor)
    {
        PedestalActor.SetHidden(!m_bUsingDefaultPedestal);        
    }    
    super.EndTransition();
    //return;    
}

defaultproperties
{
    m_bUsingDefaultPedestal=true
    m_TransitionActorClassName="TgGameContent.TgMenuTransitionActor_Pedestal"
    // Reference: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_Pedestal.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_Lobby.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.AltLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AltLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.AltLightEnvironment'
    begin object name="AltLightEnvironment"
    end object
    m_AlternateLightEnvironmentTemplate=AltLightEnvironment
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Pedestal.SkeletalMeshComponent0.AnimNodeSeq0_5'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Lobby.SkeletalMeshComponent0.AnimNodeSeq0_4'
        begin object name="AnimNodeSeq0_5"
        end object
        Animations=AnimNodeSeq0_5
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=MySilhouette
    Components[2]=FaceAudioComponent
    Components[3]=AltLightEnvironment
    Components[4]=none
    Components[5]=none
    // Reference: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_Pedestal.Cylinder0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Cylinder0'
    // Archetype: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.Cylinder0'
    begin object name="Cylinder0"
        ReplacementPrimitive=none
    end object
    Components[6]=Cylinder0
    CollisionComponent=Cylinder0
}