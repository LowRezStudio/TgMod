class TgDeploy_Barrage extends TgDeployable
    native(ChampViktor)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgCameraShake m_CameraShake;
var float m_fAllowableGroundTraceDist;
var bool m_bShouldAirBurst;

native function AdjustMeshToGround();  // Export UTgDeploy_Barrage::execAdjustMeshToGround(FFrame&, void* const)

simulated function TriggerHitFX() { }

simulated event PlayFireFx() { }

state Deploy {}

defaultproperties
{}
