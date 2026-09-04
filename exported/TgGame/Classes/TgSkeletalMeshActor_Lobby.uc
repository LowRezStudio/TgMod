class TgSkeletalMeshActor_Lobby extends TgSkeletalMeshActor_LobbyBase
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader,TgSkeletalMeshActor_Lobby);

enum LobbyMeterBusIntent
{
    LMB_RUCKUSGEM,                  // 0
    LMB_MAX                         // 1
};

struct native LobbySMAMeterBus
{
    var dword dwBusID;
    var TgSkeletalMeshActor_Lobby.LobbyMeterBusIntent eIntent;

    structdefaultproperties
    {
        dwBusID=()
        eIntent=LobbyMeterBusIntent.LMB_RUCKUSGEM
    }
};

var float m_fSpawnOffsetYaw;
var float m_fMaxSpawnRotation;
var float m_fMinSpawnRotation;
var() bool m_bAdjustMeshToGround;
var() bool m_bCanBeRotated;
var(Posture) bool m_bEnablePostures;
var transient int m_CardMICBotIdPending;
var transient float m_CardMICTransitionDesiredAlpha;
var transient float m_CardMICTransitionAlpha;
var() TgSkeletalMeshActor_FlagStand m_FlagStandActor;
var() TgSkeletalMeshActor_Pedestal m_PedestalActor;
var() array<MaterialInstanceConstant> m_CardMICs;
var array<MaterialInstanceConstant> m_MeshReplacementMICs;
var array<LobbySMAMeterBus> m_MeterBusses;
var(Posture) repnotify TgPawn.TG_POSTURE r_CurrentPosture;
var transient float m_fRotationAmount;
var transient float m_fDesiredRotationAmount;
var transient Rotator m_rOriginalRotation;
var transient float m_fSelectionGlowRemainingTime;
var float m_fSelectionGlowTotalTime;
var transient array<TgAnimBlendByPosture> m_PostureBlendNodes;

// Export UTgSkeletalMeshActor_Lobby::execSetActive(FFrame&, void* const)
native function SetActive(bool bActive);

// Export UTgSkeletalMeshActor_Lobby::execRotateModel(FFrame&, void* const)
native function RotateModel(float fValue, optional bool bSnap = false);

// Export UTgSkeletalMeshActor_Lobby::execAdjustMeshToGround(FFrame&, void* const)
native function AdjustMeshToGround();

// Export UTgSkeletalMeshActor_Lobby::execAllManifestsLoaded(FFrame&, void* const)
native function AllManifestsLoaded();

// Export UTgSkeletalMeshActor_Lobby::execReplaceMaterialInstances(FFrame&, void* const)
native function ReplaceMaterialInstances();

// Export UTgSkeletalMeshActor_Lobby::execTeardownMeterBusses(FFrame&, void* const)
native function TeardownMeterBusses();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2C
    if(VarName == 'r_CurrentPosture')
    {
        SetActivePosture(r_CurrentPosture);
        return;
    }
    super(SkeletalMeshActor).ReplicatedEvent(VarName);
    //return;    
}

simulated event PreBeginPlay()
{
    super.PreBeginPlay();
    m_rOriginalRotation = Rotation;
    //return;    
}

simulated event PostBeginPlay()
{
    local Class<TgMenuTransitionActor> transitionClass;

    super.PostBeginPlay();
    // End:0xAC
    if(!WorldInfo.IsPlayInEditor())
    {
        SetActive(false);
        transitionClass = none;
        // End:0xAC
        if((transitionClass != none) && !WorldInfo.IsPlayInEditor())
        {
            m_TransitionActor = Spawn(transitionClass, self,, Location, Rotation,, true);
        }
    }
    InitPostureNodes();
    SetActivePosture(r_CurrentPosture);
    //return;    
}

simulated event EndTransition()
{
    // End:0x3B
    if(m_bCanBeRotated)
    {
        m_fDesiredRotationAmount = 0.0000000;
        m_fRotationAmount = m_fDesiredRotationAmount;
        SetRotation(m_rOriginalRotation);
    }
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
    TeardownMeterBusses();
    super.Destroyed();
    //return;    
}

function float GetSpawnRotation()
{
    local bool bReverse;
    local float fValue, fAngle;

    fValue = FRand();
    // End:0x3B
    if(fValue > 0.5000000)
    {
        bReverse = true;
        fValue -= 0.5000000;
    }
    fAngle = m_fMinSpawnRotation + (m_fMaxSpawnRotation * fValue);
    return ((bReverse) ? -fAngle : fAngle);
    //return ReturnValue;    
}

event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super(Actor).PostInitAnimTree(SkelComp);
    // End:0x34
    if(SkelComp == SkeletalMeshComponent)
    {
        InitPostureNodes();
    }
    //return;    
}

simulated event InitPostureNodes()
{
    local array<AnimNode> BlendByPostureNodes;
    local AnimNode AnimNodeSearchIterator;
    local int I;

    m_PostureBlendNodes.Length = 0;
    // End:0x11E
    if(m_ChildMeshes.Length > 0)
    {
        I = 0;
        J0x27:

        // End:0x11E [Loop If]
        if(I < m_ChildMeshes.Length)
        {
            // End:0x110
            if((m_ChildMeshes[I] != none) && m_ChildMeshes[I].Animations != none)
            {
                m_ChildMeshes[I].Animations.GetNodesByClassWrapper(BlendByPostureNodes, Class'TgGame.TgAnimBlendByPosture');
                // End:0x10F
                foreach BlendByPostureNodes(AnimNodeSearchIterator)
                {
                    m_PostureBlendNodes.AddItem(TgAnimBlendByPosture(AnimNodeSearchIterator));                    
                }                
            }
            ++I;
            // [Loop Continue]
            goto J0x27;
        }
    }
    SetActivePosture(r_CurrentPosture);
    //return;    
}

simulated function SetActivePosture(TgPawn.TG_POSTURE Posture)
{
    local TgAnimBlendByPosture AnimNodeSearchIterator;

    r_CurrentPosture = Posture;
    // End:0x53
    foreach m_PostureBlendNodes(AnimNodeSearchIterator)
    {
        AnimNodeSearchIterator.m_CurrentPosture = r_CurrentPosture;        
    }    
    //return;    
}

simulated event OnSetSkelPosture(TgSeqAct_SetSkelPosture Action)
{
    SetActivePosture(Action.m_Posture);
    // End:0x5B
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        ForceNetRelevant();
    }
    //return;    
}

defaultproperties
{
    m_fSpawnOffsetYaw=1000.0000000
    m_fMaxSpawnRotation=6000.0000000
    m_fMinSpawnRotation=2000.0000000
    m_CardMICBotIdPending=-1
    m_fSelectionGlowTotalTime=0.6000000
    m_nCharacterMastery=-1
    // Reference: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_Lobby.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_LobbyBase.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.AltLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AltLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.AltLightEnvironment'
    begin object name="AltLightEnvironment"
    end object
    m_AlternateLightEnvironmentTemplate=AltLightEnvironment
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Lobby.SkeletalMeshComponent0.AnimNodeSeq0_4'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_LobbyBase.SkeletalMeshComponent0.AnimNodeSeq0_3'
        begin object name="AnimNodeSeq0_4"
        end object
        Animations=AnimNodeSeq0_4
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=MySilhouette
    Components[2]=FaceAudioComponent
    Components[3]=AltLightEnvironment
    Components[4]=none
    Components[5]=none
    // Reference: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_Lobby.Cylinder0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Cylinder0'
    // Archetype: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_LobbyBase.Cylinder0'
    begin object name="Cylinder0"
        ReplacementPrimitive=none
    end object
    Components[6]=Cylinder0
    CollisionComponent=Cylinder0
}