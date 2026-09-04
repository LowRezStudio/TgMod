class TgAnimNodeSimpleTransitioner extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var(ConfigureFromDevice) int m_nDeviceId;
var(ConfigureFromDevice) bool m_bConfigureBasedOnDevice;
var() bool m_bIgnoreFireMode;
var() int m_nNumberOfStances;
var() name m_StanceBaseName;
var() name m_TransitionBaseName;
var() float m_BlendTransitionDuration;

// Export UTgAnimNodeSimpleTransitioner::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimNodeSimpleTransitioner::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

// Export UTgAnimNodeSimpleTransitioner::execSetStance(FFrame&, void* const)
native function bool SetStance(int nStance, optional bool bNoBlend);

// Export UTgAnimNodeSimpleTransitioner::execFire(FFrame&, void* const)
native function bool Fire(int nMode);

defaultproperties
{
    m_bIgnoreFireMode=true
    m_nNumberOfStances=1
    m_StanceBaseName="Stance"
    m_TransitionBaseName="Fire"
    m_BlendTransitionDuration=0.5000000
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}