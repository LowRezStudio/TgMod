class TgSkeletalMeshActor_Posture extends SkeletalMeshActor
    hidecategories(Navigation);

var(Posture) repnotify TgPawn.TG_POSTURE r_CurrentPosture;
var transient array<TgAnimBlendByPosture> m_PostureBlendNodes;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_CurrentPosture;
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    InitPostureNodes();
    SetActivePosture(r_CurrentPosture);
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2C
    if(VarName == 'r_CurrentPosture')
    {
        SetActivePosture(r_CurrentPosture);
        return;
    }
    super.ReplicatedEvent(VarName);
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

simulated function InitPostureNodes()
{
    local array<AnimNode> BlendByPostureNodes;
    local AnimNode AnimNodeSearchIterator;

    m_PostureBlendNodes.Length = 0;
    // End:0xBF
    if((SkeletalMeshComponent != none) && SkeletalMeshComponent.Animations != none)
    {
        SkeletalMeshComponent.Animations.GetNodesByClassWrapper(BlendByPostureNodes, Class'TgGame.TgAnimBlendByPosture');
        // End:0xBE
        foreach BlendByPostureNodes(AnimNodeSearchIterator)
        {
            m_PostureBlendNodes.AddItem(TgAnimBlendByPosture(AnimNodeSearchIterator));            
        }        
    }
    SetActivePosture(r_CurrentPosture);
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
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Posture.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        Animations=none
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Posture.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Posture.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Posture.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Posture.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Posture.FaceAudioComponent'
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