class TgPhysAnimTestActor extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

enum EPATAState {
    PATA_FixedAll,  // 0
    PATA_FixedLower,  // 1
    PATA_MotorRagdoll,  // 2
    PATA_Floppy,  // 3
    PATA_Recover,  // 4
};

var () array<name> LowerBoneNames;
var () array<name> LinearBoneSpringNames;
var () array<name> AngularBoneSpringNames;
var () export editinline SkeletalMeshComponent SkeletalMeshComponent;
var TgPhysAnimTestActor.EPATAState CurrentState;
var bool bBlendToGetUp;
var bool bBlendingBack;
var bool bRampingDownMotors;
var bool bNextPokeKnocksDown;
var float GetUpBlendStartTime;
var () float GetUpBlendTime;
var () float GetUpToIdleTime;
var () float ActorOriginHeight;
var () float PokePauseTime;
var () float PokeBlendTime;
var float BlendBackStartTime;
var float MotorDownStartTime;
var () float MotorDownTime;
var () float MotorDownAnimTime;
var () float BlendStaggerAnimTime;
var () float StaggerSpeedAdj;
var () float StaggerVel;
var Vector MoveDir;
var () float AngularHipDriveScale;
var () float StaggerMuscleScale;
var AnimNodeBlend BlendNode;
var AnimNodeSequence GetUpNode;
var AnimNodeSequence RunNode;
var RB_BodyInstance HipBody;

simulated function PostBeginPlay() { }

simulated function BoneImpulse(Vector Impulse, name BoneName) { }

simulated function bool PrePokeActor(Vector PokeDir) { }

simulated function bool PreGrab() { }

simulated function EndGrab() { }

simulated function SetPATAState(TgPhysAnimTestActor.EPATAState NewState) { }

simulated function EnableMotors(bool InEnabled) { }

simulated function SetBodiesFixed(bool InFixed) { }

simulated function bool IsLowerBodyName(name InName) { }

simulated function DetachAttachments() { }

simulated function SetLowerFixed() { }

simulated function bool IsLinearBoneSpringName(name InName) { }

simulated function bool IsAngularBoneSpringName(name InName) { }

simulated function SetBoneSprings(bool bEnabled) { }

simulated function RecoverFromRagdoll() { }

simulated function SetAllMotorsAngularDriveStrength(float InAngularSpringStrength, float InAngularDampingStrength, float InAngularForceLimitStrength, SkeletalMeshComponent SkelMeshComp) { }

simulated function Tick(float DeltaSeconds) { }

event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime) { }

defaultproperties
{}
