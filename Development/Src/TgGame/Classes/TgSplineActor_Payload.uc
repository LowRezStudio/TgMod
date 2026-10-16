class TgSplineActor_Payload extends TgSplineActor
    hidecategories(Navigation)
    config(Engine);

var bool m_bReached;
var (Payload) float m_fSecondsToAdd;

simulated event OnSplineActorReached(TgPawn_LanePusherBase Payload) { }

defaultproperties
{
    m_fSecondsToAdd=120.0000000
}
