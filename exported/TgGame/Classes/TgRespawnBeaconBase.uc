class TgRespawnBeaconBase extends TgDestructible
    abstract
    native
    hidecategories(Navigation,SkeletalMeshActor);

var() const editconst int m_nMeshAssemblyId;
var export editinline transient MeshComponent m_ActualMeshComponent;
var transient array<TgAnimBlendByTeleportBeacon> m_BeaconNodes;
var transient bool c_bEnemyMatLoaded;
var const bool m_bShouldShowSilhouetteToFriends;
var(BeaconExit) float m_fDeployTime;

// Export UTgRespawnBeaconBase::execForceRecalculateMaterial(FFrame&, void* const)
native function ForceRecalculateMaterial();

// Export UTgRespawnBeaconBase::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    local array<AnimNode> BeaconNodes;
    local AnimNode Node;

    super(Actor).PostInitAnimTree(SkelComp);
    // End:0x3D
    if((m_ActualMeshComponent != none) && SkelComp != m_ActualMeshComponent)
    {
        return;
    }
    m_BeaconNodes.Length = 0;
    SkelComp.Animations.GetNodesByClassWrapper(BeaconNodes, Class'TgGame.TgAnimBlendByTeleportBeacon');
    // End:0xC6
    foreach BeaconNodes(Node)
    {
        m_BeaconNodes.AddItem(TgAnimBlendByTeleportBeacon(Node));        
    }    
    //return;    
}

simulated function NotifyLocalPlayerTeamReceived()
{
    RecalculateMaterial(IsFriendlyWithLocalPawn());
    super(Actor).NotifyLocalPlayerTeamReceived();
    //return;    
}

defaultproperties
{
    m_fDeployTime=5.0000000
    // Reference: SkeletalMeshComponent'TgGame.Default__TgRespawnBeaconBase.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgDestructible.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        SkeletalMesh=SkeletalMesh'DEV_TeleportBeacon.Meshes.SKL_NPC_TeleportBeacon_Skin0_3p'
        // Reference: AnimNodeSequence'TgGame.Default__TgRespawnBeaconBase.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'TgGame.Default__TgDestructible.SkeletalMeshComponent0.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        AnimSets[0]=AnimSet'DEV_TeleportBeacon.AS_TeleportBeacon'
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconBase.MyLightEnvironment'
        HiddenGame=true
        CollideActors=false
        Scale=2.0000000
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconBase.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDestructible.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgRespawnBeaconBase.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgDestructible.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=none
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgRespawnBeaconBase.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgDestructible.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    // Reference: CylinderComponent'TgGame.Default__TgRespawnBeaconBase.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=45.0000000
        CollisionRadius=55.0000000
        ReplacementPrimitive=none
        CollideActors=true
        Translation=(X=0.0000000,Y=0.0000000,Z=45.0000000)
    end object
    Components[4]=CollisionCylinder
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    CollisionType=ECollisionType.COLLIDE_TouchAll
    bServerTickIsDisabled=false
    bPushedByEncroachers=false
    bAlwaysRelevant=true
    bUpdateSimulatedPosition=true
    NetPriority=1.4000000
    CollisionComponent=CollisionCylinder
}