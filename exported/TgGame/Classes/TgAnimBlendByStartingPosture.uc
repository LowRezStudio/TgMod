class TgAnimBlendByStartingPosture extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var TgPawn m_TgPawn;
var() TgPawn.TG_POSTURE m_StartingPosture;
var bool m_bExpired;

defaultproperties
{
    DefaultBlendTime=0.0000000
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}