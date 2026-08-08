class TgAnimNodeBlendAnimsByDirection extends AnimNodeSequenceBlendBase
    native(Anim)
    hidecategories(Object,Object,Object)
    config(Engine);

var () float m_BlendSpeed;
var () bool m_bUsePlayRateByDirection;
var () bool m_bIncludeStandingAnim;
var transient bool m_bForceStanding;
var const transient bool m_bInterpolateWeights;
var () bool m_bMirrorDirectionsWhenPawnMirrored;
var () bool m_bForwardLeftCorrection;
var () float m_PlayRateByDirection[8];
var () float m_PlayRateStanding;
var () float m_fStillThreshold;
var float m_DirAngle;
var transient float m_LastRelevantTime;

defaultproperties
{
    m_BlendSpeed=10.0000000
    m_bUsePlayRateByDirection=true
    m_PlayRateByDirection[0]=1.0000000
    m_PlayRateByDirection[1]=1.0000000
    m_PlayRateByDirection[2]=1.0000000
    m_PlayRateByDirection[3]=1.0000000
    m_PlayRateByDirection[4]=1.0000000
    m_PlayRateByDirection[5]=1.0000000
    m_PlayRateByDirection[6]=1.0000000
    m_PlayRateByDirection[7]=1.0000000
    m_PlayRateStanding=1.0000000
    m_fStillThreshold=0.0001000
    Anims=/* Array type was not detected. */
}
