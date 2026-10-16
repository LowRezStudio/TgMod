class TgMapInfo extends MapInfo
    native
    editinlinenew
    config(Engine);

var () Actor m_EndFocusActor_TF1;
var () Actor m_EndFocusActor_TF2;
var () TgFatalityFactory m_FatalityFactory_TF1_1;
var () TgFatalityFactory m_FatalityFactory_TF1_2;
var () TgFatalityFactory m_FatalityFactory_TF1_3;
var () TgFatalityFactory m_FatalityFactory_TF2_1;
var () TgFatalityFactory m_FatalityFactory_TF2_2;
var () TgFatalityFactory m_FatalityFactory_TF2_3;
var () StaticMeshActor m_OverlayPathMesh;
var () Vector2D m_vMapCenter;
var () Vector2D m_vTaskForce1BaseLocation;
var () Vector2D m_vTaskForce2BaseLocation;
var () float m_fLockViewBufferZoneSize;
var () bool m_bSupportsGuardianThrone;
var () float m_LitParticleBrightness;

simulated function TgFatalityFactory GetEmptyFatalityFactory(byte TaskForceNumber) { }

defaultproperties
{
    m_vTaskForce1BaseLocation=(X=-10500.0000000,Y=0.0000000)
    m_vTaskForce2BaseLocation=(X=10500.0000000,Y=0.0000000)
    m_fLockViewBufferZoneSize=1500.0000000
    m_LitParticleBrightness=12.0000000
}
