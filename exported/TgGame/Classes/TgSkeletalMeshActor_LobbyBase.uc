class TgSkeletalMeshActor_LobbyBase extends TgSkeletalMeshActor_Loader
    abstract
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader);

var transient bool m_bPlayTransitionOutro;
var string m_TransitionActorClassName;
var transient int m_nCharacterMastery;
var transient TgMenuTransitionActor m_TransitionActor;

simulated event PreBeginPlay()
{
    super.PreBeginPlay();
    c_AssetManifestGroup.__OnAllManifestsLoaded__Delegate = AllManifestsLoaded;
    c_AssetManifestGroup.m_OwningObject = self;
    //return;    
}

simulated event PostBeginPlay()
{
    local Class<TgMenuTransitionActor> transitionClass;

    super(SkeletalMeshActor).PostBeginPlay();
    // End:0xD1
    if(!WorldInfo.IsPlayInEditor())
    {
        SetActive(false);
        transitionClass = Class<TgMenuTransitionActor>(DynamicLoadObject(m_TransitionActorClassName, Class'Core.Class'));
        // End:0xD1
        if((transitionClass != none) && !WorldInfo.IsPlayInEditor())
        {
            m_TransitionActor = Spawn(transitionClass, self,, Location, Rotation,, true);
        }
    }
    //return;    
}

simulated event BeginTransition(optional bool bPlayFx = false)
{
    // End:0x5F
    if(bPlayFx)
    {
        // End:0x5F
        if(m_TransitionActor != none)
        {
            m_TransitionActor.PlayIntro();
            m_TransitionActor.PlayLoop();
        }
    }
    m_bPlayTransitionOutro = bPlayFx;
    super.BeginTransition(bPlayFx);
    //return;    
}

simulated event EndTransition()
{
    // End:0x5A
    if(m_TransitionActor != none)
    {
        m_TransitionActor.StopLoop();
        // End:0x5A
        if(m_bPlayTransitionOutro)
        {
            m_TransitionActor.PlayOutro();
        }
    }
    m_bPlayTransitionOutro = false;
    super.EndTransition();
    //return;    
}

simulated event Destroyed()
{
    // End:0x27
    if(m_TransitionActor != none)
    {
        m_TransitionActor.Destroy();
    }
    super(SkeletalMeshActor).Destroyed();
    //return;    
}

defaultproperties
{
    m_TransitionActorClassName="TgGameContent.TgMenuTransitionActor_Content"
    // Reference: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_LobbyBase.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_Loader.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.AltLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AltLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.AltLightEnvironment'
    begin object name="AltLightEnvironment"
    end object
    m_AlternateLightEnvironmentTemplate=AltLightEnvironment
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_LobbyBase.SkeletalMeshComponent0.AnimNodeSeq0_3'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0.AnimNodeSeq0_1'
        begin object name="AnimNodeSeq0_3"
        end object
        Animations=AnimNodeSeq0_3
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Loader.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=MySilhouette
    Components[2]=FaceAudioComponent
    Components[3]=AltLightEnvironment
    Components[4]=none
    Components[5]=none
    // Reference: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.Cylinder0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Cylinder0'
    // Archetype: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_Loader.Cylinder0'
    begin object name="Cylinder0"
        ReplacementPrimitive=none
    end object
    Components[6]=Cylinder0
    CollisionComponent=Cylinder0
}