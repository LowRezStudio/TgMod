class TgAnimBlendByPosture extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native m_TransitionAnimSet
{
    var() TgPawn.TG_POSTURE m_TransitionToPosture;
    var() name m_TransitionAnimName;

    structdefaultproperties
    {
        m_TransitionToPosture=TG_POSTURE.TG_POSTURE_DEFAULT
        m_TransitionAnimName="None"
    }
};

struct native m_PostureProfile
{
    var() TgPawn.TG_POSTURE m_Posture;
    var() array<m_TransitionAnimSet> m_TransitionAnimSets;
    var() CameraAnim m_CameraAnim;
    var() float m_fCameraAnimBlendInTime;
    var() float m_fCameraAnimBlendOutTime;
    var() bool m_bCameraAnimBlendInOnTransitionIn;
    var() bool m_bCameraAnimBlendOutAfterTransitionOut;
    var CameraAnimInst m_CameraAnimInst;
    var bool m_bPlayingCameraAnim;
    var() bool m_bResetBlendByFireToIdleOnTransition;

    structdefaultproperties
    {
        m_Posture=TG_POSTURE.TG_POSTURE_DEFAULT
        m_TransitionAnimSets=none
        m_CameraAnim=none
        m_fCameraAnimBlendInTime=0.1000000
        m_fCameraAnimBlendOutTime=0.1000000
        m_bCameraAnimBlendInOnTransitionIn=true
        m_bCameraAnimBlendOutAfterTransitionOut=false
        m_CameraAnimInst=none
        m_bPlayingCameraAnim=false
        m_bResetBlendByFireToIdleOnTransition=false
    }
};

var TgPawn m_TgPawn;
var TgSkeletalMeshActor_Posture m_TgPostureMesh;
var TgPawn.TG_POSTURE m_LastPosture;
var TgPawn.TG_POSTURE m_CurrentPosture;
var TgPawn.TG_POSTURE m_TransitionFromPosture;
var() bool m_bEnableTransitionAnims;
var() bool m_bCheckLowerPriorityPostures;
var int m_CurrentPostureChildIndex;
var() array<m_PostureProfile> m_PostureProfiles;
var transient AnimNodeSequence m_TransitionAnimNodeSeq;

// Export UTgAnimBlendByPosture::execForcePostureChange(FFrame&, void* const)
native function bool ForcePostureChange(optional bool bAllowTransitionAnims = true);

// Export UTgAnimBlendByPosture::execForceAllCameraAnimsEnd(FFrame&, void* const)
native function ForceAllCameraAnimsEnd();

defaultproperties
{
    m_LastPosture=TG_POSTURE.TG_POSTURE_NONE
    m_bCheckLowerPriorityPostures=true
    DefaultBlendTime=0.2000000
    ActiveChildIndex=1
    Children=/* Array type was not detected. */
}