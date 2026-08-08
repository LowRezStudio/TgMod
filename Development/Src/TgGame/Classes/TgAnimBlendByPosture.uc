class TgAnimBlendByPosture extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgPawn);

struct m_TransitionAnimSet {
    var () TgPawn.TG_POSTURE m_TransitionToPosture;
    var () name m_TransitionAnimName;
    structdefaultproperties {}
};

struct m_PostureProfile {
    var () TgPawn.TG_POSTURE m_Posture;
    var () array<m_TransitionAnimSet> m_TransitionAnimSets;
    var () CameraAnim m_CameraAnim;
    var () float m_fCameraAnimBlendInTime;
    var () float m_fCameraAnimBlendOutTime;
    var () bool m_bCameraAnimBlendInOnTransitionIn;
    var () bool m_bCameraAnimBlendOutAfterTransitionOut;
    var CameraAnimInst m_CameraAnimInst;
    var bool m_bPlayingCameraAnim;
    var () bool m_bResetBlendByFireToIdleOnTransition;
    structdefaultproperties {}
};

var TgPawn m_TgPawn;
var TgSkeletalMeshActor_Posture m_TgPostureMesh;
var TgPawn.TG_POSTURE m_LastPosture;
var TgPawn.TG_POSTURE m_CurrentPosture;
var TgPawn.TG_POSTURE m_TransitionFromPosture;
var () bool m_bEnableTransitionAnims;
var () bool m_bCheckLowerPriorityPostures;
var int m_CurrentPostureChildIndex;
var () array<m_PostureProfile> m_PostureProfiles;
var transient AnimNodeSequence m_TransitionAnimNodeSeq;

native function bool ForcePostureChange(optional bool bAllowTransitionAnims=true);  // Export UTgAnimBlendByPosture::execForcePostureChange(FFrame&, void* const)

native function ForceAllCameraAnimsEnd();  // Export UTgAnimBlendByPosture::execForceAllCameraAnimsEnd(FFrame&, void* const)

defaultproperties
{
    m_LastPosture=TG_POSTURE_NONE
    m_bCheckLowerPriorityPostures=true
    DefaultBlendTime=0.2000000
    ActiveChildIndex=1
    Children=/* Array type was not detected. */
}
