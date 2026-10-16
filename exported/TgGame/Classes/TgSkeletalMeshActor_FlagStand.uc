class TgSkeletalMeshActor_FlagStand extends TgSkeletalMeshActor_Loader
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader);

var string m_FlagContentDataClassName;
var transient TgFlagContentData m_FlagContentData;
var() int m_nGameTaskForce;
var() int m_nTeamIndex;

// Export UTgSkeletalMeshActor_FlagStand::execChangeTaskForceFlag(FFrame&, void* const)
native function ChangeTaskForceFlag(int nTaskForce, int nTeamIndex);

simulated event PreBeginPlay()
{
    local Class<TgFlagContentData> FlagContentDataClass;

    super.PreBeginPlay();
    FlagContentDataClass = Class<TgFlagContentData>(DynamicLoadObject(m_FlagContentDataClassName, Class'Core.Class'));
    // End:0x80
    if(FlagContentDataClass != none)
    {
        m_FlagContentData = new (self) FlagContentDataClass;
        m_FlagContentData.Init();
    }
    //return;    
}

simulated function PostBeginPlay()
{
    super(SkeletalMeshActor).PostBeginPlay();
    // End:0x6A
    if(!WorldInfo.bIsMenuLevel)
    {
        // End:0x6A
        if((m_nGameTaskForce > 0) && m_nTeamIndex >= 0)
        {
            ChangeTaskForceFlag(m_nGameTaskForce, m_nTeamIndex);
        }
    }
    //return;    
}

defaultproperties
{
    m_FlagContentDataClassName="TgGameContent.TgFlagContentData_Content"
    m_nGameTaskForce=-1
    m_nTeamIndex=-1
    // Reference: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_FlagStand.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_Loader.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.AltLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AltLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.AltLightEnvironment'
    begin object name="AltLightEnvironment"
    end object
    m_AlternateLightEnvironmentTemplate=AltLightEnvironment
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_FlagStand.SkeletalMeshComponent0.AnimNodeSeq0_2'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0.AnimNodeSeq0_1'
        begin object name="AnimNodeSeq0_2"
        end object
        Animations=AnimNodeSeq0_2
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.FaceAudioComponent'
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
    // Reference: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_FlagStand.Cylinder0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Cylinder0'
    // Archetype: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_Loader.Cylinder0'
    begin object name="Cylinder0"
        ReplacementPrimitive=none
    end object
    Components[6]=Cylinder0
    CollisionComponent=Cylinder0
}