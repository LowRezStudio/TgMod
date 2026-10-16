class TgSkeletalMeshActor_Posture extends SkeletalMeshActor
    hidecategories(Navigation)
    config(Engine)
    dependson(TgPawn);

var (Posture) repnotify TgPawn.TG_POSTURE r_CurrentPosture;
var transient array<TgAnimBlendByPosture> m_PostureBlendNodes;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_CurrentPosture;
}

simulated function PostBeginPlay() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function SetActivePosture(TgPawn.TG_POSTURE Posture) { }

event PostInitAnimTree(SkeletalMeshComponent SkelComp) { }

simulated function InitPostureNodes() { }

simulated event OnSetSkelPosture(TgSeqAct_SetSkelPosture Action) { }

defaultproperties
{}
