class TgAnimNotify_ViewShake extends AnimNotify_ViewShake
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

var private editconst float m_fShakeRadius;
var private editconst float m_fDuration;
var private editconst float m_fAmplitude;
var () bool m_bUseLocationRadiusBasedShake;

simulated function Clear1pCameraAnim() { }

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator) { }

defaultproperties
{
    m_fShakeRadius=4096.0000000
    m_fDuration=1.0000000
    Duration=0.0000000
    LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    ShakeRadius=0.0000000
}
