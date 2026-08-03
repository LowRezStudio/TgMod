class GameCrowdAgentSkeletal extends GameCrowdAgent
    abstract
    native
    hidecategories(Navigation,Advanced,Attachment,Collision,Object);

struct native GameCrowdAttachmentInfo
{
    var() StaticMesh StaticMesh;
    var() float Chance;
    var() Vector Scale3D;

    structdefaultproperties
    {
        StaticMesh=none
        Chance=1.0000000
        Scale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    }
};

struct native GameCrowdAttachmentList
{
    var() name SocketName;
    var() array<GameCrowdAttachmentInfo> List;

    structdefaultproperties
    {
        SocketName="None"
        List=none
    }
};

var(Rendering) export editinline SkeletalMeshComponent SkeletalMeshComponent;
var AnimNodeBlend SpeedBlendNode;
var AnimNodeSlot FullBodySlot;
var AnimNodeSequence ActionSeqNode;
var AnimNodeSequence WalkSeqNode;
var AnimNodeSequence RunSeqNode;
var AnimTree AgentTree;
var(Rendering) array<name> WalkAnimNames;
var(Rendering) array<name> RunAnimNames;
var(Rendering) array<name> IdleAnimNames;
var(Behavior) array<name> DeathAnimNames;
var(SpeedBlendAnim) float SpeedBlendStart;
var(SpeedBlendAnim) float SpeedBlendEnd;
var(SpeedBlendAnim) float AnimVelRate;
var(SpeedBlendAnim) float MaxSpeedBlendChangeSpeed;
var(SpeedBlendAnim) name MoveSyncGroupName;
var(Rendering) array<GameCrowdAttachmentList> Attachments;
var(Behavior) float MaxTargetAcquireTime;
var(Rendering) bool bUseRootMotionVelocity;
var(Rendering) bool bAllowSkeletonUpdateChangeBasedOnTickResult;
var(Tick) bool bTickWhenNotVisible;
var bool bIsPlayingIdleAnimation;
var bool bIsPlayingDeathAnimation;
var bool bIsPlayingImportantAnimation;
var bool bAnimateThisTick;
var(Tick) float NotVisibleDisableTickTime;
var(LOD) float MaxAnimationDistance;
var float MaxAnimationDistanceSq;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x19
    if(bDeleteMe)
    {
        return;
    }
    SpeedBlendNode = AnimNodeBlend(SkeletalMeshComponent.FindAnimNode('SpeedBlendNode'));
    FullBodySlot = AnimNodeSlot(SkeletalMeshComponent.FindAnimNode('ActionBlendNode'));
    ActionSeqNode = AnimNodeSequence(SkeletalMeshComponent.FindAnimNode('ActionSeqNode'));
    WalkSeqNode = AnimNodeSequence(SkeletalMeshComponent.FindAnimNode('WalkSeqNode'));
    RunSeqNode = AnimNodeSequence(SkeletalMeshComponent.FindAnimNode('RunSeqNode'));
    AgentTree = AnimTree(SkeletalMeshComponent.Animations);
    // End:0x1C7
    if((WalkSeqNode != none) && WalkAnimNames.Length > 0)
    {
        WalkSeqNode.SetAnim(WalkAnimNames[Rand(WalkAnimNames.Length)]);
    }
    // End:0x21D
    if((RunSeqNode != none) && RunAnimNames.Length > 0)
    {
        RunSeqNode.SetAnim(RunAnimNames[Rand(RunAnimNames.Length)]);
    }
    // End:0x24D
    if(ActionSeqNode != none)
    {
        ActionSeqNode.bZeroRootTranslation = true;
    }
    // End:0x2C5
    if(bUseRootMotionVelocity)
    {
        SkeletalMeshComponent.RootMotionMode = 3;
        WalkSeqNode.SetRootBoneAxisOption(2, 2, 2);
        RunSeqNode.SetRootBoneAxisOption(2, 2, 2);
    }
    MaxAnimationDistanceSq = MaxAnimationDistance * MaxAnimationDistance;
    //return;    
}

simulated function SetLighting(bool bEnableLightEnvironment, LightingChannelContainer AgentLightingChannel, bool bCastShadows)
{
    super.SetLighting(bEnableLightEnvironment, AgentLightingChannel, bCastShadows);
    SkeletalMeshComponent.SetLightingChannels(AgentLightingChannel);
    CreateAttachments();
    SkeletalMeshComponent.CastShadow = bCastShadows;
    SkeletalMeshComponent.bCastDynamicShadow = bCastShadows;
    SkeletalMeshComponent.ForceUpdate(false);
    //return;    
}

// Export UGameCrowdAgentSkeletal::execPlayDeath(FFrame&, void* const)
native function PlayDeath(Vector KillMomentum);

// Export UGameCrowdAgentSkeletal::execSetRootMotion(FFrame&, void* const)
native function SetRootMotion(bool bRootMotionEnabled);

simulated function OnPlayAgentAnimation(SeqAct_PlayAgentAnimation Action)
{
    // End:0xB1
    if(Action.InputLinks[1].bHasImpulse)
    {
        Action.ActivateOutputLink(1);
        StopBehavior();
        // End:0xAE
        if(CurrentDestination.ReachedByAgent(self, Location, false))
        {
            CurrentDestination.ReachedDestination(self);
        }        
    }
    else
    {
        Action.SetCurrentAnimationActionFor(self);
    }
    //return;    
}

event ClearLatentAnimation()
{
    ClearLatentAction(Class'GameFramework.SeqAct_PlayAgentAnimation', false);
    //return;    
}

simulated event PlayIdleAnimation()
{
    bIsPlayingIdleAnimation = true;
    FullBodySlot.PlayCustomAnim(IdleAnimNames[Rand(IdleAnimNames.Length)], 1.0000000, 0.1000000, 0.1000000, true, false);
    //return;    
}

simulated event StopIdleAnimation()
{
    FullBodySlot.StopCustomAnim(0.1000000);
    bIsPlayingIdleAnimation = false;
    //return;    
}

event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
    // End:0x49
    if(CurrentBehavior != none)
    {
        CurrentBehavior.OnAnimEnd(SeqNode, PlayedTime, ExcessTime);
    }
    //return;    
}

simulated function CreateAttachments()
{
    local int AttachIdx, InfoIdx, PickedInfoIdx;
    local float ChanceTotal, RandVal;
    local editinline StaticMeshComponent StaticMeshComp;
    local bool bUseSocket, bUseBone;

    AttachIdx = 0;
    J0x0B:

    // End:0x4E3 [Loop If]
    if(AttachIdx < Attachments.Length)
    {
        // End:0x53
        if(Attachments[AttachIdx].List.Length == 0)
        {            
        }
        else
        {
            ChanceTotal = 0.0000000;
            InfoIdx = 0;
            J0x6D:

            // End:0xFE [Loop If]
            if(InfoIdx < Attachments[AttachIdx].List.Length)
            {
                ChanceTotal += Attachments[AttachIdx].List[InfoIdx].Chance;
                InfoIdx++;
                // [Loop Continue]
                goto J0x6D;
            }
            RandVal = FRand() * ChanceTotal;
            ChanceTotal = 0.0000000;
            InfoIdx = 0;
            J0x12F:

            // End:0x1ED [Loop If]
            if(InfoIdx < Attachments[AttachIdx].List.Length)
            {
                ChanceTotal += Attachments[AttachIdx].List[InfoIdx].Chance;
                // End:0x1DF
                if(ChanceTotal >= RandVal)
                {
                    PickedInfoIdx = InfoIdx;
                    // [Explicit Break]
                    goto J0x1ED;
                }
                InfoIdx++;
                // [Loop Continue]
                goto J0x12F;
            }
            J0x1ED:

            // End:0x4D5
            if(Attachments[AttachIdx].List[PickedInfoIdx].StaticMesh != none)
            {
                bUseSocket = SkeletalMeshComponent.GetSocketByName(Attachments[AttachIdx].SocketName) != none;
                bUseBone = SkeletalMeshComponent.MatchRefBone(Attachments[AttachIdx].SocketName) != -1;
                // End:0x4D5
                if(bUseSocket || bUseBone)
                {
                    StaticMeshComp = new (self) Class'Engine.StaticMeshComponent';
                    StaticMeshComp.SetStaticMesh(Attachments[AttachIdx].List[PickedInfoIdx].StaticMesh);
                    StaticMeshComp.SetActorCollision(false, false);
                    StaticMeshComp.SetScale3D(Attachments[AttachIdx].List[PickedInfoIdx].Scale3D);
                    StaticMeshComp.SetLightEnvironment(LightEnvironment);
                    // End:0x481
                    if(bUseSocket)
                    {
                        SkeletalMeshComponent.AttachComponentToSocket(StaticMeshComp, Attachments[AttachIdx].SocketName);                        
                    }
                    else
                    {
                        SkeletalMeshComponent.AttachComponent(StaticMeshComp, Attachments[AttachIdx].SocketName);
                    }                    
                }
            }
        }
        AttachIdx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

defaultproperties
{
    // Reference: SkeletalMeshComponent'GameFramework.Default__GameCrowdAgentSkeletal.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0" class=Engine.SkeletalMeshComponent
        bUpdateSkelWhenNotRendered=false
        bTickAnimNodesWhenNotRendered=false
        bEnableLineCheckWithBounds=true
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'GameFramework.Default__GameCrowdAgentSkeletal.MyLightEnvironment'
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        bCastDynamicShadow=false
        CollideActors=true
        BlockZeroExtent=true
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true)
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    SpeedBlendStart=150.0000000
    SpeedBlendEnd=180.0000000
    AnimVelRate=0.0098000
    MaxSpeedBlendChangeSpeed=2.0000000
    MoveSyncGroupName="MoveGroup"
    MaxTargetAcquireTime=5.0000000
    bAllowSkeletonUpdateChangeBasedOnTickResult=true
    NotVisibleDisableTickTime=0.2000000
    MaxAnimationDistance=12000.0000000
    // Reference: DynamicLightEnvironmentComponent'GameFramework.Default__GameCrowdAgentSkeletal.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'GameFramework.Default__GameCrowdAgent.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
}