class TgAnimNodeTiltTowardsVelocity extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object)
    config(Engine);

var () Vector2D m_MaximumVelocity;
var transient int m_PitchOffset;
var () int m_MaximumPitchOffset;
var transient int m_RollOffset;
var () int m_MaximumRollOffset;
var transient TgPawn m_Pawn;

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
